//*****************************************************************************
//
//! @page xspi_testcase xcore register test
//!
//! File: @ref spitest03.c
//!
//! <h2>Description</h2>
//! This module implements the test sequence for the xsysctl sub component.<br><br>
//! - \p Board: KL25Z128 <br><br>
//! - \p Last-Time(about): 0.5s <br><br>
//! - \p Phenomenon: Success or failure information will be printed on the UART. 
//! .
//!
//! <h2>Preconditions</h2>
//! The module requires the following options:<br><br>
//! - \p Option-define:
//! <br>(1)None.<br><br>
//! - \p Option-hardware:
//! <br>(1)Connect an USB cable to the development board.<br><br>
//! - \p Option-OtherModule:
//! <br>Connect an COM cable to the development board.<br>
//! .
//! In case some of the required options are not enabled then some or all tests
//! may be skipped or result FAILED.<br>
//!
//! <h2>Test Cases</h2>
//! The module contain those sub tests:<br><br>
//! - \subpage test_xspi_register
//! .
//! \file spitest03.c
//! \brief xspi test source file
//! \brief xspi test header file <br>
//
//*****************************************************************************

#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <stdarg.h>
#include "xhw_types.h"
#include "xhw_ints.h"
#include "xhw_nvic.h"
#include "xhw_memmap.h"
#include "xdebug.h"
#include "xcore.h"
#include "xsysctl.h"
#include "xhw_sysctl.h"
#include "xhw_gpio.h"
#include "xgpio.h"
#include "xhw_uart.h"
#include "xuart.h"
#include "xhw_spi.h"
#include "xspi.h"

void xspi004_MasterIntFunction(void)
{
    unsigned long ulTemp=0;
    
    SysCtlPeripheralEnable(SYSCTL_PERIPH_SPI0);
    SysCtlPeripheralEnable(SYSCTL_PERIPH_GPIOD);
    
    xSPinTypeSPI(SPI0CLK,  PD1);
    xSPinTypeSPI(SPI0CS,   PD0);
    xSPinTypeSPI(SPI0MISO, PD2);
    xSPinTypeSPI(SPI0MOSI, PD3);  
        
    ulTemp = xSPI_MOTO_FORMAT_MODE_0 | xSPI_MODE_MASTER | xSPI_MSB_FIRST;
        
    xSPIConfigSet(xSPI0_BASE, 20000, ulTemp);    
    xSPIEnable(xSPI0_BASE);
    while(1)
    {
        xSPISingleDataReadWrite(xSPI0_BASE, 0x55);
    }
    
}
