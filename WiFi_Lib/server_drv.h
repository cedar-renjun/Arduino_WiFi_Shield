/*---------------------------------------------------------------------------*-

     File:   debug.h

     Modified by: CooCox cedar
     Time       :

-*---------------------------------------------------------------------------*/


#ifndef SERVER_DRV_H
#define SERVER_DRV_H

#include <stdint.h>
#include "wifi_spi.h"

void    ServerDrv_StartServer(uint16_t port, uint8_t sock);
void    ServerDrv_StartClient(uint32_t ipAddress, uint16_t port, uint8_t sock);
void    ServerDrv_StopClient(uint8_t sock);
uint8_t ServerDrv_GetServerState(uint8_t sock);
uint8_t ServerDrv_GetClientState(uint8_t sock);
int32_t ServerDrv_AvailData(uint8_t sock);
int32_t ServerDrv_GetData(uint8_t sock, uint8_t *data, uint8_t peek);
int32_t ServerDrv_GetDataBuf(uint8_t sock, uint8_t *_data, uint16_t *_dataLen);
int32_t ServerDrv_SendData(uint8_t sock, uint8_t *data, uint16_t len);
int32_t ServerDrv_CheckDataSent(uint8_t sock);

/*--------------------------- FILE END --------------------------------------*/


#endif //  SERVER_DRV_H
