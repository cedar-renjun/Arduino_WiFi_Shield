#include "WiFi.h"
#include "WiFiClient.h"

#define APIKEY         "enVXRmO1dRKzSpU2SIh-EPIibBiSAKxBMWpxS1poTElSYz0g" // replace your pachube api key here
#define FEEDID         106382                    // replace your feed ID
#define USERAGENT      "My Arduino Project"     // user agent is the project name


// if you don't want to use DNS (and reduce your sketch size)
// use the numeric IP instead of the name for the server:
static uint8_t server[] = {216,52,233,121};      // numeric IP for api.pachube.com
//char server[] = "api.pachube.com";   // name address for pachube API

unsigned long lastConnectionTime = 0;          // last time you connected to the server, in milliseconds
uint8_t lastConnected = 0;                 // state of the connection last time through the main loop
const unsigned long postingInterval = 10*1000; //delay between updates to pachube.com
static uint8_t Buf[20];

static void WebPrint(uint8_t *Str)
{
    WiFiClient_WriteBlock(Str, strlen((char*) Str));
}

static void delay(volatile uint32_t tick)
{
	while(tick--);
}

// This method calculates the number of digits in the
// sensor reading.  Since each digit of the ASCII decimal
// representation is a byte, the number of digits equals
// the number of bytes:

int getLength(int someValue) {
  // there's at least one byte:
  int digits = 1;
  // continually divide the value by ten, 
  // adding one to the digit count for each
  // time you divide, until you're at 0:
  int dividend = someValue /10;
  while (dividend > 0) {
    dividend = dividend /10;
    digits++;
  }
  // return the number of digits:
  return digits;
}

// this method makes a HTTP connection to the server:
void sendData(int thisData)
{
    int thisLength = 0;
  // if there's a successful connection:
  if (_ConnectViaIP(server, 80))
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
    thisLength  = 8 + getLength(thisData);
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
  else
  {
    // if you couldn't make a connection:
    printf("connection failed\r\n\r\n");
    printf("disconnecting.\r\n");
    WiFiClient_Stop();
  }

}


void PachubeClient(void)
{
  // read the analog sensor:
  static int sensorReading = 0;
  
  if(sensorReading++ >= 20)
  {
      sensorReading = 0;
  }
  
  WiFiClient_Init();
  // if there's incoming data from the net connection.
  // send it out the serial port.  This is for debugging
  // purposes only:
/*  while(WiFiClient_Available())
  {
      char c = WiFiClient_ReadByte();
      putchar(c);
  }
*/
  // if there's no net connection, but there was one last time
  // through the loop, then stop the client:
  if (!WiFiClient_Connected() && lastConnected)
  {
    printf("\r\ndisconnecting.\r\n");
    WiFiClient_Stop();
  }

  // if you're not connected, and ten seconds have passed since
  // your last connection, then connect again and send data:
  //if(!WiFiClient_Connected())
  //{
      sendData(sensorReading);
  //}
  // store the state of the connection for next time through
  // the loop:
  lastConnected = WiFiClient_Connected();
  delay(0xFFFF);
}



/*
static uint8_t Http_Req[] = 
{
    "PUT /v2/feeds/"
    "106382"
    ".csv HTTP/1.1\r\n"
    "Host: api.pachube.com\r\n"
    "X-ApiKey: "
    "enVXRmO1dRKzSpU2SIh-EPIibBiSAKxBMWpxS1poTElSYz0g\r\n"
    "User-Agent: "
    "CooCox WiFi Demo\r\n"
    "Content-Length: "
};

static uint8_t server[] = {216,52,233,121};      // numeric IP for api.pachube.com
//char server[] = "api.pachube.com";      // name address for pachube API

static uint8_t Buf[20];

static void WebPrint(uint8_t *Str)
{
    WiFiClient_WriteBlock(Str, strlen((char*) Str));
}

static void delay(volatile uint32_t tick)
{
	while(tick--);
}

static int getLength(int someValue)
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

static void SendData(int thisData)
{
    int thisLength = 0;
    // if there's a successful connection:
    if (_ConnectViaIP(server, 80))
    {
        printf("Connect to webserver\r\n");
        thisLength = 8 + getLength(thisData);
        WebPrint(Http_Req);

        // calculate the length of the sensor reading in bytes:
        // 8 bytes for "sensor1," + number of digits of the data:
        sprintf((char *)Buf, "%d\r\n", thisLength);
        WebPrint(Buf);

        // last pieces of the HTTP PUT request:
        WebPrint("Content-Type: text/csv\r\n"
                 "Connection: close\r\n"
                 "\r\n");

        // here's the actual content of the PUT request:
        sprintf((char *)Buf, "sensor1,%d\r\n", thisData);
        WebPrint(Buf);
        
        delay(0xFFFF);
        
        //WiFiClient_Stop();
    } 
}

void PachubeClient(void)
{
    int Cnt = 0;
    
    WiFiClient_Init();
    while(1)
    {

        if(Cnt++ == 50)
        {
            Cnt = 0;
        }

        SendData(Cnt);
        
        while(WiFiClient_Available())
        {
            char c = WiFiClient_ReadByte();
            putchar(c);
        }
        
        if(WiFiClient_Connected())
        {
            WiFiClient_Stop();
        }

        delay(0xFFFFF);
    }
}
*/
