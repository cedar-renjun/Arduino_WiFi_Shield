/*---------------------------------------------------------------------------*-

     File:   debug.h

     Modified by: CooCox cedar
     Time       :

-*---------------------------------------------------------------------------*/

#include "server_drv.h"
#include "spi_drv.h"

static void delay(volatile uint32_t tick)
{
    while(tick--);
}


// Start server TCP on port specified
void ServerDrv_StartServer(uint16_t port, uint8_t sock)
{

    uint8_t _data    = 0;
    uint8_t _dataLen = 0;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrv_WaitForSlaveReady();
    SpiDrv_SlaveSelect();

    // Send Command
    SpiDrv_SendCmd(START_SERVER_TCP_CMD, PARAM_NUMS_2);
    SpiDrv_SendParam16(port, NO_LAST_PARAM);
    SpiDrv_SendParam(&sock, 1, LAST_PARAM);

    //Wait the reply elaboration
    SpiDrv_WaitForSlaveReady();

    // Wait for reply
    if (!SpiDrv_WaitResponseCmd(START_SERVER_TCP_CMD, PARAM_NUMS_1, &_data, &_dataLen))
    {
        //WARN("error waitResponse");
    }
    SpiDrv_SlaveDeselect();
}

// Start server TCP on port specified
void ServerDrv_StartClient(uint32_t ipAddress, uint16_t port, uint8_t sock)
{
    uint8_t _data    = 0;
    uint8_t _dataLen = 0;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrv_WaitForSlaveReady();
    SpiDrv_SlaveSelect();

    // Send Command
    SpiDrv_SendCmd(START_CLIENT_TCP_CMD, PARAM_NUMS_3);
    SpiDrv_SendParam((uint8_t*)&ipAddress, sizeof(ipAddress), NO_LAST_PARAM);
    SpiDrv_SendParam16(port, NO_LAST_PARAM);
    SpiDrv_SendParam(&sock, 1, LAST_PARAM);

    //Wait the reply elaboration
    SpiDrv_WaitForSlaveReady();

    // Wait for reply
    if (!SpiDrv_WaitResponseCmd(START_CLIENT_TCP_CMD, PARAM_NUMS_1, &_data, &_dataLen))
    {
        //WARN("error waitResponse");
    }
    SpiDrv_SlaveDeselect();
}

// Start server TCP on port specified
void ServerDrv_StopClient(uint8_t sock)
{
    uint8_t _data    = 0;
    uint8_t _dataLen = 0;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrv_WaitForSlaveReady();
    SpiDrv_SlaveSelect();

    // Send Command
    SpiDrv_SendCmd(STOP_CLIENT_TCP_CMD, PARAM_NUMS_1);
    SpiDrv_SendParam(&sock, 1, LAST_PARAM);

    //Wait the reply elaboration
    SpiDrv_WaitForSlaveReady();

    // Wait for reply
    if (!SpiDrv_WaitResponseCmd(STOP_CLIENT_TCP_CMD, PARAM_NUMS_1, &_data, &_dataLen))
    {
        //WARN("error waitResponse");
    }
    SpiDrv_SlaveDeselect();
}

uint8_t ServerDrv_GetServerState(uint8_t sock)
{
    uint8_t _data    = 0;
    uint8_t _dataLen = 0;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrv_WaitForSlaveReady();
    SpiDrv_SlaveSelect();

    // Send Command
    SpiDrv_SendCmd(GET_STATE_TCP_CMD, PARAM_NUMS_1);
    SpiDrv_SendParam(&sock, 1, LAST_PARAM);

    //Wait the reply elaboration
    SpiDrv_WaitForSlaveReady();

    // Wait for reply
    if (!SpiDrv_WaitResponseCmd(GET_STATE_TCP_CMD, PARAM_NUMS_1, &_data, &_dataLen))
    {
        //WARN("error waitResponse");
    }
    SpiDrv_SlaveDeselect();

    return (_data);
}



uint8_t ServerDrv_GetClientState(uint8_t sock)
{
    uint8_t _data    = 0;
    uint8_t _dataLen = 0;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrv_WaitForSlaveReady();
    SpiDrv_SlaveSelect();
    // Send Command
    SpiDrv_SendCmd(GET_CLIENT_STATE_TCP_CMD, PARAM_NUMS_1);
    SpiDrv_SendParam(&sock, 1, LAST_PARAM);

    //Wait the reply elaboration
    SpiDrv_WaitForSlaveReady();

    // Wait for reply
    if (!SpiDrv_WaitResponseCmd(GET_CLIENT_STATE_TCP_CMD, PARAM_NUMS_1, &_data, &_dataLen))
    {
        //WARN("error waitResponse");
    }
    SpiDrv_SlaveDeselect();

    return (_data);
}

