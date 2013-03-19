///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.40.1.53790/W32 for ARM    24/Feb/2013  09:52:16 /
// Copyright 1999-2012 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  C:\Users\renjun\Desktop\Cox\CoX_Peripheral\CoX_Peripher /
//                    al_KLx\libcox\xuart.c                                   /
//    Command line =  C:\Users\renjun\Desktop\Cox\CoX_Peripheral\CoX_Peripher /
//                    al_KLx\libcox\xuart.c -D ewarm -lCN                     /
//                    C:\Users\renjun\Desktop\Cox\CoX_Peripheral\CoX_Peripher /
//                    al_KLx\uart\test\suite1\ewarm\Debug\List\ -lB           /
//                    C:\Users\renjun\Desktop\Cox\CoX_Peripheral\CoX_Peripher /
//                    al_KLx\uart\test\suite1\ewarm\Debug\List\ -o            /
//                    C:\Users\renjun\Desktop\Cox\CoX_Peripheral\CoX_Peripher /
//                    al_KLx\uart\test\suite1\ewarm\Debug\Obj\ --no_cse       /
//                    --no_unroll --no_inline --no_code_motion --no_tbaa      /
//                    --no_clustering --no_scheduling --debug                 /
//                    --endian=little --cpu=Cortex-M0+ -e --fpu=None          /
//                    --dlib_config "C:\Program Files\IAR Systems\Embedded    /
//                    Workbench 6.4\arm\INC\c\DLib_Config_Normal.h" -I        /
//                    C:\Users\renjun\Desktop\Cox\CoX_Peripheral\CoX_Peripher /
//                    al_KLx\uart\test\suite1\ewarm\..\..\..\..\libcox\ -I    /
//                    C:\Users\renjun\Desktop\Cox\CoX_Peripheral\CoX_Peripher /
//                    al_KLx\uart\test\suite1\ewarm\..\..\..\..\testframe\    /
//                    -I C:\Users\renjun\Desktop\Cox\CoX_Peripheral\CoX_Perip /
//                    heral_KLx\uart\test\suite1\ewarm\..\..\..\..\uart\test\ /
//                    suite1\src\ -On                                         /
//    List file    =  C:\Users\renjun\Desktop\Cox\CoX_Peripheral\CoX_Peripher /
//                    al_KLx\uart\test\suite1\ewarm\Debug\List\xuart.s        /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME xuart

        #define SHT_PROGBITS 0x1

        EXTERN SysCtlBusClkGet
        EXTERN SysCtlPWMAndUART0ClkGet
        EXTERN __aeabi_uidiv

        PUBLIC UART0SEIntHandler
        PUBLIC UART1SEIntHandler
        PUBLIC UART2SEIntHandler
        PUBLIC UARTBothEdgeSampleDisable
        PUBLIC UARTBothEdgeSampleEnable
        PUBLIC UARTBusy
        PUBLIC UARTCharGet
        PUBLIC UARTCharGetNonBlocking
        PUBLIC UARTCharPut
        PUBLIC UARTCharPutNonBlocking
        PUBLIC UARTCharsAvail
        PUBLIC UARTConfigSet
        PUBLIC UARTDMADisable
        PUBLIC UARTDMAEnable
        PUBLIC UARTDisable
        PUBLIC UARTEnable
        PUBLIC UARTGetBit10
        PUBLIC UARTGetBit9
        PUBLIC UARTIdleFlagClear
        PUBLIC UARTIdleFlagGet
        PUBLIC UARTIdleLineTypeConfig
        PUBLIC UARTIdleSend
        PUBLIC UARTIntCallbackInit
        PUBLIC UARTIntDisable
        PUBLIC UARTIntEnable
        PUBLIC UARTLINConfig
        PUBLIC UARTLINDisable
        PUBLIC UARTLINEnable
        PUBLIC UARTLINSyncBreakPut
        PUBLIC UARTLsbFirst
        PUBLIC UARTMatchAddrModeDisable
        PUBLIC UARTMatchAddrModeEnable
        PUBLIC UARTMatchAddressSet
        PUBLIC UARTMsbFirst
        PUBLIC UARTOutModeConfig
        PUBLIC UARTReSyncDisable
        PUBLIC UARTReSyncEnable
        PUBLIC UARTReceiverStatus
        PUBLIC UARTRxErrorClear
        PUBLIC UARTRxErrorGet
        PUBLIC UARTRxInvertDisable
        PUBLIC UARTRxInvertEnable
        PUBLIC UARTSetBit10
        PUBLIC UARTSetBit9
        PUBLIC UARTSpaceAvail
        PUBLIC UARTTxInvertDisable
        PUBLIC UARTTxInvertEnable
        PUBLIC UARTWaitModeRun
        PUBLIC UARTWaitModeStop
        PUBLIC UARTWakeupMethodConfig

// C:\Users\renjun\Desktop\Cox\CoX_Peripheral\CoX_Peripheral_KLx\libcox\xuart.c
//    1 //*****************************************************************************
//    2 //
//    3 //! \file xuart.c
//    4 //! \brief Driver for the UART
//    5 //! \version V2.2.1.0
//    6 //! \date 08/17/2012
//    7 //! \author CooCox
//    8 //! \copy
//    9 //!
//   10 //! Copyright (c)  2012, CooCox
//   11 //! All rights reserved.
//   12 //!
//   13 //! Redistribution and use in source and binary forms, with or without
//   14 //! modification, are permitted provided that the following conditions
//   15 //! are met:
//   16 //!
//   17 //!     * Redistributions of source code must retain the above copyright
//   18 //! notice, this list of conditions and the following disclaimer.
//   19 //!     * Redistributions in binary form must reproduce the above copyright
//   20 //! notice, this list of conditions and the following disclaimer in the
//   21 //! documentation and/or other materials provided with the distribution.
//   22 //!     * Neither the name of the <ORGANIZATION> nor the names of its
//   23 //! contributors may be used to endorse or promote products derived
//   24 //! from this software without specific prior written permission.
//   25 //!
//   26 //! THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//   27 //! AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//   28 //! IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//   29 //! ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
//   30 //! LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//   31 //! CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//   32 //! SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//   33 //! INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//   34 //! CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//   35 //! ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
//   36 //! THE POSSIBILITY OF SUCH DAMAGE.
//   37 //
//   38 //*****************************************************************************
//   39 
//   40 #include "xhw_types.h"
//   41 #include "xhw_ints.h"
//   42 #include "xhw_memmap.h"
//   43 #include "xhw_nvic.h"
//   44 #include "xhw_sysctl.h"
//   45 #include "xhw_uart.h"
//   46 #include "xdebug.h"
//   47 #include "xsysctl.h"
//   48 #include "xuart.h"
//   49 
//   50 
//   51 //*****************************************************************************
//   52 //
//   53 // An array is UART callback function point
//   54 //
//   55 //*****************************************************************************

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   56 static xtEventCallback g_pfnUARTHandlerCallbacks[3]={0};
g_pfnUARTHandlerCallbacks:
        DS8 12
//   57 
//   58 //*****************************************************************************
//   59 //
//   60 //! \internal
//   61 //! \brief The function is the UART1 interrupt service.
//   62 //!
//   63 //! \param None.
//   64 //!
//   65 //! This function is a interrupt service routine of UART0.
//   66 //!
//   67 //! \return None.
//   68 //
//   69 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   70 void UART0SEIntHandler(void)
//   71 {
UART0SEIntHandler:
        PUSH     {R3-R5,LR}
//   72     unsigned long ulEvent = 0;
        MOVS     R4,#+0
