#include <string.h>
#include "server_drv.h"
#include "WiFi.h"
#include "WiFiClient.h"
#include "WiFiServer.h"

static uint16_t _port = 0;


void WiFiServer_Init(uint16_t port)
{
    WiFiClient_Init();
    _port = port;
    ServerDrv_StartServer(_port, _sock);
}

uint8_t WiFiServer_Available(void)
{
    static int Cnt = 0;

    //server not in listen state, restart it
    if ((WiFiServer_Status() == 0) && (Cnt++ > 50))
    {
        Cnt = 0;
        ServerDrv_StartServer(_port, _sock);
    }

    if (WiFiClient_Status() == ESTABLISHED)
    {                
        return 1; //OK
    }

    return (0); //ERROR
}

uint8_t WiFiServer_Status()
{
    return ServerDrv_GetServerState(_sock);
}


uint16_t WiFiServer_WriteByte(uint8_t b)
{
    return WiFiServer_WriteBlock(&b, 1);
}

uint16_t WiFiServer_WriteBlock(uint8_t *buf, uint16_t size)
{
	uint16_t n = 0;

    if(WiFiClient_Status() == ESTABLISHED)
    {                
        n = WiFiClient_WriteBlock(buf, size);
    }
    return n;
}
