#ifndef WL_DEFINITIONS_H
#define WL_DEFINITIONS_H

// Maximum size of a SSID
#define WL_SSID_MAX_LENGTH           32

// Length of passphrase. Valid lengths are 8-63.
#define WL_WPA_KEY_MAX_LENGTH        63

// Length of key in bytes. Valid values are 5 and 13.
#define WL_WEP_KEY_MAX_LENGTH        13

// Size of a MAC-address or BSSID
#define WL_MAC_ADDR_LENGTH           6

// Size of a MAC-address or BSSID
#define WL_IPV4_LENGTH               4

// Maximum size of a SSID list
#define WL_NETWORKS_LIST_MAXNUM      10

// Maxmium number of socket
#define MAX_SOCK_NUM                 4

//Maximum number of attempts to establish wifi connection
#define WL_MAX_ATTEMPT_CONNECTION    10

#define TCP_SOCKET  1
#define UDP_SOCKET  2
#define RAW_SOCKET  3

#define SOCK_NOT_AVAIL  255

#if 0
typedef char                   int8;
typedef volatile char          vint8;
typedef unsigned char          uint8;
typedef volatile unsigned char vuint8;
typedef int                    int16;
typedef volatile int           vint16;
typedef unsigned int           uint16;
typedef volatile unsigned int  vuint16;
typedef long                   int32;
typedef volatile long          vint32;
typedef unsigned long          uint32;
typedef volatile unsigned long vuint32;
#endif

typedef enum 
{
    WL_NO_SHIELD    = 255,
    WL_IDLE_STATUS  = 0  ,
    WL_NO_SSID_AVAIL     ,
    WL_SCAN_COMPLETED    ,
    WL_CONNECTED         ,
    WL_CONNECT_FAILED    ,
    WL_CONNECTION_LOST   ,
    WL_DISCONNECTED
} wl_status_t;

/* Encryption modes */
enum wl_enc_type 
{  
    // Values map to 802.11 encryption suites
    ENC_TYPE_WEP  = 5,
    ENC_TYPE_TKIP = 2,
    ENC_TYPE_CCMP = 4,
    //except these two, 7 and 8 are reserved in 802.11-2007
    ENC_TYPE_NONE = 7,
    ENC_TYPE_AUTO = 8
};

//WiFi Result
typedef enum
{
    WL_FAILURE = -1,
    WL_SUCCESS = 1 ,
} wl_error_code_t;


/* Authentication modes */
enum wl_auth_mode 
{
    AUTH_MODE_INVALID     ,
    AUTH_MODE_AUTO        ,
    AUTH_MODE_OPEN_SYSTEM ,
    AUTH_MODE_SHARED_KEY  ,
    AUTH_MODE_WPA         ,
    AUTH_MODE_WPA2        ,
    AUTH_MODE_WPA_PSK     ,
    AUTH_MODE_WPA2_PSK    ,
};

#endif
