#include "includes.h"

// firmware version string length
#define WL_FW_VER_LENGTH 6
// firmware version string in the format a.b.c
static char fwVersion[WL_FW_VER_LENGTH];

// settings of requested network
static char 	_networkSsid[WL_NETWORKS_LIST_MAXNUM][WL_SSID_MAX_LENGTH] =
                 {{"1"},{"2"},{"3"},{"4"},{"5"}};

static int32_t 	_networkRssi[WL_NETWORKS_LIST_MAXNUM];
static uint8_t 	_networkEncr[WL_NETWORKS_LIST_MAXNUM];

// settings of current selected network
static char 	_ssid[WL_SSID_MAX_LENGTH];
static uint8_t _bssid[WL_MAC_ADDR_LENGTH];
static uint8_t _mac[WL_MAC_ADDR_LENGTH];
static uint8_t _localIp[WL_IPV4_LENGTH];
static uint8_t _subnetMask[WL_IPV4_LENGTH];
static uint8_t _gatewayIp[WL_IPV4_LENGTH];

// Internal function
static uint8_t _ReqHostByName(const char* aHostname);
static int     _GetHostByName(uint8_t *aResult);
static void delay(uint32_t tick)
{
    volatile uint32_t _tick = tick;
	while(_tick--);
}

static void WiFiDrvGetNetworkData(uint8_t *ip, uint8_t *mask, uint8_t *gwip)
{
    uint8_t _dummy = DUMMY_DATA;

    tParam params[PARAM_NUMS_3] = 
    {
        {0, (char*)ip  },
        {0, (char*)mask},
        {0, (char*)gwip}
    };

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrvWaitForSlaveReady();
    SpiDrvSlaveSelect();

    // Send Command
    SpiDrvSendCmd(GET_IPADDR_CMD, PARAM_NUMS_1);

    SpiDrvSendParamL(&_dummy, sizeof(_dummy), LAST_PARAM);

    //Wait the reply elaboration
    SpiDrvWaitForSlaveReady();

    // Wait for reply
    SpiDrvWaitResponseParams(GET_IPADDR_CMD, PARAM_NUMS_3, params);

    SpiDrvSlaveDeselect();
}

void WiFiDrvInit(void)
{
    SpiDrvBegin();
}

int8_t WiFiDrvSetNetwork(char* ssid, uint8_t ssid_len)
{
    uint8_t _data = 0;
    uint8_t _dataLen = 0;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrvWaitForSlaveReady();
    SpiDrvSlaveSelect();

    // Send Command
    SpiDrvSendCmd(SET_NET_CMD, PARAM_NUMS_1);
    SpiDrvSendParamL((uint8_t*)ssid, ssid_len, LAST_PARAM);

    //Wait the reply elaboration
    SpiDrvWaitForSlaveReady();

    // Wait for reply
    if (!SpiDrvWaitResponseCmd(SET_NET_CMD, PARAM_NUMS_1, &_data, &_dataLen))
    {
        //WARN("error waitResponse");
        _data = WL_FAILURE;
    }
    SpiDrvSlaveDeselect();

    if(_data == WIFI_SPI_ACK) 
    {
        return (WL_SUCCESS);
    }
    else
    {
        return (WL_FAILURE);
    }
}

int8_t WiFiDrvSetPassphrase(char* ssid, uint8_t ssid_len, const char *passphrase, const uint8_t len)
{
    uint8_t _data = 0;
    uint8_t _dataLen = 0;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrvWaitForSlaveReady();
    SpiDrvSlaveSelect();

    // Send Command
    SpiDrvSendCmd(SET_PASSPHRASE_CMD, PARAM_NUMS_2);
    SpiDrvSendParamL((uint8_t*)ssid, ssid_len, NO_LAST_PARAM);
    SpiDrvSendParamL((uint8_t*)passphrase, len, LAST_PARAM);

    //Wait the reply elaboration
    SpiDrvWaitForSlaveReady();

    // Wait for reply
    if (!SpiDrvWaitResponseCmd(SET_PASSPHRASE_CMD, PARAM_NUMS_1, &_data, &_dataLen))
    {
        //WARN("error waitResponse");
        _data = WL_FAILURE;
    }
    SpiDrvSlaveDeselect();
    return (_data);
}


