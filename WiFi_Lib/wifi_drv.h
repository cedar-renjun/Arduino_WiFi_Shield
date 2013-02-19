#ifndef _WiFI_DRV_H_
#define _WiFI_DRV_H_

#include <inttypes.h>
#include "wifi_spi.h"

// Key index length
#define KEY_IDX_LEN                 1
// 5 secs of delay to have the connection established
#define WL_DELAY_START_CONNECTION   5000
// firmware version string length
#define WL_FW_VER_LENGTH            6

void     WiFiDrv_GetNetworkData(uint8_t *ip, uint8_t *mask, uint8_t *gwip);
void     WiFiDrv_Init(void);
int8_t   WiFiDrv_SetNetwork(uint8_t* ssid, uint8_t ssid_len);
int8_t   WiFiDrv_SetPassphrase(uint8_t* ssid, uint8_t ssid_len, uint8_t *passphrase, uint8_t len);
int8_t   WiFiDrv_SetKey(uint8_t* ssid, uint8_t ssid_len, uint8_t key_idx, uint8_t *key, uint8_t len);
int8_t   WiFiDrv_Disconnect(void);
uint8_t  WiFiDrv_GetConnectionStatus(void);
uint8_t* WiFiDrv_GetMacAddress(void);
void     WiFiDrv_GetIpAddress(uint8_t *ip);
void     WiFiDrv_GetSubnetMask(uint8_t *mask);
void     WiFiDrv_GetGatewayIP(uint8_t *ip);
uint8_t* WiFiDrv_GetCurrentSSID(void);
uint8_t* WiFiDrv_GetCurrentBSSID(void);
int32_t  WiFiDrv_GetCurrentRSSI(void);
uint8_t  WiFiDrv_GetCurrentEncryptionType(void);
int8_t   WiFiDrv_StartScanNetworks(void);
uint8_t  WiFiDrv_GetScanNetworks(void);
uint8_t* WiFiDrv_GetSSIDNetoworks(uint8_t networkItem);
uint8_t  WiFiDrv_GetEncTypeNetowrks(uint8_t networkItem);
int32_t  WiFiDrv_GetRSSINetoworks(uint8_t networkItem);
uint8_t  WiFiDrv_ReqHostByName(uint8_t* aHostname);
//static int32_t _GetHostByName(uint8_t *aResult);
int32_t  WiFiDrv_GetHostByName(uint8_t* aHostname, uint8_t *aResult);
uint8_t* WiFiDrv_GetFwVersion(void);

#endif  //  _WiFI_DRV_H_

