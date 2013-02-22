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

/* Includes ------------------------------------------------------------------*/
#include "stm32f10x.h"
#include "WiFi.h"

uint8_t Buf[5];
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




/*
Sorry, we can not find network here!

Now Input Target Network ID
Tips:
#1 press <F5> to refresh network
#2 press <ESC> to exit demo

Your have selected network XXX, correct?
press: 
      <Enter> to continue
      <Esc>   to reselect

Please input network's Key

Wait, Connecting...

Congratulation! Connect to network XXX successfully!
Now, you can open your web browser and input WiFi Server address
192.168.2.1:88888 to control your Freedom board LED.
*/


static void delay(volatile uint32_t tick)
{
    while(tick--);
}


int fgetc(FILE *f)
{
    /* Loop until the USARTz Receive Data Register is not empty */
    while(USART_GetFlagStatus(USART1, USART_FLAG_RXNE) == RESET)
    {

    }

    /* Store the received byte in RxBuffer */
    return (USART_ReceiveData(USART1));
}

int fputc(int ch, FILE *f) 
{
    /* Place your implementation of fputc here */
    /* e.g. write a character to the USART */
    USART_SendData(USART1, (uint8_t) ch);

    /* Loop until the end of transmission */
    while (USART_GetFlagStatus(USART1, USART_FLAG_TC) == RESET)
    {}

    return ch;
}

void ComInit(void)
{
    GPIO_InitTypeDef GPIO_InitStructure;
    USART_InitTypeDef USART_InitStructure;

    /* config USART1 clock */
    RCC_APB2PeriphClockCmd(RCC_APB2Periph_USART1 | RCC_APB2Periph_GPIOA, ENABLE);

    /* USART1 GPIO config */
    /* Configure USART1 Tx (PA.09) as alternate function push-pull */
    GPIO_InitStructure.GPIO_Pin = GPIO_Pin_9;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_PP;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_Init(GPIOA, &GPIO_InitStructure);    
    /* Configure USART1 Rx (PA.10) as input floating */
    GPIO_InitStructure.GPIO_Pin = GPIO_Pin_10;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING;
    GPIO_Init(GPIOA, &GPIO_InitStructure);

    /* USART1 mode config */
    USART_InitStructure.USART_BaudRate = 115200;
    USART_InitStructure.USART_WordLength = USART_WordLength_8b;
    USART_InitStructure.USART_StopBits = USART_StopBits_1;
    USART_InitStructure.USART_Parity = USART_Parity_No ;
    USART_InitStructure.USART_HardwareFlowControl = USART_HardwareFlowControl_None;
    USART_InitStructure.USART_Mode = USART_Mode_Rx | USART_Mode_Tx;
    USART_Init(USART1, &USART_InitStructure); 
    USART_Cmd(USART1, ENABLE);
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
        break;
    case ENC_TYPE_TKIP:   //WPA
    case ENC_TYPE_CCMP:   //WPA2
        return WiFi_Begin(WPA, WiFi_SSIDGet(ChoiceID), Key);
        break;
    case ENC_TYPE_NONE:   //OPEN
        return WiFi_Begin(OPEN, WiFi_SSIDGet(ChoiceID));
        break;
    case ENC_TYPE_AUTO:   //AUTO        
        break;
    }
}


int main(void)
{

  

    WiFi_Init();
    ComInit();


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
        delay(0xFFF); 

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
    
    while(1)
    {
        status = JoinNetWork(NetWorkType);
        if(status == WL_CONNECTED)
        {
            printf("OK, Connect to Network!!!\r\n");
            break;
        }
        else
        {            
            Ch = getchar();
            if((char)Ch == 0x1B) //ESC
            {
                //getchar();
                printf("\r\nStop join Now\r\n");
                goto RESCAN;
            }            
        }
        delay(0xFFF);
    }
          
    WiFi_LocalIPGet(Buf);
    printf("Freedom WiFi Server IP is: %d:%d:%d:%d\r\n", Buf[0],Buf[1],Buf[2],Buf[3]);
    while(1);              

}