int8_t WiFiDrvSetKey(char* ssid, uint8_t ssid_len, uint8_t key_idx, const void *key, const uint8_t len)
{
    uint8_t _data = 0;
    uint8_t _dataLen = 0;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrvWaitForSlaveReady();
    SpiDrvSlaveSelect();

    // Send Command
    SpiDrvSendCmd(SET_KEY_CMD, PARAM_NUMS_3);
    SpiDrvSendParamL((uint8_t*)ssid, ssid_len, NO_LAST_PARAM);
    SpiDrvSendParamL(&key_idx, KEY_IDX_LEN, NO_LAST_PARAM);
    SpiDrvSendParamL((uint8_t*)key, len, LAST_PARAM);
    
    //Wait the reply elaboration
    SpiDrvWaitForSlaveReady();

    // Wait for reply
    if (!SpiDrvWaitResponseCmd(SET_KEY_CMD, PARAM_NUMS_1, &_data, &_dataLen))
    {
        //WARN("error waitResponse");
        _data = WL_FAILURE;
    }
    SpiDrvSlaveDeselect();
    return (_data);
}
                        
int8_t WiFiDrvDisconnect(void)
{
    uint8_t _dummy = DUMMY_DATA;
    uint8_t _data = 0;
    uint8_t _dataLen = 0;
    int8_t result = 0;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrvWaitForSlaveReady();
    SpiDrvSlaveSelect();

    // Send Command
    SpiDrvSendCmd(DISCONNECT_CMD, PARAM_NUMS_1);

    SpiDrvSendParamL(&_dummy, 1, LAST_PARAM);

    //Wait the reply elaboration
    SpiDrvWaitForSlaveReady();

    // Wait for reply
    result = SpiDrvWaitResponseCmd(DISCONNECT_CMD, PARAM_NUMS_1, &_data, &_dataLen);

    SpiDrvSlaveDeselect();

    return (result);
}

uint8_t WiFiDrvGetConnectionStatus(void)
{
    uint8_t _data = -1;
    uint8_t _dataLen = 0;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrvWaitForSlaveReady();
    SpiDrvSlaveSelect();

    // Send Command
    SpiDrvSendCmd(GET_CONN_STATUS_CMD, PARAM_NUMS_0);

    //Wait the reply elaboration
    SpiDrvWaitForSlaveReady();

    // Wait for reply
    SpiDrvWaitResponseCmd(GET_CONN_STATUS_CMD, PARAM_NUMS_1, &_data, &_dataLen);

    SpiDrvSlaveDeselect();

    return (_data);
}

uint8_t* WiFiDrvGetMacAddress(void)
{
    uint8_t _dummy = DUMMY_DATA;
    uint8_t _dataLen = 0;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrvWaitForSlaveReady();
    SpiDrvSlaveSelect();

    // Send Command
    SpiDrvSendCmd(GET_MACADDR_CMD, PARAM_NUMS_1);

    SpiDrvSendParamL(&_dummy, 1, LAST_PARAM);

    //Wait the reply elaboration
    SpiDrvWaitForSlaveReady();

    // Wait for reply
    SpiDrvWaitResponseCmd(GET_MACADDR_CMD, PARAM_NUMS_1, _mac, &_dataLen);

    SpiDrvSlaveDeselect();

    return (_mac);
}

void WiFiDrvGetIpAddress(uint8_t *ip)
{
    WiFiDrvGetNetworkData(_localIp, _subnetMask, _gatewayIp);
    memcpy(ip, _localIp, WL_IPV4_LENGTH);
}

 void WiFiDrvGetSubnetMask(uint8_t *mask)
 {
    WiFiDrvGetNetworkData(_localIp, _subnetMask, _gatewayIp);
    memcpy(mask, _subnetMask, WL_IPV4_LENGTH);
 }

 void WiFiDrvGetGatewayIP(uint8_t *ip)
 {
    WiFiDrvGetNetworkData(_localIp, _subnetMask, _gatewayIp);
    memcpy(ip, _gatewayIp, WL_IPV4_LENGTH);
 }

char* WiFiDrvGetCurrentSSID(void)
{
    uint8_t _dummy = DUMMY_DATA;
    uint8_t _dataLen = 0;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrvWaitForSlaveReady();
    SpiDrvSlaveSelect();

    // Send Command
    SpiDrvSendCmd(GET_CURR_SSID_CMD, PARAM_NUMS_1);

    SpiDrvSendParamL(&_dummy, 1, LAST_PARAM);

    //Wait the reply elaboration
    SpiDrvWaitForSlaveReady();

    // Wait for reply
    SpiDrvWaitResponseCmd(GET_CURR_SSID_CMD, PARAM_NUMS_1, (uint8_t*)_ssid, &_dataLen);

    SpiDrvSlaveDeselect();

    return (_ssid);
}

