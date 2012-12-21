#include "includes.h"

static void delay(uint32_t tick)
{
    volatile uint32_t _tick = tick;
	while(_tick--);
}

// Start server TCP on port specified
void ServerDrvStartServer(uint16_t port, uint8_t sock)
{
    
    uint8_t _data    = 0;
    uint8_t _dataLen = 0;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrvWaitForSlaveReady();
    SpiDrvSlaveSelect();
    // Send Command
    SpiDrvSendCmd(START_SERVER_TCP_CMD, PARAM_NUMS_2);
    //TODO
	SpiDrvSendParamS(port, NO_LAST_PARAM);
    SpiDrvSendParamL(&sock, 1, LAST_PARAM);

    //Wait the reply elaboration
    SpiDrvWaitForSlaveReady();

    // Wait for reply
    if (!SpiDrvWaitResponseCmd(START_SERVER_TCP_CMD, PARAM_NUMS_1, &_data, &_dataLen))
    {
        //WARN("error waitResponse");
    }
    SpiDrvSlaveDeselect();
}

// Start server TCP on port specified
void ServerDrvStartClient(uint32_t ipAddress, uint16_t port, uint8_t sock)
{
    uint8_t _data    = 0;
    uint8_t _dataLen = 0;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrvWaitForSlaveReady();
    SpiDrvSlaveSelect();
    // Send Command
    SpiDrvSendCmd(START_CLIENT_TCP_CMD, PARAM_NUMS_3);
    //TODO
    SpiDrvSendParamL((uint8_t*)&ipAddress, sizeof(ipAddress), NO_LAST_PARAM);
    SpiDrvSendParamS(port, NO_LAST_PARAM);
    SpiDrvSendParamL(&sock, 1, LAST_PARAM);

    //Wait the reply elaboration
    SpiDrvWaitForSlaveReady();

    // Wait for reply
    if (!SpiDrvWaitResponseCmd(START_CLIENT_TCP_CMD, PARAM_NUMS_1, &_data, &_dataLen))
    {
        //WARN("error waitResponse");
    }
    SpiDrvSlaveDeselect();
}

// Start server TCP on port specified
void ServerDrvStopClient(uint8_t sock)
{
    uint8_t _data    = 0;
    uint8_t _dataLen = 0;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrvWaitForSlaveReady();
    SpiDrvSlaveSelect();

    // Send Command
    SpiDrvSendCmd(STOP_CLIENT_TCP_CMD, PARAM_NUMS_1);
    SpiDrvSendParamL(&sock, 1, LAST_PARAM);

    //Wait the reply elaboration
    SpiDrvWaitForSlaveReady();

    // Wait for reply
    if (!SpiDrvWaitResponseCmd(STOP_CLIENT_TCP_CMD, PARAM_NUMS_1, &_data, &_dataLen))
    {
        //WARN("error waitResponse");
    }
    SpiDrvSlaveDeselect();
}


uint8_t ServerDrvGetServerState(uint8_t sock)
{
    uint8_t _data    = 0;
    uint8_t _dataLen = 0;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrvWaitForSlaveReady();
    SpiDrvSlaveSelect();
    // Send Command
    SpiDrvSendCmd(GET_STATE_TCP_CMD, PARAM_NUMS_1);
    SpiDrvSendParamL(&sock, sizeof(sock), LAST_PARAM);

    //Wait the reply elaboration
    SpiDrvWaitForSlaveReady();

    // Wait for reply
    if (!SpiDrvWaitResponseCmd(GET_STATE_TCP_CMD, PARAM_NUMS_1, &_data, &_dataLen))
    {
        //WARN("error waitResponse");
    }
    SpiDrvSlaveDeselect();
    return (_data);
}

uint8_t ServerDrvGetClientState(uint8_t sock)
{
    uint8_t _data    = 0;
    uint8_t _dataLen = 0;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrvWaitForSlaveReady();
    SpiDrvSlaveSelect();
    // Send Command
    SpiDrvSendCmd(GET_CLIENT_STATE_TCP_CMD, PARAM_NUMS_1);
    SpiDrvSendParamL(&sock, sizeof(sock), LAST_PARAM);

    //Wait the reply elaboration
    SpiDrvWaitForSlaveReady();

    // Wait for reply
    if (!SpiDrvWaitResponseCmd(GET_CLIENT_STATE_TCP_CMD, PARAM_NUMS_1, &_data, &_dataLen))
    {
        //WARN("error waitResponse");
    }
    SpiDrvSlaveDeselect();

    return (_data);
}

