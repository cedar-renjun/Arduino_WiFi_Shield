/*
 * wl_definitions.h
 *
 *  Created on: Mar 6, 2011
 *      Author: dlafauci
 */

#ifndef WL_DEFINITIONS_H_
#define WL_DEFINITIONS_H_

#include "stdint.h"

//#ifndef _DELAY_H_
//#define _DELAY_H_

#define F_CLK                   ((uint32_t)48000000)
#define TIME_K                  ((uint32_t)8       )
#define TICK_1MS                ((F_CLK/1000)/TIME_K)
#define TICK_1US                ((F_CLK/1000000)/TIME_K)

static void DelayMs(uint32_t ms)
{
    volatile uint32_t _tick = ms * TICK_1MS;
    while(_tick--);
}

static void DelayUs(uint32_t us)
{
    volatile uint32_t _tick = us * TICK_1US;
    while(_tick--);
}

//#endif //_DELAY_H_

// Maximum size of a SSID
#define WL_SSID_MAX_LENGTH 32
// Length of passphrase. Valid lengths are 8-63.
#define WL_WPA_KEY_MAX_LENGTH 63
// Length of key in bytes. Valid values are 5 and 13.
#define WL_WEP_KEY_MAX_LENGTH 13
// Size of a MAC-address or BSSID
#define WL_MAC_ADDR_LENGTH 6
// Size of a MAC-address or BSSID
#define WL_IPV4_LENGTH 4
// Maximum size of a SSID list
#define WL_NETWORKS_LIST_MAXNUM 10
// Maxmium number of socket
#define MAX_SOCK_NUM        4
//Maximum number of attempts to establish wifi connection
#define WL_MAX_ATTEMPT_CONNECTION   10

typedef enum {
        WL_NO_SHIELD = 255,
        WL_IDLE_STATUS = 0,
        WL_NO_SSID_AVAIL,
        WL_SCAN_COMPLETED,
        WL_CONNECTED,
        WL_CONNECT_FAILED,
        WL_CONNECTION_LOST,
        WL_DISCONNECTED
} wl_status_t;

/* Encryption modes */
enum wl_enc_type {  /* Values map to 802.11 encryption suites... */
        ENC_TYPE_WEP  = 5,
        ENC_TYPE_TKIP = 2,
        ENC_TYPE_CCMP = 4,
        /* ... except these two, 7 and 8 are reserved in 802.11-2007 */
        ENC_TYPE_NONE = 7,
        ENC_TYPE_AUTO = 8
};

#endif /* WL_DEFINITIONS_H_ */

