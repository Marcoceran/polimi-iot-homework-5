#include "printf.h"
#include "RanVal.h"
#include "Timer.h"
module RanValC {
  uses {
    interface Boot;
    interface Timer<TMilli>;
	interface Receive;
	interface AMSend;
	interface SplitControl as AMControl;
	interface Packet;
	interface Random;
  }
}

implementation {

	message_t packet;
	
	event void Boot.booted() {
	//dbg("boot","Application booted.\n");  
		call AMControl.start();
	}

	event void AMControl.startDone(error_t err){
		if(err == SUCCESS){
			dbg("radio", "radio started!\n")
			if(TOS_NODE_ID == 2 || TOS_NODE_ID == 3){
				call Timer.startPeriodic( 5000 );
			}
		} else{
			dbgerror("radio err", "radio error, restart radio\n")
			call AMControl.start();
		}
	}
	
	event void AMControl.stopDone(error_t err){
	/*emptyevent*/
	}
	
	event void Timer.fired() {
		my_msg_t* ran_msg = (my_msg_t*)call Packet.getPayload(&packet, sizeof(my_msg_t));
		
		//Generates random 16 bit value and computes modulo 101 in order to have a number between 0 and 100
		uint16_t temp = call Random.rand16();
		ran_msg -> val = temp % 101;
		ran_msg -> topic = TOS_NODE_ID;
	
	 	
	 	if(call AMSend.send(1, &packet, sizeof(my_msg_t)) == SUCCESS){
	 		dbg("radio_send", "Mote #%d: Sending message \n", TOS_NODE_ID);
		}
	}
  
	event void AMSend.sendDone(message_t* buf, error_t err){
  	}
  
  	event message_t* Receive.receive(message_t* buf,void* payload, uint8_t len) {
	
 		my_msg_t* recm = (my_msg_t*)payload;
	 
		if(len != sizeof(my_msg_t)){
			return buf;
		}
	
		printf("Topic: /field%u, Value: %u\n  ", recm-> topic, recm -> val);
		printfflush();
		
		return buf;
	}
}

