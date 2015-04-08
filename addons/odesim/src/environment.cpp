#include <XMLConfiguration.h>

#include <grl/environments/odesim/environment.h>
#include <grl/environments/odesim/dialog.h>

#define REQUIRED_CONFIG_VERSION 1.1

using namespace std;
using namespace grl;

REGISTER_CONFIGURABLE(ODEEnvironment)

// ** ODESTGEnvironment ***

ODESTGEnvironment::~ODESTGEnvironment()
{
  simulator_.stop();
  simulator_.deinit();
  listener_.stopListening();
}

bool ODESTGEnvironment::configure(Configuration &config)
{
  std::string xml = config["xml"].str();

  CXMLConfiguration xmlConfig;

  if (!xmlConfig.loadFile(xml))
  {
    ERROR("Couldn't load XML configuration file \"" << xml << "\"!\nPlease check that the file exists and that it is sound (error: " << xmlConfig.errorStr() << ").");
    return false;
  }
  
  // Resolve expressions
  xmlConfig.resolveExpressions();

  std::string loglevel;
  xmlConfig.root().get("loglevel", &loglevel, "info");
  gLogFactory().setLevel(gLogFactory().getLevelFromString(loglevel));

  // Check version
  double version;
  xmlConfig.root().get("version", &version, -1);
  if (version < REQUIRED_CONFIG_VERSION)
  {
    ERROR("XML configuration file has version " << version << " but version " << REQUIRED_CONFIG_VERSION << " required!");
    return false;
  }
  else
  {
    if (version > REQUIRED_CONFIG_VERSION)
      WARNING("Version (" << version << ") larger than required (" << REQUIRED_CONFIG_VERSION << ")!");
  }

  if (!simulator_.readConfig(xmlConfig.root().section("ode")))
  {
    ERROR("Loading XML configuration failed!");
    return false;
  }

  if (!simulator_.init())
  {
    ERROR("Could not init simulation!");
    return false;
  }
  
  CConfigSection configNode = xmlConfig.root().section("policy");
  
  bool configresult = true;
  
  double trialTimeoutSeconds=20;
  configNode.get("trialTimeoutSeconds", &trialTimeoutSeconds);
  timeout_ = (uint64_t)(trialTimeoutSeconds*1E6);

  Vector observation_min, observation_max, action_min, action_max;
  double reward_min, reward_max, val;

  for (CConfigSection stateNode = configNode.section("statevar"); !stateNode.isNull();
      stateNode = stateNode.nextSimilarSection())
  {
    CGenericStateVar statevar;
    configresult &= statevar.readConfig(stateNode);
    configresult &= statevar.resolve(&simulator_);
    sensors_.push_back(statevar);
    
    configresult &= stateNode.get("min", &val); observation_min.push_back(val);
    configresult &= stateNode.get("max", &val); observation_max.push_back(val);
  }

  for (CConfigSection actionNode = configNode.section("actionvar"); !actionNode.isNull();
      actionNode = actionNode.nextSimilarSection())
  {
    CGenericActionVar actionvar;
    configresult &= actionvar.readConfig(actionNode);
    configresult &= actionvar.resolve(&simulator_);
    actuators_.push_back(actionvar);

    configresult &= actionNode.get("min", &val); action_min.push_back(val);
    configresult &= actionNode.get("max", &val); action_max.push_back(val);
  }

  CConfigSection terminationNode = configNode.section("termination");
  if (!terminationNode.isNull())
  {
    configresult &= termination_.readConfig(terminationNode);
    configresult &= termination_.resolve(&simulator_);
  }

  CConfigSection rewardNode = configNode.section("reward");
  if (!rewardNode.isNull())
  {
    configresult &= reward_.readConfig(rewardNode);
    configresult &= reward_.resolve(&simulator_);

    configresult &= rewardNode.get("min", &reward_min);
    configresult &= rewardNode.get("max", &reward_max);
  }

  if (!configresult)
  {
    ERROR("Could not load state and action variables");
    return false;
  }
  
  config.set("observation_dims", observation_min.size());
  config.set("observation_min", observation_min);
  config.set("observation_max", observation_max);
  config.set("action_dims", action_min.size());
  config.set("action_min", action_min);
  config.set("action_max", action_max);
  config.set("reward_min", reward_min);
  config.set("reward_max", reward_max);

  if (!listener_.startListening(stgReceiveAll, 1, 10, "-PolicyPlayer"))
  {
    ERROR("Could not start listening for states");
    return false;
  }

  if (!simulator_.start())
  {
    ERROR("Could not start simulation!");
    return false;
  }
  
  DEBUG("Waiting for initial STG state");
    
  if (!listener_.waitForNewState())
  {
    ERROR("Error getting initial state from simulator");
    return false;
  }
  
  return true;
}

