#ifndef RANVAL_H
#define RANVAL_H


enum{
AM_MY_MSG = 6,
};

//Message structure
typedef nx_struct my_msg {
	nx_uint8_t val;	// Message Value
	nx_uint8_t topic; // 2 for Mote 2 and 3 for Mote 3 lol
} my_msg_t;

#endif
