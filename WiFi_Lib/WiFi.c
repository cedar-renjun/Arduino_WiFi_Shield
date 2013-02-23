#include "WiFi.h"
#include "wifi_drv.h"
#include "wl_definitions.h"
#include "wl_types.h"

//int16_t   _state[MAX_SOCK_NUM];
//uint16_t  _server_port[MAX_SOCK_NUM];

//int16_t   _state = 0;
uint8_t   _sock = 0;

//TODO
static int _WiFiBeginOpen(uint8_t* ssid);
int _WiFiBeginWep(uint8_t* ssid, uint8_t key_idx,uint8_t* key);
static int _WiFiBeginWpa(uint8_t* ssid, uint8_t* passphrase);

static void delay(volatile uint32_t tick)
{
	while(tick--);
}

void WiFi_Init(void)
{
    WiFiDrv_Init();
}

/*
uint8_t WiFi_PortAvilGet(void)
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
*/

/*
uint8_t WiFi_SocketAvilGet(void)
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
*/

uint8_t* WiFi_FwVerGet(void)
{
    return  WiFiDrv_GetFwVersion();
}

int32_t WiFi_Begin(uint8_t NetType, uint8_t* ssid, ...)
{
    uint8_t* _ssid      = ssid;
    uint8_t* _key       = NULL;
    uint8_t* _passphrase = NULL;
    uint8_t  _key_idx   = 0;
    int32_t  status     = WL_IDLE_STATUS;
    va_list  para;
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
                _passphrase = (uint8_t *)va_arg(para, int);
                status = _WiFiBeginWpa(_ssid, _passphrase);
                break;
            }
        case WEP:
            {
                va_start(para, ssid);
                //_key_idx = (uint8_t)va_arg(para, int);
                _key_idx = (uint8_t)va_arg(para, int);
                _key     = (uint8_t*)va_arg(para, int);
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

static int _WiFiBeginOpen(uint8_t* ssid)
{
    uint8_t status   = WL_IDLE_STATUS;
    uint8_t attempts = WL_MAX_ATTEMPT_CONNECTION;

   if (WiFiDrv_SetNetwork(ssid, strlen((const char *)ssid)) != WL_FAILURE)
   {
       do
       {
           delay(WL_DELAY_START_CONNECTION);
           status = WiFiDrv_GetConnectionStatus();
       }
       while ((( status == WL_IDLE_STATUS)||(status == WL_SCAN_COMPLETED))&&(--attempts>0));
   }else
   {
       status = WL_CONNECT_FAILED;
   }
   return (status);
}

int _WiFiBeginWep(uint8_t* ssid, uint8_t key_idx, uint8_t* key)
{
    uint8_t status   = WL_IDLE_STATUS;
    uint8_t attempts = WL_MAX_ATTEMPT_CONNECTION;

    // set encryption key
   if (WiFiDrv_SetKey(ssid, strlen((const char *)ssid), key_idx, key, strlen((const char *)key)) != WL_FAILURE)
   {
       do
       {
           delay(WL_DELAY_START_CONNECTION);
           status = WiFiDrv_GetConnectionStatus();
       }
       while ((( status == WL_IDLE_STATUS)||(status == WL_SCAN_COMPLETED))&&(--attempts>0));
   }else
   {
       status = WL_CONNECT_FAILED;
   }
   return (status);
}

static int  _WiFiBeginWpa(uint8_t* ssid, uint8_t* passphrase)
{
    uint8_t status   = WL_IDLE_STATUS;
    uint8_t attempts = WL_MAX_ATTEMPT_CONNECTION;

    // set passphrase
    if (WiFiDrv_SetPassphrase(ssid, strlen((const char *)ssid), passphrase, strlen((const char *)passphrase)) != WL_FAILURE)
    {
       do
       {
           delay(WL_DELAY_START_CONNECTION);
           status = WiFiDrv_GetConnectionStatus();
       }
       while ((( status == WL_IDLE_STATUS)||(status == WL_SCAN_COMPLETED))&&(--attempts>0));
    }else
    {
        status = WL_CONNECT_FAILED;
    }
    return (status);
}

int8_t WiFi_Disconnect(void)
{
    return WiFiDrv_Disconnect();
}

uint8_t* WiFi_MacAddrGet(uint8_t* mac)
{
    uint8_t* _mac = WiFiDrv_GetMacAddress();

    memcpy(mac, _mac, WL_MAC_ADDR_LENGTH);

    return (mac);
}
   
void WiFi_LocalIPGet(uint8_t * ip)
{
    WiFiDrv_GetIpAddress(ip);
}

void WiFi_SubnetMaskGet(uint8_t * mask)
{
    WiFiDrv_GetSubnetMask(mask);
}

void WiFi_GatewayIPGet(uint8_t * gateway)
{
    WiFiDrv_GetGatewayIP(gateway);
}

uint8_t* WiFi_BSSIDGet(uint8_t* bssid)
{
    uint8_t* _bssid = WiFiDrv_GetCurrentBSSID();
    memcpy(bssid, _bssid, WL_MAC_ADDR_LENGTH);
    return (bssid);
}

int8_t WiFi_ScanNetworks(void)
{
    int8_t  attempts      = 10;
    uint8_t numOfNetworks = 0;

    if (WiFiDrv_StartScanNetworks() == WL_FAILURE)
    {
        return (WL_FAILURE);
    }
    do
    {
        delay(2000);
        numOfNetworks = WiFiDrv_GetScanNetworks();
    }
    while((numOfNetworks == 0) && (--attempts > 0));

    return (numOfNetworks);
}

uint8_t* WiFi_SSIDGet(uint8_t networkItem)
{
    return WiFiDrv_GetSSIDNetoworks(networkItem);
}

uint8_t WiFi_EncryptionTypeGet(uint8_t networkItem)
{
    return WiFiDrv_GetEncTypeNetowrks(networkItem);
}

int32_t WiFi_RSSIGet(uint8_t networkItem)
{
    return WiFiDrv_GetRSSINetoworks(networkItem);
}

uint8_t WiFi_StatusGet(void)
{
    return WiFiDrv_GetConnectionStatus();
}

int32_t WiFi_HostToIP(uint8_t* aHostname, uint8_t * aResult)
{
    return WiFiDrv_GetHostByName(aHostname, aResult);
}

int32_t IPToNetAddr(uint8_t * IPStr, uint8_t * NetAddr)
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

