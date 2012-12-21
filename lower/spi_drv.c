#include "includes.h"

/*
 #define DATAOUT     11 // MOSI
 #define DATAIN      12 // MISO
 #define SPICLOCK    13 // sck
 #define SLAVESELECT 10 // ss
 #define SLAVEREADY  7  // handshake pin
 #define WIFILED     9  // led on wifi shield
 */

#define SPI_DELAY 300
static void delay(uint32_t tick) {
    volatile uint32_t _tick = tick;
    while (_tick--)
        ;
}

#define IF_CHECK_START_CMD(x)                   \
    if (!SpiDrvWaitChar(START_CMD))             \
    {                                           \
        return 0;                               \
    }else                                       \

#define CHECK_DATA(check, x)                    \
        if (!SpiDrvReadAndCheckChar(check, &x)) \
        {                                       \
            return 0;                           \
        }else                                   \


static void _getParam(uint8_t* param);

//////////////////////// SPI PART ///////////////////////////////////

//Init the SPI Derive
void SpiDrvBegin(void) 
{

    // Init the system
    xSysCtlClockSet(36000000, xSYSCTL_OSC_MAIN | xSYSCTL_XTAL_12MHZ);

    // Init SPI Port
    SysCtlPeripheralEnable(SYSCTL_PERIPH_SPI1);

    xSPinTypeSPI(SPI1CLK,  PA7);
    xSPinTypeSPI(SPI1MISO, PA6);
    xSPinTypeSPI(SPI1MOSI, PA5);
    xSPinTypeSPI(SPI1CS,   PA4);

    xSPIConfigSet(SPI1_BASE, 200000,
            xSPI_MOTO_FORMAT_MODE_0 | SPI_DATA_WIDTH8 | SPI_MSB_FIRST | SPI_MODE_MASTER);

    // Init Handshake Pin
    xSysCtlPeripheralEnable(xGPIOSPinToPeripheralId(sD7));

    // Init UART Port
    xSysCtlPeripheralEnable(xSYSCTL_PERIPH_UART0);
    xSysCtlPeripheralClockSourceSet(xSYSCTL_UART0_MAIN, 1);

    sPinTypeUART(sUART_DBG_BASE);
    xUARTConfigSet(sUART_DBG_BASE, 9600,
            (UART_CONFIG_WLEN_8 | UART_CONFIG_STOP_ONE | UART_CONFIG_PAR_NONE));
    xUARTEnable(sUART_DBG_BASE,
            (UART_BLOCK_UART | UART_BLOCK_TX | UART_BLOCK_RX));

}

void SpiDrvEnd(void) {
    //Stop the SPI Derive
}

void SpiDrvSlaveSelect(void) {
    //Select the salve
}

void SpiDrvSlaveDeselect(void) {
    //Deselect the salve
}

//Write and Read
uint8_t SpiDrvTransfer(uint8_t data) {
    uint8_t _recv = xSPISingleDataReadWrite(SPI1_BASE, data);
    return (_recv);
}

//Waitting for the special char
int SpiDrvWaitChar(uint8_t waitChar) {
    uint32_t tick = 0;
    uint8_t _readChar = 0;

    do {
        _readChar = SpiDrvReadChar(); //get data byte
        if (_readChar == ERR_CMD) {
            //WARN("Err cmd received\n");
            return -1;
        }
    } while ((tick++ < 1000) && (_readChar != waitChar));

    return (_readChar == waitChar);
}

int SpiDrvReadAndCheckChar(char checkChar, char* readChar) {
    _getParam((uint8_t*) readChar);
    return (*readChar == checkChar);
}

uint8_t SpiDrvReadChar(void) {
    uint8_t readChar = 0;
    _getParam(&readChar);
    return readChar;
}

//////////////////////// HandShake //////////////////////////////////

static void _waitForSlaveSign() {
    //while (!waitSlaveSign());
}

void SpiDrvWaitForSlaveReady() 
{
    while (xGPIOSPinRead(sD7) != 0);
}

static void _getParam(uint8_t* param) {
    // Get Params data
    *param = SpiDrvTransfer(DUMMY_DATA);
    //DELAY_TRANSFER();
    delay(SPI_DELAY);
}

