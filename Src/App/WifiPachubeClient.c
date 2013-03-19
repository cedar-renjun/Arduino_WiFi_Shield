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

#define APIKEY         "enVXRmO1dRKzSpU2SIh-EPIibBiSAKxBMWpxS1poTElSYz0g" // replace your pachube api key here
#define FEEDID         106382                    // replace your feed ID
#define USERAGENT      "My Arduino Project"     // user agent is the project name

//uint8_t tmp[1024];
//int i = 0;

int Data = 0;
int Cnt = 0;
uint8_t Buf[1024];
uint8_t Ssid[20];
int     KeyIndex;
uint8_t Key[40] ;
int8_t NetWorkNum  = 0;    
int8_t ChoiceID    = 0;
int8_t WaitCnt     = 0;
int8_t NetWorkType = 0;
int Ch = 0;
int i = 0;
int status = WL_IDLE_STATUS;  

static void SysInit(void);
extern void DebugPortInit(void);

static int _getLength(int someValue);
static void SendData(int thisData);

static void WebPrint(uint8_t *Str)
{
    WiFiClient_WriteBlock(Str, strlen((char*) Str));
}


void ListNetworks(int num)
{
    int i   = 0;

    printf("\r\n");
    // print the network number and name for each network found:
    for (i = 0; i < num; i++)
    {
        printf("#%d\t%s\r\n", i, WiFi_SSIDGet(i));
    }
}  

int JoinNetWork(int8_t Type)
{
    switch (Type)
    {
    case ENC_TYPE_WEP:    //WEP
        return WiFi_Begin(WEP, WiFi_SSIDGet(ChoiceID), KeyIndex, Key);        
    case ENC_TYPE_TKIP:   //WPA
    case ENC_TYPE_CCMP:   //WPA2
        return WiFi_Begin(WPA, WiFi_SSIDGet(ChoiceID), Key);        
    case ENC_TYPE_AUTO:   //AUTO
    case ENC_TYPE_NONE:   //OPEN
        return WiFi_Begin(OPEN, WiFi_SSIDGet(ChoiceID));        
    }
    return(!WL_CONNECTED);
}





int main(void)
{  
    int status = WL_IDLE_STATUS;  
    int Cnt = 0;
    uint8_t lastConnected = 0;
    //uint8_t res = 0;

    SysInit();    
    DebugPortInit();
    WiFi_Init();
    WiFiClient_Init();

    printf( "\r\n"
            "======================================================================\r\n"
            "            Welcome to Freedom Board WiFi Module Demo                 \r\n"
            "                                                        Made by CooCox\r\n"
            "======================================================================\r\n");
        
    // check for the presence of the shield:
    if (WiFi_StatusGet() == WL_NO_SHIELD) 
    {
        printf(" Sorry, we can not detect the wifi module on your freedom board!\r\n"
               " please check your hardwire connection.\r\n");
        //Stop
        while(1);
    } 


    printf(" Congratulation! We detect your WiFi module!\r\n"
            " Now, Please press <Enter> to continue demo.\r\n"
          );
    while(getchar() != 0x0D);

RESCAN:
    printf("Scanning Network");

    while(1)
    {
        if((WaitCnt++)%20 == 0)
        {
            printf(".");
        }
        else if(WaitCnt == 60)
        {
            WaitCnt = 0;
            printf("\b\b\b   \b\b\b");
        }

        NetWorkNum = WiFi_ScanNetworks();
        if((NetWorkNum != -1) && (NetWorkNum != 0))
        {
            break;
        }
        DelayMs(50);

    }

    ListNetworks(NetWorkNum);
    printf( "Now Input Target Network ID\r\n"
            "Tips: \r\n"
            "      #1 press <R> to refresh network\r\n"  //'R'
            "      #2 press <ESC> to exit demo\r\n");    //1B
    while(1)
    {
        Ch = getchar();
        if((char) Ch >= '0' && (char) Ch <= '9')
        {
            ChoiceID = Ch - '0';
            break;
        }
        if((char) Ch == 'R')
        {
            goto  RESCAN;
        }

        if((char) Ch == 0x1B) //ESC
        {
            printf("\r\nExit demo Now, thank you\r\n");
            while(1);
        }
    }

    printf("You have select Network:%s\r\n", WiFi_SSIDGet(ChoiceID));
    // read the encryption type and print out the name:
    NetWorkType = WiFi_EncryptionTypeGet(ChoiceID);
    switch (NetWorkType)
    {
    case ENC_TYPE_WEP:    //WEP
        printf("\r\nThis is a WEP Network, Please Input the KeyIndex:");
        KeyIndex = getchar();
        putchar(KeyIndex);
        getchar();
        printf("\r\nPlease Input the Key:");
        for(i = 0; i < sizeof(Key); i++)
        {
            //scanf("%s", Key);
            Ch = getchar();
            if(Ch == 0x0D)
            {
                Key[i] = '\0';
                break;
            }
            Key[i] = (uint8_t)Ch;
            putchar(Ch);
        }
        break;
    case ENC_TYPE_TKIP:   //WPA
    case ENC_TYPE_CCMP:   //WPA2
        printf("\r\nThis is a WPA Network, Please Input the key:");
        //scanf("%s", Key);
        for(i = 0; i < sizeof(Key); i++)
        {
            //scanf("%s", Key);
            Ch = getchar();
            if(Ch == 0x0D)
            {
                Key[i] = '\0';
                break;
            }
            Key[i] = (uint8_t)Ch;
            putchar(Ch);
        }               
        break;
    case ENC_TYPE_NONE:   //OPEN
        printf("\r\nThis is an OPEN Network");
        //printf("None\r\n");
        break;
    case ENC_TYPE_AUTO:
        //printf("Auto\r\n");
        break;
    }
                   
    printf("\r\nBeginning to join the network\r\n");
    printf("Note: you can stop Join by press <ESC>\r\n");
     
    
    Cnt = 0;
    printf("Joining");
    while(1)
    {
        status = JoinNetWork(NetWorkType);        
        //extern int _WiFiBeginWep(uint8_t* ssid, uint8_t key_idx, uint8_t* key);
        //status = _WiFiBeginWep("Embest", 0, "0123456789");
        
        if(status == WL_CONNECTED)
        {
            printf("\r\nOK, Connect to Network!!!\r\n");
            break;
        }        
        else
        {   
            if(Cnt++ < 200)
            {       
                
                if(Cnt%4)
                {
                    printf(".");
                }
                else
                {                    
                    printf("\b\b\b   \b\b\b");
                }
                DelayMs(20);     
            }
            else
            {
                Cnt = 0;
                printf("Can not connect to network, try again?\r\n");
                printf("Press <Enter> to retry, <Esc> to Stop\r\n");
                while(1)
                {
                    Ch = getchar();
                    if((char)Ch == 0x1B) //ESC
                    {
                        //getchar();
                        printf("Stop join Now\r\n");
                        goto RESCAN;
                    }
                    else if((char)Ch == 0x0D) //Enter
                    {
                        printf("Retry Now!\r\n");
                        break;
                    }
                    else
                    {
                        //Void
                    }
                }
            }           
        }        

    }
            
    WiFi_LocalIPGet(Buf);
    printf("Freedom WiFi IP is: %d:%d:%d:%d\r\n", Buf[0],Buf[1],Buf[2],Buf[3]);



    /*status = WiFi_Begin(WEP,"Embest", 0, "0123456789");*/
    //if(status != WL_CONNECTED)
    //{
        //printf("\r\nFailure to join network\r\n");
        //while(1);
    //}
    
    while(1)
    {        
        if(Data++ > 10)
        {
            Data = 0;
        }
        
        while (WiFiClient_Available()) 
        {
            char c = WiFiClient_ReadByte();
            //putchar(c);
            //tmp[i++] = c;
            //if(i > 1000) i = 0;
        }

        if (!WiFiClient_Connected() && lastConnected)
        {
            printf("\r\nDisconnecting.\r\n");
            WiFiClient_Stop();
        }

        if(!WiFiClient_Connected() && (Cnt++ > 2000))
        {
            Cnt = 0;
            printf("Data:%d\r\n", Data);
            SendData(Data);
        }

        lastConnected = WiFiClient_Connected();
        DelayMs(2);  
    }
}

