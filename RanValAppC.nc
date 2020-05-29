#define NEW_PRINTF_SEMANTICS
#include "printf.h"
#include "RanVal.h"
configuration RanValAppC{
}
implementation {

  //Components
  components MainC, RanValC as App;
  components new TimerMilliC();
  components PrintfC;
  components SerialStartC;
  components RandomC;

  components new AMSenderC(AM_MY_MSG);
  components new AMReceiverC(AM_MY_MSG);
  components ActiveMessageC;
	
  //Boot interface
  App.Boot -> MainC.Boot;
  
  //Timer
  App.Timer -> TimerMilliC;
  
  //Send and Receive interfaces
  App.Receive -> AMReceiverC;
  App.AMSend -> AMSenderC;
  
  //Radio Control
  App.AMControl -> ActiveMessageC;
  
  //Interfaces to access package fields
  App.Packet -> AMSenderC;
  
  //Generate random values
  App.Random -> RandomC;
}

