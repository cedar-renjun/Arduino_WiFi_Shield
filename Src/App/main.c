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
#include "WiFiServer.h"

static void SysInit(void);
extern void DebugPortInit(void);

extern void WebServer(uint16_t port);

static uint8_t Http_head[] = 
{
    "HTTP/1.1 200 OK\r\n"
    "Content-Type: text/html\r\n"
    "Connnection: close\r\n"
    "\r\n"
    "<!DOCTYPE HTML>\r\n"
    "<html>\r\n"
    "Hello world\r\n"
    "</html>\r\n\r\n"
    //"<meta http-equiv=\"refresh\" content=\"2\">\r\n"
};

static void WebPrint(uint8_t *Str)
{
    WiFiServer_WriteBlock(Str, strlen((char*) Str));
}


int main(void)
{  
    int status = WL_IDLE_STATUS;  
    //uint8_t Res = 0;

    SysInit();    
    DebugPortInit();
    WiFi_Init();
    printf("Init OK\r\n");
    //WiFiClient_Init();
    status = WiFi_Begin(WEP,"Embest", 0, "0123456789");
    if(status != WL_CONNECTED)
    {
        printf("\r\nFailure to join network\r\n");
        while(1);
    }
    
    while(1)
    {
        WiFiServer_Init(80);
        
        // listen for incoming clients
        while(!WiFiServer_Available())   
        {
            DelayMs(2);
        }

        while(1)
        {
            if(WiFiClient_Available()) 
            {
                char c = WiFiClient_ReadByte();
                putchar(c);
            }
        }

        DelayMs(2000);
        
        WebPrint("HTTP/1.1 200 OK\r\n");
        DelayMs(2);
        WebPrint("Content-Type: text/html\r\n");
        DelayMs(2);
        WebPrint("Connnection: close\r\n");
        DelayMs(2);
        WebPrint("\r\n");
        DelayMs(2);
        WebPrint("<!DOCTYPE HTML>\r\n");
        DelayMs(2);
        WebPrint("<html>\r\n");
        DelayMs(2);
        WebPrint("Hello world\r\n");
        DelayMs(2);
        WebPrint("</html>\r\n\r\n");
        DelayMs(2);
        
        DelayMs(20);
        WiFiClient_Stop();
        DelayMs(1000);
    }
    while(1);
}

static void SysInit(void)
{
    // Close watchdog
    (*((volatile unsigned long *)(0x40048100))) = 0x00;
    
    // Configure System clock    
    xSysCtlClockSet(F_CLK, xSYSCTL_OSC_MAIN | xSYSCTL_XTAL_8MHZ);
    SysCtlDelay(100*TICK_1MS);
}


