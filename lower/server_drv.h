/*---------------------------------------------------------------------------*-
 
     File:   debug.h
     
     Modified by: CooCox cedar 
     Time       : 

-*---------------------------------------------------------------------------*/


#ifndef SERVER_DRV_H
#define SERVER_DRV_H

#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "wl_definitions.h"
#include "wifi_spi.h"

// Start server TCP on port specified
extern void    ServerDrvStartServer        (uint16_t port, uint8_t sock);
extern void    ServerDrvStartClient        (uint32_t ipAddress, uint16_t port, uint8_t sock);
extern void    ServerDrvStopClient         (uint8_t sock);
extern uint8_t ServerDrvGetServerState     (uint8_t sock);
extern uint8_t ServerDrvGetClientState     (uint8_t sock);
extern uint8_t ServerDrvAvailData          (uint8_t sock);
extern uint8_t ServerDrvGetData            (uint8_t sock, uint8_t *data, uint8_t peek);
extern uint8_t ServerDrvGetDataBuf         (uint8_t sock, uint8_t *data, uint16_t *len);
extern uint8_t ServerDrvSendData           (uint8_t sock, const uint8_t *data, uint16_t len);
extern uint8_t ServerDrvCheckDataSent      (uint8_t sock);

#endif //  SERVER_DRV_H

/*--------------------------- FILE END --------------------------------------*/

