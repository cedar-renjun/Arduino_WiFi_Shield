#include "includes.h"

//static uint16_t _srcport = 1024;
static uint8_t _sock;
//uint8_t getFirstSocket();


static int _ConnectViaHost(const char* host, uint16_t port);
static int _ConnectViaIP(uint8_t* ip, uint16_t port);

static void delay(uint32_t tick)
{
    volatile uint32_t _tick = tick;
	while(_tick--);
}

// ServerAddr can be Host or IP
// Example:
// WiFiClientConnect("www.baidu.com", 80);
// WiFiClientConnect("192.168.2.71", 80);
int WiFiClientConnect(char *NetAddr, uint16_t port)
{
    int Result = 0;
    uint8_t _NetAddr[4] = {0, 0, 0, 0};

    // check parameter vaild
    if(NetAddr == NULL)
    {
        return (0);
    }

    if(WiFiHostToIP(NetAddr, _NetAddr))       // Host
    {
        Result = _ConnectViaHost(NetAddr, port);
    }
    else                                       // IP
    {
        Result = _ConnectViaIP(_NetAddr, port);        
    }

    return (Result);
}

static int _ConnectViaHost(const char* host, uint16_t port) 
{
    uint8_t remote_addr[4] = {0, 0, 0, 0};

    if (WiFiHostToIP(host, remote_addr))
    {
        return _ConnectViaIP(remote_addr, port);
    }
    return (0);
}

static int _ConnectViaIP(uint8_t* ip, uint16_t port) 
{
    _sock = WiFiSocketAvilGet();
    if (_sock != NO_SOCKET_AVAIL)
    {
        ServerDrvStartClient(*((uint32_t *)ip), port, _sock);
        _state[_sock] = _sock;

        //TODO
        /*
        unsigned long start = millis();

        // wait 4 second for the connection to close
        while (!connected() && millis() - start < 10000)
        {
            delay(1);
        }
        */

        if (!WiFiClientConnected())
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


uint16_t WiFiClientWriteByte(uint8_t b) 
{
	  return WiFiClientWriteBlock(&b, 1);
}

uint16_t WiFiClientWriteBlock(const uint8_t *buf, uint16_t size) 
{
    if (_sock >= MAX_SOCK_NUM)
    {
        //setWriteError();
        return (0);
    }
    if (size==0)
    {
        //setWriteError();
        return (0);
    }

    if (!ServerDrvSendData(_sock, buf, size))
    {
        //setWriteError();
        return (0);
    }
    if (!ServerDrvCheckDataSent(_sock))
    {
        //setWriteError();
        return (0);
    }

    return (size);
}

int WiFiClientAvailable(void) 
{
    if (_sock != 255)
    {
        return ServerDrvAvailData(_sock);
    }

    return (0);
}

int WiFiClientReadByte(void) 
{
    uint8_t b;

    if (!WiFiClientAvailable())
    {
        return (-1);
    }

    ServerDrvGetData(_sock, &b, 0);

    return (b);
}

int WiFiClientReadBlock(uint8_t* buf, uint16_t size)
{
    if (!ServerDrvGetDataBuf(_sock, buf, &size))
    {
        return (-1);
    }
    return (0);
}

int WiFiClientPeek(void) 
{
    uint8_t b;

    if (!WiFiClientAvailable())
    {
        return -1;
    }

    ServerDrvGetData(_sock, &b, 1);

    return (b);
}

void WiFiClientFlush(void) 
{
    while (WiFiClientAvailable())
    {
        WiFiClientReadByte();
    }
}

void WiFiClientStop(void) 
{
    uint32_t i = 0;

    if (_sock == 255)
    {
        return;
    }

    ServerDrvStopClient(_sock);

    // wait a second for the connection to close
    while ((WiFiClientStatus() != CLOSED) && (i++ < 1000))
    {
        delay(1);
    }
    _sock = 255;
}

uint8_t WiFiClientConnected(void) 
{
    uint8_t s = 0;

    if (_sock == 255) 
    {
        return 0;
    }
    else 
    {
        s = WiFiClientStatus();

        return !(s == LISTEN || s == CLOSED || s == FIN_WAIT_1 ||
                s == FIN_WAIT_2 || s == TIME_WAIT ||
                s == SYN_SENT || s== SYN_RCVD ||
                (s == CLOSE_WAIT && !WiFiClientAvailable()));
    }
}

uint8_t WiFiClientStatus() 
{
    if (_sock == 255) 
    {
        return (CLOSED);
    }
    else 
    {
        return ServerDrvGetClientState(_sock);
    }
}

