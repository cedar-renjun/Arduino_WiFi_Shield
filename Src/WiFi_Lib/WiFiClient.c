
#include "wl_definitions.h"
#include "wl_types.h"
#include "WiFi.h"
#include "WiFiClient.h"
#include "server_drv.h"

static int32_t _ConnectViaHost(uint8_t* host, uint16_t port);
static int32_t _ConnectViaIP(uint8_t* ip, uint16_t port);
static int32_t _IPToNetAddr(uint8_t* IPStr, uint8_t * NetAddr);

void WiFiClient_Init(void) 
{
    _sock = 0;
}

// ServerAddr can be Host or IP
// Example:
// WiFiClient_Connect("www.baidu.com", 80);
// WiFiClient_Connect("61.135.169.125", 80);
// return 1: succuss 0:failure
int32_t WiFiClient_Connect(uint8_t* NetAddr, uint16_t port)
{
    int32_t Result      = 0;
    uint8_t _NetAddr[4] = {0, 0, 0, 0};

    // check parameter vaild
    if(NetAddr == NULL)
    {
        return (0);
    }

    if(_IPToNetAddr(NetAddr, _NetAddr))           // Host
    {
        Result = _ConnectViaHost(NetAddr, port);
    }
    else                                           // IP
    {
        Result = _ConnectViaIP(_NetAddr, port);        
    }

    return (Result);
}

uint16_t WiFiClient_WriteByte(uint8_t b) 
{
	  return WiFiClient_WriteBlock(&b, 1);
}

uint16_t WiFiClient_WriteBlock(uint8_t *buf, uint16_t size) 
{
    if (size==0)
    {
        //Size Error
        return (0);
    }

    if (!ServerDrv_SendData(_sock, buf, size))
    {
        //Send Failure
        return (0);
    }
    if (!ServerDrv_CheckDataSent(_sock))
    {
        //Send Data not completed.
        return (0);
    }

    //Success
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
    while ((WiFiClient_Status() != CLOSED) && (i++ < 500))
    {
        DelayMs(2);
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

static int32_t _IPToNetAddr(uint8_t * IPStr, uint8_t * NetAddr)
{
    uint32_t _IP[4] = {0, 0, 0, 0};
    uint8_t cnt = 0;
    uint8_t idx = 0;
    uint8_t _str = NULL;
    
    // Check input paramters vaild
    if(IPStr == NULL || NetAddr == NULL)
    {
        return (-1);
    }

    while((_str = *IPStr++) != NULL)
    {
        if(_str == '.')
        {
            // Clear the count, cnt MUST <= 3
            cnt = 0;            
            if(_IP[idx] > 255)
            {
                return (-1);
            }
            idx = idx + 1;
        }
        else if(_str >= '0' && _str <= '9')  // '0' --> '9'
        {            
            if(cnt++ < 3 && idx <= 3)
            {
                _IP[idx] = (10 * _IP[idx]) + (_str - '0');
            }
            else
            {
                return (-1);
            }
        }
        else
        {
            return (-1);
        }
    }

    if(_IP[idx] > 255)
    {
        return (-1);
    }

    // Copy Buffer to user space
    NetAddr[0] = (uint8_t)_IP[0];
    NetAddr[1] = (uint8_t)_IP[1];
    NetAddr[2] = (uint8_t)_IP[2];
    NetAddr[3] = (uint8_t)_IP[3];

    return (0);
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

static int32_t _ConnectViaIP(uint8_t* ip, uint16_t port) 
{
    //Wait 10S to connect to webserver.
    int32_t cnt = 10000;
    
    if (_sock != NO_SOCKET_AVAIL)
    {        
        ServerDrv_StartClient(*((uint32_t *)ip), port, _sock);
        
        while(cnt-- > 0)
        {            
            if(WiFiClient_Connected())            
            {
                break;
            }

            DelayMs(1);
        }

        if (!WiFiClient_Connected())        
        {
            return (0);
        }
    }
    else
    {
        //No Socket available
        return (0);
    }
    return (1);
}
