#include "includes.h"
//Comment this function
#if 0
void WiFiServerBegin(uint16_t port)
{
    uint8_t _sock = WiFiClass::getSocket();
    if (_sock != NO_SOCKET_AVAIL)
    {
        ServerDrv::startServer(_port, _sock);
        WiFiClass::_server_port[_sock] = _port;
    }
}

WiFiClient WiFiServerAvailable(byte* status)
{
    uint8_t _status              = 0;
    uint8_t _ser_status          = 0;
    static int cycle_server_down = 0;
    const int TH_SERVER_DOWN     = 50;

    for (int sock = 0; sock < MAX_SOCK_NUM; sock++)
    {
        if (WiFiClass::_server_port[sock] == _port)
        {
            WiFiClient client(sock);
            _status = client.status();
            _ser_status = this->status();

            if (status != NULL)
                *status = _status;

            //server not in listen state, restart it
            if ((_ser_status == 0)&&(cycle_server_down++ > TH_SERVER_DOWN))
            {
                ServerDrvStartServer(_port, sock);
                cycle_server_down = 0;
            }

            if (_status == ESTABLISHED)
            {                
                return (client);
            }
        }
    }

    return WiFiClient(255);
}

uint8_t WiFiServerStatus(void) 
{
    return ServerDrvGetServerState(0);
}


uint16_t WiFiServerWrite(const uint8_t *buffer, uint16_t size)
{
    uint16_t n    = 0;
    uint8_t  sock = 0;

    for (sock = 0; sock < MAX_SOCK_NUM; sock++)
    {
        if (_server_port[sock] != 0)
        {
            //TODO
            //WiFiClient client(sock);

            if (_server_port[sock] == _port &&
                    WiFiClientStatus() == ESTABLISHED)
            {                
                n += WiFiClientWriteBlock(buffer, size);
            }
        }
    }
    return (n);
}
#endif // comment this function
