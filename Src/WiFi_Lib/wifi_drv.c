#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include "spi_drv.h"
#include "wifi_drv.h"
#include "wifi_spi.h"
#include "wl_types.h"

static uint8_t  _networkSsid[WL_NETWORKS_LIST_MAXNUM][WL_SSID_MAX_LENGTH];
//static int32_t  _networkRssi[WL_NETWORKS_LIST_MAXNUM];
//static uint8_t  _networkEncr[WL_NETWORKS_LIST_MAXNUM];

// firmware version string in the format a.b.c
static uint8_t  _fwVersion[WL_FW_VER_LENGTH];

// settings of current selected network
static uint8_t  _ssid[WL_SSID_MAX_LENGTH];
static uint8_t  _bssid[WL_MAC_ADDR_LENGTH];
static uint8_t  _mac[WL_MAC_ADDR_LENGTH];
static uint8_t  _localIp[WL_IPV4_LENGTH];
static uint8_t  _subnetMask[WL_IPV4_LENGTH];
static uint8_t  _gatewayIp[WL_IPV4_LENGTH];

static int32_t _GetHostByName(uint8_t *aResult);

void WiFiDrv_GetNetworkData(uint8_t *ip, uint8_t *mask, uint8_t *gwip)
{
    uint8_t _dummy = DUMMY_DATA;

    tParam params[PARAM_NUMS_3] =
    {
        {0, ip  },
        {0, mask},
        {0, gwip}
    };

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrv_WaitForSlaveReady();
    SpiDrv_SlaveSelect();

    // Send Command
    SpiDrv_SendCmd(GET_IPADDR_CMD, PARAM_NUMS_1);

    SpiDrv_SendParam(&_dummy, sizeof(_dummy), LAST_PARAM);

    //Wait the reply elaboration
    SpiDrv_WaitForSlaveReady();

    // Wait for reply
    SpiDrv_WaitResponseParams(GET_IPADDR_CMD, PARAM_NUMS_3, params);

    SpiDrv_SlaveDeselect();
}

void WiFiDrv_Init(void)
{
    SpiDrv_Init();
}

int8_t WiFiDrv_SetNetwork(uint8_t* ssid, uint8_t ssid_len)
{
    uint8_t _data    = 0;
    uint8_t _dataLen = 0;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrv_WaitForSlaveReady();
    SpiDrv_SlaveSelect();

    // Send Command
    SpiDrv_SendCmd(SET_NET_CMD, PARAM_NUMS_1);
    SpiDrv_SendParam(ssid, ssid_len, LAST_PARAM);

    //Wait the reply elaboration
    SpiDrv_WaitForSlaveReady();

    // Wait for reply
    if (!SpiDrv_WaitResponseCmd(SET_NET_CMD, PARAM_NUMS_1, &_data, &_dataLen))
    {
        //WARN("error waitResponse");
        _data = WL_FAILURE;
    }
    SpiDrv_SlaveDeselect();

    if(_data == WIFI_SPI_ACK)
    {
        return (WL_SUCCESS);
    }
    else
    {
        return (WL_FAILURE);
    }
}

int8_t WiFiDrv_SetPassphrase(uint8_t* ssid, uint8_t ssid_len, uint8_t *passphrase, uint8_t len)
{
    uint8_t _data = 0;
    uint8_t _dataLen = 0;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrv_WaitForSlaveReady();
    SpiDrv_SlaveSelect();

    // Send Command
    SpiDrv_SendCmd(SET_PASSPHRASE_CMD, PARAM_NUMS_2);
    SpiDrv_SendParam(ssid, ssid_len, NO_LAST_PARAM);
    SpiDrv_SendParam(passphrase, len, LAST_PARAM);

    //Wait the reply elaboration
    SpiDrv_WaitForSlaveReady();

    // Wait for reply
    if (!SpiDrv_WaitResponseCmd(SET_PASSPHRASE_CMD, PARAM_NUMS_1, &_data, &_dataLen))
    {
        //WARN("error waitResponse");
        _data = WL_FAILURE;
    }
    SpiDrv_SlaveDeselect();
    return (_data);
}

