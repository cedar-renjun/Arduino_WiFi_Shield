
#include "stm32f10x.h"
#include "spi_drv.h"

//About 15us
#define DELAY_TRANSFER() delay(0x5F)

static void delay(volatile uint32_t tick)
{
    while(tick--);
}

//  HAND_PIN  --> PA3
//  SPI1_NSS  --> PA4
//  SPI1_SCK  --> PA5
//  SPI1_MISO --> PA6
//  SPI1_MOSI --> PA7

//WiFi shield IO refence volatge == 3.3V

void SpiDrv_Init(void)
{

    SPI_InitTypeDef  SPI_InitStructure;
    GPIO_InitTypeDef GPIO_InitStructure;

    /* PCLK2 = HCLK/2 */
    RCC_PCLK2Config(RCC_HCLK_Div2);

    //Enable peripheral clocks
    //GPIOA, GPIOB and SPI1 clock enable
    RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOA | RCC_APB2Periph_SPI1, ENABLE);

    //Configure PA3 to HandShake Pin
    GPIO_InitStructure.GPIO_Pin = GPIO_Pin_2;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING;
    GPIO_Init(GPIOA, &GPIO_InitStructure);

    //Configure PA4 to Salave Select pin
    GPIO_InitStructure.GPIO_Pin = GPIO_Pin_4;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;
    GPIO_Init(GPIOA, &GPIO_InitStructure);

    //Configure SPI1 pins: SCK, MISO and MOSI 
    //Confugure SCK and MOSI pins as Alternate Function Push Pull
    GPIO_InitStructure.GPIO_Pin = GPIO_Pin_5 | GPIO_Pin_7;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_PP;
    GPIO_Init(GPIOA, &GPIO_InitStructure);

    //Confugure MISO pin as Input Floating
    GPIO_InitStructure.GPIO_Pin = GPIO_Pin_6;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING;
    GPIO_Init(GPIOA, &GPIO_InitStructure);
    
    //Note
    GPIO_SetBits(GPIOA, GPIO_Pin_4);

    /* SPI1 configuration ------------------------------------------------------*/
    SPI_InitStructure.SPI_Direction = SPI_Direction_2Lines_FullDuplex;
    SPI_InitStructure.SPI_Mode = SPI_Mode_Master;
    SPI_InitStructure.SPI_DataSize = SPI_DataSize_8b;
    SPI_InitStructure.SPI_CPOL = SPI_CPOL_Low;
    SPI_InitStructure.SPI_CPHA = SPI_CPHA_1Edge;
    SPI_InitStructure.SPI_NSS = SPI_NSS_Soft;
    SPI_InitStructure.SPI_BaudRatePrescaler = SPI_BaudRatePrescaler_8;
    SPI_InitStructure.SPI_FirstBit = SPI_FirstBit_MSB;
    SPI_InitStructure.SPI_CRCPolynomial = 7;
    SPI_Init(SPI1, &SPI_InitStructure);

    /* Enable SPI1 */
    SPI_Cmd(SPI1, ENABLE);

}

void SpiDrv_Stop(void)
{
    SPI_Cmd(SPI1, DISABLE);
}

void SpiDrv_SlaveSelect(void)
{
    //Select the SPI slave
    //GPIO_ResetBits(GPIOA, GPIO_Pin_4);
}

void SpiDrv_SlaveDeselect(void)
{
    //Deselect the SPI slave
    //GPIO_SetBits(GPIOA, GPIO_Pin_4);
}

//Write an byte to SPI Bus then read back an byte.
uint8_t SpiDrv_Transfer(uint8_t data)
{
    uint8_t recv = 0;

    while (SPI_I2S_GetFlagStatus(SPI1, SPI_I2S_FLAG_TXE) == RESET);
    SPI_I2S_SendData(SPI1, data);
    while (SPI_I2S_GetFlagStatus(SPI1, SPI_I2S_FLAG_RXNE) == RESET);
    recv = SPI_I2S_ReceiveData(SPI1);

    //This delay is must
    //Note By CooCox Cedar
    delay(0x5F);

    return (recv);
}

void SpiDrv_WaitForSlaveReady(void)
{
    //Wait WiFi SPI idle.
    while(GPIO_ReadInputDataBit(GPIOA, GPIO_Pin_2) == Bit_SET);
}

//////////////////////////////////////////////////////////////////////////

int32_t SpiDrv_WaitChar(uint8_t waitChar)
{
    uint8_t _readChar = 0;
    int16_t timeout   = TIMEOUT_CHAR;

    do{
        _readChar = SpiDrv_ReadChar();
        if (_readChar == ERR_CMD)
        {
            return (-1);
        }
    }while((timeout-- > 0) && (_readChar != waitChar));

    return  (_readChar == waitChar);
}