int32_t ServerDrv_AvailData(uint8_t sock)
{
    uint8_t _data    = 0;
    uint8_t _dataLen = 0;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrv_WaitForSlaveReady();
    SpiDrv_SlaveSelect();

    // Send Command
    SpiDrv_SendCmd(AVAIL_DATA_TCP_CMD, PARAM_NUMS_1);
    SpiDrv_SendParam(&sock, sizeof(sock), LAST_PARAM);

    //Wait the reply elaboration
    SpiDrv_WaitForSlaveReady();

    // Wait for reply
    if (!SpiDrv_WaitResponseCmd(AVAIL_DATA_TCP_CMD, PARAM_NUMS_1, &_data, &_dataLen))
    {
        //WARN("error waitResponse");
    }
    SpiDrv_SlaveDeselect();

    if (_dataLen!=0)
    {
        return (_data == 1);
    }
    return (0);
}

int32_t ServerDrv_GetData(uint8_t sock, uint8_t *data, uint8_t peek)
{
    uint8_t _data    = 0;
    uint8_t _dataLen = 0;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrv_WaitForSlaveReady();
    SpiDrv_SlaveSelect();

    // Send Command
    SpiDrv_SendCmd(GET_DATA_TCP_CMD, PARAM_NUMS_2);
    SpiDrv_SendParam(&sock, 1, NO_LAST_PARAM);
    //NOTE check this @cedar
    SpiDrv_SendParam16(peek, LAST_PARAM);

    //Wait the reply elaboration
    SpiDrv_WaitForSlaveReady();

    // Wait for reply
    if (!SpiDrv_WaitResponseData8(GET_DATA_TCP_CMD, &_data, &_dataLen))
    {
        //WARN("error waitResponse");
    }
    SpiDrv_SlaveDeselect();
    if (_dataLen!=0)
    {
        *data = _data;
        return (1);
    }
    return (0);
}

int32_t ServerDrv_GetDataBuf(uint8_t sock, uint8_t *_data, uint16_t *_dataLen)
{
    //WAIT_FOR_SLAVE_SELECT();
    SpiDrv_WaitForSlaveReady();
    SpiDrv_SlaveSelect();

    // Send Command
    SpiDrv_SendCmd(GET_DATABUF_TCP_CMD, PARAM_NUMS_1);
    SpiDrv_SendBuffer(&sock, 1, LAST_PARAM);

    //Wait the reply elaboration
    SpiDrv_WaitForSlaveReady();

    // Wait for reply
    if (!SpiDrv_WaitResponseData16(GET_DATABUF_TCP_CMD, _data, _dataLen))
    {
        //WARN("error waitResponse");
    }

    SpiDrv_SlaveDeselect();
    if (*_dataLen!=0)
    {
        return (1);
    }
    return (0);
}

int32_t ServerDrv_SendData(uint8_t sock, uint8_t *data, uint16_t len)
{
    uint8_t _data    = 0;
    uint8_t _dataLen = 0;

    //WAIT_FOR_SLAVE_SELECT();
    SpiDrv_WaitForSlaveReady();
    SpiDrv_SlaveSelect();

    // Send Command
    SpiDrv_SendCmd(SEND_DATA_TCP_CMD, PARAM_NUMS_2);
    SpiDrv_SendBuffer(&sock, 1, NO_LAST_PARAM);
    SpiDrv_SendBuffer((uint8_t *)data, len, LAST_PARAM);

    //Wait the reply elaboration
    SpiDrv_WaitForSlaveReady();

    // Wait for reply
    if (!SpiDrv_WaitResponseData8(SEND_DATA_TCP_CMD, &_data, &_dataLen))
    {
        //WARN("error waitResponse");
    }
    SpiDrv_SlaveDeselect();
    if (_dataLen!=0)
    {
        return (_data == 1);
    }
    return (0);
}

int32_t ServerDrv_CheckDataSent(uint8_t sock)
{
    uint16_t timeout = 0;
    uint8_t _data    = 0;
    uint8_t _dataLen = 0;
    const uint16_t TIMEOUT_DATA_SENT = 25;

    do
    {
        //WAIT_FOR_SLAVE_SELECT();
        SpiDrv_WaitForSlaveReady();
        SpiDrv_SlaveSelect();

        // Send Command
        SpiDrv_SendCmd(DATA_SENT_TCP_CMD, PARAM_NUMS_1);
        SpiDrv_SendParam(&sock, sizeof(sock), LAST_PARAM);

        //Wait the reply elaboration
        SpiDrv_WaitForSlaveReady();

        // Wait for reply
        if (!SpiDrv_WaitResponseCmd(DATA_SENT_TCP_CMD, PARAM_NUMS_1, &_data, &_dataLen))
        {
            //WARN("error waitResponse isDataSent");
        }
        SpiDrv_SlaveDeselect();

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

/*--------------------------- FILE END --------------------------------------*/