///////////////////////// END //////////////////////////////////////

void WaitForSlaveSelect(void) {
    //_waitForSlaveReady();
    SpiDrvSlaveSelect();
}

int SpiDrvWaitResponseCmd(uint8_t cmd, uint8_t numParam, uint8_t* param,
        uint8_t* param_len) {
    char _data = 0;
    int ii = 0;

    IF_CHECK_START_CMD(_data) {
        CHECK_DATA(cmd | REPLY_FLAG, _data) {
        };

        CHECK_DATA(numParam, _data);
        {
            SpiDrvReadParamLen8(param_len);
            for (ii = 0; ii < (*param_len); ++ii) {
                // Get Params data
                //param[ii] = SpiDrvTransfer(DUMMY_DATA);
                _getParam(&param[ii]);
            }
        }

        SpiDrvReadAndCheckChar(END_CMD, &_data);
    }

    return 1;
}

int SpiDrvWaitResponseData16(uint8_t cmd, uint8_t* param, uint16_t* param_len) {
    char _data = 0;
    uint16_t ii = 0;

    IF_CHECK_START_CMD(_data) {
        CHECK_DATA(cmd | REPLY_FLAG, _data) {
        };

        if (SpiDrvReadChar() != 0) {
            SpiDrvReadParamLen16(param_len);
            for (ii = 0; ii < (*param_len); ++ii) {
                // Get Params data
                param[ii] = SpiDrvTransfer(DUMMY_DATA);
            }
        }

        SpiDrvReadAndCheckChar(END_CMD, &_data);
    }

    return 1;
}

int SpiDrvWaitResponseData8(uint8_t cmd, uint8_t* param, uint8_t* param_len) {
    char _data = 0;
    int ii = 0;

    IF_CHECK_START_CMD(_data) {
        CHECK_DATA(cmd | REPLY_FLAG, _data) {
        };

        if (SpiDrvReadChar() != 0) {
            SpiDrvReadParamLen8(param_len);
            for (ii = 0; ii < (*param_len); ++ii) {
                // Get Params data
                param[ii] = SpiDrvTransfer(DUMMY_DATA);
            }
        }

        SpiDrvReadAndCheckChar(END_CMD, &_data);
    }

    return 1;
}

int SpiDrvWaitResponseParams(uint8_t cmd, uint8_t numParam, tParam* params) {
    char _data = 0;
    int i = 0;
    int ii = 0;
    uint8_t _numParam = 0;

    IF_CHECK_START_CMD(_data) {
        CHECK_DATA(cmd | REPLY_FLAG, _data) {
        };

        _numParam = SpiDrvReadChar();
        if (_numParam != 0) {
            for (i = 0; i < _numParam; ++i) {
                params[i].paramLen = SpiDrvReadParamLen8(NULL);
                for (ii = 0; ii < params[i].paramLen; ++ii) {
                    // Get Params data
                    params[i].param[ii] = SpiDrvTransfer(DUMMY_DATA);
                }
            }
        } else {
            //WARN("Error numParam == 0");
            return 0;
        }

        if (numParam != _numParam) {
            //WARN("Mismatch numParam");
            return 0;
        }

        SpiDrvReadAndCheckChar(END_CMD, &_data);
    }
    return 1;
}

int SpiDrvWaitResponse(uint8_t cmd, uint8_t* numParamRead, uint8_t** params,
        uint8_t maxNumParams) {
    char _data = 0;
    int i = 0;
    int ii = 0;
    uint8_t numParam = 0;
    char *index[WL_SSID_MAX_LENGTH];

    for (i = 0; i < WL_NETWORKS_LIST_MAXNUM; i++) {
        index[i] = (char *) params + WL_SSID_MAX_LENGTH * i;
    }

    IF_CHECK_START_CMD(_data) {
        CHECK_DATA(cmd | REPLY_FLAG, _data) {
        };

        numParam = SpiDrvReadChar();

        if (numParam > maxNumParams) {
            numParam = maxNumParams;
        }
        *numParamRead = numParam;
        if (numParam != 0) {
            for (i = 0; i < numParam; ++i) {
                uint8_t paramLen = SpiDrvReadParamLen8(NULL);
                for (ii = 0; ii < paramLen; ++ii) {
                    //ssid[ii] = SpiDrvTransfer(DUMMY_DATA);
                    // Get Params data
                    index[i][ii] = (uint8_t) SpiDrvTransfer(DUMMY_DATA);

                }
                index[i][ii] = 0;
            }
        } else {
            //WARN("Error numParams == 0");
            SpiDrvReadAndCheckChar(END_CMD, &_data);
            return 0;
        }
        SpiDrvReadAndCheckChar(END_CMD, &_data);
    }
    return 1;
}