int8_t WiFiDrv_SetKey(uint8_t* ssid, uint8_t ssid_len, uint8_t key_idx, uint8_t *key, uint8_t len)
{
    uint8_t _data = 0;
    uint8_t _dataLen = 0;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrv_WaitForSlaveReady();
    SpiDrv_SlaveSelect();

    // Send Command
    SpiDrv_SendCmd(SET_KEY_CMD, PARAM_NUMS_3);
    SpiDrv_SendParam(ssid, ssid_len, NO_LAST_PARAM);
    SpiDrv_SendParam(&key_idx, KEY_IDX_LEN, NO_LAST_PARAM);
    SpiDrv_SendParam(key, len, LAST_PARAM);

    //Wait the reply elaboration
    SpiDrv_WaitForSlaveReady();

    // Wait for reply
    if (!SpiDrv_WaitResponseCmd(SET_KEY_CMD, PARAM_NUMS_1, &_data, &_dataLen))
    {
        //WARN("error waitResponse");
        _data = WL_FAILURE;
    }
    SpiDrv_SlaveDeselect();

    return (_data);
}

int8_t WiFiDrv_Disconnect(void)
{
    uint8_t _dummy   = DUMMY_DATA;
    uint8_t _data    = 0;
    uint8_t _dataLen = 0;
    int8_t  _result  = 0;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrv_WaitForSlaveReady();
    SpiDrv_SlaveSelect();

    // Send Command
    SpiDrv_SendCmd(DISCONNECT_CMD, PARAM_NUMS_1);

    SpiDrv_SendParam(&_dummy, 1, LAST_PARAM);

    //Wait the reply elaboration
    SpiDrv_WaitForSlaveReady();

    // Wait for reply
    _result = SpiDrv_WaitResponseCmd(DISCONNECT_CMD, PARAM_NUMS_1, &_data, &_dataLen);

    SpiDrv_SlaveDeselect();

    return (_result);
}

uint8_t WiFiDrv_GetConnectionStatus(void)
{
    uint8_t _data = -1;
    uint8_t _dataLen = 0;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrv_WaitForSlaveReady();
    SpiDrv_SlaveSelect();

    // Send Command
    SpiDrv_SendCmd(GET_CONN_STATUS_CMD, PARAM_NUMS_0);

    //Wait the reply elaboration
    SpiDrv_WaitForSlaveReady();

    // Wait for reply
    SpiDrv_WaitResponseCmd(GET_CONN_STATUS_CMD, PARAM_NUMS_1, &_data, &_dataLen);

    SpiDrv_SlaveDeselect();

    return (_data);
}

uint8_t* WiFiDrv_GetMacAddress(void)
{
    uint8_t _dataLen = 0;
    uint8_t _dummy   = DUMMY_DATA;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrv_WaitForSlaveReady();
    SpiDrv_SlaveSelect();

    // Send Command
    SpiDrv_SendCmd(GET_MACADDR_CMD, PARAM_NUMS_1);

    SpiDrv_SendParam(&_dummy, 1, LAST_PARAM);

    //Wait the reply elaboration
    SpiDrv_WaitForSlaveReady();

    // Wait for reply
    SpiDrv_WaitResponseCmd(GET_MACADDR_CMD, PARAM_NUMS_1, _mac, &_dataLen);

    SpiDrv_SlaveDeselect();

    return (_mac);
}

void WiFiDrv_GetIpAddress(uint8_t *ip)
{
    WiFiDrv_GetNetworkData(_localIp, _subnetMask, _gatewayIp);
    memcpy(ip, _localIp, WL_IPV4_LENGTH);
}

void WiFiDrv_GetSubnetMask(uint8_t *mask)
{
    WiFiDrv_GetNetworkData(_localIp, _subnetMask, _gatewayIp);
    memcpy(mask, _subnetMask, WL_IPV4_LENGTH);
}

void WiFiDrv_GetGatewayIP(uint8_t *ip)
{
    WiFiDrv_GetNetworkData(_localIp, _subnetMask, _gatewayIp);
    memcpy(ip, _gatewayIp, WL_IPV4_LENGTH);
}

uint8_t* WiFiDrv_GetCurrentSSID(void)
{
    uint8_t _dataLen = 0;
    uint8_t _dummy   = DUMMY_DATA;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrv_WaitForSlaveReady();
    SpiDrv_SlaveSelect();

    // Send Command
    SpiDrv_SendCmd(GET_CURR_SSID_CMD, PARAM_NUMS_1);

    SpiDrv_SendParam(&_dummy, 1, LAST_PARAM);

    //Wait the reply elaboration
    SpiDrv_WaitForSlaveReady();

    // Wait for reply
    SpiDrv_WaitResponseCmd(GET_CURR_SSID_CMD, PARAM_NUMS_1, _ssid, &_dataLen);

    SpiDrv_SlaveDeselect();

    return (_ssid);
}

