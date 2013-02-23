#ifndef _SPI_DRV_H_
#define _SPI_DRV_H_

#include <stdio.h>
#include <stdint.h>
#include "wifi_spi.h"

#define NO_LAST_PARAM                  0
#define LAST_PARAM                     1

#define DUMMY_DATA                     0xFF

#define WAIT_FOR_SLAVE_SELECT()        \
    do                                 \
    {                                  \
        SpiDrv_WaitForSlaveReady();    \
        SpiDrv_SlaveSelect();          \
    }while(0)


void     SpiDrv_Init(void);
void     SpiDrv_Stop(void);
void     SpiDrv_SlaveSelect(void);
void     SpiDrv_SlaveDeselect(void);
uint8_t  SpiDrv_Transfer(uint8_t data);
void     SpiDrv_WaitForSlaveReady(void);
int32_t  SpiDrv_WaitChar(uint8_t waitChar);
int32_t  SpiDrv_ReadAndCheckChar(uint8_t checkChar, uint8_t* readChar);
uint8_t  SpiDrv_ReadChar(void);
void     SpiDrv_GetParam(uint8_t* param);
int32_t  SpiDrv_WaitResponseCmd(uint8_t cmd, uint8_t numParam, uint8_t* param, uint8_t* param_len);
int32_t  SpiDrv_WaitResponseData16(uint8_t cmd, uint8_t* param, uint16_t* param_len);
int32_t  SpiDrv_WaitResponseData8(uint8_t cmd, uint8_t* param, uint8_t* param_len);
int32_t  SpiDrv_WaitResponseParams(uint8_t cmd, uint8_t numParam, tParam* params);
int32_t  SpiDrv_WaitResponse(uint8_t cmd, uint8_t* numParamRead, uint8_t** params, uint8_t maxNumParams);
void     SpiDrv_SendParam(uint8_t* param, uint8_t param_len, uint8_t lastParam);
void     SpiDrv_SendParamLen8(uint8_t param_len);
void     SpiDrv_SendParamLen16(uint16_t param_len);
uint8_t  SpiDrv_ReadParamLen8(uint8_t* param_len);
uint16_t SpiDrv_ReadParamLen16(uint16_t* param_len);
void     SpiDrv_SendBuffer(uint8_t* param, uint16_t param_len, uint8_t lastParam);
void     SpiDrv_SendParam16(uint16_t param, uint8_t lastParam);
void     SpiDrv_SendCmd(uint8_t cmd, uint8_t numParam);


#endif //__SPI_DRV_H