static void SysInit(void)
{
    // Close watchdog
    (*((volatile unsigned long *)(0x40048100))) = 0x00;
    
    // Configure System clock    
    xSysCtlClockSet(F_CLK, xSYSCTL_OSC_MAIN | xSYSCTL_XTAL_8MHZ);
    SysCtlDelay(100*TICK_1MS);
}

// this method makes a HTTP connection to the server:
static void SendData(int thisData)
{
    int thisLength = 0;
    uint8_t Buf[] = {0,0,0,0,0,0,0,0,0,};

    WiFiClient_Init();
    if(!WiFiClient_Connect("api.pachube.com", 80))    
    {
        printf("\r\nFailure to connect to webserver\r\n");
        printf("Disconnecting\r\n");
        WiFiClient_Stop();
    }
    else
    {
        printf("connecting...\r\n");
        // send the HTTP PUT request:
        WebPrint("PUT /v2/feeds/");
        sprintf((char *)Buf, "%d", FEEDID);
        WebPrint(Buf);
        /*client.print(FEEDID);*/
        WebPrint(".csv HTTP/1.1\r\n");
        WebPrint("Host: api.pachube.com\r\n");
        WebPrint("X-ApiKey: ");
        WebPrint(APIKEY "\r\n");
        WebPrint("User-Agent: ");
        WebPrint(USERAGENT "\r\n");
        WebPrint("Content-Length: ");

        // calculate the length of the sensor reading in bytes:
        // 8 bytes for "sensor1," + number of digits of the data:
        thisLength  = 8 + _getLength(thisData);
        /*client.println(thisLength);*/
        sprintf((char *)Buf, "%d\r\n", thisLength);
        WebPrint(Buf);

        // last pieces of the HTTP PUT request:
        WebPrint("Content-Type: text/csv\r\n");
        WebPrint("Connection: close\r\n");
        WebPrint("\r\n");

        // here's the actual content of the PUT request:
        WebPrint("sensor1,");
        /*client.println(thisData);*/
        sprintf((char *)Buf, "%d\r\n", thisData);
        WebPrint(Buf);
    }
}

static int _getLength(int someValue)
{
  // there's at least one byte:
  int digits = 1;
  // continually divide the value by ten, 
  // adding one to the digit count for each
  // time you divide, until you're at 0:
  int dividend = someValue /10;
  while (dividend > 0)
  {
    dividend = dividend /10;
    digits++;
  }
  // return the number of digits:
  return digits;
}