//   73 
//   74     //
//   75     // Decide the interrupt event type
//   76     //
//   77     ulEvent =   xHWREGB(UART0_BASE + UART_0_S2) & 0xC0;
        LDR      R0,??DataTable4  ;; 0x4006a005
        LDRB     R0,[R0, #+0]
        UXTB     R0,R0
        MOVS     R1,#+192
        ANDS     R1,R1,R0
        MOVS     R4,R1
//   78     ulEvent <<= 8;
        LSLS     R4,R4,#+8
//   79     ulEvent |=  xHWREGB(UART0_BASE + UART_0_S1);
        MOVS     R1,R4
        LDR      R0,??DataTable4_1  ;; 0x4006a004
        LDRB     R4,[R0, #+0]
        UXTB     R4,R4
        ORRS     R4,R4,R1
//   80 
//   81     if(0 != g_pfnUARTHandlerCallbacks[0])
        LDR      R0,??DataTable4_2
        LDR      R0,[R0, #+0]
        CMP      R0,#+0
        BEQ      ??UART0SEIntHandler_0
//   82     {
//   83         (*g_pfnUARTHandlerCallbacks[0])(0, ulEvent, 0, 0);
        MOVS     R3,#+0
        MOVS     R2,#+0
        MOVS     R1,R4
        MOVS     R0,#+0
        LDR      R5,??DataTable4_2
        LDR      R5,[R5, #+0]
        BLX      R5
//   84     }
//   85 }
??UART0SEIntHandler_0:
        POP      {R0,R4,R5,PC}    ;; return
//   86 
//   87 //*****************************************************************************
//   88 //
//   89 //! \internal
//   90 //! \brief The function is the UART1 interrupt service.
//   91 //!
//   92 //! \param None.
//   93 //!
//   94 //! This function is a interrupt service routine of UART1.
//   95 //!
//   96 //! \return None.
//   97 //
//   98 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   99 void UART1SEIntHandler(void)
//  100 {
UART1SEIntHandler:
        PUSH     {R3-R5,LR}
//  101     unsigned long ulEvent = 0;
        MOVS     R4,#+0
//  102     
//  103     ulEvent =   xHWREGB(UART1_BASE + UART_12_S2) & 0xC0;
        LDR      R0,??DataTable4_3  ;; 0x4006b005
        LDRB     R0,[R0, #+0]
        UXTB     R0,R0
        MOVS     R1,#+192
        ANDS     R1,R1,R0
        MOVS     R4,R1
//  104     ulEvent <<= 8;
        LSLS     R4,R4,#+8
//  105     ulEvent |=  xHWREGB(UART1_BASE + UART_12_S1);
        MOVS     R1,R4
        LDR      R0,??DataTable4_4  ;; 0x4006b004
        LDRB     R4,[R0, #+0]
        UXTB     R4,R4
        ORRS     R4,R4,R1
//  106     if(0 != g_pfnUARTHandlerCallbacks[1])
        LDR      R0,??DataTable4_2
        LDR      R0,[R0, #+4]
        CMP      R0,#+0
        BEQ      ??UART1SEIntHandler_0
//  107     {
//  108         (*g_pfnUARTHandlerCallbacks[1])(0, ulEvent, 0, 0);
        MOVS     R3,#+0
        MOVS     R2,#+0
        MOVS     R1,R4
        MOVS     R0,#+0
        LDR      R5,??DataTable4_2
        LDR      R5,[R5, #+4]
        BLX      R5
//  109     }
//  110 }
??UART1SEIntHandler_0:
        POP      {R0,R4,R5,PC}    ;; return
//  111 
//  112 //*****************************************************************************
//  113 //
//  114 //! \internal
//  115 //! \brief The function is the UART1 interrupt service.
//  116 //!
//  117 //! \param None.
//  118 //!
//  119 //! This function is a interrupt service routine of UART2.
//  120 //!
//  121 //! \return None.
//  122 //
//  123 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  124 void UART2SEIntHandler(void)
//  125 {
UART2SEIntHandler:
        PUSH     {R3-R5,LR}
//  126     unsigned long ulEvent = 0;
        MOVS     R4,#+0
//  127 
//  128     ulEvent =   xHWREGB(UART2_BASE + UART_12_S2) & 0xC0;
        LDR      R0,??DataTable4_5  ;; 0x4006c005
        LDRB     R0,[R0, #+0]
        UXTB     R0,R0
        MOVS     R1,#+192
        ANDS     R1,R1,R0
        MOVS     R4,R1
//  129     ulEvent <<= 8;
        LSLS     R4,R4,#+8
//  130     ulEvent |=  xHWREGB(UART2_BASE + UART_12_S1);
        MOVS     R1,R4
        LDR      R0,??DataTable4_6  ;; 0x4006c004
        LDRB     R4,[R0, #+0]
        UXTB     R4,R4
        ORRS     R4,R4,R1
//  131 
//  132     if(0 != g_pfnUARTHandlerCallbacks[2])
        LDR      R0,??DataTable4_2
        LDR      R0,[R0, #+8]
        CMP      R0,#+0
        BEQ      ??UART2SEIntHandler_0
//  133     {
//  134         (*g_pfnUARTHandlerCallbacks[2])(0, ulEvent, 0, 0);
        MOVS     R3,#+0
        MOVS     R2,#+0
        MOVS     R1,R4
        MOVS     R0,#+0
        LDR      R5,??DataTable4_2
        LDR      R5,[R5, #+8]
        BLX      R5
//  135     }
//  136 }
??UART2SEIntHandler_0:
        POP      {R0,R4,R5,PC}    ;; return
//  137 
//  138 //*****************************************************************************
//  139 //
//  140 //! \internal
//  141 //! \brief Get the uart intput clock frequency
//  142 //!
//  143 //! \param ulBase is the base address of the UART port.
//  144 //!
//  145 //! The \e ulBase parameter can be one of the following:
//  146 //! - \b UART0_BASE    = UART 0 Module base address
//  147 //! - \b UART1_BASE    = UART 1 Module base address
//  148 //! - \b UART2_BASE    = UART 2 Module base address
//  149 //!
//  150 //! \note this function is used internally and only called by \b UARTConfigSet
//  151 //!
//  152 //! \return None.
//  153 //
//  154 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  155 static unsigned long GetUartClock(unsigned long ulBase)
//  156 {
GetUartClock:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
//  157     unsigned long ulUartClock = 0;
        MOVS     R5,#+0
//  158 
//  159     if(UART0_BASE == ulBase)
        LDR      R0,??DataTable4_7  ;; 0x4006a000
        CMP      R4,R0
        BNE      ??GetUartClock_0
//  160     {
//  161         ulUartClock = SysCtlPWMAndUART0ClkGet();
        BL       SysCtlPWMAndUART0ClkGet
        MOVS     R5,R0
        B        ??GetUartClock_1
//  162     }
//  163     else if((UART1_BASE == ulBase) || (UART2_BASE == ulBase))
??GetUartClock_0:
        LDR      R0,??DataTable4_8  ;; 0x4006b000
        CMP      R4,R0
        BEQ      ??GetUartClock_2
        LDR      R0,??DataTable4_9  ;; 0x4006c000
        CMP      R4,R0
        BNE      ??GetUartClock_1
//  164     {
//  165         ulUartClock = SysCtlBusClkGet();
??GetUartClock_2:
        BL       SysCtlBusClkGet
        MOVS     R5,R0
//  166     }
//  167 
//  168     return (ulUartClock);
??GetUartClock_1:
        MOVS     R0,R5
        POP      {R1,R4,R5,PC}    ;; return
//  169 }
//  170 
//  171 //*****************************************************************************
//  172 //
//  173 //! \brief Sets the configuration of a UART.
//  174 //!
//  175 //! \param ulBase is the base address of the UART port.
//  176 //! \param ulBaud is the desired baud rate.
//  177 //! \param ulConfig is the data format for the port (number of data bits,
//  178 //! number of stop bits, parity and oversample ratio).
//  179 //!
//  180 //! This function configures the UART for operation in the specified data
//  181 //! format.  The baud rate is provided in the \e ulBaud parameter and the data
//  182 //! format in the \e ulConfig parameter.
//  183 //!
//  184 //! The \e ulBase parameter can be one of the following:
//  185 //! - \b UART0_BASE    = UART 0 Module base address
//  186 //! - \b UART1_BASE    = UART 1 Module base address
//  187 //! - \b UART2_BASE    = UART 2 Module base address
//  188 //!
//  189 //! The \e ulBaud parameter can be one of the following:
//  190 //! The \e ulConfig parameter is the logical OR of four values: the number of
//  191 //! data bits, the number of stop bits, the parity and the oversample ratio.
//  192 //!
//  193 //! - \b UART_CONFIG_WLEN_8
//  194 //! - \b UART_CONFIG_WLEN_9
//  195 //! - \b UART_CONFIG_WLEN_10
//  196 //! - \b UART_CONFIG_PAR_ODD
//  197 //! - \b UART_CONFIG_PAR_EVEN
//  198 //! - \b UART_CONFIG_PAR_NONE
//  199 //! - \b UART_CONFIG_STOP_1
//  200 //! - \b UART_CONFIG_STOP_2
//  201 //! - \b UART_CONFIG_SAMPLE_RATE_DEFAULT
//  202 //! - \b UART_CONFIG_SAMPLE_RATE_xx (xx = 04,05,06 ... 32)
//  203 //!
//  204 //! \b UART_CONFIG_WLEN_8,\b UART_CONFIG_WLEN_9,\b UART_CONFIG_WLEN_10
//  205 //! select from eight to ten data bits per byte (respectively).
//  206 //! \b UART_CONFIG_STOP_ONE and \b UART_CONFIG_STOP_TWO select one two stop
//  207 //! bits (respectively).
//  208 //! \b UART_CONFIG_PAR_NONE, \b UART_CONFIG_PAR_EVEN,\b UART_CONFIG_PAR_ODD
//  209 //! select the parity mode (no parity bit, even parity bit, odd parity bit,
//  210 //! parity bit always one, and parity bit always zero, respectively).
//  211 //! \b UART_CONFIG_SAMPLE_RATE_xx,  \b UART_CONFIG_SAMPLE_RATE_DEFAULT select
//  212 //! uart oversample ratio, this parameter is only used for UART0 module.
//  213 //!
//  214 //!
//  215 //! \note Oversample ratio is only used in UART 0 Module.
//  216 //! \return None.
//  217 //
//  218 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  219 void UARTConfigSet(unsigned long ulBase,
//  220                    unsigned long ulBaud,
//  221                    unsigned long ulConfig)
//  222 {
UARTConfigSet:
        PUSH     {R1,R4-R7,LR}
        SUB      SP,SP,#+8
        MOVS     R4,R0
        MOVS     R7,R2
//  223     unsigned long ulUartClock  = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+4]
//  224     unsigned long ulDivisor    = 0;
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
//  225     unsigned char ulTmpReg     = 0;
        MOVS     R5,#+0
//  226     unsigned long ulSampleRate = 0;
        MOVS     R6,#+0
//  227 
//  228     //
//  229     // Check the parameters.
//  230     //
//  231     xASSERT((ulBase == UART0_BASE) ||
//  232             (ulBase == UART1_BASE) ||
//  233             (ulBase == UART2_BASE) );
//  234     xASSERT(0 == (ulConfig & ~(UART_CONFIG_WLEN_8   | UART_CONFIG_WLEN_9   |
//  235                                UART_CONFIG_WLEN_10  | UART_CONFIG_PAR_ODD  |
//  236                                UART_CONFIG_PAR_EVEN | UART_CONFIG_PAR_NONE |
//  237                                UART_CONFIG_STOP_1   | UART_CONFIG_STOP_2   |
//  238                                UART_CONFIG_SAMPLE_RATE_MASK )));
//  239 
//  240     //
//  241     // Configure UART OverSample Rate value.
//  242     //
//  243     switch(ulBase)
        MOVS     R0,R4
        LDR      R1,??DataTable4_7  ;; 0x4006a000
        CMP      R0,R1
        BEQ      ??UARTConfigSet_0
        LDR      R1,??DataTable4_8  ;; 0x4006b000
        CMP      R0,R1
        BEQ      ??UARTConfigSet_1
        LDR      R1,??DataTable4_9  ;; 0x4006c000
        CMP      R0,R1
        BEQ      ??UARTConfigSet_1
        B        ??UARTConfigSet_2
//  244     {
//  245         case UART0_BASE:
//  246         {
//  247             ulSampleRate = ((ulConfig & UART_CONFIG_SAMPLE_RATE_MASK)
//  248                            >> UART_CONFIG_SAMPLE_RATE_SHIFT);
??UARTConfigSet_0:
        MOVS     R0,R7
        LSRS     R0,R0,#+16
        UXTB     R0,R0
        MOVS     R6,R0
//  249             ulTmpReg =  xHWREGB(ulBase + UART_0_C4);
        LDRB     R0,[R4, #+10]
        MOVS     R5,R0
//  250             ulTmpReg &= (unsigned char)(~UART_0_C4_OSR_MASK);
        MOVS     R0,R5
        MOVS     R5,#+224
        ANDS     R5,R5,R0
//  251             ulTmpReg |= (unsigned char)(ulSampleRate & UART_0_C4_OSR_MASK);
        MOVS     R1,R5
        MOVS     R0,R6
        LSLS     R5,R0,#+27       ;; ZeroExtS R5,R0,#+27,#+27
        LSRS     R5,R5,#+27
        ORRS     R5,R5,R1
//  252             xHWREGB(ulBase + UART_0_C4)  =  ulTmpReg;
        STRB     R5,[R4, #+10]
//  253             break;
        B        ??UARTConfigSet_2
//  254         }
//  255         case UART1_BASE:
//  256         case UART2_BASE:
//  257         {
//  258             ulSampleRate = 16;  // UART 1/2 default over sample rate.
??UARTConfigSet_1:
        MOVS     R0,#+16
        MOVS     R6,R0
//  259             break;
//  260         }
//  261     }
//  262 
//  263     //
//  264     // Configure UART Baud Rate.
//  265     //
//  266     ulUartClock = GetUartClock(ulBase);
??UARTConfigSet_2:
        MOVS     R0,R4
        BL       GetUartClock
        STR      R0,[SP, #+4]
//  267     ulDivisor = ulUartClock / (ulBaud * ulSampleRate);
        LDR      R0,[SP, #+4]
        LDR      R1,[SP, #+8]
        MULS     R1,R6,R1
        BL       __aeabi_uidiv
        STR      R0,[SP, #+0]
//  268 
//  269     ulTmpReg = xHWREGB(ulBase + UART_012_BDH);
        LDRB     R0,[R4, #+0]
        MOVS     R5,R0
//  270     ulTmpReg &= (unsigned char)(~UART_012_BDH_SBR_MASK);
        MOVS     R0,R5
        MOVS     R5,#+224
        ANDS     R5,R5,R0
//  271     ulTmpReg |= (unsigned char)((ulDivisor >> 8) & UART_012_BDH_SBR_MASK);
        LDR      R0,[SP, #+0]
        LSRS     R0,R0,#+8
        LSLS     R0,R0,#+27       ;; ZeroExtS R0,R0,#+27,#+27
        LSRS     R0,R0,#+27
        ORRS     R0,R0,R5
        MOVS     R5,R0
//  272     xHWREGB(ulBase + UART_012_BDH) = ulTmpReg;
        STRB     R5,[R4, #+0]
//  273     xHWREGB(ulBase + UART_012_BDL) = (unsigned char)(ulDivisor);
        LDR      R0,[SP, #+0]
        STRB     R0,[R4, #+1]
//  274 
//  275     //
//  276     // Configure byes length
//  277     //
//  278     switch(ulConfig & UART_CONFIG_WEN_MASK)
        LSLS     R0,R7,#+28       ;; ZeroExtS R0,R7,#+28,#+28
        LSRS     R0,R0,#+28
        CMP      R0,#+1
        BEQ      ??UARTConfigSet_3
        CMP      R0,#+2
        BEQ      ??UARTConfigSet_4
        CMP      R0,#+4
        BEQ      ??UARTConfigSet_5
        B        ??UARTConfigSet_6
//  279     {
//  280         case  UART_CONFIG_WLEN_8:
//  281         {
//  282             if(UART0_BASE == ulBase)
??UARTConfigSet_3:
        LDR      R0,??DataTable4_7  ;; 0x4006a000
        CMP      R4,R0
        BNE      ??UARTConfigSet_7
//  283             {
//  284                 xHWREGB(ulBase + UART_0_C4) &= (unsigned char)(~UART_0_C4_M10_MASK);
        LDRB     R0,[R4, #+10]
        MOVS     R1,#+223
        ANDS     R1,R1,R0
        STRB     R1,[R4, #+10]
//  285                 xHWREGB(ulBase + UART_0_C4) |= (unsigned char)(UART_0_C4_M10_8_9_BIT);
        LDRB     R0,[R4, #+10]
        STRB     R0,[R4, #+10]
//  286             }
//  287             xHWREGB(ulBase + UART_012_C1) &= (unsigned char)(~UART_012_C1_M_MASK);
??UARTConfigSet_7:
        LDRB     R0,[R4, #+2]
        MOVS     R1,#+239
        ANDS     R1,R1,R0
        STRB     R1,[R4, #+2]
//  288             xHWREGB(ulBase + UART_012_C1) |= (unsigned char)(UART_012_C1_M_8_BIT);
        LDRB     R0,[R4, #+2]
        STRB     R0,[R4, #+2]
//  289             break;
        B        ??UARTConfigSet_6
//  290         }
//  291 
//  292         case  UART_CONFIG_WLEN_9:
//  293         {
//  294             if(UART0_BASE == ulBase)
??UARTConfigSet_4:
        LDR      R0,??DataTable4_7  ;; 0x4006a000
        CMP      R4,R0
        BNE      ??UARTConfigSet_8
//  295             {
//  296                 xHWREGB(ulBase + UART_0_C4) &= (unsigned char)(~UART_0_C4_M10_MASK);
        LDRB     R0,[R4, #+10]
        MOVS     R1,#+223
        ANDS     R1,R1,R0
        STRB     R1,[R4, #+10]
//  297                 xHWREGB(ulBase + UART_0_C4) |= (unsigned char)(UART_0_C4_M10_8_9_BIT);
        LDRB     R0,[R4, #+10]
        STRB     R0,[R4, #+10]
//  298             }
//  299             xHWREGB(ulBase + UART_012_C1) &= (unsigned char)(~UART_012_C1_M_MASK);
??UARTConfigSet_8:
        LDRB     R0,[R4, #+2]
        MOVS     R1,#+239
        ANDS     R1,R1,R0
        STRB     R1,[R4, #+2]
//  300             xHWREGB(ulBase + UART_012_C1) |= (unsigned char)(UART_012_C1_M_9_BIT);
        LDRB     R0,[R4, #+2]
        MOVS     R1,#+16
        ORRS     R1,R1,R0
        STRB     R1,[R4, #+2]
//  301             break;
        B        ??UARTConfigSet_6
//  302         }
//  303 
//  304         case  UART_CONFIG_WLEN_10:
//  305         {
//  306             xHWREGB(ulBase + UART_012_C1) &= (unsigned char)(~UART_012_C1_M_MASK);
??UARTConfigSet_5:
        LDRB     R0,[R4, #+2]
        MOVS     R1,#+239
        ANDS     R1,R1,R0
        STRB     R1,[R4, #+2]
//  307             xHWREGB(ulBase + UART_0_C4) &= (unsigned char)(~UART_0_C4_M10_MASK);
        LDRB     R0,[R4, #+10]
        MOVS     R1,#+223
        ANDS     R1,R1,R0
        STRB     R1,[R4, #+10]
//  308             xHWREGB(ulBase + UART_0_C4) |= (unsigned char)(UART_0_C4_M10_10_BIT);
        LDRB     R0,[R4, #+10]
        MOVS     R1,#+32
        ORRS     R1,R1,R0
        STRB     R1,[R4, #+10]
//  309             break;
//  310         }
//  311     }
//  312 
//  313     //
//  314     // Configure Parity
//  315     //
//  316     switch(ulConfig & UART_CONFIG_PAR_MASK)
??UARTConfigSet_6:
        MOVS     R0,#+240
        ANDS     R0,R0,R7
        CMP      R0,#+16
        BEQ      ??UARTConfigSet_9
        CMP      R0,#+32
        BEQ      ??UARTConfigSet_10
        CMP      R0,#+64
        BEQ      ??UARTConfigSet_11
        B        ??UARTConfigSet_12
//  317     {
//  318         case  UART_CONFIG_PAR_ODD:
//  319         {
//  320             xHWREGB(ulBase + UART_012_C1) &= (unsigned char)(~UART_012_C1_PE_MASK);
??UARTConfigSet_9:
        LDRB     R0,[R4, #+2]
        MOVS     R1,#+253
        ANDS     R1,R1,R0
        STRB     R1,[R4, #+2]
//  321             xHWREGB(ulBase + UART_012_C1) |= (unsigned char)(UART_012_C1_PE_ENABLE);
        LDRB     R0,[R4, #+2]
        MOVS     R1,#+2
        ORRS     R1,R1,R0
        STRB     R1,[R4, #+2]
//  322 
//  323             xHWREGB(ulBase + UART_012_C1) &= (unsigned char)(~UART_012_C1_PT_MASK);
        LDRB     R0,[R4, #+2]
        MOVS     R1,#+254
        ANDS     R1,R1,R0
        STRB     R1,[R4, #+2]
//  324             xHWREGB(ulBase + UART_012_C1) |= (unsigned char)(UART_012_C1_PT_ODD);                       
        LDRB     R0,[R4, #+2]
        MOVS     R1,#+1
        ORRS     R1,R1,R0
        STRB     R1,[R4, #+2]
//  325             
//  326             break ;
        B        ??UARTConfigSet_12
//  327         }
//  328 
//  329         case  UART_CONFIG_PAR_EVEN:
//  330         {
//  331             xHWREGB(ulBase + UART_012_C1) &= (unsigned char)(~UART_012_C1_PE_MASK);
??UARTConfigSet_10:
        LDRB     R0,[R4, #+2]
        MOVS     R1,#+253
        ANDS     R1,R1,R0
        STRB     R1,[R4, #+2]
//  332             xHWREGB(ulBase + UART_012_C1) |= (unsigned char)(UART_012_C1_PE_ENABLE);
        LDRB     R0,[R4, #+2]
        MOVS     R1,#+2
        ORRS     R1,R1,R0
        STRB     R1,[R4, #+2]
//  333 
//  334             xHWREGB(ulBase + UART_012_C1) &= (unsigned char)(~UART_012_C1_PT_MASK);
        LDRB     R0,[R4, #+2]
        MOVS     R1,#+254
        ANDS     R1,R1,R0
        STRB     R1,[R4, #+2]
//  335             xHWREGB(ulBase + UART_012_C1) |= (unsigned char)(UART_012_C1_PT_EVEN);
        LDRB     R0,[R4, #+2]
        STRB     R0,[R4, #+2]
//  336 
//  337             break ;
        B        ??UARTConfigSet_12
//  338         }
//  339 
//  340         case  UART_CONFIG_PAR_NONE:
//  341         {
//  342             xHWREGB(ulBase + UART_012_C1) &= (unsigned char)(~UART_012_C1_PE_MASK);
??UARTConfigSet_11:
        LDRB     R0,[R4, #+2]
        MOVS     R1,#+253
        ANDS     R1,R1,R0
        STRB     R1,[R4, #+2]
//  343             xHWREGB(ulBase + UART_012_C1) |= (unsigned char)(UART_012_C1_PE_DISABLE);
        LDRB     R0,[R4, #+2]
        STRB     R0,[R4, #+2]
//  344 
//  345             break ;
//  346         }
//  347     }
//  348 
//  349     //
//  350     // Configure Stop Bit
//  351     //
//  352     switch(ulConfig & UART_CONFIG_STOP_MASK)
??UARTConfigSet_12:
        MOVS     R0,#+240
        LSLS     R0,R0,#+4        ;; #+3840
        ANDS     R0,R0,R7
        MOVS     R1,#+128
        LSLS     R1,R1,#+1        ;; #+256
        CMP      R0,R1
        BEQ      ??UARTConfigSet_13
        MOVS     R1,#+128
        LSLS     R1,R1,#+2        ;; #+512
        CMP      R0,R1
        BEQ      ??UARTConfigSet_14
        B        ??UARTConfigSet_15
//  353     {
//  354         case  UART_CONFIG_STOP_1:
//  355         {
//  356             xHWREGB(ulBase + UART_012_BDH) &= (unsigned char)(~UART_012_BDH_SBNS_MASK);
??UARTConfigSet_13:
        LDRB     R0,[R4, #+0]
        MOVS     R1,#+223
        ANDS     R1,R1,R0
        STRB     R1,[R4, #+0]
//  357             xHWREGB(ulBase + UART_012_BDH) |= (unsigned char)(UART_012_BDH_SBNS_ONE);
        LDRB     R0,[R4, #+0]
        STRB     R0,[R4, #+0]
//  358 
//  359             break;
        B        ??UARTConfigSet_15
//  360         }
//  361 
//  362         case  UART_CONFIG_STOP_2:
//  363         {
//  364             xHWREGB(ulBase + UART_012_BDH) &= (unsigned char)(~UART_012_BDH_SBNS_MASK);
??UARTConfigSet_14:
        LDRB     R0,[R4, #+0]
        MOVS     R1,#+223
        ANDS     R1,R1,R0
        STRB     R1,[R4, #+0]
//  365             xHWREGB(ulBase + UART_012_BDH) |= (unsigned char)(UART_012_BDH_SBNS_TWO);
        LDRB     R0,[R4, #+0]
        MOVS     R1,#+32
        ORRS     R1,R1,R0
        STRB     R1,[R4, #+0]
//  366 
//  367             break;
//  368         }
//  369     }
//  370 }
??UARTConfigSet_15:
        POP      {R0-R2,R4-R7,PC}  ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4:
        DC32     0x4006a005

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_1:
        DC32     0x4006a004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_2:
        DC32     g_pfnUARTHandlerCallbacks

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_3:
        DC32     0x4006b005

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_4:
        DC32     0x4006b004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_5:
        DC32     0x4006c005

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_6:
        DC32     0x4006c004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_7:
        DC32     0x4006a000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_8:
        DC32     0x4006b000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_9:
        DC32     0x4006c000
//  371 
//  372 
//  373 //*****************************************************************************
//  374 //
//  375 //! \brief Enables transmitting or receiving.
//  376 //!
//  377 //! \param ulBase is the base address of the UART port.
//  378 //! \param ulBlock is the block to enable. it is the logical OR of
//  379 //! these values:  \b UART_TX, \b UART_RX.
//  380 //!
//  381 //! Sets the TXE or RXE bits.
//  382 //!
//  383 //! \return None.
//  384 //
//  385 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  386 void UARTEnable(unsigned long ulBase, unsigned long ulConfig)
//  387 {
//  388     xASSERT((ulBase == UART0_BASE) || (ulBase == UART1_BASE) ||
//  389             (ulBase == UART2_BASE) );
//  390     xASSERT(0 == (ulConfig & ~(UART_TX | UART_RX)));
//  391 
//  392     xHWREGB(ulBase + UART_012_C2) |= (unsigned char)(ulConfig);
UARTEnable:
        LDRB     R2,[R0, #+3]
        MOVS     R3,R1
        ORRS     R3,R3,R2
        STRB     R3,[R0, #+3]
//  393 }
        BX       LR               ;; return
//  394 
//  395 //*****************************************************************************
//  396 //
//  397 //! \brief Disables transmitting or receiving.
//  398 //!
//  399 //! \param ulBase is the base address of the UART port.
//  400 //! \param ulBlock is the block to disable. it is the logical OR of
//  401 //! these values:  \b UART_TX, \b UART_RX.
//  402 //!
//  403 //! Sets the TXE or RXE bits.
//  404 //!
//  405 //! \return None.
//  406 //
//  407 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  408 void UARTDisable(unsigned long ulBase, unsigned long ulConfig)
//  409 {
//  410     xASSERT((ulBase == UART0_BASE) || (ulBase == UART1_BASE) ||
//  411             (ulBase == UART2_BASE) );
//  412     xASSERT(0 == ((ulConfig) & ~(UART_TX | UART_RX)));
//  413 
//  414     xHWREGB(ulBase + UART_012_C2) &= (unsigned char)(~(ulConfig));
UARTDisable:
        LDRB     R2,[R0, #+3]
        MOVS     R3,R1
        BICS     R2,R2,R3
        STRB     R2,[R0, #+3]
//  415 }
        BX       LR               ;; return
//  416 
//  417 //*****************************************************************************
//  418 //
//  419 //! \brief Determines if there are any characters in receiver register.
//  420 //!
//  421 //! \param ulBase is the base address of the UART port.
//  422 //!
//  423 //! This function returns a flag indicating whether or not there is data
//  424 //! available in the receive register.
//  425 //!
//  426 //! \return Returns \b true if there is data in the receive register or \b false
//  427 //! if there is no data in the receive register.
//  428 //
//  429 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  430 xtBoolean UARTCharsAvail(unsigned long ulBase)
//  431 {
UARTCharsAvail:
        MOVS     R1,R0
//  432     xtBoolean ulStatus = xfalse;
        MOVS     R0,#+0
//  433 
//  434     xASSERT((ulBase == UART0_BASE) || (ulBase == UART1_BASE) ||
//  435             (ulBase == UART2_BASE) );
//  436 
//  437     ulStatus = (xtBoolean)(xHWREGB(ulBase + UART_012_S1) &
//  438                           ((unsigned char) UART_012_S1_RDRF_MASK));
        LDRB     R2,[R1, #+4]
        MOVS     R3,#+32
        ANDS     R2,R2,R3
        MOVS     R0,R2
//  439 
//  440     return (ulStatus);
        UXTB     R0,R0
        BX       LR               ;; return
//  441 }
//  442 
//  443 //*****************************************************************************
//  444 //
//  445 //! \brief Determines if there are any space in the transmit register.
//  446 //!
//  447 //! \param ulBase is the base address of the UART port.
//  448 //!
//  449 //! This function returns a flag indicating whether or not there is data
//  450 //! available in the receive register.
//  451 //!
//  452 //! \return Returns \b true if there is data in the receive register or \b false
//  453 //! if there is no data in the receive register.
//  454 //
//  455 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  456 xtBoolean UARTSpaceAvail(unsigned long ulBase)
//  457 {
UARTSpaceAvail:
        PUSH     {LR}
        MOVS     R1,R0
//  458     xtBoolean ulStatus = xfalse;
        MOVS     R0,#+0
//  459 
//  460     xASSERT((ulBase == UART0_BASE) || (ulBase == UART1_BASE) ||
//  461             (ulBase == UART2_BASE) );
//  462 
//  463     ulStatus = (xtBoolean)(xHWREGB(ulBase + UART_012_S1) &
//  464                           ((unsigned char) UART_012_S1_TDRE_MASK));
        LDRB     R2,[R1, #+4]
        MOVS     R3,#+128
        ANDS     R2,R2,R3
        MOVS     R0,R2
//  465     if(0 != ulStatus)
        UXTB     R0,R0
        CMP      R0,#+0
        BEQ      ??UARTSpaceAvail_0
//  466     {
//  467         ulStatus = 1;
        MOVS     R2,#+1
        MOVS     R0,R2
        B        ??UARTSpaceAvail_1
//  468     }
//  469     else
//  470     {
//  471         ulStatus = 0;
??UARTSpaceAvail_0:
        MOVS     R2,#+0
        MOVS     R0,R2
//  472     }
//  473     
//  474     return (ulStatus);
??UARTSpaceAvail_1:
        UXTB     R0,R0
        POP      {PC}             ;; return
//  475 }
//  476 
//  477 //*****************************************************************************
//  478 //
//  479 //! \brief Receives a character from the specified port.
//  480 //!
//  481 //! \param ulBase is the base address of the UART port.
//  482 //!
//  483 //! Gets a character from the receive register for the specified port.
//  484 //!
//  485 //! This function replaces the original UARTCharNonBlockingGet() API and
//  486 //! performs the same actions.  A macro is provided in <tt>uart.h</tt> to map
//  487 //! the original API to this API.
//  488 //!
//  489 //! \return Returns the character read from the specified port, cast as a
//  490 //! \e long.  A \b -1 is returned if there are no characters present in the
//  491 //! receive FIFO.  The UARTCharsAvail() function should be called before
//  492 //! attempting to call this function.
//  493 //
//  494 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  495 unsigned long UARTCharGetNonBlocking(unsigned long ulBase)
//  496 {
UARTCharGetNonBlocking:
        PUSH     {R4,LR}
        MOVS     R1,R0
//  497     xtBoolean     ulStatus = xfalse;
        MOVS     R2,#+0
//  498     unsigned long ulChar   = 0;
        MOVS     R0,#+0
//  499 
//  500     xASSERT((ulBase == UART0_BASE) || (ulBase == UART1_BASE) ||
//  501             (ulBase == UART2_BASE) );
//  502 
//  503     //
//  504     // Char available?
//  505     //
//  506     ulStatus = (xtBoolean) (xHWREGB(ulBase + UART_012_S1) &
//  507                            (unsigned char)(UART_012_S1_RDRF_MASK));
        LDRB     R3,[R1, #+4]
        MOVS     R4,#+32
        ANDS     R3,R3,R4
        MOVS     R2,R3
//  508 
//  509     if(xtrue == ulStatus)                        // Char available
        UXTB     R2,R2
        CMP      R2,#+1
        BNE      ??UARTCharGetNonBlocking_0
//  510     {
//  511         ulChar = (unsigned long) xHWREGB(ulBase + UART_012_D);
        LDRB     R3,[R1, #+7]
        UXTB     R3,R3
        MOVS     R0,R3
        B        ??UARTCharGetNonBlocking_1
//  512     }
//  513     else                                         // Char Not available
//  514     {
//  515         ulChar = (unsigned long) (-1);
??UARTCharGetNonBlocking_0:
        MOVS     R3,#+0
        MVNS     R3,R3            ;; #-1
        MOVS     R0,R3
//  516     }
//  517 
//  518     return (ulChar);
??UARTCharGetNonBlocking_1:
        POP      {R4,PC}          ;; return
//  519 }
//  520 
//  521 //*****************************************************************************
//  522 //
//  523 //! \brief Waits for a character from the specified port.
//  524 //!
//  525 //! \param ulBase is the base address of the UART port.
//  526 //!
//  527 //! Gets a character from the receive register for the specified port.  If there
//  528 //! are no characters available, this function waits until a character is
//  529 //! received before returning.
//  530 //!
//  531 //! \return Returns the character read from the specified port, cast as a
//  532 //! \e long.
//  533 //
//  534 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  535 unsigned char UARTCharGet(unsigned long ulBase)
//  536 {
UARTCharGet:
        PUSH     {R7,LR}
        MOVS     R1,R0
//  537     unsigned long          ulChar   = 0;
        MOVS     R0,#+0
//  538     volatile unsigned char ulStatus = 0;
        MOV      R2,SP
        MOVS     R3,#+0
        STRB     R3,[R2, #+0]
//  539 
//  540     xASSERT((ulBase == UART0_BASE) || (ulBase == UART1_BASE) ||
//  541             (ulBase == UART2_BASE) );
//  542 
//  543     //
//  544     // Wait until Receive a char
//  545     //
//  546     do
//  547     {
//  548         ulStatus = xHWREGB(ulBase + UART_012_S1) &
//  549                    ((unsigned char ) UART_012_S1_RDRF_MASK);
??UARTCharGet_0:
        LDRB     R2,[R1, #+4]
        MOVS     R3,#+32
        ANDS     R2,R2,R3
        MOV      R3,SP
        STRB     R2,[R3, #+0]
//  550     }while(0 == ulStatus);
        MOV      R2,SP
        LDRB     R2,[R2, #+0]
        CMP      R2,#+0
        BEQ      ??UARTCharGet_0
//  551 
//  552     //
//  553     // Get the char
//  554     //
//  555     ulChar = xHWREGB(ulBase + UART_012_D);
        LDRB     R2,[R1, #+7]
        UXTB     R2,R2
        MOVS     R0,R2
//  556 
//  557     return (ulChar);
        UXTB     R0,R0
        POP      {R1,PC}          ;; return
//  558 }
//  559 
//  560 //*****************************************************************************
//  561 //
//  562 //! \brief Sends a character to the specified port.
//  563 //!
//  564 //! \param ulBase is the base address of the UART port.
//  565 //! \param ucData is the character to be transmitted.
//  566 //!
//  567 //! Writes the character \e ucData to the transmit register for the specified port.
//  568 //! This function does not block, so if there is no space available, then a
//  569 //! \b false is returned, and the application must retry the function later.
//  570 //!
//  571 //! This function replaces the original UARTCharNonBlockingPut() API and
//  572 //! performs the same actions.  A macro is provided in <tt>uart.h</tt> to map
//  573 //! the original API to this API.
//  574 //!
//  575 //! \return Returns \b true if the character was successfully placed in the
//  576 //! transmit register or \b false if there was no space available in the transmit
//  577 //! register.
//  578 //
//  579 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  580 xtBoolean UARTCharPutNonBlocking(unsigned long ulBase, unsigned char ulData)
//  581 {
UARTCharPutNonBlocking:
        PUSH     {R4,R5,LR}
        MOVS     R2,R0
//  582     xtBoolean     ulStatus = 0;
        MOVS     R3,#+0
//  583     xtBoolean     ulResult = 0;
        MOVS     R0,#+0
//  584 
//  585     xASSERT((ulBase == UART0_BASE) || (ulBase == UART1_BASE) ||
//  586             (ulBase == UART2_BASE) );
//  587 
//  588     //
//  589     // Transmit register is available ?
//  590     //
//  591     ulStatus = (xtBoolean) xHWREGB(ulBase + UART_012_S1) & UART_012_S1_TDRE_MASK;
        LDRB     R4,[R2, #+4]
        MOVS     R5,#+128
        ANDS     R4,R4,R5
        MOVS     R3,R4
//  592 
//  593     if(xtrue == ulStatus)                      // Transmit Register available
        UXTB     R3,R3
        CMP      R3,#+1
        BNE      ??UARTCharPutNonBlocking_0
//  594     {
//  595         xHWREGB(ulBase + UART_012_D) = ulData;
        STRB     R1,[R2, #+7]
//  596         ulResult = xtrue;
        MOVS     R4,#+1
        MOVS     R0,R4
        B        ??UARTCharPutNonBlocking_1
//  597     }
//  598     else                                       // Transmit Register NOT available
//  599     {
//  600         ulResult = xfalse;
??UARTCharPutNonBlocking_0:
        MOVS     R4,#+0
        MOVS     R0,R4
//  601     }
//  602 
//  603     return (ulResult);
??UARTCharPutNonBlocking_1:
        UXTB     R0,R0
        POP      {R4,R5,PC}       ;; return
//  604 }
//  605 
//  606 //*****************************************************************************
//  607 //
//  608 //! \brief Waits to send a character from the specified port.
//  609 //!
//  610 //! \param ulBase is the base address of the UART port.
//  611 //! \param ucData is the character to be transmitted.
//  612 //!
//  613 //! Sends the character \e ucData to the transmit register for the specified port.
//  614 //! If there is no space available in the transmit register, this function waits
//  615 //! until there is space available before returning.
//  616 //!
//  617 //! \return None.
//  618 //
//  619 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  620 void UARTCharPut(unsigned long ulBase, unsigned char ulData)
//  621 {
UARTCharPut:
        PUSH     {R7,LR}
//  622     volatile unsigned char ulStatus = 0;
        MOV      R2,SP
        MOVS     R3,#+0
        STRB     R3,[R2, #+0]
//  623 
//  624     xASSERT((ulBase == UART0_BASE) || (ulBase == UART1_BASE) ||
//  625             (ulBase == UART2_BASE) );
//  626 
//  627     //
//  628     // Wait until transmit register availavle
//  629     //
//  630     do
//  631     {
//  632         ulStatus = xHWREGB(ulBase + UART_012_S1) &
//  633                    ((unsigned char) UART_012_S1_TDRE_MASK);
??UARTCharPut_0:
        LDRB     R2,[R0, #+4]
        MOVS     R3,#+128
        ANDS     R2,R2,R3
        MOV      R3,SP
        STRB     R2,[R3, #+0]
//  634     }while(0 == ulStatus);
        MOV      R2,SP
        LDRB     R2,[R2, #+0]
        CMP      R2,#+0
        BEQ      ??UARTCharPut_0
//  635 
//  636     //
//  637     // Send the char
//  638     //
//  639     xHWREGB(ulBase + UART_012_D) = ulData;
        STRB     R1,[R0, #+7]
//  640 
//  641 }
        POP      {R0,PC}          ;; return
//  642 
//  643 //*****************************************************************************
//  644 //
//  645 //! \brief Determines whether the UART transmitter is busy or not.
//  646 //!
//  647 //! \param ulBase is the base address of the UART port.
//  648 //!
//  649 //! Allows the caller to determine whether all transmitted bytes have cleared
//  650 //! the transmitter hardware.  If \b false is returned, the transmit register is
//  651 //! empty and all bits of the last transmitted character, including all stop
//  652 //! bits, have left the hardware shift register.
//  653 //!
//  654 //! \return Returns \b true if the UART is transmitting or \b false if all
//  655 //! transmissions are complete.
//  656 //
//  657 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  658 xtBoolean UARTBusy(unsigned long ulBase)
//  659 {
UARTBusy:
        PUSH     {LR}
        MOVS     R1,R0
//  660     xtBoolean ulStatus = xfalse;
        MOVS     R0,#+0
//  661 
//  662     xASSERT((ulBase == UART0_BASE) || (ulBase == UART1_BASE) ||
//  663             (ulBase == UART2_BASE) );
//  664 
//  665     ulStatus = (xtBoolean) xHWREGB(ulBase + UART_012_S1) &
//  666                            ((unsigned char)UART_012_S1_TDRE_MASK);
        LDRB     R2,[R1, #+4]
        MOVS     R3,#+128
        ANDS     R2,R2,R3
        MOVS     R0,R2
//  667 
//  668     //
//  669     // Transmit full mean busy and vice versa
//  670     //
//  671     ulStatus = !ulStatus;
        UXTB     R0,R0
        CMP      R0,#+0
        BNE      ??UARTBusy_0
        MOVS     R0,#+1
        B        ??UARTBusy_1
??UARTBusy_0:
        MOVS     R0,#+0
//  672 
//  673     return (ulStatus);
??UARTBusy_1:
        UXTB     R0,R0
        POP      {PC}             ;; return
//  674 }
//  675 
//  676 //*****************************************************************************
//  677 //
//  678 //! \brief Enables individual UART interrupt sources.
//  679 //!
//  680 //! \param ulBase is the base address of the UART port.
//  681 //! \param ulIntFlags is the bit mask of the interrupt sources to be enabled.
//  682 //!
//  683 //! Enables the indicated UART interrupt sources.  Only the sources that are
//  684 //! enabled can be reflected to the processor interrupt; disabled sources have
//  685 //! no effect on the processor.
//  686 //!
//  687 //! The \e ulBase parameter can be one of the following:
//  688 //! - \b UART0_BASE    = UART 0 Module base address
//  689 //! - \b UART1_BASE    = UART 1 Module base address
//  690 //! - \b UART2_BASE    = UART 2 Module base address
//  691 //!
//  692 //! The \e ulIntFlags parameter is the logical OR of any of the following:
//  693 //! - \b UART_INT_LBKD   - LIN RX Break Field Detected Interrupt
//  694 //! - \b UART_INT_RXEDG  - RX pin active edge interrupt
//  695 //! - \b UART_INT_T      - Transmission data register empty interrupt
//  696 //! - \b UART_INT_TC     - Transmission complete interrupt
//  697 //! - \b UART_INT_R      - Receive data register full interrupt
//  698 //! - \b UART_INT_IL     - Idle line interrupt
//  699 //! - \b UART_INT_OR     - Overrun error interrupt
//  700 //! - \b UART_INT_NE     - Noise error interrupt
//  701 //! - \b UART_INT_FE     - Frame error interrupt
//  702 //! - \b UART_INT_PE     - Parity error interrupt
//  703 //!
//  704 //! \return None.
//  705 //
//  706 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  707 void UARTIntEnable(unsigned long ulBase, unsigned long ulIntFlags)
//  708 {
UARTIntEnable:
        PUSH     {R4,LR}
//  709     unsigned long ulTmp = 0;
        MOVS     R2,#+0
//  710 
//  711     xASSERT((ulBase == UART0_BASE) || (ulBase == UART1_BASE) ||
//  712             (ulBase == UART2_BASE) );
//  713     xASSERT(0 == ((ulIntFlags) &~ (UART_INT_LBKD | UART_INT_RXEDG |
//  714                                    UART_INT_T    | UART_INT_TC    |
//  715                                    UART_INT_R    | UART_INT_IL    |
//  716                                    UART_INT_OR   | UART_INT_NE    |
//  717                                    UART_INT_FE   | UART_INT_PE    )));
//  718 
//  719     if(0 != (ulIntFlags & UART_INT_BDH_FLAG))
        LSLS     R3,R1,#+7
        BPL      ??UARTIntEnable_0
//  720     {
//  721         ulTmp = (ulIntFlags & UART_INT_BDH_MASK) >> UART_INT_BDH_SHIFT;
        UXTB     R3,R1
        MOVS     R2,R3
//  722         xHWREGB(ulBase + UART_012_BDH) |= ((unsigned char)ulTmp);
        LDRB     R3,[R0, #+0]
        MOVS     R4,R2
        ORRS     R4,R4,R3
        STRB     R4,[R0, #+0]
//  723     }
//  724 
//  725     if(0 != (ulIntFlags & UART_INT_C2_FLAG))
??UARTIntEnable_0:
        LSLS     R3,R1,#+6
        BPL      ??UARTIntEnable_1
//  726     {
//  727         ulTmp = (ulIntFlags & UART_INT_C2_MASK) >> UART_INT_C2_SHIFT;
        MOVS     R3,R1
        LSRS     R3,R3,#+8
        UXTB     R3,R3
        MOVS     R2,R3
//  728         xHWREGB(ulBase + UART_012_C2) |= ((unsigned char)ulTmp);
        LDRB     R3,[R0, #+3]
        MOVS     R4,R2
        ORRS     R4,R4,R3
        STRB     R4,[R0, #+3]
//  729     }
//  730 
//  731     if(0 != (ulIntFlags & UART_INT_C3_FLAG))
??UARTIntEnable_1:
        LSLS     R3,R1,#+5
        BPL      ??UARTIntEnable_2
//  732     {
//  733         ulTmp = (ulIntFlags & UART_INT_C3_MASK) >> UART_INT_C3_SHIFT;
        MOVS     R3,R1
        LSRS     R3,R3,#+16
        UXTB     R3,R3
        MOVS     R2,R3
//  734         xHWREGB(ulBase + UART_012_C3) |= ((unsigned char)ulTmp);
        LDRB     R3,[R0, #+6]
        MOVS     R4,R2
        ORRS     R4,R4,R3
        STRB     R4,[R0, #+6]
//  735     }
//  736 }
??UARTIntEnable_2:
        POP      {R4,PC}          ;; return
//  737 
//  738 
//  739 //*****************************************************************************
//  740 //
//  741 //! \brief Disables individual UART interrupt sources.
//  742 //!
//  743 //! \param ulBase is the base address of the UART port.
//  744 //! \param ulIntFlags is the bit mask of the interrupt sources to be enabled.
//  745 //!
//  746 //! Disables the indicated UART interrupt sources.  Only the sources that are
//  747 //! enabled can be reflected to the processor interrupt; disabled sources have
//  748 //! no effect on the processor.
//  749 //!
//  750 //! The \e ulBase parameter can be one of the following:
//  751 //! - \b UART0_BASE    = UART 0 Module base address
//  752 //! - \b UART1_BASE    = UART 1 Module base address
//  753 //! - \b UART2_BASE    = UART 2 Module base address
//  754 //!
//  755 //! The \e ulIntFlags parameter is the logical OR of any of the following:
//  756 //! - \b UART_INT_LBKD   - LIN RX Break Field Detected Interrupt
//  757 //! - \b UART_INT_RXEDG  - RX pin active edge interrupt
//  758 //! - \b UART_INT_T      - Transmission data register empty interrupt
//  759 //! - \b UART_INT_TC     - Transmission complete interrupt
//  760 //! - \b UART_INT_R      - Receive data register full interrupt
//  761 //! - \b UART_INT_IL     - Idle line interrupt
//  762 //! - \b UART_INT_OR     - Overrun error interrupt
//  763 //! - \b UART_INT_NE     - Noise error interrupt
//  764 //! - \b UART_INT_FE     - Frame error interrupt
//  765 //! - \b UART_INT_PE     - Parity error interrupt
//  766 //!
//  767 //! \return None.
//  768 //
//  769 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  770 void UARTIntDisable(unsigned long ulBase, unsigned long ulIntFlags)
//  771 {
UARTIntDisable:
        PUSH     {R4,LR}
//  772     unsigned long ulTmp = 0;
        MOVS     R2,#+0
//  773 
//  774     xASSERT((ulBase == UART0_BASE) || (ulBase == UART1_BASE) ||
//  775             (ulBase == UART2_BASE) );
//  776     xASSERT(0 == ((ulIntFlags) &~ (UART_INT_LBKD | UART_INT_RXEDG |
//  777                                    UART_INT_T    | UART_INT_TC    |
//  778                                    UART_INT_R    | UART_INT_IL    |
//  779                                    UART_INT_OR   | UART_INT_NE    |
//  780                                    UART_INT_FE   | UART_INT_PE    )));
//  781 
//  782     if(0 != (ulIntFlags & UART_INT_BDH_FLAG))
        LSLS     R3,R1,#+7
        BPL      ??UARTIntDisable_0
//  783     {
//  784         ulTmp = (ulIntFlags & UART_INT_BDH_MASK) >> UART_INT_BDH_SHIFT;
        UXTB     R3,R1
        MOVS     R2,R3
//  785         xHWREGB(ulBase + UART_012_BDH) &= ((unsigned char)~ulTmp);
        LDRB     R3,[R0, #+0]
        MOVS     R4,R2
        BICS     R3,R3,R4
        STRB     R3,[R0, #+0]
//  786     }
//  787 
//  788     if(0 != (ulIntFlags & UART_INT_C2_FLAG))
??UARTIntDisable_0:
        LSLS     R3,R1,#+6
        BPL      ??UARTIntDisable_1
//  789     {
//  790         ulTmp = (ulIntFlags & UART_INT_C2_MASK) >> UART_INT_C2_SHIFT;
        MOVS     R3,R1
        LSRS     R3,R3,#+8
        UXTB     R3,R3
        MOVS     R2,R3
//  791         xHWREGB(ulBase + UART_012_C2) &= ((unsigned char)~ulTmp);
        LDRB     R3,[R0, #+3]
        MOVS     R4,R2
        BICS     R3,R3,R4
        STRB     R3,[R0, #+3]
//  792     }
//  793 
//  794     if(0 != (ulIntFlags & UART_INT_C3_FLAG))
??UARTIntDisable_1:
        LSLS     R3,R1,#+5
        BPL      ??UARTIntDisable_2
//  795     {
//  796         ulTmp = (ulIntFlags & UART_INT_C3_MASK) >> UART_INT_C3_SHIFT;
        MOVS     R3,R1
        LSRS     R3,R3,#+16
        UXTB     R3,R3
        MOVS     R2,R3
//  797         xHWREGB(ulBase + UART_012_C3) &= ((unsigned char)~ulTmp);
        LDRB     R3,[R0, #+6]
        MOVS     R4,R2
        BICS     R3,R3,R4
        STRB     R3,[R0, #+6]
//  798     }
//  799 }
??UARTIntDisable_2:
        POP      {R4,PC}          ;; return
//  800 
//  801 
//  802 //*****************************************************************************
//  803 //
//  804 //! \brief Init interrupts callback for the specified UART Port.
//  805 //!
//  806 //! \param ulPort is the base address of the UART port.
//  807 //! \param xtUARTCallback is callback for the specified UART Port.
//  808 //!
//  809 //! Init interrupts callback for the specified UART Port.
//  810 //!
//  811 //! The \e ulBase parameter can be one of the following:
//  812 //! - \b UART0_BASE    = UART 0 Module base address
//  813 //! - \b UART1_BASE    = UART 1 Module base address
//  814 //! - \b UART2_BASE    = UART 2 Module base address
//  815 //!
//  816 //! \return None.
//  817 //
//  818 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  819 void UARTIntCallbackInit(unsigned long ulBase,
//  820                     xtEventCallback pfnCallback)
//  821 {
UARTIntCallbackInit:
        PUSH     {LR}
//  822     //
//  823     // Check the parameters.
//  824     //
//  825     xASSERT((ulBase == UART0_BASE) || (ulBase == UART1_BASE) ||
//  826             (ulBase == UART2_BASE) );
//  827 
//  828     //
//  829     // Register user's handler function.
//  830     //
//  831     switch(ulBase)
        MOVS     R2,R0
        LDR      R3,??DataTable13  ;; 0x4006a000
        CMP      R2,R3
        BEQ      ??UARTIntCallbackInit_0
        LDR      R3,??DataTable13_1  ;; 0x4006b000
        CMP      R2,R3
        BEQ      ??UARTIntCallbackInit_1
        LDR      R3,??DataTable5  ;; 0x4006c000
        CMP      R2,R3
        BEQ      ??UARTIntCallbackInit_2
        B        ??UARTIntCallbackInit_3
//  832     {
//  833         case UART0_BASE:
//  834         {
//  835             g_pfnUARTHandlerCallbacks[0] = pfnCallback;
??UARTIntCallbackInit_0:
        LDR      R2,??DataTable18
        STR      R1,[R2, #+0]
//  836             break;
        B        ??UARTIntCallbackInit_4
//  837         }
//  838         case UART1_BASE:
//  839         {
//  840             g_pfnUARTHandlerCallbacks[1] = pfnCallback;
??UARTIntCallbackInit_1:
        LDR      R2,??DataTable18
        STR      R1,[R2, #+4]
//  841             break;
        B        ??UARTIntCallbackInit_4
//  842         }
//  843         case UART2_BASE:
//  844         {
//  845             g_pfnUARTHandlerCallbacks[2] = pfnCallback;
??UARTIntCallbackInit_2:
        LDR      R2,??DataTable18
        STR      R1,[R2, #+8]
//  846             break;
        B        ??UARTIntCallbackInit_4
//  847         }
//  848         default:
//  849         {
//  850             break;
//  851         }
//  852     }
//  853 }
??UARTIntCallbackInit_3:
??UARTIntCallbackInit_4:
        POP      {PC}             ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5:
        DC32     0x4006c000
//  854 
//  855 
//  856 //*****************************************************************************
//  857 //
//  858 //! \brief Gets current receiver errors.
//  859 //!
//  860 //! \param ulBase is the base address of the UART port.
//  861 //!
//  862 //! This function returns the current state of each of the 4 receiver error
//  863 //! sources.  The returned errors are equivalent to the four error bits
//  864 //! returned via the previous call to UARTCharGet() or UARTCharGetNonBlocking()
//  865 //! with the exception that the overrun error is set immediately the overrun
//  866 //! occurs rather than when a character is next read.
//  867 //!
//  868 //! \return Returns a logical OR combination of the receiver error flags,
//  869 //! \b xUART_RXERROR_FRAMING, \b xUART_RXERROR_PARITY, \b xUART_RXERROR_BREAK
//  870 //! and \b xUART_RXERROR_OVERRUN.
//  871 //
//  872 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  873 unsigned long UARTRxErrorGet(unsigned long ulBase)
//  874 {
UARTRxErrorGet:
        MOVS     R1,R0
//  875     unsigned long ulErrorFlag = 0;
        MOVS     R0,#+0
//  876 
//  877     xASSERT((ulBase == UART0_BASE) || (ulBase == UART1_BASE) ||
//  878             (ulBase == UART2_BASE) );
//  879 
//  880     ulErrorFlag = ((unsigned long)xHWREGB(ulBase + UART_012_S1)) &
//  881                                                                UART_ERROR_MASK;
        LDRB     R2,[R1, #+4]
        UXTB     R2,R2
        LSLS     R2,R2,#+28       ;; ZeroExtS R2,R2,#+28,#+28
        LSRS     R2,R2,#+28
        MOVS     R0,R2
//  882 
//  883     return ulErrorFlag;
        BX       LR               ;; return
//  884 }
//  885 
//  886 
//  887 //*****************************************************************************
//  888 //
//  889 //! \brief Clears all reported receiver errors.
//  890 //!
//  891 //! \param ulBase is the base address of the UART port.
//  892 //!
//  893 //! This function is used to clear all receiver error conditions reported via
//  894 //! UARTRxErrorGet().  If using the overrun, framing error, parity error or
//  895 //! break interrupts, this function must be called after clearing the interrupt
//  896 //! to ensure that later errors of the same type trigger another interrupt.
//  897 //!
//  898 //! \return None.
//  899 //
//  900 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  901 void UARTRxErrorClear(unsigned long ulBase)
//  902 {
UARTRxErrorClear:
        PUSH     {LR}
//  903     xASSERT((ulBase == UART0_BASE) || (ulBase == UART1_BASE) ||
//  904             (ulBase == UART2_BASE) );
//  905     switch(ulBase)
        MOVS     R1,R0
        LDR      R2,??DataTable13  ;; 0x4006a000
        CMP      R1,R2
        BEQ      ??UARTRxErrorClear_0
        LDR      R2,??DataTable13_1  ;; 0x4006b000
        CMP      R1,R2
        BEQ      ??UARTRxErrorClear_1
        LDR      R2,??DataTable19  ;; 0x4006c000
        CMP      R1,R2
        BEQ      ??UARTRxErrorClear_1
        B        ??UARTRxErrorClear_2
//  906     {
//  907         case UART0_BASE:
//  908         {
//  909             xHWREGB(ulBase + UART_012_S1) |= UART_ERROR_MASK;
??UARTRxErrorClear_0:
        LDRB     R1,[R0, #+4]
        MOVS     R2,#+15
        ORRS     R2,R2,R1
        STRB     R2,[R0, #+4]
//  910 
//  911             break;
        B        ??UARTRxErrorClear_2
//  912         }
//  913 
//  914         case UART1_BASE:
//  915         case UART2_BASE:
//  916         {
//  917             (void)xHWREGB(ulBase + UART_012_S1);
??UARTRxErrorClear_1:
        LDRB     R1,[R0, #+4]
//  918             (void)xHWREGB(ulBase + UART_012_D);
        LDRB     R2,[R0, #+7]
//  919 
//  920             break;
//  921         }
//  922     }
//  923 }
??UARTRxErrorClear_2:
        POP      {PC}             ;; return
//  924 
//  925 
//  926 
//  927 //*****************************************************************************
//  928 //
//  929 //! \brief Open LIN mode on the specified UART.
//  930 //!
//  931 //! \param ulBase is the base address of the UART port.
//  932 //! \param ulConfig is the Config of the UART port in LIN mode.
//  933 //!
//  934 //! Open the LIN mode for the UART.
//  935 //!
//  936 //! The \e ulConfig parameter is the logical OR of three values: the LIN Tx or Rx
//  937 //! Mode, the LIN Break Field Length.\b UART_CONFIG_LIN_RX_EN ,and \b
//  938 //! UART_CONFIG_LIN_TX_EN is to enable LIN Rx or Tx.
//  939 //!
//  940 //! \note
//  941 //!  ------------------------------------------------
//  942 //!  |  S2    | C1 | C4  | BDH  |   Break Character |
//  943 //!  |  BPK13 | M  | M10 | SBNS |   Length          |
//  944 //!  |--------|----|-----|------|-------------------|
//  945 //!  |  0     | 0  | 0   | 0    |   10              |
//  946 //!  |  0     | 0  | 0   | 1    |   11              |
//  947 //!  |  0     | 1  | 0   | 1    |   12              |
//  948 //!  |  1     | 0  | 0   | 0    |   13              |
//  949 //!  |  1     | 0  | 0   | 1    |   14              |
//  950 //!  |  1     | 1  | 0   | 1    |   15              |
//  951 //!  |  1     | 0  | 1   | 1    |   16              |
//  952 //!  ------------------------------------------------
//  953 //!  .
//  954 //! \return None.
//  955 //
//  956 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  957 void UARTLINConfig(unsigned long ulBase, unsigned long ulBaud,
//  958                    unsigned long ulConfig)
//  959 {
UARTLINConfig:
        PUSH     {R4-R6,LR}
        MOVS     R4,R0
        MOVS     R6,R1
        MOVS     R5,R2
//  960     xASSERT((ulBase == UART0_BASE) || (ulBase == UART1_BASE) ||
//  961             (ulBase == UART2_BASE) );
//  962     xASSERT((ulConfig == UART_LIN_SYNC_BREAK_LEN_10) ||
//  963             (ulConfig == UART_LIN_SYNC_BREAK_LEN_11) ||
//  964             (ulConfig == UART_LIN_SYNC_BREAK_LEN_12) ||
//  965             (ulConfig == UART_LIN_SYNC_BREAK_LEN_13) ||
//  966             (ulConfig == UART_LIN_SYNC_BREAK_LEN_14) ||
//  967             (ulConfig == UART_LIN_SYNC_BREAK_LEN_15) ||
//  968             (ulConfig == UART_LIN_SYNC_BREAK_LEN_16) );
//  969 
//  970     //
//  971     // General UART 8-N-1
//  972     //
//  973 
//  974     UARTConfigSet(ulBase, ulBaud, (UART_CONFIG_WLEN_8   |
//  975                 UART_CONFIG_PAR_NONE | UART_CONFIG_STOP_1));
        MOVS     R2,#+255
        ADDS     R2,R2,#+66       ;; #+321
        MOVS     R1,R6
        MOVS     R0,R4
        BL       UARTConfigSet
//  976 
//  977     switch(ulBase)
        MOVS     R0,R4
        LDR      R1,??DataTable13  ;; 0x4006a000
        CMP      R0,R1
        BEQ      ??UARTLINConfig_0
        LDR      R1,??DataTable13_1  ;; 0x4006b000
        CMP      R0,R1
        BEQ      ??UARTLINConfig_1
        LDR      R1,??DataTable19  ;; 0x4006c000
        CMP      R0,R1
        BEQ      ??UARTLINConfig_1
        B        ??UARTLINConfig_2
//  978     {
//  979         case UART0_BASE:
//  980         {
//  981             unsigned char tmp = 0;
??UARTLINConfig_0:
        MOVS     R0,#+0
//  982             
//  983             //
//  984             // Clear S2 C1 C4 SBNS Bit
//  985             //
//  986             xHWREGB(ulBase + UART_012_S2 ) &= (unsigned char)(~UART_012_S2_BRK13_MASK);
        LDRB     R1,[R4, #+5]
        MOVS     R2,#+251
        ANDS     R2,R2,R1
        STRB     R2,[R4, #+5]
//  987             xHWREGB(ulBase + UART_012_C1 ) &= (unsigned char)(~UART_012_C1_M_MASK);
        LDRB     R1,[R4, #+2]
        MOVS     R2,#+239
        ANDS     R2,R2,R1
        STRB     R2,[R4, #+2]
//  988             xHWREGB(ulBase + UART_0_C4 )   &= (unsigned char)(~UART_0_C4_M10_MASK);
        LDRB     R1,[R4, #+10]
        MOVS     R2,#+223
        ANDS     R2,R2,R1
        STRB     R2,[R4, #+10]
//  989             xHWREGB(ulBase + UART_012_BDH) &= (unsigned char)(~UART_012_BDH_SBNS_MASK);
        LDRB     R1,[R4, #+0]
        MOVS     R2,#+223
        ANDS     R2,R2,R1
        STRB     R2,[R4, #+0]
//  990 
//  991             //
//  992             // Configure Break Length
//  993             //
//  994             xHWREGB(ulBase + UART_0_S2 ) |= (unsigned char)(ulConfig >> 24);
        LDRB     R1,[R4, #+5]
        MOVS     R2,R5
        LSRS     R2,R2,#+24
        ORRS     R2,R2,R1
        STRB     R2,[R4, #+5]
//  995             xHWREGB(ulBase + UART_0_C1 ) |= (unsigned char)(ulConfig >> 16);
        LDRB     R1,[R4, #+2]
        MOVS     R2,R5
        LSRS     R2,R2,#+16
        ORRS     R2,R2,R1
        STRB     R2,[R4, #+2]
//  996             xHWREGB(ulBase + UART_0_C4 ) |= (unsigned char)(ulConfig >> 8 );
        LDRB     R1,[R4, #+10]
        MOVS     R2,R5
        LSRS     R2,R2,#+8
        ORRS     R2,R2,R1
        STRB     R2,[R4, #+10]
//  997             xHWREGB(ulBase + UART_0_BDH) |= (unsigned char)(ulConfig      );
        LDRB     R1,[R4, #+0]
        MOVS     R2,R5
        ORRS     R2,R2,R1
        STRB     R2,[R4, #+0]
//  998             tmp = xHWREGB(ulBase + UART_0_BDH);
        LDRB     R1,[R4, #+0]
        MOVS     R0,R1
//  999 
// 1000             break;
        B        ??UARTLINConfig_2
// 1001         }
// 1002 
// 1003         case UART1_BASE:
// 1004         case UART2_BASE:
// 1005         {
// 1006             //
// 1007             // Clear S2 C1 SBNS Bit
// 1008             //
// 1009             xHWREGB(ulBase + UART_12_S2 ) &= (unsigned char)(~UART_012_S2_BRK13_MASK);
??UARTLINConfig_1:
        LDRB     R0,[R4, #+5]
        MOVS     R1,#+251
        ANDS     R1,R1,R0
        STRB     R1,[R4, #+5]
// 1010             xHWREGB(ulBase + UART_12_C1 ) &= (unsigned char)(~UART_012_C1_M_MASK);
        LDRB     R0,[R4, #+2]
        MOVS     R1,#+239
        ANDS     R1,R1,R0
        STRB     R1,[R4, #+2]
// 1011             xHWREGB(ulBase + UART_12_BDH) &= (unsigned char)(~UART_012_BDH_SBNS_MASK);
        LDRB     R0,[R4, #+0]
        MOVS     R1,#+223
        ANDS     R1,R1,R0
        STRB     R1,[R4, #+0]
// 1012 
// 1013             //
// 1014             // Configure Break Length
// 1015             //
// 1016             xHWREGB(ulBase + UART_12_S2 ) |= (unsigned char)(ulConfig >> 24);
        LDRB     R0,[R4, #+5]
        MOVS     R1,R5
        LSRS     R1,R1,#+24
        ORRS     R1,R1,R0
        STRB     R1,[R4, #+5]
// 1017             xHWREGB(ulBase + UART_12_C1 ) |= (unsigned char)(ulConfig >> 16);
        LDRB     R0,[R4, #+2]
        MOVS     R1,R5
        LSRS     R1,R1,#+16
        ORRS     R1,R1,R0
        STRB     R1,[R4, #+2]
// 1018             xHWREGB(ulBase + UART_12_BDH) |= (unsigned char)(ulConfig      );
        LDRB     R0,[R4, #+0]
        MOVS     R1,R5
        ORRS     R1,R1,R0
        STRB     R1,[R4, #+0]
// 1019             break;
// 1020         }
// 1021     }
// 1022 }
??UARTLINConfig_2:
        POP      {R4-R6,PC}       ;; return
// 1023 
// 1024 
// 1025 //*****************************************************************************
// 1026 //
// 1027 //! \brief Enables LIN Function mode on the specified UART.
// 1028 //!
// 1029 //! \param ulBase is the base address of the UART port.
// 1030 //!
// 1031 //! Enables the SIREN control bit for LIN Function on the UART.
// 1032 //!
// 1033 //! \return None.
// 1034 //
// 1035 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1036 void UARTLINEnable(unsigned long ulBase)
// 1037 {
// 1038     xASSERT((ulBase == UART0_BASE) || (ulBase == UART1_BASE) ||
// 1039             (ulBase == UART2_BASE) );
// 1040     xHWREGB(ulBase + UART_012_S2) |= (unsigned char)(UART_012_S2_LBKDE);
UARTLINEnable:
        LDRB     R1,[R0, #+5]
        MOVS     R2,#+2
        ORRS     R2,R2,R1
        STRB     R2,[R0, #+5]
// 1041 }
        BX       LR               ;; return
// 1042 
// 1043 //*****************************************************************************
// 1044 //
// 1045 //! \brief Disables LIN Function mode on the specified UART.
// 1046 //!
// 1047 //! \param ulBase is the base address of the UART port.
// 1048 //!
// 1049 //! Clears the LIN Function bits.
// 1050 //!
// 1051 //! \return None.
// 1052 //
// 1053 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1054 void UARTLINDisable(unsigned long ulBase)
// 1055 {
// 1056     xASSERT((ulBase == UART0_BASE) || (ulBase == UART1_BASE) ||
// 1057             (ulBase == UART2_BASE) );
// 1058 
// 1059     xHWREGB(ulBase + UART_012_S2) &= (unsigned char)(~UART_012_S2_LBKDE);
UARTLINDisable:
        LDRB     R1,[R0, #+5]
        MOVS     R2,#+253
        ANDS     R2,R2,R1
        STRB     R2,[R0, #+5]
// 1060 }
        BX       LR               ;; return
// 1061 
// 1062 //*****************************************************************************
// 1063 //
// 1064 //! \brief Send sync break chars.
// 1065 //!
// 1066 //! \param ulBase is the base address of the UART port.
// 1067 //!
// 1068 //! Send synch break chars.
// 1069 //!
// 1070 //! \return None.
// 1071 //
// 1072 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1073 void UARTLINSyncBreakPut(unsigned long ulBase)
// 1074 {
UARTLINSyncBreakPut:
        PUSH     {LR}
// 1075     xASSERT((ulBase == UART0_BASE) || (ulBase == UART1_BASE) ||
// 1076             (ulBase == UART2_BASE) );
// 1077     //
// 1078     // Wait until Transmit Register available
// 1079     //
// 1080     while(0 == (xHWREGB(ulBase + UART_012_S1) & UART_012_S1_TDRE_MASK));
??UARTLINSyncBreakPut_0:
        LDRB     R1,[R0, #+4]
        LSLS     R1,R1,#+24
        BPL      ??UARTLINSyncBreakPut_0
// 1081 
// 1082     //
// 1083     //
// 1084     //
// 1085     xHWREGB(ulBase + UART_012_C2) |= (unsigned char)(UART_012_C2_SBK_MASK);
        LDRB     R1,[R0, #+3]
        MOVS     R2,#+1
        ORRS     R2,R2,R1
        STRB     R2,[R0, #+3]
// 1086     xHWREGB(ulBase + UART_012_C2) &= (unsigned char)(~UART_012_C2_SBK_MASK);
        LDRB     R1,[R0, #+3]
        MOVS     R2,#+254
        ANDS     R2,R2,R1
        STRB     R2,[R0, #+3]
// 1087 }
        POP      {PC}             ;; return
// 1088 
// 1089 
// 1090 //*****************************************************************************
// 1091 //
// 1092 //! \brief Enables individual UART DMA sources.
// 1093 //!
// 1094 //! \param ulBase is the base address of the UART port.
// 1095 //! \param ulConfig is the bit mask of the DMA sources.
// 1096 //!
// 1097 //! When a flag is configured for a DMA request, its associated DMA request
// 1098 //! is asserted when the flag is set. The DMA request remains asserted until
// 1099 //! an indication is received that the DMA transactions are done. When this
// 1100 //! indication is received, the flag bit and the associated DMA request are
// 1101 //! cleared. If the DMA operation failed to remove the situation that caused
// 1102 //! the DMA request another request will be issued
// 1103 //!
// 1104 //! The \e ulBase parameter can be one of the following:
// 1105 //! - \b UART0_BASE    = UART 0 Module base address
// 1106 //! - \b UART1_BASE    = UART 1 Module base address
// 1107 //! - \b UART2_BASE    = UART 2 Module base address
// 1108 //!
// 1109 //! The \e ulConfig parameter is the logical OR of any of the following
// 1110 //! - \b UART_DMA_T      Transmit register empty
// 1111 //! - \b UART_DMA_TC     Transmit complete
// 1112 //! - \b UART_DMA_R      Receive register full
// 1113 //! - \b UART_DMA_IDLE   Idle line detect
// 1114 //! - \b UART_DMA_LBKD   LIN break
// 1115 //!
// 1116 //! \return None.
// 1117 //
// 1118 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1119 void UARTDMAEnable(unsigned long ulBase, unsigned long ulConfig)
// 1120 {
UARTDMAEnable:
        PUSH     {LR}
// 1121     xASSERT((ulBase == UART0_BASE) || (ulBase == UART1_BASE) ||
// 1122             (ulBase == UART2_BASE) );
// 1123     xASSERT(0 == (ulConfig & (UART_DMA_T | UART_DMA_TC | UART_DMA_R |
// 1124                               UART_DMA_IDLE | UART_DMA_LBKD)));
// 1125     switch(ulBase)
        MOVS     R2,R0
        LDR      R3,??DataTable13  ;; 0x4006a000
        CMP      R2,R3
        BEQ      ??UARTDMAEnable_0
        LDR      R3,??DataTable13_1  ;; 0x4006b000
        CMP      R2,R3
        BEQ      ??UARTDMAEnable_1
        LDR      R3,??DataTable21  ;; 0x4006c000
        CMP      R2,R3
        BEQ      ??UARTDMAEnable_1
        B        ??UARTDMAEnable_2
// 1126     {
// 1127         case UART0_BASE:
// 1128             {
// 1129                 xHWREGB(ulBase + UART_0_C5) |= (unsigned char) ulConfig;
??UARTDMAEnable_0:
        LDRB     R2,[R0, #+11]
        MOVS     R3,R1
        ORRS     R3,R3,R2
        STRB     R3,[R0, #+11]
// 1130                 break;
        B        ??UARTDMAEnable_2
// 1131             }
// 1132         case UART1_BASE:
// 1133         case UART2_BASE:
// 1134             {
// 1135                 xHWREGB(ulBase + UART_12_C4) |= (unsigned char) ulConfig;
??UARTDMAEnable_1:
        LDRB     R2,[R0, #+8]
        MOVS     R3,R1
        ORRS     R3,R3,R2
        STRB     R3,[R0, #+8]
// 1136                 break;
// 1137             }
// 1138     }
// 1139 }
??UARTDMAEnable_2:
        POP      {PC}             ;; return
// 1140 
// 1141 //*****************************************************************************
// 1142 //
// 1143 //! \brief Disables individual UART DMA sources.
// 1144 //!
// 1145 //! \param ulBase is the base address of the UART port.
// 1146 //! \param ulConfig is the bit mask of the DMA sources.
// 1147 //!
// 1148 //! When a flag is configured for a DMA request, its associated DMA request
// 1149 //! is asserted when the flag is set. The DMA request remains asserted until
// 1150 //! an indication is received that the DMA transactions are done. When this
// 1151 //! indication is received, the flag bit and the associated DMA request are
// 1152 //! cleared. If the DMA operation failed to remove the situation that caused
// 1153 //! the DMA request another request will be issued
// 1154 //!
// 1155 //! The \e ulBase parameter can be one of the following:
// 1156 //! - \b UART0_BASE    = UART 0 Module base address
// 1157 //! - \b UART1_BASE    = UART 1 Module base address
// 1158 //! - \b UART2_BASE    = UART 2 Module base address
// 1159 //!
// 1160 //! The \e ulConfig parameter is the logical OR of any of the following
// 1161 //! - \b UART_DMA_T      Transmit register empty
// 1162 //! - \b UART_DMA_TC     Transmit complete
// 1163 //! - \b UART_DMA_R      Receive register full
// 1164 //! - \b UART_DMA_IDLE   Idle line detect
// 1165 //! - \b UART_DMA_LBKD   LIN break
// 1166 //!
// 1167 //! \return None.
// 1168 //
// 1169 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1170 void UARTDMADisable(unsigned long ulBase, unsigned long ulConfig)
// 1171 {
UARTDMADisable:
        PUSH     {LR}
// 1172     xASSERT((ulBase == UART0_BASE) || (ulBase == UART1_BASE) ||
// 1173             (ulBase == UART2_BASE) );
// 1174     xASSERT(0 == (ulConfig & (UART_DMA_T | UART_DMA_TC | UART_DMA_R |
// 1175                               UART_DMA_IDLE | UART_DMA_LBKD)));
// 1176     switch(ulBase)
        MOVS     R2,R0
        LDR      R3,??DataTable13  ;; 0x4006a000
        CMP      R2,R3
        BEQ      ??UARTDMADisable_0
        LDR      R3,??DataTable13_1  ;; 0x4006b000
        CMP      R2,R3
        BEQ      ??UARTDMADisable_1
        LDR      R3,??DataTable21  ;; 0x4006c000
        CMP      R2,R3
        BEQ      ??UARTDMADisable_1
        B        ??UARTDMADisable_2
// 1177     {
// 1178         case UART0_BASE:
// 1179             {
// 1180                 xHWREGB(ulBase + UART_0_C5) &= (unsigned char)(~ulConfig);
??UARTDMADisable_0:
        LDRB     R2,[R0, #+11]
        MOVS     R3,R1
        BICS     R2,R2,R3
        STRB     R2,[R0, #+11]
// 1181                 break;
        B        ??UARTDMADisable_2
// 1182             }
// 1183         case UART1_BASE:
// 1184         case UART2_BASE:
// 1185             {
// 1186                 xHWREGB(ulBase + UART_12_C4) &= (unsigned char)(~ulConfig);
??UARTDMADisable_1:
        LDRB     R2,[R0, #+8]
        MOVS     R3,R1
        BICS     R2,R2,R3
        STRB     R2,[R0, #+8]
// 1187                 break;
// 1188             }
// 1189     }
// 1190 }
??UARTDMADisable_2:
        POP      {PC}             ;; return
// 1191 
// 1192 //*****************************************************************************
// 1193 //
// 1194 //! \brief Invert the uart output signal.
// 1195 //!
// 1196 //! \param ulPort is the base address of the UART port.
// 1197 //!
// 1198 //! The \e ulBase parameter can be one of the following:
// 1199 //! - \b UART0_BASE    = UART 0 Module base address
// 1200 //! - \b UART1_BASE    = UART 1 Module base address
// 1201 //! - \b UART2_BASE    = UART 2 Module base address
// 1202 //!
// 1203 //! \return None.
// 1204 //
// 1205 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1206 void UARTTxInvertEnable(unsigned long ulBase)
// 1207 {
// 1208     xASSERT((ulBase == UART0_BASE) || (ulBase == UART1_BASE) ||
// 1209             (ulBase == UART2_BASE) );
// 1210 
// 1211     xHWREGB(ulBase + UART_012_C3) &= (unsigned char)(~UART_012_C3_TXINV_MASK);
UARTTxInvertEnable:
        LDRB     R1,[R0, #+6]
        MOVS     R2,#+239
        ANDS     R2,R2,R1
        STRB     R2,[R0, #+6]
// 1212     xHWREGB(ulBase + UART_012_C3) |= (unsigned char)(UART_012_C3_TXINV_INVERT);
        LDRB     R1,[R0, #+6]
        MOVS     R2,#+16
        ORRS     R2,R2,R1
        STRB     R2,[R0, #+6]
// 1213 }
        BX       LR               ;; return
// 1214 
// 1215 //*****************************************************************************
// 1216 //
// 1217 //! \brief NOT Invert the uart output signal.
// 1218 //!
// 1219 //! \param ulPort is the base address of the UART port.
// 1220 //!
// 1221 //! The \e ulBase parameter can be one of the following:
// 1222 //! - \b UART0_BASE    = UART 0 Module base address
// 1223 //! - \b UART1_BASE    = UART 1 Module base address
// 1224 //! - \b UART2_BASE    = UART 2 Module base address
// 1225 //!
// 1226 //! \return None.
// 1227 //
// 1228 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1229 void UARTTxInvertDisable(unsigned long ulBase)
// 1230 {
// 1231     xASSERT((ulBase == UART0_BASE) || (ulBase == UART1_BASE) ||
// 1232             (ulBase == UART2_BASE) );
// 1233 
// 1234     xHWREGB(ulBase + UART_012_C3) &= (unsigned char)(~UART_012_C3_TXINV_MASK);
UARTTxInvertDisable:
        LDRB     R1,[R0, #+6]
        MOVS     R2,#+239
        ANDS     R2,R2,R1
        STRB     R2,[R0, #+6]
// 1235     xHWREGB(ulBase + UART_012_C3) |= (unsigned char)(UART_012_C3_TXINV_NORMAL);
        LDRB     R1,[R0, #+6]
        STRB     R1,[R0, #+6]
// 1236 }
        BX       LR               ;; return
// 1237 
// 1238 //*****************************************************************************
// 1239 //
// 1240 //! \brief Invert the uart input signal.
// 1241 //!
// 1242 //! \param ulPort is the base address of the UART port.
// 1243 //!
// 1244 //! The \e ulBase parameter can be one of the following:
// 1245 //! - \b UART0_BASE    = UART 0 Module base address
// 1246 //! - \b UART1_BASE    = UART 1 Module base address
// 1247 //! - \b UART2_BASE    = UART 2 Module base address
// 1248 //!
// 1249 //! \return None.
// 1250 //
// 1251 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1252 void UARTRxInvertEnable(unsigned long ulBase)
// 1253 {
// 1254     xASSERT((ulBase == UART0_BASE) || (ulBase == UART1_BASE) ||
// 1255             (ulBase == UART2_BASE) );
// 1256 
// 1257     xHWREGB(ulBase + UART_012_S2) &= (unsigned char)(~UART_012_S2_RXINV_MASK);
UARTRxInvertEnable:
        LDRB     R1,[R0, #+5]
        MOVS     R2,#+239
        ANDS     R2,R2,R1
        STRB     R2,[R0, #+5]
// 1258     xHWREGB(ulBase + UART_012_S2) |= (unsigned char)(UART_012_S2_RXINV_INVERT);
        LDRB     R1,[R0, #+5]
        MOVS     R2,#+16
        ORRS     R2,R2,R1
        STRB     R2,[R0, #+5]
// 1259 }
        BX       LR               ;; return
// 1260 
// 1261 //*****************************************************************************
// 1262 //
// 1263 //! \brief NOT Invert the uart input signal.
// 1264 //!
// 1265 //! \param ulPort is the base address of the UART port.
// 1266 //!
// 1267 //! The \e ulBase parameter can be one of the following:
// 1268 //! - \b UART0_BASE    = UART 0 Module base address
// 1269 //! - \b UART1_BASE    = UART 1 Module base address
// 1270 //! - \b UART2_BASE    = UART 2 Module base address
// 1271 //!
// 1272 //! \return None.
// 1273 //
// 1274 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1275 void UARTRxInvertDisable(unsigned long ulBase)
// 1276 {
// 1277     xASSERT((ulBase == UART0_BASE) || (ulBase == UART1_BASE) ||
// 1278             (ulBase == UART2_BASE) );
// 1279 
// 1280     xHWREGB(ulBase + UART_012_S2) &= (unsigned char)(~UART_012_S2_RXINV_MASK);
UARTRxInvertDisable:
        LDRB     R1,[R0, #+5]
        MOVS     R2,#+239
        ANDS     R2,R2,R1
        STRB     R2,[R0, #+5]
// 1281     xHWREGB(ulBase + UART_012_S2) |= (unsigned char)(UART_012_S2_RXINV_NORMAL);
        LDRB     R1,[R0, #+5]
        STRB     R1,[R0, #+5]
// 1282 }
        BX       LR               ;; return
// 1283 
// 1284 
// 1285 //*****************************************************************************
// 1286 //
// 1287 //! \brief Configure UART output Mode.
// 1288 //!
// 1289 //! \param ulPort is the base address of the UART port.
// 1290 //! \param ulConfig is the UART mode.
// 1291 //!
// 1292 //!  UART can be set to three operate mode:
// 1293 //!  \b NORMAL, \b SINGLE_LINE ,\b LOOPS
// 1294 //!  in \b NORMAL mode, RX and TX is separate pin; in \b SINGLE_LINE mode RX and
// 1295 //!  TX use a common pin(TX Pin); in \b LOOPS mode UART does output signal,and
// 1296 //!  TX is connected to RX pin internal.
// 1297 //!
// 1298 //! The \e ulBase parameter can be one of the following:
// 1299 //! - \b UART0_BASE    = UART 0 Module base address
// 1300 //! - \b UART1_BASE    = UART 1 Module base address
// 1301 //! - \b UART2_BASE    = UART 2 Module base address
// 1302 //! The \e ulConfig parameter can be one of the following:
// 1303 //!
// 1304 //! - \b UART_MODE_NORMAL       Normal Mode
// 1305 //! - \b UART_MODE_SINGLE_LINE  Single line Mode
// 1306 //! - \b UART_MODE_LOOP         Loops Mode
// 1307 //
// 1308 //! \return None.
// 1309 //
// 1310 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1311 void UARTOutModeConfig(unsigned long ulBase, unsigned long ulConfig)
// 1312 {
// 1313     xASSERT((ulBase == UART0_BASE) || (ulBase == UART1_BASE) ||
// 1314             (ulBase == UART2_BASE) );
// 1315 
// 1316     xHWREGB(ulBase + UART_012_C1) &= (unsigned char)(~UART_MODE_MASK);
UARTOutModeConfig:
        LDRB     R2,[R0, #+2]
        MOVS     R3,#+95
        ANDS     R3,R3,R2
        STRB     R3,[R0, #+2]
// 1317     xHWREGB(ulBase + UART_012_C1) |= (unsigned char)(ulConfig);
        LDRB     R2,[R0, #+2]
        MOVS     R3,R1
        ORRS     R3,R3,R2
        STRB     R3,[R0, #+2]
// 1318 }
        BX       LR               ;; return
// 1319 
// 1320 //*****************************************************************************
// 1321 //
// 1322 //! \brief Enable UART in wait mode.
// 1323 //!
// 1324 //! \param ulPort is the base address of the UART port.
// 1325 //!
// 1326 //! UART clocks continue to run in wait mode so the UART can be the source of
// 1327 //! an interrupt that wakes up the CPU.
// 1328 //!
// 1329 //! \return None.
// 1330 //
// 1331 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1332 void UARTWaitModeRun(unsigned long ulBase)
// 1333 {
// 1334     xASSERT((ulBase == UART0_BASE) || (ulBase == UART1_BASE) ||
// 1335             (ulBase == UART2_BASE) );
// 1336 
// 1337     xHWREGB(ulBase + UART_012_C1) &= (unsigned char)(~UART_012_C1_DOZEEN_ENABLE);
UARTWaitModeRun:
        LDRB     R1,[R0, #+2]
        STRB     R1,[R0, #+2]
// 1338 }
        BX       LR               ;; return
// 1339 
// 1340 //*****************************************************************************
// 1341 //
// 1342 //! \brief Disable UART in wait mode.
// 1343 //!
// 1344 //! \param ulPort is the base address of the UART port.
// 1345 //!
// 1346 //! UART clocks freeze while CPU is in wait mode.
// 1347 //!
// 1348 //! \return None.
// 1349 //
// 1350 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1351 void UARTWaitModeStop(unsigned long ulBase)
// 1352 {
// 1353     xASSERT((ulBase == UART0_BASE) || (ulBase == UART1_BASE) ||
// 1354             (ulBase == UART2_BASE) );
// 1355 
// 1356     xHWREGB(ulBase + UART_012_C1) |= (unsigned char)(UART_012_C1_DOZEEN_DISABLE);
UARTWaitModeStop:
        LDRB     R1,[R0, #+2]
        MOVS     R2,#+64
        ORRS     R2,R2,R1
        STRB     R2,[R0, #+2]
// 1357 }
        BX       LR               ;; return
// 1358 
// 1359 //*****************************************************************************
// 1360 //
// 1361 //! \brief Receiver wakeup mode select.
// 1362 //!
// 1363 //! \param ulPort is the base address of the UART port.
// 1364 //! \param ulConfig is the wakeup mode select.
// 1365 //!
// 1366 //! Receiver wakeup is a hardware mechanism that allows an UART receiver to
// 1367 //! ignore the characters in a message intended for a different UART receiver.
// 1368 //!
// 1369 //! The \e ulConfig parameter can be one of the followings:
// 1370 //! - \b UART_WAKEUP_IDLE_LINE Idle line wakeup mode.
// 1371 //! - \b UART_WAKEUP_ADDRESS_MARK Address match wakeup mode.
// 1372 //!
// 1373 //! \return None.
// 1374 //
// 1375 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1376 void UARTWakeupMethodConfig(unsigned long ulBase, unsigned long ulConfig)
// 1377 {
// 1378     xASSERT((ulBase == UART0_BASE) || (ulBase == UART1_BASE) ||
// 1379             (ulBase == UART2_BASE) );
// 1380     xASSERT((ulBase == UART_WAKEUP_IDLE_LINE   ) ||
// 1381             (ulBase == UART_WAKEUP_ADDRESS_MARK) );
// 1382     xHWREGB(ulBase + UART_012_C1) &= (unsigned char)(~UART_WAKEUP_MASK);
UARTWakeupMethodConfig:
        LDRB     R2,[R0, #+2]
        MOVS     R3,#+247
        ANDS     R3,R3,R2
        STRB     R3,[R0, #+2]
// 1383     xHWREGB(ulBase + UART_012_C1) |= (unsigned char)(ulConfig);
        LDRB     R2,[R0, #+2]
        MOVS     R3,R1
        ORRS     R3,R3,R2
        STRB     R3,[R0, #+2]
// 1384 }
        BX       LR               ;; return
// 1385 
// 1386 //*****************************************************************************
// 1387 //
// 1388 //! \brief Configure MSB of chars to be sent first.
// 1389 //!
// 1390 //! \param ulPort is the base address of the UART port.
// 1391 //!
// 1392 //! Setting this bit reverses the order of the bits that are transmitted and
// 1393 //! received on the wire. this bit does not affect the polarity of the bits,
// 1394 //! the location of the parity bit or the location of the start or stop bits.
// 1395 //! This bit should only be changed when the transmitter and receiver are both
// 1396 //! disabled.
// 1397 //!
// 1398 //! \return None.
// 1399 //
// 1400 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1401 void UARTMsbFirst(unsigned long ulBase)
// 1402 {
// 1403     xASSERT((ulBase == UART0_BASE));
// 1404     xHWREGB(UART0_BASE + UART_0_S2) &= (unsigned char)(~UART_0_S2_MSBF_MASK);
UARTMsbFirst:
        LDR      R1,??DataTable21_1  ;; 0x4006a005
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+223
        ANDS     R2,R2,R1
        LDR      R1,??DataTable21_1  ;; 0x4006a005
        STRB     R2,[R1, #+0]
// 1405     xHWREGB(UART0_BASE + UART_0_S2) |= (unsigned char)(UART_0_S2_MSBF_MSB);
        LDR      R1,??DataTable21_1  ;; 0x4006a005
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+32
        ORRS     R2,R2,R1
        LDR      R1,??DataTable21_1  ;; 0x4006a005
        STRB     R2,[R1, #+0]
// 1406 }
        BX       LR               ;; return
// 1407 
// 1408 //*****************************************************************************
// 1409 //
// 1410 //! \brief Configure LSB of chars to be sent first.
// 1411 //!
// 1412 //! \param ulPort is the base address of the UART port.
// 1413 //!
// 1414 //! Setting this bit reverses the order of the bits that are transmitted and
// 1415 //! received on the wire. this bit does not affect the polarity of the bits,
// 1416 //! the location of the parity bit or the location of the start or stop bits.
// 1417 //! This bit should only be changed when the transmitter and receiver are both
// 1418 //! disabled.
// 1419 //!
// 1420 //! \return None.
// 1421 //
// 1422 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1423 void UARTLsbFirst(unsigned long ulBase)
// 1424 {
// 1425     xASSERT((ulBase == UART0_BASE));
// 1426     xHWREGB(UART0_BASE + UART_0_S2) &= (unsigned char)(~UART_0_S2_MSBF_MASK);
UARTLsbFirst:
        LDR      R1,??DataTable21_1  ;; 0x4006a005
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+223
        ANDS     R2,R2,R1
        LDR      R1,??DataTable21_1  ;; 0x4006a005
        STRB     R2,[R1, #+0]
// 1427     xHWREGB(UART0_BASE + UART_0_S2) |= (unsigned char)(UART_0_S2_MSBF_LSB);
        LDR      R1,??DataTable21_1  ;; 0x4006a005
        LDR      R2,??DataTable21_1  ;; 0x4006a005
        LDRB     R2,[R2, #+0]
        STRB     R2,[R1, #+0]
// 1428 }
        BX       LR               ;; return
// 1429 
// 1430 //*****************************************************************************
// 1431 //
// 1432 //! \brief Get receiver status.
// 1433 //!
// 1434 //! \param ulPort is the base address of the UART port.
// 1435 //!
// 1436 //! Get the receiver status, active or idle?
// 1437 //!
// 1438 //! \return Receiver status, this value is one of the followings:
// 1439 //! \b xtrue   UART receiver active.
// 1440 //! \b xfalse  UART receiver idle waitting for a start bit.
// 1441 //
// 1442 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1443 xtBoolean UARTReceiverStatus(unsigned long ulBase)
// 1444 {
UARTReceiverStatus:
        MOVS     R1,R0
// 1445     xtBoolean ulStatus = xfalse;
        MOVS     R0,#+0
// 1446     xASSERT((ulBase == UART0_BASE) || (ulBase == UART1_BASE) ||
// 1447             (ulBase == UART2_BASE) );
// 1448     ulStatus = (xtBoolean) (xHWREGB(ulBase + UART_012_S2) &
// 1449                            (unsigned char)UART_012_S2_RAF);
        LDRB     R2,[R1, #+5]
        MOVS     R3,R2
        LSLS     R3,R3,#+31       ;; ZeroExtS R3,R3,#+31,#+31
        LSRS     R3,R3,#+31
        MOVS     R0,R3
// 1450 
// 1451     return (ulStatus);
        UXTB     R0,R0
        BX       LR               ;; return
// 1452 }
// 1453 
// 1454 //*****************************************************************************
// 1455 //
// 1456 //! \brief Configure the UART Match address.
// 1457 //!
// 1458 //! \param ulPort is the base address of the UART port.
// 1459 //! \param ulChl  is the match address ID.
// 1460 //! \param ulAddr is the user's address.
// 1461 //!
// 1462 //! The Match register are compared to input data addresses when the most
// 1463 //! significant bit is set and the associated bit is set. If a match occurs,
// 1464 //! the following data is transferred to the data register. if a match fails,
// 1465 //! the following data is discarded. This function can be called at anytime.
// 1466 //!
// 1467 //! The \e ulChl parameter can be one of the following:
// 1468 //! \b UART_ADDRESS_CHL_1 \b UART_ADDRESS_CHL_2
// 1469 //! The \b ulAddr parameter must <= 255.
// 1470 //!
// 1471 //! \return None.
// 1472 //
// 1473 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1474 void UARTMatchAddressSet(unsigned long ulBase, unsigned long ulChl,
// 1475                          unsigned long ulAddr)
// 1476 {
UARTMatchAddressSet:
        PUSH     {R4,LR}
// 1477     xASSERT((ulBase == UART0_BASE));
// 1478     xASSERT((ulBase == UART_ADDRESS_CHL_1) || (ulBase == UART_ADDRESS_CHL_2));
// 1479     xASSERT(ulAddr < 0x00000100UL);
// 1480 
// 1481     //
// 1482     // Avoid compiler warning
// 1483     //
// 1484     ulBase = ulBase;
// 1485 
// 1486     if(UART_ADDRESS_CHL_1 == ulChl)
        CMP      R1,#+1
        BNE      ??UARTMatchAddressSet_0
// 1487     {
// 1488         xHWREGB(UART0_BASE + UART_0_MA1) = (unsigned char)(ulAddr);
        LDR      R3,??DataTable21_2  ;; 0x4006a008
        MOVS     R4,R2
        STRB     R4,[R3, #+0]
        B        ??UARTMatchAddressSet_1
// 1489     }
// 1490     else if(UART_ADDRESS_CHL_2 == ulChl)
??UARTMatchAddressSet_0:
        CMP      R1,#+2
        BNE      ??UARTMatchAddressSet_1
// 1491     {
// 1492         xHWREGB(UART0_BASE + UART_0_MA2) = (unsigned char)(ulAddr);
        LDR      R3,??DataTable21_3  ;; 0x4006a009
        MOVS     R4,R2
        STRB     R4,[R3, #+0]
// 1493     }
// 1494 }
??UARTMatchAddressSet_1:
        POP      {R4,PC}          ;; return
// 1495 
// 1496 
// 1497 //*****************************************************************************
// 1498 //
// 1499 //! \brief Enable Address match mode.
// 1500 //!
// 1501 //! \param ulPort is the base address of the UART port.
// 1502 //! \param ulChl  is the match address ID.
// 1503 //!
// 1504 //! The Match register are compared to input data addresses when the most
// 1505 //! significant bit is set and the associated bit is set. If a match occurs,
// 1506 //! the following data is transferred to the data register. if a match fails,
// 1507 //! the following data is discarded. This function can be called at anytime.
// 1508 //!
// 1509 //! The \e ulChl parameter can be one of the following:
// 1510 //! \b UART_ADDRESS_CHL_1 \b UART_ADDRESS_CHL_2
// 1511 //!
// 1512 //! \return None.
// 1513 //
// 1514 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1515 void UARTMatchAddrModeEnable(unsigned long ulBase, unsigned long ulChl)
// 1516 {
UARTMatchAddrModeEnable:
        PUSH     {LR}
// 1517     xASSERT((ulBase == UART0_BASE));
// 1518     xASSERT((ulBase == UART_ADDRESS_CHL_1) || (ulBase == UART_ADDRESS_CHL_2));
// 1519 
// 1520     //
// 1521     // Avoid compiler warning
// 1522     //
// 1523     ulBase = ulBase;
// 1524 
// 1525     if(UART_ADDRESS_CHL_1 == ulChl)
        CMP      R1,#+1
        BNE      ??UARTMatchAddrModeEnable_0
// 1526     {
// 1527         xHWREGB(UART0_BASE + UART_0_C4) |= (unsigned char)(UART_0_C4_MAEN1_MASK);
        LDR      R2,??DataTable21_4  ;; 0x4006a00a
        LDRB     R2,[R2, #+0]
        MOVS     R3,#+128
        ORRS     R3,R3,R2
        LDR      R2,??DataTable21_4  ;; 0x4006a00a
        STRB     R3,[R2, #+0]
        B        ??UARTMatchAddrModeEnable_1
// 1528     }
// 1529     else if(UART_ADDRESS_CHL_2 == ulChl)
??UARTMatchAddrModeEnable_0:
        CMP      R1,#+2
        BNE      ??UARTMatchAddrModeEnable_1
// 1530     {
// 1531         xHWREGB(UART0_BASE + UART_0_C4) |= (unsigned char)(UART_0_C4_MAEN2_MASK);
        LDR      R2,??DataTable21_4  ;; 0x4006a00a
        LDRB     R2,[R2, #+0]
        MOVS     R3,#+64
        ORRS     R3,R3,R2
        LDR      R2,??DataTable21_4  ;; 0x4006a00a
        STRB     R3,[R2, #+0]
// 1532     }
// 1533 }
??UARTMatchAddrModeEnable_1:
        POP      {PC}             ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable13:
        DC32     0x4006a000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable13_1:
        DC32     0x4006b000
// 1534 
// 1535 //*****************************************************************************
// 1536 //
// 1537 //! \brief Disable Address match mode.
// 1538 //!
// 1539 //! \param ulPort is the base address of the UART port.
// 1540 //! \param ulChl  is the match address ID.
// 1541 //!
// 1542 //! The Match register are compared to input data addresses when the most
// 1543 //! significant bit is set and the associated bit is set. If a match occurs,
// 1544 //! the following data is transferred to the data register. if a match fails,
// 1545 //! the following data is discarded. This function can be called at anytime.
// 1546 //!
// 1547 //! The \e ulChl parameter can be one of the following:
// 1548 //! \b UART_ADDRESS_CHL_1 \b UART_ADDRESS_CHL_2
// 1549 //!
// 1550 //! \return None.
// 1551 //
// 1552 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1553 void UARTMatchAddrModeDisable(unsigned long ulBase, unsigned long ulChl)
// 1554 {
UARTMatchAddrModeDisable:
        PUSH     {LR}
// 1555     xASSERT((ulBase == UART0_BASE));
// 1556     xASSERT((ulBase == UART_ADDRESS_CHL_1) || (ulBase == UART_ADDRESS_CHL_2));
// 1557 
// 1558     //
// 1559     // Avoid compiler warning
// 1560     //
// 1561     ulBase = ulBase;
// 1562 
// 1563     if(UART_ADDRESS_CHL_1 == ulChl)
        CMP      R1,#+1
        BNE      ??UARTMatchAddrModeDisable_0
// 1564     {
// 1565         xHWREGB(UART0_BASE + UART_0_C4) &= (unsigned char)(~UART_0_C4_MAEN1_MASK);
        LDR      R2,??DataTable21_4  ;; 0x4006a00a
        LDRB     R2,[R2, #+0]
        LSLS     R2,R2,#+25       ;; ZeroExtS R2,R2,#+25,#+25
        LSRS     R2,R2,#+25
        LDR      R3,??DataTable21_4  ;; 0x4006a00a
        STRB     R2,[R3, #+0]
        B        ??UARTMatchAddrModeDisable_1
// 1566     }
// 1567     else if(UART_ADDRESS_CHL_2 == ulChl)
??UARTMatchAddrModeDisable_0:
        CMP      R1,#+2
        BNE      ??UARTMatchAddrModeDisable_1
// 1568     {
// 1569         xHWREGB(UART0_BASE + UART_0_C4) &= (unsigned char)(~UART_0_C4_MAEN2_MASK);
        LDR      R2,??DataTable21_4  ;; 0x4006a00a
        LDRB     R2,[R2, #+0]
        MOVS     R3,#+191
        ANDS     R3,R3,R2
        LDR      R2,??DataTable21_4  ;; 0x4006a00a
        STRB     R3,[R2, #+0]
// 1570     }
// 1571 }
??UARTMatchAddrModeDisable_1:
        POP      {PC}             ;; return
// 1572 
// 1573 
// 1574 //*****************************************************************************
// 1575 //
// 1576 //! \brief Enable both edge sampling function.
// 1577 //!
// 1578 //! \param ulPort is the base address of the UART port.
// 1579 //!
// 1580 //! Enables sampling of the received data on both edges of the baud clock,
// 1581 //! effectively doubling the number of times the receiver samples the input data
// 1582 //! for a given oversampling ratio. This bit must be set for oversampling ratios
// 1583 //! between x4 and x8 and is optional for highter oversampling ratios.
// 1584 //!
// 1585 //! \note This function is UART0 special function
// 1586 //!
// 1587 //! \return None.
// 1588 //
// 1589 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1590 void UARTBothEdgeSampleEnable(unsigned long ulBase)
// 1591 {
// 1592     xASSERT((ulBase == UART0_BASE));
// 1593     xHWREGB(UART0_BASE + UART_0_C5) |= (unsigned char)UART_0_C5_BOTHEDGE;
UARTBothEdgeSampleEnable:
        LDR      R1,??DataTable21_5  ;; 0x4006a00b
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+2
        ORRS     R2,R2,R1
        LDR      R1,??DataTable21_5  ;; 0x4006a00b
        STRB     R2,[R1, #+0]
// 1594 }
        BX       LR               ;; return
// 1595 
// 1596 //*****************************************************************************
// 1597 //
// 1598 //! \brief Disable both edge sampling function.
// 1599 //!
// 1600 //! \param ulPort is the base address of the UART port.
// 1601 //!
// 1602 //! Enables sampling of the received data on both edges of the baud clock,
// 1603 //! effectively doubling the number of times the receiver samples the input data
// 1604 //! for a given oversampling ratio. This bit must be set for oversampling ratios
// 1605 //! between x4 and x8 and is optional for highter oversampling ratios.
// 1606 //!
// 1607 //! \note This function is UART0 special function
// 1608 //!
// 1609 //! \return None.
// 1610 //
// 1611 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1612 void UARTBothEdgeSampleDisable(unsigned long ulBase)
// 1613 {
// 1614     xASSERT((ulBase == UART0_BASE));
// 1615     xHWREGB(UART0_BASE + UART_0_C5) &= (unsigned char)(~UART_0_C5_BOTHEDGE);
UARTBothEdgeSampleDisable:
        LDR      R1,??DataTable21_5  ;; 0x4006a00b
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+253
        ANDS     R2,R2,R1
        LDR      R1,??DataTable21_5  ;; 0x4006a00b
        STRB     R2,[R1, #+0]
// 1616 }
        BX       LR               ;; return
// 1617 
// 1618 //*****************************************************************************
// 1619 //
// 1620 //! \brief Enable UART resynchronization function.
// 1621 //!
// 1622 //! \param ulPort is the base address of the UART port.
// 1623 //!
// 1624 //! Enable the resynchronization of the received data word when a data one
// 1625 //! followed by data zero transition is detected.
// 1626 //!
// 1627 //! \note This function is UART0 special function
// 1628 //!
// 1629 //! \return None.
// 1630 //
// 1631 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1632 void UARTReSyncEnable(unsigned long ulBase)
// 1633 {
// 1634     xASSERT((ulBase == UART0_BASE));
// 1635     xHWREGB(UART0_BASE + UART_0_C5) &= (unsigned char)(~UART_0_C5_RESYNCDIS);
UARTReSyncEnable:
        LDR      R1,??DataTable21_5  ;; 0x4006a00b
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+254
        ANDS     R2,R2,R1
        LDR      R1,??DataTable21_5  ;; 0x4006a00b
        STRB     R2,[R1, #+0]
// 1636 }
        BX       LR               ;; return
// 1637 
// 1638 //*****************************************************************************
// 1639 //
// 1640 //! \brief Disable UART resynchronization function.
// 1641 //!
// 1642 //! \param ulPort is the base address of the UART port.
// 1643 //!
// 1644 //! Disable the resynchronization of the received data word when a data one
// 1645 //! followed by data zero transition is detected.
// 1646 //!
// 1647 //! \note This function is UART0 special function
// 1648 //!
// 1649 //! \return None.
// 1650 //
// 1651 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1652 void UARTReSyncDisable(unsigned long ulBase)
// 1653 {
// 1654     xASSERT((ulBase == UART0_BASE));
// 1655     xHWREGB(UART0_BASE + UART_0_C5) |= (unsigned char)(UART_0_C5_RESYNCDIS);
UARTReSyncDisable:
        LDR      R1,??DataTable21_5  ;; 0x4006a00b
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+1
        ORRS     R2,R2,R1
        LDR      R1,??DataTable21_5  ;; 0x4006a00b
        STRB     R2,[R1, #+0]
// 1656 }
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable18:
        DC32     g_pfnUARTHandlerCallbacks
// 1657 
// 1658 
// 1659 
// 1660 //*****************************************************************************
// 1661 //
// 1662 //! \brief Get 9-th bit of the transmit data.
// 1663 //!
// 1664 //! \param ulPort is the base address of the UART port.
// 1665 //!
// 1666 //! when configure UART to 9bits mode, you can use this function to get 9-th bit.
// 1667 //!
// 1668 //! \note This function is UART0 special function
// 1669 //!
// 1670 //! \return None.
// 1671 //
// 1672 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1673 unsigned char UARTGetBit9(unsigned long ulBase)
// 1674 {
UARTGetBit9:
        PUSH     {R4,LR}
        MOVS     R1,R0
// 1675     unsigned char ulTmp   = 0;
        MOVS     R2,#+0
// 1676     unsigned char ulValue = 0;
        MOVS     R0,#+0
// 1677     xASSERT((ulBase == UART0_BASE) || (ulBase == UART1_BASE) ||
// 1678             (ulBase == UART2_BASE) );
// 1679     ulTmp = xHWREGB(ulBase + UART_012_C3) &
// 1680         (unsigned char)UART_012_C3_R8T9_MASK;
        LDRB     R3,[R1, #+6]
        MOVS     R4,#+128
        ANDS     R3,R3,R4
        MOVS     R2,R3
// 1681     if(0 != ulTmp)
        UXTB     R2,R2
        CMP      R2,#+0
        BEQ      ??UARTGetBit9_0
// 1682     {
// 1683         ulValue = 0x01;
        MOVS     R3,#+1
        MOVS     R0,R3
        B        ??UARTGetBit9_1
// 1684     }
// 1685     else
// 1686     {
// 1687         ulValue = 0x00;
??UARTGetBit9_0:
        MOVS     R3,#+0
        MOVS     R0,R3
// 1688     }
// 1689     return (ulValue);
??UARTGetBit9_1:
        UXTB     R0,R0
        POP      {R4,PC}          ;; return
// 1690 }
// 1691 
// 1692 //*****************************************************************************
// 1693 //
// 1694 //! \brief Get 10-th bit of the transmit data.
// 1695 //!
// 1696 //! \param ulPort is the base address of the UART port.
// 1697 //!
// 1698 //! when configure UART to 10bits mode, you can use this function to get
// 1699 //! 10-th bit.
// 1700 //!
// 1701 //! \note This function is UART0 special function
// 1702 //!
// 1703 //! \return None.
// 1704 //
// 1705 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1706 unsigned char UARTGetBit10(unsigned long ulBase)
// 1707 {
UARTGetBit10:
        PUSH     {R4,LR}
        MOVS     R1,R0
// 1708     
// 1709 
// 1710     unsigned char ulTmp   = 0;
        MOVS     R2,#+0
// 1711     unsigned char ulValue = 0;
        MOVS     R0,#+0
// 1712     xASSERT((ulBase == UART0_BASE));
// 1713     xASSERT((ulBase == UART0_BASE));
// 1714     ulTmp = xHWREGB(UART0_BASE + UART_012_C3) &
// 1715         (unsigned char)UART_012_C3_R9T8_MASK;
        LDR      R3,??DataTable21_6  ;; 0x4006a006
        LDRB     R3,[R3, #+0]
        MOVS     R4,#+64
        ANDS     R3,R3,R4
        MOVS     R2,R3
// 1716 
// 1717     if(0 != ulTmp)
        UXTB     R2,R2
        CMP      R2,#+0
        BEQ      ??UARTGetBit10_0
// 1718     {
// 1719         ulValue = 0x01;
        MOVS     R3,#+1
        MOVS     R0,R3
        B        ??UARTGetBit10_1
// 1720     }
// 1721     else
// 1722     {
// 1723         ulValue = 0x00;
??UARTGetBit10_0:
        MOVS     R3,#+0
        MOVS     R0,R3
// 1724     }
// 1725     return (ulValue);
??UARTGetBit10_1:
        UXTB     R0,R0
        POP      {R4,PC}          ;; return
// 1726 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable19:
        DC32     0x4006c000
// 1727 
// 1728 //*****************************************************************************
// 1729 //
// 1730 //! \brief Set 9-th bit of the transmit data.
// 1731 //!
// 1732 //! \param ulPort is the base address of the UART port.
// 1733 //! \param ulCh is the bit 9 of the send chars.
// 1734 //!
// 1735 //! when configure UART to 9bits mode, you can use this function to set 9-th bit.
// 1736 //!
// 1737 //! \note This function is UART0 special function
// 1738 //!
// 1739 //! \return None.
// 1740 //
// 1741 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1742 void UARTSetBit9(unsigned long ulBase, unsigned char ulCh)
// 1743 {
UARTSetBit9:
        PUSH     {LR}
// 1744     xASSERT((ulBase == UART0_BASE) || (ulBase == UART1_BASE) ||
// 1745             (ulBase == UART2_BASE) );
// 1746     if(0 == ulCh)
        UXTB     R1,R1
        CMP      R1,#+0
        BNE      ??UARTSetBit9_0
// 1747     {
// 1748         xHWREGB(ulBase + UART_012_C3) &=
// 1749             (unsigned char)(~UART_012_C3_R9T8_MASK);
        LDRB     R2,[R0, #+6]
        MOVS     R3,#+191
        ANDS     R3,R3,R2
        STRB     R3,[R0, #+6]
        B        ??UARTSetBit9_1
// 1750     }
// 1751     else
// 1752     {
// 1753         xHWREGB(ulBase + UART_012_C3) |=
// 1754             (unsigned char)(UART_012_C3_R9T8_MASK);
??UARTSetBit9_0:
        LDRB     R2,[R0, #+6]
        MOVS     R3,#+64
        ORRS     R3,R3,R2
        STRB     R3,[R0, #+6]
// 1755     }
// 1756 }
??UARTSetBit9_1:
        POP      {PC}             ;; return
// 1757 
// 1758 //*****************************************************************************
// 1759 //
// 1760 //! \brief Set 10-th bit of the transmit data.
// 1761 //!
// 1762 //! \param ulPort is the base address of the UART port.
// 1763 //! \param ulCh is the bit 10 of the send chars.
// 1764 //!
// 1765 //! when configure UART to 10 bits mode, you can use this function to set 10-th
// 1766 //! bit.
// 1767 //!
// 1768 //! \note This function is UART0 special function
// 1769 //!
// 1770 //! \return None.
// 1771 //
// 1772 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1773 void UARTSetBit10(unsigned long ulBase, unsigned char ulCh)
// 1774 {
UARTSetBit10:
        PUSH     {LR}
// 1775     xASSERT((ulBase == UART0_BASE));
// 1776     if(0 == ulCh)
        UXTB     R1,R1
        CMP      R1,#+0
        BNE      ??UARTSetBit10_0
// 1777     {
// 1778         xHWREGB(UART0_BASE + UART_012_C3) &=
// 1779             (unsigned char)(~UART_012_C3_R8T9_MASK);
        LDR      R2,??DataTable21_6  ;; 0x4006a006
        LDRB     R2,[R2, #+0]
        LSLS     R2,R2,#+25       ;; ZeroExtS R2,R2,#+25,#+25
        LSRS     R2,R2,#+25
        LDR      R3,??DataTable21_6  ;; 0x4006a006
        STRB     R2,[R3, #+0]
        B        ??UARTSetBit10_1
// 1780     }
// 1781     else
// 1782     {
// 1783         xHWREGB(UART0_BASE + UART_012_C3) |=
// 1784             (unsigned char)(UART_012_C3_R8T9_MASK);
??UARTSetBit10_0:
        LDR      R2,??DataTable21_6  ;; 0x4006a006
        LDRB     R2,[R2, #+0]
        MOVS     R3,#+128
        ORRS     R3,R3,R2
        LDR      R2,??DataTable21_6  ;; 0x4006a006
        STRB     R3,[R2, #+0]
// 1785     }
// 1786 }
??UARTSetBit10_1:
        POP      {PC}             ;; return
// 1787 
// 1788 
// 1789 //*****************************************************************************
// 1790 //
// 1791 //! \brief Configure the idle line type.
// 1792 //!
// 1793 //! \param ulPort is the base address of the UART port.
// 1794 //! \param ulConfig is the idle line type.
// 1795 //!
// 1796 //! When configure UART to "after stop" mode, module ensures that stop bits and
// 1797 //! logic 1 bits at the end of a character do not count toward the 10 to 13 bit
// 1798 //! times of logic high level needed by the idle line detection logic.
// 1799 //!
// 1800 //! The \e ulConfig parameter can be one of the following:
// 1801 //! - \b UART_IDLE_TYPE_AFTER_START
// 1802 //! - \b UART_IDLE_TYPE_AFTER_STOP
// 1803 //!
// 1804 //! \return None.
// 1805 //
// 1806 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1807 void UARTIdleLineTypeConfig(unsigned long ulBase, unsigned long ulConfig)
// 1808 {
// 1809     xASSERT((ulBase == UART0_BASE) || (ulBase == UART1_BASE) ||
// 1810             (ulBase == UART2_BASE) );
// 1811     xASSERT(
// 1812             (UART_IDLE_TYPE_AFTER_START == ulConfig) ||
// 1813             (UART_IDLE_TYPE_AFTER_START == ulConfig) );
// 1814 
// 1815     xHWREGB(ulBase + UART_012_C1) &= (unsigned char)(~UART_012_C1_ILT_MASK);
UARTIdleLineTypeConfig:
        LDRB     R2,[R0, #+2]
        MOVS     R3,#+251
        ANDS     R3,R3,R2
        STRB     R3,[R0, #+2]
// 1816     xHWREGB(ulBase + UART_012_C1) |= (unsigned char)(ulConfig);
        LDRB     R2,[R0, #+2]
        MOVS     R3,R1
        ORRS     R3,R3,R2
        STRB     R3,[R0, #+2]
// 1817 
// 1818 }
        BX       LR               ;; return
// 1819 
// 1820 //*****************************************************************************
// 1821 //
// 1822 //! \brief Get the idle line flag.
// 1823 //!
// 1824 //! \param ulBase is the base address of the UART port.
// 1825 //!
// 1826 //! Idle line is set when the UART receive line becomes idles for a full
// 1827 //! character time after a period of activity.
// 1828 //!
// 1829 //! \return Returns the idle line status, can be one of the following:
// 1830 //! - \b xtrue  Idle line was detected.
// 1831 //! - \b xfalse No idle line was detected.
// 1832 //
// 1833 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1834 xtBoolean UARTIdleFlagGet(unsigned long ulBase)
// 1835 {
UARTIdleFlagGet:
        PUSH     {R4,LR}
        MOVS     R1,R0
// 1836     unsigned char ulStatus = 0;
        MOVS     R2,#+0
// 1837     xtBoolean     ulFlag   = xfalse;
        MOVS     R0,#+0
// 1838 
// 1839     xASSERT((ulBase == UART0_BASE) || (ulBase == UART1_BASE) ||
// 1840             (ulBase == UART2_BASE) );
// 1841     ulStatus = xHWREGB(ulBase + UART_012_S1) &
// 1842         (unsigned char)UART_012_S1_IDLE_MASK;
        LDRB     R3,[R1, #+4]
        MOVS     R4,#+16
        ANDS     R3,R3,R4
        MOVS     R2,R3
// 1843     if(0 != ulStatus)
        UXTB     R2,R2
        CMP      R2,#+0
        BEQ      ??UARTIdleFlagGet_0
// 1844     {
// 1845         ulFlag = xtrue;
        MOVS     R3,#+1
        MOVS     R0,R3
        B        ??UARTIdleFlagGet_1
// 1846     }
// 1847     else
// 1848     {
// 1849         ulFlag = xfalse;
??UARTIdleFlagGet_0:
        MOVS     R3,#+0
        MOVS     R0,R3
// 1850     }
// 1851     return (ulFlag);
??UARTIdleFlagGet_1:
        UXTB     R0,R0
        POP      {R4,PC}          ;; return
// 1852 }
// 1853 
// 1854 //*****************************************************************************
// 1855 //
// 1856 //! \brief Clear the idle line flag.
// 1857 //!
// 1858 //! \param ulBase is the base address of the UART port.
// 1859 //!
// 1860 //! To clear idle line flag.
// 1861 //!
// 1862 //! \note After flag has been cleared, it cannot become set again until after
// 1863 //! a new character has been received and receiver data register full. IDLE
// 1864 //! is set only once even if the receive line remains idle for an extended period.
// 1865 //!
// 1866 //! \return None.
// 1867 //
// 1868 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1869 void UARTIdleFlagClear(unsigned long ulBase)
// 1870 {
UARTIdleFlagClear:
        PUSH     {LR}
// 1871     xASSERT((ulBase == UART0_BASE) || (ulBase == UART1_BASE) ||
// 1872             (ulBase == UART2_BASE) );
// 1873     switch(ulBase)
        MOVS     R1,R0
        LDR      R2,??DataTable21_7  ;; 0x4006a000
        CMP      R1,R2
        BEQ      ??UARTIdleFlagClear_0
        LDR      R2,??DataTable21_8  ;; 0x4006b000
        CMP      R1,R2
        BEQ      ??UARTIdleFlagClear_1
        LDR      R2,??DataTable21  ;; 0x4006c000
        CMP      R1,R2
        BEQ      ??UARTIdleFlagClear_1
        B        ??UARTIdleFlagClear_2
// 1874     {
// 1875         case UART0_BASE:
// 1876             {
// 1877                 xHWREGB(UART0_BASE + UART_012_S1) |=
// 1878                     (unsigned char)UART_012_S1_IDLE_MASK;
??UARTIdleFlagClear_0:
        LDR      R1,??DataTable21_9  ;; 0x4006a004
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+16
        ORRS     R2,R2,R1
        LDR      R1,??DataTable21_9  ;; 0x4006a004
        STRB     R2,[R1, #+0]
// 1879                 break;
        B        ??UARTIdleFlagClear_2
// 1880             }
// 1881         case UART1_BASE:
// 1882         case UART2_BASE:
// 1883             {
// 1884                 (void)xHWREGB(UART0_BASE + UART_012_S1);
??UARTIdleFlagClear_1:
        LDR      R1,??DataTable21_9  ;; 0x4006a004
        LDRB     R1,[R1, #+0]
// 1885                 (void)xHWREGB(UART0_BASE + UART_012_D);
        LDR      R2,??DataTable21_10  ;; 0x4006a007
        LDRB     R2,[R2, #+0]
// 1886                 break;
// 1887             }
// 1888     }
// 1889 }
??UARTIdleFlagClear_2:
        POP      {PC}             ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable21:
        DC32     0x4006c000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable21_1:
        DC32     0x4006a005

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable21_2:
        DC32     0x4006a008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable21_3:
        DC32     0x4006a009

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable21_4:
        DC32     0x4006a00a

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable21_5:
        DC32     0x4006a00b

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable21_6:
        DC32     0x4006a006

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable21_7:
        DC32     0x4006a000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable21_8:
        DC32     0x4006b000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable21_9:
        DC32     0x4006a004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable21_10:
        DC32     0x4006a007
// 1890 
// 1891 
// 1892 //*****************************************************************************
// 1893 //
// 1894 //! \brief Send queued idle characters.
// 1895 //!
// 1896 //! \param ulBase is the base address of the UART port.
// 1897 //!
// 1898 //! \return None.
// 1899 //
// 1900 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1901 void UARTIdleSend(unsigned long ulBase)
// 1902 {
UARTIdleSend:
        PUSH     {LR}
// 1903     //
// 1904     // Wait until Transmit Register available
// 1905     //
// 1906     while(0 == (xHWREGB(ulBase + UART_012_S1) & UART_012_S1_TDRE_MASK));
??UARTIdleSend_0:
        LDRB     R1,[R0, #+4]
        LSLS     R1,R1,#+24
        BPL      ??UARTIdleSend_0
// 1907 
// 1908     xHWREGB(ulBase + UART_012_C2) |= (unsigned char)(UART_012_C2_TE_MASK);
        LDRB     R1,[R0, #+3]
        MOVS     R2,#+8
        ORRS     R2,R2,R1
        STRB     R2,[R0, #+3]
// 1909     xHWREGB(ulBase + UART_012_C2) &= (unsigned char)(~UART_012_C2_TE_MASK);
        LDRB     R1,[R0, #+3]
        MOVS     R2,#+247
        ANDS     R2,R2,R1
        STRB     R2,[R0, #+3]
// 1910 }
        POP      {PC}             ;; return

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        END
// 1911 
// 
//    12 bytes in section .bss
// 2 072 bytes in section .text
// 
// 2 072 bytes of CODE memory
//    12 bytes of DATA memory
//
//Errors: none
//Warnings: 1
