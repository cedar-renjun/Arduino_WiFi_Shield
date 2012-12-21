#ifndef SPI_DRV_H
#define SPI_DRV_H


#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "wl_definitions.h"

#define SPI_START_CMD_DELAY 	12

#define NO_LAST_PARAM   0
#define LAST_PARAM      1

#define DUMMY_DATA  0xFF

#define WAIT_FOR_SLAVE_SELECT() WaitForSlaveSelect()

extern void     SpiDrvBegin(void);
extern void     SpiDrvEnd(void);
extern void     SpiDrvSlaveSelect(void);
extern void     SpiDrvSlaveDeselect(void);
extern uint8_t  SpiDrvTransfer(uint8_t data);

extern void     SpiDrvWaitForSlaveReady(void);
extern int      SpiDrvWaitChar(uint8_t waitChar);
extern int      SpiDrvReadAndCheckChar(char checkChar, char* readChar);
extern uint8_t  SpiDrvReadChar(void);
extern int      SpiDrvWaitResponseParams(uint8_t cmd, uint8_t numParam, tParam* params);
extern int      SpiDrvWaitResponseCmd(uint8_t cmd, uint8_t numParam, uint8_t* param, uint8_t* param_len);
extern int      SpiDrvWaitResponseData8(uint8_t cmd, uint8_t* param, uint8_t* param_len);
extern int      SpiDrvWaitResponseData16(uint8_t cmd, uint8_t* param, uint16_t* param_len);
extern int      SpiDrvWaitResponse(uint8_t cmd, uint8_t* numParamRead, uint8_t** params, uint8_t maxNumParams);
extern void     SpiDrvSendParamL(uint8_t* param, uint8_t param_len, uint8_t lastParam);
extern void     SpiDrvSendParamLen8(uint8_t param_len);
extern void     SpiDrvSendParamLen16(uint16_t param_len);
extern uint8_t  SpiDrvReadParamLen8(uint8_t* param_len);
extern uint16_t SpiDrvReadParamLen16(uint16_t* param_len);
extern void     SpiDrvSendBuffer(uint8_t* param, uint16_t param_len, uint8_t lastParam);
extern void     SpiDrvSendParamS(uint16_t param, uint8_t lastParam);
extern void     SpiDrvSendCmd(uint8_t cmd, uint8_t numParam);

// Internal Function
extern void     WaitForSlaveSelect(void);

#endif //  SPI_DRV_H
