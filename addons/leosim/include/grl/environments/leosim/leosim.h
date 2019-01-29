#ifndef GRL_LEOSIM_ENVIRONMENT_H_
#define GRL_LEOSIM_ENVIRONMENT_H_

#include <grl/environments/odesim/environment.h>
#include "LeoBhWalkSym.h"
#include "STGLeo.h"
#include "STGLeoSim.h"
#include "ThirdOrderButterworth.h"

namespace grl
{

class CGrlLeoBhWalkSym : public CLeoBhWalkSym
{
  public:
    enum LeoStateVar
    {
      svTorsoAngle,
      svTorsoAngleRate,
      svLeftArmAngle,
      svLeftArmAngleRate,
      svRightHipAngle,
      svRightHipAngleRate,
      svLeftHipAngle,
      svLeftHipAngleRate,
      svRightKneeAngle,
      svRightKneeAngleRate,
      svLeftKneeAngle,
      svLeftKneeAngleRate,
      svRightAnkleAngle,
      svRightAnkleAngleRate,
      svLeftAnkleAngle,
      svLeftAnkleAngleRate,
      svRightToeContact,
      svRightHeelContact,
      svLeftToeContact,
      svLeftHeelContact,
      svNumStates
    };
    enum LeoActionVar
    {
      avLeftArmTorque,
      avRightHipTorque,
      avLeftHipTorque,
      avRightKneeTorque,
      avLeftKneeTorque,
      avRightAnkleTorque,
      avLeftAnkleTorque,
      svNumActions
    };

  public:
    CGrlLeoBhWalkSym(ISTGActuation *actuationInterface) : CLeoBhWalkSym(actuationInterface) {}

    int getHipStance()   {return mHipStance;}
    int getHipSwing()    {return mHipSwing;}
    int getKneeStance()  {return mKneeStance;}
    int getKneeSwing()   {return mKneeSwing;}
    int getAnkleStance() {return mAnkleStance;}
    int getAnkleSwing()  {return mAnkleSwing;}
    bool stanceLegLeft() {return mLastStancelegWasLeft;}

  public:
    void resetState();
    void fillLeoState(const Vector &obs, const Vector &action, CLeoState &leoState);
    void parseLeoState(const CLeoState &leoState, Vector &obs);
    void updateDerivedStateVars(CLeoState *currentSTGState);
    void setCurrentSTGState(CLeoState *leoState);
    void setPreviousSTGState(CLeoState *leoState);
    void grlAutoActuateAnkles(Vector &out)
    {
      CSTGLeoSim *leoSim = dynamic_cast<CSTGLeoSim*>(mActuationInterface);
      CLeoBhWalkSym::autoActuateAnkles_FixedPos(leoSim);
      out.resize(2);
      out << leoSim->getJointVoltage(ljAnkleRight), leoSim->getJointVoltage(ljAnkleLeft);
    }
    double grlAutoActuateArm()
    {
      CSTGLeoSim *leoSim = dynamic_cast<CSTGLeoSim*>(mActuationInterface);
      CLeoBhWalkSym::autoActuateArm(leoSim);
      return leoSim->getJointVoltage(ljShoulder);
    }
    double grlAutoActuateKnee()
    {
      CSTGLeoSim *leoSim = dynamic_cast<CSTGLeoSim*>(mActuationInterface);
      CLeoBhWalkSym::autoActuateKnees(leoSim);
      return stanceLegLeft() ? leoSim->getJointVoltage(ljKneeLeft) : leoSim->getJointVoltage(ljKneeRight);
    }

  protected:
    CButterworthFilter<1>	mJointSpeedFilter[ljNumJoints];
};

/// Simulation of original Leo robot by Erik Schuitema.
class LeoSimEnvironment : public ODEEnvironment
{
  public:
    TYPEINFO("environment/leosim", "Leo simulation environment")

  public:
    LeoSimEnvironment();

    // From Configurable
    virtual void request(ConfigurationRequest *config);
    virtual void configure(Configuration &config);
    virtual void reconfigure(const Configuration &config);
    
    // From ODEEnvironment
    virtual LeoSimEnvironment *clone();
    
    // From Environment
    virtual void start(int test, Observation *obs);
    virtual double step(const Action &action, Observation *obs, double *reward, int *terminal);
    virtual void report(std::ostream &os) const;
    
  protected:
    CSTGLeoSim leoSim_;
    CLeoState leoState_;
    CGrlLeoBhWalkSym bhWalk_;
    int observation_dims_, requested_action_dims_, action_dims_;
    int ode_observation_dims_, ode_action_dims_;
    int learn_stance_knee_;

    // Exporter
    Exporter *exporter_;
    int test_;
    double time_test_, time_learn_, time0_;

  private:
    void fillObserve(const std::vector<CGenericStateVar> &genericStates,
                     const std::vector<std::string> &observeList,
                     Vector &out) const;

    void fillActuate(const std::vector<CGenericActionVar> &genericAction,
                     const std::vector<std::string> &actuateList,
                     Vector &out, std::vector<int> &knee_idx) const;
  private:
    Observation ode_obs_;
    Action ode_action_;
    Vector observe_, actuate_;
};

}

#endif /* GRL_LEOSIM_ENVIRONMENT_H_ */
