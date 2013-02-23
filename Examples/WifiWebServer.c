#include "WiFiServer.h"

int AccRead(int id)
{
    return (id);
}

static void delay(volatile uint32_t tick)
{
	while(tick--);
}

static uint8_t Http_head[] = 
{
    "HTTP/1.1 200 OK\r\n"
    "Content-Type: text/html\r\n"
    "Connnection: close\r\n"
    "\r\n"
    "<!DOCTYPE HTML>\r\n"
    "<html>\r\n"
    "<meta http-equiv=\"refresh\" content=\"2\">\r\n"
};

static void WebPrint(uint8_t *Str)
{
    WiFiClient_WriteBlock(Str, strlen((char*) Str));
}

void WebServer(uint16_t port)
{
    uint8_t Buf[30];

    WiFiServer_Init(port);
    while(1)
    {
        // listen for incoming clients
        if(!WiFiServer_Available())   
        {
            uint8_t currentLineIsBlank = 1;
            //printf("new client");
            // an http request ends with a blank line
            while(WiFiClient_Connected())
            {
                printf("new client");
                if (WiFiClient_Available())
                {
                    uint8_t c = WiFiClient_ReadByte();
                    putchar(c);
                    // if you've gotten to the end of the line (received a newline
                    // character) and the line is blank, the http request has ended,
                    // so you can send a reply
                    if (c == '\n' && currentLineIsBlank)
                    {
                        uint8_t i = 0;
                        WebPrint(Http_head);
                        WebPrint("Accelermeter Value<br />");
                        for(i = 0; i < 3; i++)
                        {
                            sprintf((char *)Buf,"#%d is %d<br />\r\n", i, AccRead(i));
                            WebPrint(Buf);
                        }
                        WebPrint("</html>\r\n");
                        break;
                    }
                    if (c == '\n')
                    {
                        // you're starting a new line
                        currentLineIsBlank = 1;
                    } 
                    else if (c != '\r')
                    {
                        // you've gotten a character on the current line
                        currentLineIsBlank = 0;
                    }
                }
            }
            // give the web browser time to receive the data
            delay(0xFF);
            // close the connection:
            WiFiClient_Stop();
            //printf("client disonnected");
        }
    }
}

