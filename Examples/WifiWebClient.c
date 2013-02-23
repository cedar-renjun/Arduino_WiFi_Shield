
#include "WiFi.h"
#include "WiFiClient.h"


//extern int32_t _ConnectViaIP(uint8_t* ip, uint16_t port);

//int status = WL_IDLE_STATUS;
// if you don't want to use DNS (and reduce your sketch size)
// use the numeric IP instead of the name for the server:
uint8_t server[] = {173,194,73,105};  // numeric IP for Google (no DNS)
//char server[] = "www.google.com";    // name address for Google (using DNS)

static void WebPrint(uint8_t *Str)
{
    WiFiClient_WriteBlock(Str, strlen((char*) Str));
}


// Initialize the Ethernet client library
// with the IP address and port of the server 
// that you want to connect to (port 80 is default for HTTP)


void WiFiClientDemo(void)
{  
    while(1)
    {
        WiFiClient_Init();
        if(_ConnectViaIP(server, 80))
        {
            printf("connected to server\r\n");
            // Make a HTTP request:
            WebPrint(
                     "GET /search?q=arduino HTTP/1.1\r\n"
                         "Host:www.google.com\r\n"
                             "Connection: close\r\n"
                                 "\r\n");
        }
        // if there are incoming bytes available 
        // from the server, read them and print them:
        while (WiFiClient_Available()) 
        {
            char c = WiFiClient_ReadByte();
            putchar(c);
        }
        
        // if the server's disconnected, stop the client:
        if (!WiFiClient_Connected()) 
        {
            
            printf("\r\ndisconnecting from server.\r\n");
            WiFiClient_Stop();
            
            // do nothing forevermore:
            //while(1);
        }  
    }
}