void SpiDrvSendParamL(uint8_t* param, uint8_t param_len, uint8_t lastParam) {
    int i = 0;
    // Send Spi paramLen
    SpiDrvSendParamLen8(param_len);

    // Send Spi param data
    for (i = 0; i < param_len; ++i) {
        SpiDrvTransfer(param[i]);
    }

    // if lastParam==1 Send Spi END CMD
    if (lastParam == 1) {
        SpiDrvTransfer(END_CMD);
    }
}

void SpiDrvSendParamLen8(uint8_t param_len) {
    // Send Spi paramLen
    SpiDrvTransfer(param_len);
}

void SpiDrvSendParamLen16(uint16_t param_len) {
    // Send Spi paramLen
    SpiDrvTransfer((uint8_t)((param_len & 0xff00) >> 8));
    SpiDrvTransfer((uint8_t)(param_len & 0xff));
}

uint8_t SpiDrvReadParamLen8(uint8_t* param_len) {
    uint8_t _param_len = SpiDrvTransfer(DUMMY_DATA);
    if (param_len != NULL) {
        *param_len = _param_len;
    }
    return _param_len;
}

uint16_t SpiDrvReadParamLen16(uint16_t* param_len) {
    uint16_t _param_len = SpiDrvTransfer(DUMMY_DATA) << 8
            | (SpiDrvTransfer(DUMMY_DATA) & 0xff);
    if (param_len != NULL) {
        *param_len = _param_len;
    }
    return _param_len;
}

void SpiDrvSendBuffer(uint8_t* param, uint16_t param_len, uint8_t lastParam) {
    uint16_t i = 0;

    // Send Spi paramLen
    SpiDrvSendParamLen16(param_len);

    // Send Spi param data
    for (i = 0; i < param_len; ++i) {
        SpiDrvTransfer(param[i]);
    }

    // if lastParam==1 Send Spi END CMD
    if (lastParam == 1) {
        SpiDrvTransfer(END_CMD);
    }
}

void SpiDrvSendParamS(uint16_t param, uint8_t lastParam) {
    // Send Spi paramLen
    SpiDrvSendParamLen8(2);

    SpiDrvTransfer((uint8_t)((param & 0xff00) >> 8));
    SpiDrvTransfer((uint8_t)(param & 0xff));

    // if lastParam==1 Send Spi END CMD
    if (lastParam == 1) {
        SpiDrvTransfer(END_CMD);
    }
}

//    Cmd Struct Message
// _________________________________________________________________________________ 
//| START CMD | C/R  | CMD  |[TOT LEN]| N.PARAM | PARAM LEN | PARAM  | .. | END CMD |
//|___________|______|______|_________|_________|___________|________|____|_________|
//|   8 bit   | 1bit | 7bit |  8bit   |  8bit   |   8bit    | nbytes | .. |   8bit  |
//|___________|______|______|_________|_________|___________|________|____|_________|

void SpiDrvSendCmd(uint8_t cmd, uint8_t numParam) {
    // Send Spi START CMD
    SpiDrvTransfer(START_CMD);

    //waitForSlaveSign();
    //wait the interrupt trigger on slave
    //TODO I have commented it, but not sure is there any side effect
    //Cedar
    //delayMicroseconds(SPI_START_CMD_DELAY);

    // Send Spi C + cmd
    SpiDrvTransfer(cmd & ~(REPLY_FLAG));

    // Send Spi totLen
    //SpiDrvTransfer(totLen);

    // Send Spi numParam
    SpiDrvTransfer(numParam);

    // If numParam == 0 send END CMD
    if (numParam == 0) {
        SpiDrvTransfer(END_CMD);
    }
}