uint8_t* WiFiDrvGetCurrentBSSID(void)
{
    uint8_t _dummy = DUMMY_DATA;
    uint8_t _dataLen = 0;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrvWaitForSlaveReady();
    SpiDrvSlaveSelect();

    // Send Command
    SpiDrvSendCmd(GET_CURR_BSSID_CMD, PARAM_NUMS_1);

    SpiDrvSendParamL(&_dummy, 1, LAST_PARAM);

    //Wait the reply elaboration
    SpiDrvWaitForSlaveReady();

    // Wait for reply
    SpiDrvWaitResponseCmd(GET_CURR_BSSID_CMD, PARAM_NUMS_1, _bssid, &_dataLen);

    SpiDrvSlaveDeselect();

    return (_bssid);
}

int32_t WiFiDrvGetCurrentRSSI(void)
{
    uint8_t _dummy = DUMMY_DATA;
    uint8_t _dataLen = 0;
    int32_t rssi = 0;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrvWaitForSlaveReady();
    SpiDrvSlaveSelect();

    // Send Command
    SpiDrvSendCmd(GET_CURR_RSSI_CMD, PARAM_NUMS_1);

    SpiDrvSendParamL(&_dummy, 1, LAST_PARAM);

    //Wait the reply elaboration
    SpiDrvWaitForSlaveReady();

    // Wait for reply
    SpiDrvWaitResponseCmd(GET_CURR_RSSI_CMD, PARAM_NUMS_1, (uint8_t*)&rssi, &_dataLen);

    SpiDrvSlaveDeselect();

    return (rssi);
}

uint8_t WiFiDrvGetCurrentEncryptionType(void)
{
    uint8_t _dummy = DUMMY_DATA;
    uint8_t dataLen = 0;
    uint8_t encType = 0;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrvWaitForSlaveReady();
    SpiDrvSlaveSelect();

    // Send Command
    SpiDrvSendCmd(GET_CURR_ENCT_CMD, PARAM_NUMS_1);

    SpiDrvSendParamL(&_dummy, 1, LAST_PARAM);

    //Wait the reply elaboration
    SpiDrvWaitForSlaveReady();

    // Wait for reply
    SpiDrvWaitResponseCmd(GET_CURR_ENCT_CMD, PARAM_NUMS_1, (uint8_t*)&encType, &dataLen);

    SpiDrvSlaveDeselect();

    return (encType);
}

int8_t WiFiDrvStartScanNetworks(void)
{
    uint8_t _data = 0;
    uint8_t _dataLen = 0;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrvWaitForSlaveReady();
    SpiDrvSlaveSelect();

    // Send Command
    SpiDrvSendCmd(START_SCAN_NETWORKS, PARAM_NUMS_0);

    //Wait the reply elaboration
    SpiDrvWaitForSlaveReady();

    // Wait for reply

    if (!SpiDrvWaitResponseCmd(START_SCAN_NETWORKS, PARAM_NUMS_1, &_data, &_dataLen))
    {
        //WARN("error waitResponse");
        _data = WL_FAILURE;
    }

    SpiDrvSlaveDeselect();

    if (_data == (uint8_t)WL_FAILURE)
    {  
        return (_data);
    }
    else
    {
        return (WL_SUCCESS);
    } 
}

uint8_t WiFiDrvGetScanNetworks(void)
{
    uint8_t ssidListNum = 0;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrvWaitForSlaveReady();
    SpiDrvSlaveSelect();

    // Send Command
    SpiDrvSendCmd(SCAN_NETWORKS, PARAM_NUMS_0);

    //Wait the reply elaboration
    SpiDrvWaitForSlaveReady();

    // Wait for reply
    SpiDrvWaitResponse(SCAN_NETWORKS, &ssidListNum, (uint8_t**)_networkSsid, WL_NETWORKS_LIST_MAXNUM);

    SpiDrvSlaveDeselect();

    return (ssidListNum);
}

char* WiFiDrvGetSSIDNetoworks(uint8_t networkItem)
{
    if (networkItem >= WL_NETWORKS_LIST_MAXNUM)
        return (NULL);

    return (_networkSsid[networkItem]);
}

