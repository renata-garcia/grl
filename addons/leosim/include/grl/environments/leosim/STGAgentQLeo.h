/*
 * STGAgentQLeo.h
 *
 *  Created on: Sep 1, 2009
 *      Author: Erik Schuitema
 */

#ifndef STGAGENTQLEO_H_
#define STGAGENTQLEO_H_

#include "AgentInterface.h"
#include "STGLeo.h"
#include <Configuration.h>

template<class STGStateType>
class CSTGAgentQ
{
public:
  CSTGAgentQ(ISTGActuation *actuationInterface):
    mLog("CSTGAgentQ"),
    mActuationInterface(actuationInterface)
  {}
  STGStateType  *getCurrentSTGState()			{return mCurrentSTGState;}
  STGStateType  *getPreviousSTGState()		{return &mPreviousSTGState;}
  double        getTotalReward()          {return 0;}
  ISTGActuation *getActuationInterface()	{return mActuationInterface;}

protected:
  STGStateType	mPreviousSTGState;
  STGStateType	*mCurrentSTGState;
  CAgentAction	mPreviousAction;
  CLog2					mLog;
  ISTGActuation *mActuationInterface;
  CAgentAction  mAgentAction;

};

typedef CSTGAgentQ<CLeoState> CSTGAgentQLeo;

#endif /* STGAGENTQLEO_H_ */
