#ifndef WIFICLIENT_H
#define WIFICLIENT_H

#include "includes.h"

//#define CONNECT_IP              0
//#define CONNECT_HOST            1

extern uint8_t  WiFiClientStatus(void);
extern int      WiFiClientConnect(char *NetAddr, uint16_t port);
extern uint16_t WiFiClientWriteByte(uint8_t);
extern uint16_t WiFiClientWriteBlock(const uint8_t *buf, uint16_t size);
extern int      WiFiClientAvailable(void);
extern int      WiFiClientReadByte(void);
extern int      WiFiClientReadBlock(uint8_t* buf, uint16_t size);
extern int      WiFiClientPeek(void);
extern void     WiFiClientFlush(void);
extern void     WiFiClientStop(void);
extern uint8_t  WiFiClientConnected(void);

#endif