int32_t SpiDrv_ReadAndCheckChar(uint8_t checkChar, uint8_t* readChar)
{
    SpiDrv_GetParam(readChar);

    return  (*readChar == checkChar);
}

char SpiDrv_ReadChar(void)
{
    uint8_t readChar = 0;

    readChar = SpiDrv_Transfer(DUMMY_DATA);
    DELAY_TRANSFER();

    return readChar;
}

void SpiDrv_GetParam(uint8_t* param)
{
    // Get Params data
    *param = SpiDrv_Transfer(DUMMY_DATA);
    DELAY_TRANSFER();
}

int32_t SpiDrv_WaitResponseCmd(uint8_t cmd, uint8_t numParam, uint8_t* param, uint8_t* param_len)
{
    uint8_t i     = 0;
    uint8_t _data = 0;

    if(!SpiDrv_WaitChar(START_CMD))
    {
        return 0;
    }
    else
    {
        if (!SpiDrv_ReadAndCheckChar(cmd | REPLY_FLAG, &_data))
        {
            return 0;
        }

        if (!SpiDrv_ReadAndCheckChar(numParam, &_data))
        {
            return 0;
        }
        else
        {
            SpiDrv_ReadParamLen8(param_len);
            for (i=0; i<(*param_len); ++i)
            {
                // Get Params data
                SpiDrv_GetParam(&param[i]);
            }
        }

        SpiDrv_ReadAndCheckChar(END_CMD, &_data);
    }

    return 1;
}

int32_t SpiDrv_WaitResponseData16(uint8_t cmd, uint8_t* param, uint16_t* param_len)
{
    uint8_t  _data    = 0;
    uint8_t  numParam = 0;
    uint16_t i        = 0;

    if(!SpiDrv_WaitChar(START_CMD))
    {
        return 0;
    }
    else
    {
        if (!SpiDrv_ReadAndCheckChar(cmd | REPLY_FLAG, &_data))
        {
            return 0;
        }
        numParam = SpiDrv_ReadChar();
        if (numParam != 0)
        {
            SpiDrv_ReadParamLen16(param_len);
            for (i=0; i<(*param_len); ++i)
            {
                // Get Params data
                SpiDrv_GetParam(&param[i]);
            }
        }

        SpiDrv_ReadAndCheckChar(END_CMD, &_data);
    }

    return 1;
}

int32_t SpiDrv_WaitResponseData8(uint8_t cmd, uint8_t* param, uint8_t* param_len)
{
    uint8_t i        = 0;
    uint8_t _data    = 0;
    uint8_t numParam = 0;

    if(!SpiDrv_WaitChar(START_CMD))
    {
        return 0;
    }
    else
    {
        if (!SpiDrv_ReadAndCheckChar(cmd | REPLY_FLAG, &_data))
        {
            return 0;
        }

        numParam = SpiDrv_ReadChar();
        if (numParam != 0)
        {
            SpiDrv_ReadParamLen8(param_len);
            for (i=0; i<(*param_len); ++i)
            {
                // Get Params data
                SpiDrv_GetParam(&param[i]);
            }
        }

        SpiDrv_ReadAndCheckChar(END_CMD, &_data);
    }

    return 1;
}

int32_t SpiDrv_WaitResponseParams(uint8_t cmd, uint8_t numParam, tParam* params)
{
    uint8_t i         = 0;
    uint8_t ii        = 0;
    uint8_t _data     = 0;
    uint8_t _numParam = 0;

    if(!SpiDrv_WaitChar(START_CMD))
    {
        return 0;
    }
    else
    {
        if (!SpiDrv_ReadAndCheckChar(cmd | REPLY_FLAG, &_data))
        {
            return 0;
        }

        _numParam = SpiDrv_ReadChar();
        if (_numParam != 0)
        {
            if (numParam != _numParam)
            {
                /*WARN("Mismatch numParam");*/
                return 0;
            }

            for (i=0; i<_numParam; ++i)
            {
                params[i].paramLen = SpiDrv_ReadParamLen8(NULL);
                for (ii=0; ii<params[i].paramLen; ++ii)
                {
                    // Get Params data
                    params[i].param[ii] = SpiDrv_Transfer(DUMMY_DATA);
                }
            }
        }
        else
        {
            /*WARN("Error numParam == 0");*/
            return 0;
        }

        SpiDrv_ReadAndCheckChar(END_CMD, &_data);
    }
    return 1;
}

