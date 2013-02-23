#ifndef _WIFICLIENT_H_
#define _WIFICLIENT_H_

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

void     WiFiClient_Init(void);
int32_t  WiFiClient_Connect(uint8_t* NetAddr, uint16_t port);
uint16_t WiFiClient_WriteByte(uint8_t b);
uint16_t WiFiClient_WriteBlock(uint8_t *buf, uint16_t size);
int32_t  WiFiClient_Available(void);
uint8_t  WiFiClient_ReadByte(void);
int32_t  WiFiClient_ReadBlock(uint8_t* buf, uint16_t size);
int32_t  WiFiClient_Peek(void);
void     WiFiClient_Flush(void);
void     WiFiClient_Stop(void);
uint8_t  WiFiClient_Connected(void);
uint8_t  WiFiClient_Status(void);


int32_t _ConnectViaIP(uint8_t* ip, uint16_t port);

#endif //_WIFICLIENT_H_
