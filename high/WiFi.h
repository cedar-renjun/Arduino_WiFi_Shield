#ifndef WIFI_H
#define WIFI_H

#include "includes.h"

// Network encrytion type
// used in WiFiBegin Function
#define OPEN                    1
#define WEP                     2
#define WPA                     3

//This paragma is only used in the following three functions
//
//#1# char* WiFiSSIDGet(uint8_t networkItem);
//#2# uint8_t WiFiEncryptionTypeGet(uint8_t networkItem);
//#3# int32_t WiFiRSSIGet(uint8_t networkItem);

#define CURRENT                 ((uint8_t)(-1))

extern int16_t   _state[MAX_SOCK_NUM];
extern uint16_t  _server_port[MAX_SOCK_NUM];


//Initial the WiFi module
extern void WiFiInit(void);

/*
 * Get the first Port available
 */
extern uint8_t  WiFiPortAvilGet(void);

/*
 * Get the first socket available
 */
extern uint8_t  WiFiSocketAvilGet(void);

/*
 * Get firmware version
 */
extern char* WiFiFwVerGet(void);

/* Start Wifi connection with OPEN/WEP/WPA encryption.
 * Configure a key into the device. The key type (WEP-40, WEP-104)
 * is determined by the size of the key (5 bytes for WEP-40, 13 bytes for WEP-104).
 *
 * param ssid: Pointer to the SSID string.
 * param key_idx: The key index to set. Valid values are 0-3.
 * param key: Key input buffer.
 *
 * Start Wifi connection with passphrase
 * the most secure supported mode will be automatically selected
 *
 * param ssid: Pointer to the SSID string.
 * param passphrase: Passphrase. Valid characters in a passphrase
 *        must be between ASCII 32-126 (decimal).
 *
 * Example:
 * Open network:
 * WiFiBegin(OPEN, ssid);
 *
 * WPA network:
 * WiFiBegin(WPA, ssid, passphrase);
 *
 * WEP network:
 * WiFiBegin(WEP, ssid, key_idx, key);
 */
extern int WiFiBegin(uint8_t NetType, char* ssid, ...);

/*
 * Disconnect from the network
 *
 * return: one value of wl_status_t enum
 */
extern int WiFiDisconnect(void);

/*
 * Get the interface MAC address.
 *
 * return: pointer to uint8_t array with length WL_MAC_ADDR_LENGTH
 */
extern uint8_t* WiFiMacAddrGet(uint8_t* mac);

/*
 * Get the interface IP address.
 *
 * return: Ip address value
 */
void WiFiLocalIPGet(uint8_t * ip);

/*
 * Get the interface subnet mask address.
 *
 * return: subnet mask address value
 */
void WiFiSubnetMaskGet(uint8_t * mask);

/*
 * Get the gateway ip address.
 *
 * return: gateway ip address value
 */
void WiFiGatewayIPGet(uint8_t * gateway);

/*
 * Return the current BSSID associated with the network.
 * It is the MAC address of the Access Point
 *
 * return: pointer to uint8_t array with length WL_MAC_ADDR_LENGTH
 */
extern uint8_t* WiFiBSSIDGet(uint8_t* bssid);

/*
 * Start scan WiFi networks available
 *
 * return: Number of discovered networks
 */
extern int8_t WiFiScanNetworks(void);

/*
 * Return the SSID discovered during the network scan.
 *
 * param networkItem: specify from which network item want to get the information
 *
 * return: ssid string of the specified item on the networks scanned list
 */
extern char* WiFiSSIDGet(uint8_t networkItem);

/*
 * Return the encryption type of the networks discovered during the scanNetworks
 *
 * param networkItem: specify from which network item want to get the information
 *
 * return: encryption type (enum wl_enc_type) of the specified item on the networks scanned list
 */
extern uint8_t WiFiEncryptionTypeGet(uint8_t networkItem);

/*
 * Return the RSSI of the networks discovered during the scanNetworks
 *
 * param networkItem: specify from which network item want to get the information
 *
 * return: signed value of RSSI of the specified item on the networks scanned list
 */
extern int32_t WiFiRSSIGet(uint8_t networkItem);

/*
 * Return Connection status.
 *
 * return: one of the value defined in wl_status_t
 */
extern uint8_t WiFiStatusGet(void);

/*
 * Resolve the given hostname to an IP address.
 * param aHostname: Name to be resolved
 * param aResult: IPAddress structure to store the returned IP address
 * result: 1 if aIPAddrString was successfully converted to an IP address,
 *          else error code
 */

extern int WiFiHostToIP(const char* aHostname, uint8_t * aResult);

extern int IPToNetAddr(char * IPStr, uint8_t * NetAddr);

#endif  // WIFI_H