int32_t SpiDrv_WaitResponse(uint8_t cmd, uint8_t* numParamRead, uint8_t** params, uint8_t maxNumParams)
{
    uint8_t _data    = 0;
    int     i        = 0;
    int     ii       = 0;
    uint8_t numParam = 0;
    uint8_t paramLen = 0;

    char    *index[WL_SSID_MAX_LENGTH];

    for (i = 0 ; i < WL_NETWORKS_LIST_MAXNUM ; i++)
    {
        index[i] = (char *)params + WL_SSID_MAX_LENGTH*i;
    }

    if(!SpiDrv_WaitChar(START_CMD))
    {
        return 0;
    }
    else
    {
        if (!SpiDrv_ReadAndCheckChar(cmd | REPLY_FLAG, &_data))
        {
            return 0;
        }

        numParam = SpiDrv_ReadChar();

        if (numParam > maxNumParams)
        {
            numParam = maxNumParams;
        }
        *numParamRead = numParam;
        if (numParam != 0)
        {
            for (i=0; i<numParam; ++i)
            {
                paramLen = SpiDrv_ReadParamLen8(NULL);
                for (ii=0; ii<paramLen; ++ii)
                {
                    // Get Params data
                    index[i][ii] = SpiDrv_Transfer(DUMMY_DATA);
                }
                index[i][ii]=0;
            }
        }
        else
        {
            /*WARN("Error numParams == 0");*/
            SpiDrv_ReadAndCheckChar(END_CMD, &_data);
            return 0;
        }
        SpiDrv_ReadAndCheckChar(END_CMD, &_data);
    }
    return 1;
}

void SpiDrv_SendParam(uint8_t* param, uint8_t param_len, uint8_t lastParam)
{
    int i = 0;

    // Send Spi paramLen
    SpiDrv_SendParamLen8(param_len);

    // Send Spi param data
    for (i=0; i<param_len; ++i)
    {
        SpiDrv_Transfer(param[i]);
    }

    // if lastParam==1 Send Spi END CMD
    if (lastParam == 1)
    {
        SpiDrv_Transfer(END_CMD);
    }
}

void SpiDrv_SendParamLen8(uint8_t param_len)
{
    // Send Spi paramLen
    SpiDrv_Transfer(param_len);
}

void SpiDrv_SendParamLen16(uint16_t param_len)
{
    // Send Spi paramLen
    SpiDrv_Transfer((uint8_t)(param_len >> 8));
    SpiDrv_Transfer((uint8_t)param_len);
}

uint8_t SpiDrv_ReadParamLen8(uint8_t* param_len)
{
    uint8_t _param_len = SpiDrv_Transfer(DUMMY_DATA);
    if (param_len != NULL)
    {
        *param_len = _param_len;
    }
    return _param_len;
}

uint16_t SpiDrv_ReadParamLen16(uint16_t* param_len)
{
    uint16_t _param_len = 0;

    _param_len  = SpiDrv_Transfer(DUMMY_DATA) << 8;
    _param_len |= SpiDrv_Transfer(DUMMY_DATA) & 0xff;

    if (param_len != NULL)
    {
        *param_len = _param_len;
    }
    return _param_len;
}

void SpiDrv_SendBuffer(uint8_t* param, uint16_t param_len, uint8_t lastParam)
{
    uint16_t i = 0;

    // Send Spi paramLen
    SpiDrv_SendParamLen16(param_len);

    // Send Spi param data
    for (i=0; i<param_len; ++i)
    {
        SpiDrv_Transfer(param[i]);
    }

    // if lastParam==1 Send Spi END CMD
    if (lastParam == 1)
    {
        SpiDrv_Transfer(END_CMD);
    }
}

void SpiDrv_SendParam16(uint16_t param, uint8_t lastParam)
{
    // Send Spi paramLen
    SpiDrv_SendParamLen8(2);

    SpiDrv_Transfer((uint8_t)((param & 0xff00)>>8));
    SpiDrv_Transfer((uint8_t)(param & 0xff));

    // if lastParam==1 Send Spi END CMD
    if (lastParam == 1)
    {
        SpiDrv_Transfer(END_CMD);
    }
}


/* Cmd Struct Message */
/* _________________________________________________________________________________  */
/*| START CMD | C/R  | CMD  |[TOT LEN]| N.PARAM | PARAM LEN | PARAM  | .. | END CMD | */
/*|___________|______|______|_________|_________|___________|________|____|_________| */
/*|   8 bit   | 1bit | 7bit |  8bit   |  8bit   |   8bit    | nbytes | .. |   8bit  | */
/*|___________|______|______|_________|_________|___________|________|____|_________| */

void SpiDrv_SendCmd(uint8_t cmd, uint8_t numParam)
{
    // Send Spi START CMD
    SpiDrv_Transfer(START_CMD);

    //wait the interrupt trigger on slave
    DELAY_TRANSFER();
    DELAY_TRANSFER();

    // Send Spi C + cmd
    SpiDrv_Transfer(cmd & ~(REPLY_FLAG));

    // Send Spi numParam
    SpiDrv_Transfer(numParam);

    // Check Param length
    if (numParam == 0)
    {
        SpiDrv_Transfer(END_CMD);
    }

}

