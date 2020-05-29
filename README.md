# polimi-iot-homework-5

## [ThingSpeak Channel Link](https://thingspeak.com/channels/1070813)

## Group members
* [Marco Ceran](mailto:marco.ceran@mail.polimi.it) ID: 952673
* [Fabio Segato](mailto:fabio1.segato@mail.polimi.it) ID: 928084
* [Urszula Szczepanska](mailto:urszulamarta.szczepanska@mail.polimi.it) ID: 950021

## Description
* Create a Cooja simulation with 3 TinyOS (sky) motes, called 1, 2, 3.
* The motes communicate over the radio. Mote #2 and #3 sends a message every 5 seconds to mote #1
* The message contains a random value (between 0 an 100) and a static topic
* Mote #1 receives messages and ’’forwards’’ them to node-red
* The node-red dashboard removes the values > 70 and publishes the message to thingspeak via MQTT into two different charts

## Execution

We uploaded 3 files for this project:
* The modules file `RanValC.nc` 
* The config file `RanValAppC.nc`
* The header file `RanVal.h`

	
We chose the interfaces needed for this task and included them into the configuration file and linked them to the interfaces declared into the modules file, in the latter we also defined their behavior in case of specific events. The header file was used to define parameters and the message structure. Cooja was used to run the simulation.

* **Interfaces**:
	* 	`Boot`, to start the application
	* 	`Receive`, for the reception of packets
	* 	`AMSend`, to send packets
	* 	`Timer<TMilli>`, to enable the use of timer
	* 	`SplitControl`, to turn on and off the communication interface
	* 	`Packet`, to get the payload of the received packet of information
	* 	`RandomC`, to generate random values
	
* **Events**:
	* `Boot`: triggered when the mote is turned on
	* `AMControl.startDone()`: triggered when the communication interface is done starting up
	* `AMControl.stopDone()`: triggered when the communication interface is turned off 
	* `Timer.fired()`: triggered when a timer ends a period, Motes 2 and 3 send a message to Mote 1
	* `Receive.receive()`: triggered when a packet is received, Mote 1 prints to the serial port the values received in the messages.
	* `AMSend.sendDone()`: triggered when a packet is sent correctly
  
* **Message structure**:
	* topic: equal to the Mote ID in order to be able to differentiate topics on the node-red side.
	* value: randomly generated value
   
* **Implementation**
 After the radio interface is done booting, the 5000ms timer starts for Mote 2 and 3 (checking `TOS_NODE_ID`). When the timer fires a message containing the `TOS_NODE_ID` as topic and a randomly generated value is sent to Mote 1, which simply writes it to the serial port. With Cooja a Serial Socker Server is created for Mote 1 at port 42069. On Node-Red a tcp-in node connects to `localhost:42069` and reads the string coming from Mote 1. The string is parsed, separated into 2 topics according to the Mote that sent the message and forwarded to a Thingspeak channel through MQTT, passing through a rate limiter to avoid Thingspeak restrictions. 
