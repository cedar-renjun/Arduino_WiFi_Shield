/**
 ******************************************************************************
 * @file    SPI/CRC/main.c 
 * @author  MCD Application Team
 * @version V3.5.0
 * @date    08-April-2011
 * @brief   Main program body
 ******************************************************************************
 * @attention
 *
 * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
 * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
 * TIME. AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
 * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
 * FROM THE CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
 * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
 *
 * <h2><center>&copy; COPYRIGHT 2011 STMicroelectronics</center></h2>
 ******************************************************************************
 */ 
#include "server_drv.h"
#include "WiFi.h"
#include "WiFiClient.h"

static void SysInit(void);
extern void DebugPortInit(void);

///////////////////////////// Configure network information ///////////////////    
//Note: 
// (A)  if your network type is wep, please set keyindex 
//      comma is must
//      e.g:
//      #define NET_TYPE         WEP
//      #define NET_SSID         "CooCox"
//      #define NET_KEY_INDEX    ,0
//      #define NET_KEY          ,"0123456789"
//
// (B)   for open network, you only need ssid, so set keyindex and key void
//       e.g:
//      #define NET_TYPE         OPEN
//      #define NET_SSID         "CooCox"
//      #define NET_KEY_INDEX    //leave void here
//      #define NET_KEY          //leave void here
//
// (C)  for wpa  network, need ssid and key, leave keyindex void
//      #define NET_TYPE         WPA 
//      #define NET_SSID         "CooCox"
//      #define NET_KEY_INDEX    //leave void here
//      #define NET_KEY          ,"0123456789"
    
#define NET_TYPE         WEP
#define NET_SSID         "Here is your network ssid"
#define NET_KEY_INDEX    ,0
#define NET_KEY          ,"Here is your network key"

static void WebPrint(uint8_t *Str)
{
    WiFiClient_WriteBlock(Str, strlen((char*) Str));
}

void Example_WebClient(void)
{
    int status = WL_IDLE_STATUS; 
    
    //uint32_t ip = *(uint32_t *)Addr;
    
    SysInit();    
    DebugPortInit();
    WiFi_Init();
    //status = WiFi_Begin(WEP,"Embest", 0, "0123456789");
    status = WiFi_Begin(NET_TYPE, NET_SSID NET_KEY_INDEX NET_KEY);
   
    if(status != WL_CONNECTED)
    {
        printf("\r\nFailure to join network\r\n");
        while(1);
    }
    
    //wait network connection stable.
    DelayMs(200);
    if(!WiFiClient_Connect("www.google.com.hk", 80))    
    {
        printf("\r\nFailure to connect to webserver\r\n");
        while(1);
    }

    WebPrint( "GET /search?q=CooCox HTTP/1.1\r\n"
              "Host:www.google.com.hk\r\n"
              "Connection: close\r\n"
              "\r\n");

    DelayMs(2000);
    // if there are incoming bytes available 
    // from the server, read them and print them:    
    while (WiFiClient_Available()) 
    {
        char c = WiFiClient_ReadByte();
        putchar(c);
    }
    printf("\r\nExample End\r\n");
    while(1);

}

//Initialize the system
static void SysInit(void)
{
    // Close watchdog
    (*((volatile unsigned long *)(0x40048100))) = 0x00;
    
    // Configure System clock    
    xSysCtlClockSet(F_CLK, xSYSCTL_OSC_MAIN | xSYSCTL_XTAL_8MHZ);
    SysCtlDelay(100*TICK_1MS);
}