uint8_t* WiFiDrv_GetCurrentBSSID(void)
{
    uint8_t _dataLen = 0;
    uint8_t _dummy   = DUMMY_DATA;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrv_WaitForSlaveReady();
    SpiDrv_SlaveSelect();

    // Send Command
    SpiDrv_SendCmd(GET_CURR_BSSID_CMD, PARAM_NUMS_1);

    SpiDrv_SendParam(&_dummy, 1, LAST_PARAM);

    //Wait the reply elaboration
    SpiDrv_WaitForSlaveReady();

    // Wait for reply
    SpiDrv_WaitResponseCmd(GET_CURR_BSSID_CMD, PARAM_NUMS_1, _bssid, &_dataLen);

    SpiDrv_SlaveDeselect();

    return (_bssid);
}

int32_t WiFiDrv_GetCurrentRSSI(void)
{
    uint8_t _dataLen = 0;
    int32_t rssi     = 0;
    uint8_t _dummy   = DUMMY_DATA;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrv_WaitForSlaveReady();
    SpiDrv_SlaveSelect();

    // Send Command
    SpiDrv_SendCmd(GET_CURR_RSSI_CMD, PARAM_NUMS_1);

    SpiDrv_SendParam(&_dummy, 1, LAST_PARAM);

    //Wait the reply elaboration
    SpiDrv_WaitForSlaveReady();

    // Wait for reply
    // Note: Big/little endian problem
    SpiDrv_WaitResponseCmd(GET_CURR_RSSI_CMD, PARAM_NUMS_1, (uint8_t*)&rssi, &_dataLen);

    SpiDrv_SlaveDeselect();

    return (rssi);
}

uint8_t WiFiDrv_GetCurrentEncryptionType(void)
{
    uint8_t dataLen = 0;
    uint8_t encType = 0;
    uint8_t _dummy  = DUMMY_DATA;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrv_WaitForSlaveReady();
    SpiDrv_SlaveSelect();

    // Send Command
    SpiDrv_SendCmd(GET_CURR_ENCT_CMD, PARAM_NUMS_1);

    SpiDrv_SendParam(&_dummy, 1, LAST_PARAM);

    //Wait the reply elaboration
    SpiDrv_WaitForSlaveReady();

    // Wait for reply
    SpiDrv_WaitResponseCmd(GET_CURR_ENCT_CMD, PARAM_NUMS_1, &encType, &dataLen);

    SpiDrv_SlaveDeselect();

    return (encType);
}

int8_t WiFiDrv_StartScanNetworks(void)
{
    int8_t _data    = 0;
    uint8_t _dataLen = 0;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrv_WaitForSlaveReady();
    SpiDrv_SlaveSelect();

    // Send Command
    SpiDrv_SendCmd(START_SCAN_NETWORKS, PARAM_NUMS_0);

    //Wait the reply elaboration
    SpiDrv_WaitForSlaveReady();

    // Wait for reply

    if (!SpiDrv_WaitResponseCmd(START_SCAN_NETWORKS, PARAM_NUMS_1, (uint8_t *)&_data, &_dataLen))
    {
        // WARN("error waitResponse");
        _data = WL_FAILURE;
    }

    SpiDrv_SlaveDeselect();

    if (_data == WL_FAILURE)
    {
        return (_data);
    }
    else
    {
        return (WL_SUCCESS);
    }
}

uint8_t WiFiDrv_GetScanNetworks(void)
{
    uint8_t ssidListNum = 0;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrv_WaitForSlaveReady();
    SpiDrv_SlaveSelect();

    // Send Command
    SpiDrv_SendCmd(SCAN_NETWORKS, PARAM_NUMS_0);

    //Wait the reply elaboration
    SpiDrv_WaitForSlaveReady();

    // Wait for reply
    SpiDrv_WaitResponse(SCAN_NETWORKS, &ssidListNum, (uint8_t**)_networkSsid, WL_NETWORKS_LIST_MAXNUM);

    SpiDrv_SlaveDeselect();

    return (ssidListNum);
}

uint8_t* WiFiDrv_GetSSIDNetoworks(uint8_t networkItem)
{
    if (networkItem >= WL_NETWORKS_LIST_MAXNUM)
    {
        return (NULL);
    }

    return (_networkSsid[networkItem]);
}

