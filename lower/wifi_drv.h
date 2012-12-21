#ifndef WiFI_DRV_H
#define WiFI_DRV_H

#include <stdint.h>
#include "wl_definitions.h"
#include "wifi_spi.h"



// Key index length
#define KEY_IDX_LEN                 1
// 5 secs of delay to have the connection established
#define WL_DELAY_START_CONNECTION   5000
// firmware version string length
#define WL_FW_VER_LENGTH            6


/*
 * Driver initialization
 */
extern void WiFiDrvInit(void);

/*
 * Set the desired network which the connection manager should try to
 * connect to.
 *
 * The ssid of the desired network should be specified.
 *
 * param ssid: The ssid of the desired network.
 * param ssid_len: Lenght of ssid string.
 * return: WL_SUCCESS or WL_FAILURE
 */
extern int8_t WiFiDrvSetNetwork(char* ssid, uint8_t ssid_len);

/* Start Wifi connection with passphrase
 * the most secure supported mode will be automatically selected
 *
 * param ssid: Pointer to the SSID string.
 * param ssid_len: Lenght of ssid string.
 * param passphrase: Passphrase. Valid characters in a passphrase
 *        must be between ASCII 32-126 (decimal).
 * param len: Lenght of passphrase string.
 * return: WL_SUCCESS or WL_FAILURE
 */
extern int8_t WiFiDrvSetPassphrase(char* ssid, uint8_t ssid_len, const char *passphrase, const uint8_t len);

/* Start Wifi connection with WEP encryption.
 * Configure a key into the device. The key type (WEP-40, WEP-104)
 * is determined by the size of the key (5 bytes for WEP-40, 13 bytes for WEP-104).
 *
 * param ssid: Pointer to the SSID string.
 * param ssid_len: Lenght of ssid string.
 * param key_idx: The key index to set. Valid values are 0-3.
 * param key: Key input buffer.
 * param len: Lenght of key string.
 * return: WL_SUCCESS or WL_FAILURE
 */
extern int8_t WiFiDrvSetKey(char* ssid, uint8_t ssid_len, uint8_t key_idx, const void *key, const uint8_t len);

/*
 * Disconnect from the network
 *
 * return: WL_SUCCESS or WL_FAILURE
 */
extern int8_t WiFiDrvDisconnect(void);

/*
 * Disconnect from the network
 *
 * return: one value of wl_status_t enum
 */
extern uint8_t WiFiDrvGetConnectionStatus(void);

/*
 * Get the interface MAC address.
 *
 * return: pointer to uint8_t array with length WL_MAC_ADDR_LENGTH
 */
extern uint8_t* WiFiDrvGetMacAddress(void);

/*
 * Get the interface IP address.
 *
 * return: copy the ip address value in IPAddress object
 */
extern void WiFiDrvGetIpAddress(uint8_t *ip);

/*
 * Get the interface subnet mask address.
 *
 * return: copy the subnet mask address value in IPAddress object
 */
extern void WiFiDrvGetSubnetMask(uint8_t *mask);

/*
 * Get the gateway ip address.
 *
 * return: copy the gateway ip address value in IPAddress object
 */
extern void WiFiDrvGetGatewayIP(uint8_t *ip);

/*
 * Return the current SSID associated with the network
 *
 * return: ssid string
 */
extern char* WiFiDrvGetCurrentSSID(void);

/*
 * Return the current BSSID associated with the network.
 * It is the MAC address of the Access Point
 *
 * return: pointer to uint8_t array with length WL_MAC_ADDR_LENGTH
 */
extern uint8_t* WiFiDrvGetCurrentBSSID(void);

/*
 * Return the current RSSI /Received Signal Strength in dBm)
 * associated with the network
 *
 * return: signed value
 */
extern int32_t WiFiDrvGetCurrentRSSI(void);

/*
 * Return the Encryption Type associated with the network
 *
 * return: one value of wl_enc_type enum
 */
extern uint8_t WiFiDrvGetCurrentEncryptionType(void);

/*
 * Start scan WiFi networks available
 *
 * return: Number of discovered networks
 */
extern int8_t WiFiDrvStartScanNetworks(void);

/*
 * Get the networks available
 *
 * return: Number of discovered networks
 */
extern uint8_t WiFiDrvGetScanNetworks(void);

/*
 * Return the SSID discovered during the network scan.
 *
 * param networkItem: specify from which network item want to get the information
 *
 * return: ssid string of the specified item on the networks scanned list
 */
extern char* WiFiDrvGetSSIDNetoworks(uint8_t networkItem);

/*
 * Return the RSSI of the networks discovered during the scanNetworks
 *
 * param networkItem: specify from which network item want to get the information
 *
 * return: signed value of RSSI of the specified item on the networks scanned list
 */
extern int32_t WiFiDrvGetRSSINetoworks(uint8_t networkItem);

/*
 * Return the encryption type of the networks discovered during the scanNetworks
 *
 * param networkItem: specify from which network item want to get the information
 *
 * return: encryption type (enum wl_enc_type) of the specified item on the networks scanned list
 */
extern uint8_t WiFiDrvGetEncTypeNetowrks(uint8_t networkItem);

/*
 * Resolve the given hostname to an IP address.
 * param aHostname: Name to be resolved
 * param aResult: IPAddress structure to store the returned IP address
 * result: 1 if aIPAddrString was successfully converted to an IP address,
 *          else error code
 */
extern int WiFiDrvGetHostByName(const char* aHostname, uint8_t* aResult);

/*
 * Get the firmware version
 * result: version as string with this format a.b.c
 */
extern char* WiFiDrvGetFwVersion(void);



#endif  //  WiFI_DRV_H