uint8_t ServerDrvAvailData(uint8_t sock)
{
    uint8_t _data    = 0;
    uint8_t _dataLen = 0;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrvWaitForSlaveReady();
    SpiDrvSlaveSelect();
    // Send Command
    SpiDrvSendCmd(AVAIL_DATA_TCP_CMD, PARAM_NUMS_1);
    SpiDrvSendParamL(&sock, sizeof(sock), LAST_PARAM);

    //Wait the reply elaboration
    SpiDrvWaitForSlaveReady();

    // Wait for reply
    if (!SpiDrvWaitResponseCmd(AVAIL_DATA_TCP_CMD, PARAM_NUMS_1, &_data, &_dataLen))
    {
        //WARN("error waitResponse");
    }
    SpiDrvSlaveDeselect();

    if (_dataLen!=0)
    {
        return (_data == 1);
    }
    return (0);
}

uint8_t ServerDrvGetData(uint8_t sock, uint8_t *data, uint8_t peek)
{
    uint8_t _data    = 0;
    uint8_t _dataLen = 0;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrvWaitForSlaveReady();
    SpiDrvSlaveSelect();
    // Send Command
    SpiDrvSendCmd(GET_DATA_TCP_CMD, PARAM_NUMS_2);
    SpiDrvSendParamL(&sock, sizeof(sock), NO_LAST_PARAM);
    SpiDrvSendParamL(&peek, sizeof(sock), LAST_PARAM);

    //Wait the reply elaboration
    SpiDrvWaitForSlaveReady();

    // Wait for reply
    if (!SpiDrvWaitResponseData8(GET_DATA_TCP_CMD, &_data, &_dataLen))
    {
        //WARN("error waitResponse");
    }
    SpiDrvSlaveDeselect();
    if (_dataLen!=0)
    {
        *data = _data;
        return (1);
    }
    return (0);
}

uint8_t ServerDrvGetDataBuf(uint8_t sock, uint8_t *_data, uint16_t *_dataLen)
{
    //WAIT_FOR_SLAVE_SELECT();
    SpiDrvWaitForSlaveReady();
    SpiDrvSlaveSelect();

    // Send Command
    SpiDrvSendCmd(GET_DATABUF_TCP_CMD, PARAM_NUMS_1);
    SpiDrvSendBuffer(&sock, sizeof(sock), LAST_PARAM);

    //Wait the reply elaboration
    SpiDrvWaitForSlaveReady();

    // Wait for reply
    if (!SpiDrvWaitResponseData16(GET_DATABUF_TCP_CMD, _data, _dataLen))
    {
        //WARN("error waitResponse");
    }
    SpiDrvSlaveDeselect();
    if (*_dataLen!=0)
    {
        return (1);
    }
    return (0);
}


uint8_t ServerDrvSendData(uint8_t sock, const uint8_t *data, uint16_t len)
{
    uint8_t _data    = 0;
    uint8_t _dataLen = 0;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrvWaitForSlaveReady();
    SpiDrvSlaveSelect();

    // Send Command
    SpiDrvSendCmd(SEND_DATA_TCP_CMD, PARAM_NUMS_2);
    SpiDrvSendBuffer(&sock, sizeof(sock), NO_LAST_PARAM);
    SpiDrvSendBuffer((uint8_t *)data, len, LAST_PARAM);

    //Wait the reply elaboration
    SpiDrvWaitForSlaveReady();

    // Wait for reply
    if (!SpiDrvWaitResponseData8(SEND_DATA_TCP_CMD, &_data, &_dataLen))
    {
        //WARN("error waitResponse");
    }
    SpiDrvSlaveDeselect();
    if (_dataLen!=0)
    {
        return (_data == 1);
    }
    return (0);
}


uint8_t ServerDrvCheckDataSent(uint8_t sock)
{
    uint16_t timeout = 0;
    uint8_t _data    = 0;
    uint8_t _dataLen = 0;
    const uint16_t TIMEOUT_DATA_SENT = 25;

    do 
    {
        //WAIT_FOR_SLAVE_SELECT();
        SpiDrvWaitForSlaveReady();
        SpiDrvSlaveSelect();

        // Send Command
        SpiDrvSendCmd(DATA_SENT_TCP_CMD, PARAM_NUMS_1);
        SpiDrvSendParamL(&sock, sizeof(sock), LAST_PARAM);

        //Wait the reply elaboration
        SpiDrvWaitForSlaveReady();

        // Wait for reply
        if (!SpiDrvWaitResponseCmd(DATA_SENT_TCP_CMD, PARAM_NUMS_1, &_data, &_dataLen))
        {
            //WARN("error waitResponse isDataSent");
        }
        SpiDrvSlaveDeselect();

        if (_data) 
        {
            timeout = 0;
        }
        else
        {
            ++timeout;
            delay(100);
        }

    }while((_data==0)&&(timeout<TIMEOUT_DATA_SENT));

    if(timeout==TIMEOUT_DATA_SENT)
    {
        return (0);
    }
    else
    {
        return (1);
    }
}
