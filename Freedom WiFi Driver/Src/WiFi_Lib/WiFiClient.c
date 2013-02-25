
#include "wl_definitions.h"
#include "wl_types.h"
#include "WiFi.h"
#include "WiFiClient.h"
#include "server_drv.h"

//static uint16_t _srcport = 1024;
//static uint8_t _sock;
//uint8_t getFirstSocket();

static int32_t _ConnectViaHost(uint8_t* host, uint16_t port);
//static int32_t _ConnectViaIP(uint8_t* ip, uint16_t port);

static void delay(volatile uint32_t tick)
{
	while(tick--);
}

void WiFiClient_Init(void) 
{
    _sock = 0;
}

// ServerAddr can be Host or IP
// Example:
// WiFiClient_Connect("www.baidu.com", 80);
// WiFiClient_Connect("192.168.2.71", 80);
int32_t WiFiClient_Connect(uint8_t* NetAddr, uint16_t port)
{
    int32_t Result = 0;
    uint8_t _NetAddr[4] = {0, 0, 0, 0};

    // check parameter vaild
    if(NetAddr == NULL)
    {
        return (0);
    }

    if(WiFi_HostToIP(NetAddr, _NetAddr))       // Host
    {
        Result = _ConnectViaHost(NetAddr, port);
    }
    else                                       // IP
    {
        Result = _ConnectViaIP(_NetAddr, port);        
    }

    return (Result);
}

static int32_t _ConnectViaHost(uint8_t* host, uint16_t port) 
{
    uint8_t remote_addr[4] = {0, 0, 0, 0};

    if (WiFi_HostToIP(host, remote_addr))
    {
        return _ConnectViaIP(remote_addr, port);
    }
    return (0);
}

//static int32_t _ConnectViaIP(uint8_t* ip, uint16_t port) 
int32_t _ConnectViaIP(uint8_t* ip, uint16_t port) 
{
    int32_t cnt = 5000;

    //_sock = WiFi_SocketAvilGet();
    if (_sock != NO_SOCKET_AVAIL)
    {
        ServerDrv_StartClient(*((uint32_t *)ip), port, _sock);
        //_state[_sock] = _sock;

        while(cnt-- > 0)
        {
            if(WiFiClient_Connected())
            {
                break;
            }

            delay(2000);
        }

        if (!WiFiClient_Connected())
        {
            return (0);
        }
    }
    else
    {
        //Serial.println("No Socket available");
        return (0);
    }
    return (1);
}

uint16_t WiFiClient_WriteByte(uint8_t b) 
{
	  return WiFiClient_WriteBlock(&b, 1);
}

uint16_t WiFiClient_WriteBlock(uint8_t *buf, uint16_t size) 
{
    /*
    if (_sock >= MAX_SOCK_NUM)
    {
        //setWriteError();
        return (0);
    }
    */

    if (size==0)
    {
        //setWriteError();
        return (0);
    }

    if (!ServerDrv_SendData(_sock, buf, size))
    {
        //setWriteError();
        return (0);
    }
    if (!ServerDrv_CheckDataSent(_sock))
    {
        //setWriteError();
        return (0);
    }

    return (size);
}

int32_t WiFiClient_Available(void) 
{
    if (_sock != 255)
    {
        return ServerDrv_AvailData(_sock);
    }

    return (0);
}

uint8_t WiFiClient_ReadByte(void) 
{
    uint8_t b;

    if (!WiFiClient_Available())
    {
        return (-1);
    }

    ServerDrv_GetData(_sock, &b, 0);

    return (b);
}

int32_t WiFiClient_ReadBlock(uint8_t* buf, uint16_t size)
{
    uint16_t _size = size;
    if (!ServerDrv_GetDataBuf(_sock, buf, &_size))
    {
        return (-1);
    }
    return (0);
}

int32_t WiFiClient_Peek(void) 
{
    uint8_t b = 0;

    if (!WiFiClient_Available())
    {
        return -1;
    }

    ServerDrv_GetData(_sock, &b, 1);

    return (b);
}

void WiFiClient_Flush(void) 
{
    while (WiFiClient_Available())
    {
        WiFiClient_ReadByte();
    }
}

void WiFiClient_Stop(void) 
{
    uint32_t i = 0;

    if (_sock == 255)
    {
        return;
    }

    ServerDrv_StopClient(_sock);

    // wait a second for the connection to close
    while ((WiFiClient_Status() != CLOSED) && (i++ < 1000))
    {
        delay(10);
    }
    _sock = 255;
}

uint8_t WiFiClient_Connected(void) 
{
    uint8_t s = 0;

    if (_sock == 255) 
    {
        return 0;
    }
    else 
    {
        s = WiFiClient_Status();

        return !(s == LISTEN || s == CLOSED || s == FIN_WAIT_1 ||
                s == FIN_WAIT_2 || s == TIME_WAIT ||
                s == SYN_SENT || s== SYN_RCVD ||
                (s == CLOSE_WAIT && !WiFiClient_Available()));
    }
}

uint8_t WiFiClient_Status(void) 
{
    if (_sock == 255) 
    {
        return (CLOSED);
    }
    else 
    {
        return ServerDrv_GetClientState(_sock);
    }
}

