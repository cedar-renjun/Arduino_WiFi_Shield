#include <stdarg.h>
#include "includes.h"

int16_t   _state[MAX_SOCK_NUM] = { 0 };
uint16_t  _server_port[MAX_SOCK_NUM] = { 0 };

static int _WiFiBeginOpen(char* ssid);
static int _WiFiBeginWep(char* ssid, uint8_t key_idx, const char *key);
static int _WiFiBeginWpa(char* ssid, const char *passphrase);

static void delay(uint32_t tick)
{
    volatile uint32_t _tick = tick;
	while(_tick--);
}



void WiFiInit(void)
{
    WiFiDrvInit();
}

uint8_t WiFiPortAvilGet(void)
{
    uint8_t i = 0;

    for (i = 0; i < MAX_SOCK_NUM; i++)
    {
        if (_server_port[i] == 0)
        {
             return (i);
        }
    }

    return (NO_SOCKET_AVAIL);
}

uint8_t WiFiSocketAvilGet(void)
{
    uint8_t i = 0;

    for (i = 0; i < MAX_SOCK_NUM; i++) 
    {
      if (_state[i] == 0)
      {
          return (i);
      }
    }

    return (SOCK_NOT_AVAIL);
}


char* WiFiFwVerGet(void)
{
    return  WiFiDrvGetFwVersion();
}

int WiFiBegin(uint8_t NetType, char* ssid, ...)
{
    char  * _ssid      = ssid;
    char  * _key       = NULL;
    char  * _passphrase = NULL;
    uint8_t _key_idx   = 0;
    uint8_t status     = WL_IDLE_STATUS;
    va_list para;
    //va_start(para, ssid);

    switch(NetType)
    {
        case OPEN:
            {
                status = _WiFiBeginOpen(_ssid);
                break;
            }
        case WPA:
            {
                va_start(para, ssid);                
                _passphrase = (char *)va_arg(para, int);
                status = _WiFiBeginWpa(_ssid, _passphrase);
                break;
            }
        case WEP:
            {
                va_start(para, ssid);
                //_key_idx = (uint8_t)va_arg(para, int);
                _key_idx = (uint8_t)va_arg(para, int);
                _key     = (char *)va_arg(para, int);
                status = _WiFiBeginWep(_ssid, _key_idx, _key);
                break;
            }
        default:
            {
                status = WL_CONNECT_FAILED;
            }
    }

    va_end(para);
    return (status);
}

static int _WiFiBeginOpen(char* ssid)
{
    uint8_t status   = WL_IDLE_STATUS;
    uint8_t attempts = WL_MAX_ATTEMPT_CONNECTION;

   if (WiFiDrvSetNetwork(ssid, strlen(ssid)) != WL_FAILURE)
   {
       do
       {
           delay(WL_DELAY_START_CONNECTION);
           status = WiFiDrvGetConnectionStatus();
       }
       while ((( status == WL_IDLE_STATUS)||(status == WL_SCAN_COMPLETED))&&(--attempts>0));
   }else
   {
       status = WL_CONNECT_FAILED;
   }
   return (status);
}

static int _WiFiBeginWep(char* ssid, uint8_t key_idx, const char *key)
{
    uint8_t status   = WL_IDLE_STATUS;
    uint8_t attempts = WL_MAX_ATTEMPT_CONNECTION;

    // set encryption key
   if (WiFiDrvSetKey(ssid, strlen(ssid), key_idx, key, strlen(key)) != WL_FAILURE)
   {
       do
       {
           delay(WL_DELAY_START_CONNECTION);
           status = WiFiDrvGetConnectionStatus();
       }
       while ((( status == WL_IDLE_STATUS)||(status == WL_SCAN_COMPLETED))&&(--attempts>0));
   }else
   {
       status = WL_CONNECT_FAILED;
   }
   return (status);
}

static int  _WiFiBeginWpa(char* ssid, const char *passphrase)
{
    uint8_t status   = WL_IDLE_STATUS;
    uint8_t attempts = WL_MAX_ATTEMPT_CONNECTION;

    // set passphrase
    if (WiFiDrvSetPassphrase(ssid, strlen(ssid), passphrase, strlen(passphrase)) != WL_FAILURE)
    {
       do
       {
           delay(WL_DELAY_START_CONNECTION);
           status = WiFiDrvGetConnectionStatus();
       }
       while ((( status == WL_IDLE_STATUS)||(status == WL_SCAN_COMPLETED))&&(--attempts>0));
    }else
    {
        status = WL_CONNECT_FAILED;
    }
    return (status);
}

int WiFiDisconnect(void)
{
    return WiFiDrvDisconnect();
}

uint8_t* WiFiMacAddrGet(uint8_t* mac)
{
    uint8_t* _mac = WiFiDrvGetMacAddress();

    memcpy(mac, _mac, WL_MAC_ADDR_LENGTH);

    return (mac);
}
   
void WiFiLocalIPGet(uint8_t * ip)
{
    WiFiDrvGetIpAddress(ip);
}

void WiFiSubnetMaskGet(uint8_t * mask)
{
    WiFiDrvGetSubnetMask(mask);
}

void WiFiGatewayIPGet(uint8_t * gateway)
{
    WiFiDrvGetGatewayIP(gateway);
}

uint8_t* WiFiBSSIDGet(uint8_t* bssid)
{
    uint8_t* _bssid = WiFiDrvGetCurrentBSSID();
    memcpy(bssid, _bssid, WL_MAC_ADDR_LENGTH);
    return (bssid);
}

int8_t WiFiScanNetworks(void)
{
    uint8_t attempts      = 10;
    uint8_t numOfNetworks = 0;

    if (WiFiDrvStartScanNetworks() == WL_FAILURE)
    {
        return (WL_FAILURE);
    }
    do
    {
        delay(2000);
        numOfNetworks = WiFiDrvGetScanNetworks();
    }
    while((numOfNetworks == 0) && (--attempts > 0));

    return (numOfNetworks);
}

char* WiFiSSIDGet(uint8_t networkItem)
{
    if(CURRENT == networkItem)
    {
        return WiFiDrvGetCurrentSSID();
    }
    else
    {
        return WiFiDrvGetSSIDNetoworks(networkItem);
    }
}

uint8_t WiFiEncryptionTypeGet(uint8_t networkItem)
{
    if(CURRENT == networkItem)
    {
        return WiFiDrvGetCurrentEncryptionType();
    }
    else
    {
        return WiFiDrvGetEncTypeNetowrks(networkItem);
    }
}

int32_t WiFiRSSIGet(uint8_t networkItem)
{
    if(CURRENT == networkItem)
    {
        return WiFiDrvGetCurrentRSSI();
    }
    else
    {
        return WiFiDrvGetRSSINetoworks(networkItem);
    }
}

uint8_t WiFiStatusGet(void)
{
    return WiFiDrvGetConnectionStatus();
}

int WiFiHostToIP(const char* aHostname, uint8_t * aResult)
{
    return WiFiDrvGetHostByName(aHostname, aResult);
}

int IPToNetAddr(char * IPStr, uint8_t * NetAddr)
{
    uint32_t _IP[4] = {0, 0, 0, 0};
    uint8_t cnt = 0;
    uint8_t idx = 0;
    char _str = NULL;
    
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

