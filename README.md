# polimi-iot-homework-5

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

* We uploaded n files for this project:
    * ranval.h
    * ranvalAppC.nc
    * ranvalC.nc
 
