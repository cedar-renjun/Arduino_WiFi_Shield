#ifndef _WIFI_H_
#define _WIFI_H_

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include <stdint.h>

#include "spi_drv.h"
#include "wifi_drv.h"
#include "WiFi.h"

//extern int16_t   _state[MAX_SOCK_NUM];
//extern uint16_t  _server_port[MAX_SOCK_NUM];

extern int16_t   _state;
extern uint8_t   _sock;

// Network encrytion type
// used in WiFiBegin Function
#define OPEN                    1
#define WEP                     2
#define WPA                     3

void     WiFi_Init(void);
uint8_t* WiFi_FwVerGet(void);
int32_t  WiFi_Begin(uint8_t NetType, uint8_t* ssid, ...);
int8_t   WiFi_Disconnect(void);
uint8_t* WiFi_MacAddrGet(uint8_t* mac);
void     WiFi_LocalIPGet(uint8_t * ip);
void     WiFi_SubnetMaskGet(uint8_t * mask);
void     WiFi_GatewayIPGet(uint8_t * gateway);
uint8_t* WiFi_BSSIDGet(uint8_t* bssid);
int8_t   WiFi_ScanNetworks(void);
uint8_t* WiFi_SSIDGet(uint8_t networkItem);
uint8_t  WiFi_EncryptionTypeGet(uint8_t networkItem);
int32_t  WiFi_RSSIGet(uint8_t networkItem);
uint8_t  WiFi_StatusGet(void);
int32_t  WiFi_HostToIP(uint8_t* aHostname, uint8_t * aResult);
int32_t  IPToNetAddr(uint8_t* IPStr, uint8_t * NetAddr);

#endif