uint8_t WiFiDrvGetEncTypeNetowrks(uint8_t networkItem)
{
    uint8_t dataLen = 0;
    uint8_t encType = 0;

    if (networkItem >= WL_NETWORKS_LIST_MAXNUM)
    {
        return (NULL);
    }

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrvWaitForSlaveReady();
    SpiDrvSlaveSelect();

    // Send Command
    SpiDrvSendCmd(GET_IDX_ENCT_CMD, PARAM_NUMS_1);

    SpiDrvSendParamL(&networkItem, 1, LAST_PARAM);

    //Wait the reply elaboration
    SpiDrvWaitForSlaveReady();

    // Wait for reply
    SpiDrvWaitResponseCmd(GET_IDX_ENCT_CMD, PARAM_NUMS_1, (uint8_t*)&encType, &dataLen);

    SpiDrvSlaveDeselect();

    return (encType);
}

int32_t WiFiDrvGetRSSINetoworks(uint8_t networkItem)
{
    uint8_t dataLen = 0;
    int32_t networkRssi = 0;

    if (networkItem >= WL_NETWORKS_LIST_MAXNUM)
    {
        return (NULL);
    }

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrvWaitForSlaveReady();
    SpiDrvSlaveSelect();

    // Send Command
    SpiDrvSendCmd(GET_IDX_RSSI_CMD, PARAM_NUMS_1);

    SpiDrvSendParamL(&networkItem, 1, LAST_PARAM);

    //Wait the reply elaboration
    SpiDrvWaitForSlaveReady();

    // Wait for reply
    SpiDrvWaitResponseCmd(GET_IDX_RSSI_CMD, PARAM_NUMS_1, (uint8_t*)&networkRssi, &dataLen);

    SpiDrvSlaveDeselect();

    return (networkRssi);
}

static uint8_t _ReqHostByName(const char* aHostname)
{
    uint8_t _data    = 0;
    uint8_t result   = 0;
    uint8_t _dataLen = 0;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrvWaitForSlaveReady();
    SpiDrvSlaveSelect();

    // Send Command
    SpiDrvSendCmd(REQ_HOST_BY_NAME_CMD, PARAM_NUMS_1);
    SpiDrvSendParamL((uint8_t*)aHostname, strlen(aHostname), LAST_PARAM);

    //Wait the reply elaboration
    SpiDrvWaitForSlaveReady();

    // Wait for reply
    result = SpiDrvWaitResponseCmd(REQ_HOST_BY_NAME_CMD, PARAM_NUMS_1, &_data, &_dataLen);
    SpiDrvSlaveDeselect();

    return (result);
}

static int _GetHostByName(uint8_t *aResult)
{
    uint8_t  _dataLen = 0;
    int      result   = 0;
    uint8_t  _ipAddr[WL_IPV4_LENGTH] = {0, 0, 0, 0};
    uint8_t  dummy[4] = {0xFF,0xFF,0xFF,0xFF};

    //WAIT_FOR_SLAVE_SELECT
    SpiDrvWaitForSlaveReady();
    SpiDrvSlaveSelect();

    // Send Command
    SpiDrvSendCmd(GET_HOST_BY_NAME_CMD, PARAM_NUMS_0);

    //Wait the reply elaboration
    SpiDrvWaitForSlaveReady();

    // Wait for reply
    if (!SpiDrvWaitResponseCmd(GET_HOST_BY_NAME_CMD, PARAM_NUMS_1, _ipAddr, &_dataLen))
    {
        //WARN("error waitResponse");
    }
    else
    {
        memcpy(aResult, _ipAddr, WL_IPV4_LENGTH);
        result = memcmp(aResult, dummy, WL_IPV4_LENGTH);
    }
    SpiDrvSlaveDeselect();

    return (result);
}

int WiFiDrvGetHostByName(const char* aHostname, uint8_t *aResult)
{
    uint8_t retry = 10;

    if (_ReqHostByName(aHostname))
    {
        while(!_GetHostByName(aResult) && --retry > 0)
        {
            //TODO
            delay(1000);
        }
    }
    else
    {
        return (0);
    }

    return (retry > 0);
}

char*  WiFiDrvGetFwVersion(void)
{
    uint8_t _dataLen = 0;
    //WAIT_FOR_SLAVE_SELECT();
    SpiDrvWaitForSlaveReady();
    SpiDrvSlaveSelect();

    // Send Command
    SpiDrvSendCmd(GET_FW_VERSION_CMD, PARAM_NUMS_0);

    //Wait the reply elaboration
    SpiDrvWaitForSlaveReady();

    // Wait for reply
    if (!SpiDrvWaitResponseCmd(GET_FW_VERSION_CMD, PARAM_NUMS_1, (uint8_t*)fwVersion, &_dataLen))
    {
        //WARN("error waitResponse");
    }
    SpiDrvSlaveDeselect();
    return (fwVersion);
}

/*
static int IPToNetAddr(char * IPStr, uint8_t * NetAddr)
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
*/
