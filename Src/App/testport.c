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

#define _PORTC_PCR3             (0x4004B00C)
#define _PORTC_PCR4             (0x4004B010)

#define UART_DIV                16UL
#define UART_BAUD               115200UL


//*****************************************************************************
//
//! \brief Init uart to print.
//!
//! \param None
//!
//! \details uart config as (115200, 8 data bit, 1 stop bit , no partiy)
//!
//! \return None.
//
//*****************************************************************************
unsigned long tmp = 0;


void TestIOInit(void)
{
    unsigned long ulTmpReg   = 0;

    //
    // Configure System clock
    //
    xSysCtlClockSet(48000000, xSYSCTL_OSC_MAIN | xSYSCTL_XTAL_8MHZ);
   
    // Note: Defore call UART0 Function, you must call SysCtlPeripheralClockSourceSet Function.
    // SYSCTL_PERIPH_UART0_S_MCGFLLCLK, SYSCTL_PERIPH_UART0_S_MCGPLLCLK_2,
    // SYSCTL_PERIPH_UART0_S_OSCERCLK, SYSCTL_PERIPH_UART0_S_MCGIRCLK, 
    // For UART1/2, just comment it
    SysCtlPeripheralClockSourceSet(SYSCTL_PERIPH_UART0_S_MCGPLLCLK_2);
    
    //
    // Enable GPIO/UART Clock
    //    
    SysCtlPeripheralEnable(SYSCTL_PERIPH_UART0);
    SysCtlPeripheralEnable(SYSCTL_PERIPH_GPIOA);
    
    //
    // Remap UART pin to GPIO Port UART1_RX --> PC3 UART1_TX --> PC4
    xSPinTypeUART(UART0RX, PA1);
    xSPinTypeUART(UART0TX, PA2);
        
    UARTDisable(UART0_BASE, UART_TX | UART_RX);
    
    //*(volatile char *)0x4006A000 = 0x00;
    //*(volatile char *)0x4006A001 = 0x0D;
    //*(volatile char *)0x4006A002 = 0x00;
    
    UARTConfigSet(UART0_BASE, 9600, UART_CONFIG_WLEN_8 | UART_CONFIG_PAR_NONE |
            UART_CONFIG_STOP_1);
    UARTEnable(UART0_BASE, UART_TX | UART_RX);  
    
}

//*****************************************************************************
//
//! \brief print a char.
//!
//! \param None
//!
//! \return None.
//
//*****************************************************************************
void 
TestIOPut(char ch)
{
    volatile unsigned char ulStatus = 0;

    //
    // Wait until transmit register availavle
    //
    do
    {
        ulStatus = xHWREGB(UART1_BASE + UART_012_S1) &
                   ((unsigned char) UART_012_S1_TDRE_MASK);
    }while(0 == ulStatus);

    //
    // Send the char
    //
    xHWREGB(UART1_BASE + UART_012_D) = ch;

}

//*****************************************************************************
//
//! \brief Enable IRQ.
//!
//! \param None
//!
//! \return None.
//
//*****************************************************************************
void TestEnableIRQ(void)
{
    xCPUcpsie();
}

//*****************************************************************************
//
//! \brief Disable IRQ.
//!
//! \param None
//!
//! \return None.
//
//*****************************************************************************
void TestDisableIRQ(void)
{
    xCPUcpsid();
}

//*****************************************************************************
//
// The error routine that is called if the driver library encounters an error.(COX)
//
//*****************************************************************************
#ifdef xDEBUG
void
__xerror__(char *pcFilename, unsigned long ulLine)
{
    while(1);
}
#endif