void ODESTGEnvironment::start(Vector *obs)
{
  simulator_.setInitialCondition();
  simulator_.resetActuationValues();
  simulator_.activateActions(listener_.getState()->mStateID);
  
  CRAWL("Waiting for start STG state");
  
  if (!listener_.waitForNewState())
    throw Exception("Error getting start state from simulator");
    
  obs->resize(sensors_.size());
  for (size_t ii=0; ii < sensors_.size(); ++ii)
    (*obs)[ii] = sensors_[ii].evaluate(listener_.getState());
    
  start_time_ = simulator_.getAbsTime();

  emit drawFrame();
}

void ODESTGEnvironment::step(const Vector &action, Vector *obs, double *reward, int *terminal)
{
  if (action.size() != actuators_.size())
    ERROR("Got action vector size " << action.size() << " (" << actuators_.size() << " expected)");
  
  for (size_t ii=0; ii < actuators_.size(); ++ii)
    actuators_[ii].actuate(action[ii], &simulator_);
  
  simulator_.activateActions(listener_.getState()->mStateID);

  CRAWL("Waiting for next STG state");
  
  if (!listener_.waitForNewState())
    throw Exception("Error getting next state from simulator");
    
  obs->resize(sensors_.size());
  for (size_t ii=0; ii < sensors_.size(); ++ii)
    (*obs)[ii] = sensors_[ii].evaluate(listener_.getState());
    
  *reward = reward_.evaluate(listener_.getState());
  
  if (simulator_.getAbsTime() - start_time_ > timeout_)
    *terminal = 1;
  else if (termination_.evaluate(listener_.getState()))
    *terminal = 2;
  else
    *terminal = 0;

  emit drawFrame();
}

// *** ODEEnvironment ***

ODEEnvironment::~ODEEnvironment()
{
  app_->exit();
  itc::Thread::stopAndJoin();
}

void ODEEnvironment::request(ConfigurationRequest *config)
{
  config->push_back(CRP("xml", "XML configuration filename", xml_));
  
  config->push_back(CRP("observation_dims", "int.observation_dims", "Number of observation dimensions", CRP::Provided));
  config->push_back(CRP("observation_min", "vector.observation_min", "Lower limit on observations", CRP::Provided));
  config->push_back(CRP("observation_max", "vector.observation_max", "Upper limit on observations", CRP::Provided));
  config->push_back(CRP("action_dims", "int.action_dims", "Number of action dimensions", CRP::Provided));
  config->push_back(CRP("action_min", "vector.action_min", "Lower limit on actions", CRP::Provided));
  config->push_back(CRP("action_max", "vector.action_max", "Upper limit on actions", CRP::Provided));
  config->push_back(CRP("reward_min", "double.reward_min", "Lower limit on immediate reward", CRP::Provided));
  config->push_back(CRP("reward_max", "double.reward_max", "Upper limit on immediate reward", CRP::Provided));
}

void ODEEnvironment::configure(Configuration &config)
{
  config_ = &config;
    
  itc::Thread::start();
  
  while (!initialized_)
    usleep(0);
    
  config_ = NULL;
}

void ODEEnvironment::reconfigure(const Configuration &config)
{
}

void ODEEnvironment::run()
{
  bool useGUI = getenv("DISPLAY") != 0;
  int argc=1;
  char *argv[1];
  argv[0] = (char*)malloc(7*sizeof(char));
  strcpy(argv[0], "odesim");
  
  NOTICE("Initializing Qt");

  app_ = new QApplication(argc, argv, useGUI);
  env_ = new ODESTGEnvironment();
  
  if (!env_->configure(*config_))
    throw Exception("Could not initialize STG ODE environment");
    
  if (useGUI)
  {
    ODEDialog dialog(env_);

    initialized_ = true;
  
    NOTICE("Starting Qt main loop");
    app_->exec();
    WARNING("Return from Qt main loop");
  }
  else
    initialized_ = true;
    
  while (ok()) usleep(10000);

  safe_delete(&env_);
  safe_delete(&app_);
}