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

#if defined(gcc) || defined(__GNUC__) || defined(coide)
#include <stdio.h>
#include <stdarg.h>
#include <sys/types.h>
#include <sys/stat.h>
#undef errno
extern int errno;
extern int  _end;
#endif


#define UART_BASE  UART0_BASE
//#define UART_BASE  UART1_BASE


static void SendByte(uint8_t Ch)
{
    UARTCharPut(UART_BASE, Ch);
}

static uint8_t RecvByte(void)
{
     return UARTCharGet(UART_BASE);
}


#if defined(gcc) || defined(__GNUC__) || defined(coide)
caddr_t _sbrk ( int incr )
{
  static unsigned char *heap = NULL;
  unsigned char *prev_heap;

  if (heap == NULL) {
    heap = (unsigned char *)&_end;
  }
  prev_heap = heap;

  heap += incr;

  return (caddr_t) prev_heap;
}

int link(char *old, char *new) {
return -1;
}

int _close(int file)
{
  return -1;
}

int _fstat(int file, struct stat *st)
{
  st->st_mode = S_IFCHR;
  return 0;
}

int _isatty(int file)
{
  return 1;
}

int _lseek(int file, int ptr, int dir)
{
  return 0;
}

int _read(int file, char *ptr, int len)
{
  	int i = 0;
	(void) file;

	for(i = 0; i < len; i++)
	{
        *ptr++ = RecvByte();
	}

	return len;}

int _write(int file, char *ptr, int len)
{

	int i = 0;
	(void) file;

	for(i = 0; i < len; i++)
	{
        SendByte(*ptr++);
	}

	return len;
}

void abort(void)
{
  /* Abort called */
  while(1);
}
#endif

#if defined(ewarm) || defined(__ICCARM__)

int fgetc(FILE *f)
{
    return RecvByte();
}

int fputc(int ch, FILE *f) 
{
    SendByte(ch);
    return 1;
}

#endif


void DebugPortInit(void)
{

    //Close watchdog
    //(*((volatile unsigned long *)(0x40048100))) = 0x00;

    //
    // Configure System clock
    //
    //xSysCtlClockSet(48000000, xSYSCTL_OSC_MAIN | xSYSCTL_XTAL_8MHZ);
    //SysCtlDelay(1000000);

    // Note: Defore call UART0 Function, you must call SysCtlPeripheralClockSourceSet Function.
    // SYSCTL_PERIPH_UART0_S_MCGFLLCLK, SYSCTL_PERIPH_UART0_S_MCGPLLCLK_2,
    // SYSCTL_PERIPH_UART0_S_OSCERCLK, SYSCTL_PERIPH_UART0_S_MCGIRCLK, 
    // For UART1/2, just comment it
#if (UART_BASE == UART0_BASE)
    SysCtlPeripheralClockSourceSet(SYSCTL_PERIPH_UART0_S_MCGPLLCLK_2);

    //
    // Enable GPIO/UART Clock
    //
    SysCtlPeripheralEnable(SYSCTL_PERIPH_UART0);
    SysCtlPeripheralEnable(SYSCTL_PERIPH_GPIOA);
    //
    // Remap UART pin to GPIO Port UART0_RX --> PA1 UART0_TX --> PA2
    xSPinTypeUART(UART0RX, PA1);
    xSPinTypeUART(UART0TX, PA2);
#elif (UART_BASE == UART1_BASE)
    //
    // Enable GPIO/UART Clock
    //
    SysCtlPeripheralEnable(SYSCTL_PERIPH_UART1);
    SysCtlPeripheralEnable(SYSCTL_PERIPH_GPIOC);

    //
    // Remap UART pin to GPIO Port UART1_RX --> PC3 UART1_TX --> PC4
    xSPinTypeUART(UART1RX, PC3);
    xSPinTypeUART(UART1TX, PC4);
#endif
    //
    // Disable UART Receive/Transmit
    //
    UARTDisable(UART_BASE, UART_TX | UART_RX);

    //
    // Configure UART Baud 115200 8-N-1
    //
    UARTConfigSet(UART_BASE, 115200, UART_CONFIG_WLEN_8 | UART_CONFIG_PAR_NONE |
            UART_CONFIG_STOP_1);

    //
    // Enable UART Receive/Transmit
    //
    UARTEnable(UART_BASE, UART_TX | UART_RX);
    //SysCtlDelay(0xFFFFF);
    
}
