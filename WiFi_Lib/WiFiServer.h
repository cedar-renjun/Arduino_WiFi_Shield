#ifndef _WIFISERVER_H_
#define _WIFISERVER_H_

void     WiFiServer_Init(uint16_t port);
uint8_t  WiFiServer_Available(void);
uint8_t  WiFiServer_Status();
uint16_t WiFiServer_WriteByte(uint8_t b);
uint16_t WiFiServer_WriteBlock(uint8_t *buf, uint16_t size);

#endif //_WIFISERVER_H_