uint8_t WiFiDrv_GetEncTypeNetowrks(uint8_t networkItem)
{
    uint8_t dataLen = 0;
    uint8_t encType = 0;

    if (networkItem >= WL_NETWORKS_LIST_MAXNUM)
    {
        return (NULL);
    }

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrv_WaitForSlaveReady();
    SpiDrv_SlaveSelect();

    // Send Command
    SpiDrv_SendCmd(GET_IDX_ENCT_CMD, PARAM_NUMS_1);

    SpiDrv_SendParam(&networkItem, 1, LAST_PARAM);

    //Wait the reply elaboration
    SpiDrv_WaitForSlaveReady();

    // Wait for reply
    SpiDrv_WaitResponseCmd(GET_IDX_ENCT_CMD, PARAM_NUMS_1, &encType, &dataLen);

    SpiDrv_SlaveDeselect();

    return (encType);
}

int32_t WiFiDrv_GetRSSINetoworks(uint8_t networkItem)
{
    uint8_t dataLen     = 0;
    int32_t networkRssi = 0;

    if (networkItem >= WL_NETWORKS_LIST_MAXNUM)
    {
        return (NULL);
    }

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrv_WaitForSlaveReady();
    SpiDrv_SlaveSelect();

    // Send Command
    SpiDrv_SendCmd(GET_IDX_RSSI_CMD, PARAM_NUMS_1);

    SpiDrv_SendParam(&networkItem, 1, LAST_PARAM);

    //Wait the reply elaboration
    SpiDrv_WaitForSlaveReady();

    // Wait for reply
    SpiDrv_WaitResponseCmd(GET_IDX_RSSI_CMD, PARAM_NUMS_1, (uint8_t*)&networkRssi, &dataLen);

    SpiDrv_SlaveDeselect();

    return (networkRssi);
}

uint8_t WiFiDrv_ReqHostByName(uint8_t* aHostname)
{
    uint8_t _data    = 0;
    uint8_t _dataLen = 0;
    uint8_t result   = 0;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrv_WaitForSlaveReady();
    SpiDrv_SlaveSelect();

    // Send Command
    SpiDrv_SendCmd(REQ_HOST_BY_NAME_CMD, PARAM_NUMS_1);
    SpiDrv_SendParam(aHostname, strlen((const char *)aHostname), LAST_PARAM);

    //Wait the reply elaboration
    SpiDrv_WaitForSlaveReady();

    // Wait for reply
    result = SpiDrv_WaitResponseCmd(REQ_HOST_BY_NAME_CMD, PARAM_NUMS_1, &_data, &_dataLen);
    SpiDrv_SlaveDeselect();

    return (result);
}

static int32_t _GetHostByName(uint8_t *aResult)
{
    uint8_t  _dataLen = 0;
    int32_t  result   = 0;
    uint8_t  _ipAddr[WL_IPV4_LENGTH] = {0, 0, 0, 0};
    uint8_t  dummy[4] = {0xFF,0xFF,0xFF,0xFF};

    //WAIT_FOR_SLAVE_SELECT
    SpiDrv_WaitForSlaveReady();
    SpiDrv_SlaveSelect();

    // Send Command
    SpiDrv_SendCmd(GET_HOST_BY_NAME_CMD, PARAM_NUMS_0);

    //Wait the reply elaboration
    SpiDrv_WaitForSlaveReady();

    // Wait for reply
    if (!SpiDrv_WaitResponseCmd(GET_HOST_BY_NAME_CMD, PARAM_NUMS_1, _ipAddr, &_dataLen))
    {
        //WARN("error waitResponse");
    }
    else
    {
        memcpy(aResult, _ipAddr, WL_IPV4_LENGTH);
        result = memcmp(aResult, dummy, WL_IPV4_LENGTH);
    }
    SpiDrv_SlaveDeselect();

    return (result);
}

int32_t WiFiDrv_GetHostByName(uint8_t* aHostname, uint8_t *aResult)
{
    uint8_t retry = 10;

    if (WiFiDrv_ReqHostByName(aHostname))
    {
        while(!_GetHostByName(aResult) && --retry > 0)
        {
            DelayMs(1000);
        }
    }
    else
    {
        return (0);
    }

    return (retry > 0);
}

uint8_t*  WiFiDrv_GetFwVersion(void)
{
    uint8_t _dataLen = 0;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrv_WaitForSlaveReady();
    SpiDrv_SlaveSelect();

    // Send Command
    SpiDrv_SendCmd(GET_FW_VERSION_CMD, PARAM_NUMS_0);

    //Wait the reply elaboration
    SpiDrv_WaitForSlaveReady();

    // Wait for reply
    if (!SpiDrv_WaitResponseCmd(GET_FW_VERSION_CMD, PARAM_NUMS_1, _fwVersion, &_dataLen))
    {
        //WARN("error waitResponse");
    }
    SpiDrv_SlaveDeselect();
    return (_fwVersion);
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
