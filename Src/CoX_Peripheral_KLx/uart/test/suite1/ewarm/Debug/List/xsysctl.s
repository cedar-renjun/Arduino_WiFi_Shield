///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.40.1.53790/W32 for ARM    24/Feb/2013  09:52:15 /
// Copyright 1999-2012 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  C:\Users\renjun\Desktop\Cox\CoX_Peripheral\CoX_Peripher /
//                    al_KLx\libcox\xsysctl.c                                 /
//    Command line =  C:\Users\renjun\Desktop\Cox\CoX_Peripheral\CoX_Peripher /
//                    al_KLx\libcox\xsysctl.c -D ewarm -lCN                   /
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
//                    al_KLx\uart\test\suite1\ewarm\Debug\List\xsysctl.s      /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME xsysctl

        #define SHT_PROGBITS 0x1

        EXTERN __aeabi_uidiv
        EXTERN __aeabi_uidivmod
        EXTERN xCPUwfi

        PUBLIC SysCtlBandgapBufferEnable
        PUBLIC SysCtlBandgapEnable
        PUBLIC SysCtlBusClkGet
        PUBLIC SysCtlBusClkSet
        PUBLIC SysCtlClkOututSrcSet
        PUBLIC SysCtlDeepSleep
        PUBLIC SysCtlDelay
        PUBLIC SysCtlHClockGet
        PUBLIC SysCtlHClockSet
        PUBLIC SysCtlHClockSourceSet
        PUBLIC SysCtlLVDEventFlagClear
        PUBLIC SysCtlLVDEventFlagGet
        PUBLIC SysCtlLVDIntEnable
        PUBLIC SysCtlLVDResetEnable
        PUBLIC SysCtlLVDVolSet
        PUBLIC SysCtlLVDWaringFlagGet
        PUBLIC SysCtlLVDWarningFlagClear
        PUBLIC SysCtlLVDWarningIntEnable
        PUBLIC SysCtlLVDWarningVolSet
        PUBLIC SysCtlPWMAndUART0ClkGet
        PUBLIC SysCtlPeripheralClockSourceSet
        PUBLIC SysCtlPeripheralDisable
        PUBLIC SysCtlPeripheralEnable
        PUBLIC SysCtlPowerModeGet
        PUBLIC SysCtlRegulatorStatusGet
        PUBLIC SysCtlResetPinFilterBusClkWidthSet
        PUBLIC SysCtlResetPinFilterRunModeSelect
        PUBLIC SysCtlResetPinFilterStopModeEnable
        PUBLIC SysCtlResetSrcGet
        PUBLIC SysCtlSleep
        PUBLIC SysCtlStopModeSet
        PUBLIC SysCtlVeryLowPowerRunModeEnable
        PUBLIC SysCtlWakeupFilterConfig
        PUBLIC SysCtlWakeupModuleEnable
        PUBLIC SysCtlWakeupModuleFlagGet
        PUBLIC SysCtlWakeupPinConfig
        PUBLIC SysCtlWakeupPinFilterFlagGet
        PUBLIC SysCtlWakeupPinFlagGet
        PUBLIC xSysCtlClockSet
        PUBLIC xSysCtlPeripheraIntNumGet
        PUBLIC xSysCtlPeripheralClockSourceSet
        PUBLIC xSysCtlPeripheralDisable2
        PUBLIC xSysCtlPeripheralEnable2

// C:\Users\renjun\Desktop\Cox\CoX_Peripheral\CoX_Peripheral_KLx\libcox\xsysctl.c
//    1 //*****************************************************************************
//    2 //
//    3 //! \file xsysctl.c
//    4 //! \brief Driver for the system controller
//    5 //! \version V2.2.1.0
//    6 //! \date 8/7/2012
//    7 //! \author CooCox
//    8 //! \copy
//    9 //!
//   10 //! Copyright (c)  2011, CooCox 
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
//   39 #include "xhw_types.h"
//   40 #include "xhw_ints.h"
//   41 #include "xhw_memmap.h"
//   42 #include "xhw_nvic.h"
//   43 #include "xhw_sysctl.h"
//   44 #include "xhw_gpio.h"
//   45 #include "xhw_adc.h"
//   46 #include "xdebug.h"
//   47 #include "xsysctl.h"
//   48 #include "xcore.h"
//   49 
//   50 
//   51 

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   52 static unsigned long s_ulExtClockMHz = 8;
s_ulExtClockMHz:
        DATA
        DC32 8
//   53 
//   54 //*****************************************************************************
//   55 //
//   56 // This macro extracts the array index out of the peripheral number for enable.
//   57 //
//   58 //*****************************************************************************
//   59 #define SYSCTL_PERIPH_INDEX_E(a)(((a) >> 14) & 0x3)
//   60 
//   61 //*****************************************************************************
//   62 //
//   63 // This macro constructs the peripheral bit mask from the peripheral number for 
//   64 // enable.
//   65 //
//   66 //*****************************************************************************
//   67 #define SYSCTL_PERIPH_MASK_E(a) (((a) & 0xff) << (((a) & 0x1f00) >> 8))
//   68 
//   69 //*****************************************************************************
//   70 //
//   71 // An array that maps the "peripheral set" number (which is stored in the upper
//   72 // nibble of the SYSCTL_PERIPH_* defines) to the SYSCLK_AHBCLK register that
//   73 // controls the run-mode enable for that peripheral.
//   74 //
//   75 //*****************************************************************************

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
//   76 static const unsigned long g_pulAXBCLKRegs[] =
g_pulAXBCLKRegs:
        DATA
        DC32 1074036788, 1074036792, 1074036796, 1074036800
//   77 {
//   78     SIM_SCGC4,
//   79     SIM_SCGC5,
//   80     SIM_SCGC6,
//   81     SIM_SCGC7
//   82 };
//   83 
//   84 //*****************************************************************************
//   85 //
//   86 //! Peripheral Base and ID Table structure type
//   87 //
//   88 //*****************************************************************************
//   89 typedef struct 
//   90 {
//   91     unsigned long ulPeripheralBase;
//   92     unsigned long ulPeripheralID;
//   93     unsigned long ulPeripheralIntNum;
//   94 }
//   95 tPeripheralTable;
//   96 
//   97 //*****************************************************************************
//   98 //
//   99 // An array that maps the peripheral base and peripheral ID and interrupt number
//  100 // together to enablea peripheral or peripheral interrupt by a peripheral base.
//  101 //
//  102 //*****************************************************************************

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
//  103 static const tPeripheralTable g_pPeripherals[] =
g_pPeripherals:
        DATA
        DC32 1074786304, 18434, 46, 1074786496, 18448, 47, 1074176000, 2561, 28
        DC32 1074180096, 2562, 29, 1074184192, 2564, 30, 1073971200, 37248, 33
        DC32 1073975296, 37504, 34, 1073979392, 37760, 35, 1074225152, 5633, 26
        DC32 1074229248, 5634, 27, 1074159616, 64, 24, 1074163712, 128, 25
        DC32 1073983488, 38016, 31, 1074212864, 3856, 32, 1073971200, 37248, 33
        DC32 1073975296, 37504, 34, 1073979392, 37760, 35, 0, 0, 0
//  104 {
//  105     {xGPIO_PORTA_BASE, xSYSCTL_PERIPH_GPIOA, INT_PORTA},
//  106     {xGPIO_PORTD_BASE, xSYSCTL_PERIPH_GPIOD, INT_PORTD},
//  107     {xUART0_BASE,      xSYSCTL_PERIPH_UART0, INT_UART0SE},
//  108     {xUART1_BASE,      xSYSCTL_PERIPH_UART1, INT_UART1SE},
//  109     {xUART2_BASE,      xSYSCTL_PERIPH_UART2, INT_UART2SE},
//  110     {xTIMER0_BASE,     xSYSCTL_PERIPH_TIMER0, INT_FTM0},
//  111     {xTIMER1_BASE,     xSYSCTL_PERIPH_TIMER1, INT_FTM1},
//  112     {xTIMER2_BASE,     xSYSCTL_PERIPH_TIMER2, INT_FTM2},
//  113     {xSPI0_BASE,       xSYSCTL_PERIPH_SPI0, INT_SPI0},
//  114     {xSPI1_BASE,       xSYSCTL_PERIPH_SPI1, INT_SPI1},
//  115     {xI2C0_BASE,       xSYSCTL_PERIPH_I2C0, INT_I2C0},
//  116     {xI2C1_BASE,       xSYSCTL_PERIPH_I2C1, INT_I2C1},
//  117     {xADC0_BASE,       xSYSCTL_PERIPH_ADC0, INT_ADC},
//  118     {xACMP0_BASE,      xSYSCTL_PERIPH_ACMP0, INT_ACMP},
//  119     {xPWMA_BASE,       xSYSCTL_PERIPH_PWMA, xINT_PWMA},
//  120     {xPWMB_BASE,       xSYSCTL_PERIPH_PWMB, xINT_PWMB},
//  121     {xPWMC_BASE,       xSYSCTL_PERIPH_PWMC, xINT_PWMC},
//  122     {0,                0,                   0},
//  123 };
//  124     
//  125                                 
//  126 //*****************************************************************************
//  127 //
//  128 //! \brief Provides a small delay.
//  129 //!
//  130 //! \param ulCount is the number of delay loop iterations to perform.
//  131 //!
//  132 //! This function provides a means of generating a constant length delay.  It
//  133 //! is written in assembly to keep the delay consistent across tool chains,
//  134 //! avoiding the need to tune the delay based on the tool chain in use.
//  135 //!
//  136 //! The loop takes 3 cycles/loop.
//  137 //!
//  138 //! \return None.
//  139 //
//  140 //*****************************************************************************
//  141 #if defined(gcc) || defined(__GNUC__)
//  142 void __attribute__((naked))
//  143 SysCtlDelay(unsigned long ulCount)
//  144 {
//  145     __asm("    sub     r0, #1\n"
//  146           "    bne     SysCtlDelay\n"
//  147           "    bx      lr");
//  148 }
//  149 #endif
//  150 #if defined(ewarm) || defined(__ICCARM__)

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  151 void
//  152 SysCtlDelay(unsigned long ulCount)
//  153 {
//  154     __asm("    subs    r0, #1\n"
//  155           "    bne.n   SysCtlDelay\n"
//  156           "    bx      lr");
SysCtlDelay:
        subs    r0, #1
        bne.n   SysCtlDelay
        bx      lr
//  157 }
        BX       LR               ;; return
//  158 #endif
//  159 #if defined(rvmdk) || defined(__CC_ARM)
//  160 __asm void
//  161 SysCtlDelay(unsigned long ulCount)
//  162 {
//  163     subs    r0, #1;
//  164     bne     SysCtlDelay;
//  165     bx      lr;
//  166 }
//  167 #endif
//  168 
//  169 //*****************************************************************************
//  170 //
//  171 //! \internal
//  172 //! \brief Checks a peripheral identifier.
//  173 //!
//  174 //! \param ulPeripheral is the peripheral identifier.
//  175 //!
//  176 //! This function determines if a peripheral identifier is valid.
//  177 //!
//  178 //! \return Returns \b true if the peripheral identifier is valid and \b false
//  179 //! otherwise.
//  180 //
//  181 //*****************************************************************************
//  182 #ifdef xDEBUG
//  183 static xtBoolean
//  184 SysCtlPeripheralValid(unsigned long ulPeripheral)
//  185 {
//  186     return((ulPeripheral == SYSCTL_PERIPH_DMA) ||
//  187            (ulPeripheral == SYSCTL_PERIPH_RTC) ||
//  188            (ulPeripheral == SYSCTL_PERIPH_TSI) ||
//  189            (ulPeripheral == SYSCTL_PERIPH_ADC) ||
//  190            (ulPeripheral == SYSCTL_PERIPH_PIT) ||
//  191            (ulPeripheral == SYSCTL_PERIPH_TMR0) ||
//  192            (ulPeripheral == SYSCTL_PERIPH_TMR1) ||
//  193            (ulPeripheral == SYSCTL_PERIPH_TMR2) ||
//  194            (ulPeripheral == SYSCTL_PERIPH_I2C0) ||
//  195            (ulPeripheral == SYSCTL_PERIPH_I2C1) ||
//  196            (ulPeripheral == SYSCTL_PERIPH_SPI0) ||
//  197            (ulPeripheral == SYSCTL_PERIPH_SPI1) ||
//  198            (ulPeripheral == SYSCTL_PERIPH_DAC)  ||
//  199            (ulPeripheral == SYSCTL_PERIPH_PWMA) ||
//  200            (ulPeripheral == SYSCTL_PERIPH_PWMB) ||
//  201            (ulPeripheral == SYSCTL_PERIPH_PWMC) ||
//  202            (ulPeripheral == SYSCTL_PERIPH_USB)  ||
//  203            (ulPeripheral == SYSCTL_PERIPH_ACMP) ||
//  204            (ulPeripheral == SYSCTL_PERIPH_UART0) ||
//  205            (ulPeripheral == SYSCTL_PERIPH_UART1) ||
//  206            (ulPeripheral == SYSCTL_PERIPH_UART2) ||
//  207            (ulPeripheral == SYSCTL_PERIPH_GPIOA) ||
//  208            (ulPeripheral == SYSCTL_PERIPH_GPIOB) ||
//  209            (ulPeripheral == SYSCTL_PERIPH_GPIOC) ||
//  210            (ulPeripheral == SYSCTL_PERIPH_GPIOD) ||
//  211            (ulPeripheral == SYSCTL_PERIPH_GPIOE) ||
//  212            (ulPeripheral == SYSCTL_PERIPH_LPTMR) ||
//  213            (ulPeripheral == SYSCTL_PERIPH_DMAMUX));
//  214 }
//  215 #endif
//  216 
//  217 //*****************************************************************************
//  218 //
//  219 //! \brief Sets the clock of the device.
//  220 //!
//  221 //! \param ulSysClk is the clock rate you will set.
//  222 //! \param ulConfig is the required configuration of the device clock.
//  223 //!
//  224 //! This function configures the clock of the device.  The input crystal
//  225 //! frequency, oscillator to be used, use of the PLL, and the system clock
//  226 //! divider are all configured with this function.
//  227 //!
//  228 //! The \e ulConfig parameter is the logical OR of several different values,
//  229 //! many of which are grouped into sets where only one can be chosen.
//  230 //!
//  231 //! The external crystal frequency is chosen with one of the following values:
//  232 //! \ref xSYSCTL_XTAL_3MHZ, \ref xSYSCTL_XTAL_4MHZ, \ref xSYSCTL_XTAL_5MHZ,
//  233 //! \ref xSYSCTL_XTAL_32MHZ.
//  234 //!
//  235 //! The oscillator source is chosen with one of the following values:
//  236 //! \ref xSYSCTL_OSC_MAIN, \ref xSYSCTL_OSC_INTSL.
//  237 //!
//  238 //! The external oscillator must be enabled in order to use an external clock
//  239 //! source.  Note that attempts to disable the oscillator used to clock the
//  240 //! device will be prevented by the hardware.
//  241 //! <br />
//  242 //! Details please refer to \ref xSysCtl_Clock_Set_Config.
//  243 //!
//  244 //! \note The ulSysClk should be between 31250 and 39063 Hz
//  245 //! if the ulConfig is xSYSCTL_OSC_INTSL.
//  246 //!
//  247 //! \return None.
//  248 //
//  249 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  250 void
//  251 xSysCtlClockSet(unsigned long ulSysClk, unsigned long ulConfig)
//  252 {
xSysCtlClockSet:
        PUSH     {R1,R4-R7,LR}
        SUB      SP,SP,#+8
        MOVS     R7,R0
//  253     unsigned long ulOscFreq, ulSysDiv, i, ulTemp;
//  254     
//  255     unsigned char ucTempReg = 0;
        MOVS     R5,#+0
//  256     xASSERT((ulSysClk > 0 && ulSysClk <= 48000000));
//  257     //
//  258     // Calc oscillator freq
//  259     //
//  260     s_ulExtClockMHz = ((ulConfig & SYSCTL_XTAL_MASK) >> 8);
        LDR      R0,[SP, #+8]
        LSRS     R0,R0,#+8
        UXTB     R0,R0
        LDR      R1,??DataTable2
        STR      R0,[R1, #+0]
//  261     ulSysDiv = 0;
        MOVS     R0,#+0
        MOVS     R6,R0
//  262     ulOscFreq = s_ulExtClockMHz*1000000;
        LDR      R0,??DataTable2
        LDR      R0,[R0, #+0]
        LDR      R1,??DataTable3  ;; 0xf4240
        MULS     R0,R1,R0
        STR      R0,[SP, #+0]
//  263 
//  264     switch(ulConfig & SYSCTL_OSCSRC_M)
        LDR      R0,[SP, #+8]
        MOVS     R1,#+192
        ANDS     R1,R1,R0
        CMP      R1,#+64
        BNE      .+4
        B        ??xSysCtlClockSet_0
        CMP      R1,#+128
        BEQ      .+4
        B        ??xSysCtlClockSet_1
//  265     {
//  266         case xSYSCTL_OSC_MAIN:
//  267         {
//  268             xHWREG(SIM_CLKDIV1) &= ~SIM_CLKDIV1_OUTDIV1_M;
??xSysCtlClockSet_2:
        LDR      R0,??DataTable3_1  ;; 0x40048044
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+4        ;; ZeroExtS R0,R0,#+4,#+4
        LSRS     R0,R0,#+4
        LDR      R1,??DataTable3_1  ;; 0x40048044
        STR      R0,[R1, #+0]
//  269             xHWREG(SIM_CLKDIV1) &= ~SIM_CLKDIV1_OUTDIV4_M;
        LDR      R0,??DataTable3_1  ;; 0x40048044
        LDR      R0,[R0, #+0]
        LDR      R1,??DataTable3_2  ;; 0xfff8ffff
        ANDS     R1,R1,R0
        LDR      R0,??DataTable3_1  ;; 0x40048044
        STR      R1,[R0, #+0]
//  270             xHWREG(SIM_CLKDIV1) |= SIM_CLKDIV1_OUTDIV4_2;
        LDR      R0,??DataTable3_1  ;; 0x40048044
        LDR      R0,[R0, #+0]
        MOVS     R1,#+128
        LSLS     R1,R1,#+9        ;; #+65536
        ORRS     R1,R1,R0
        LDR      R0,??DataTable3_1  ;; 0x40048044
        STR      R1,[R0, #+0]
//  271 
//  272             if(!((((xHWREGB(MCG_S) & MCG_S_CLKST_M) >> MCG_S_CLKST_S) == 0x0) &&
//  273               (xHWREGB(MCG_S) & MCG_S_IREFST) &&
//  274               (!(xHWREGB(MCG_S) & MCG_S_PLLST))))                                
        LDR      R0,??DataTable3_3  ;; 0x40064006
        LDRB     R0,[R0, #+0]
        UXTB     R0,R0
        ASRS     R0,R0,#+2
        LSLS     R0,R0,#+30       ;; ZeroExtS R0,R0,#+30,#+30
        LSRS     R0,R0,#+30
        CMP      R0,#+0
        BNE      ??xSysCtlClockSet_3
        LDR      R0,??DataTable3_3  ;; 0x40064006
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+27
        BPL      ??xSysCtlClockSet_3
        LDR      R0,??DataTable3_3  ;; 0x40064006
        LDRB     R0,[R0, #+0]
//  275             {
//  276             }
//  277            
//  278             ucTempReg = xHWREGB(MCG_C2);
??xSysCtlClockSet_3:
        LDR      R0,??DataTable3_4  ;; 0x40064001
        LDRB     R0,[R0, #+0]
        MOVS     R5,R0
//  279             ucTempReg &= ~(MCG_C2_RANGE0_M | MCG_C2_HGO0 | MCG_C2_EREFS0);
        MOVS     R0,R5
        MOVS     R5,#+195
        ANDS     R5,R5,R0
//  280             ucTempReg |= (MCG_C2_RANGE0_HIGH | MCG_C2_EREFS0); 
        MOVS     R0,R5
        MOVS     R5,#+20
        ORRS     R5,R5,R0
//  281             xHWREGB(MCG_C2) = ucTempReg;
        LDR      R0,??DataTable3_4  ;; 0x40064001
        STRB     R5,[R0, #+0]
//  282 
//  283             ucTempReg = xHWREGB(MCG_C1);
        LDR      R0,??DataTable3_5  ;; 0x40064000
        LDRB     R0,[R0, #+0]
        MOVS     R5,R0
//  284             ucTempReg &= ~(MCG_C1_SRC_MCGOUTCLK_M | MCG_C1_FRDIV_M | MCG_C1_IREFS);
        LSLS     R5,R5,#+30       ;; ZeroExtS R5,R5,#+30,#+30
        LSRS     R5,R5,#+30
//  285             ucTempReg |= (MCG_C1_SRC_MCGOUTCLK_EXTERAL | MCG_C1_FRDIV_256); 
        MOVS     R0,R5
        MOVS     R5,#+152
        ORRS     R5,R5,R0
//  286             xHWREGB(MCG_C1) = ucTempReg;
        LDR      R0,??DataTable3_5  ;; 0x40064000
        STRB     R5,[R0, #+0]
//  287 
//  288             for (i = 0 ; i < 20000 ; i++)
        MOVS     R0,#+0
        MOVS     R4,R0
??xSysCtlClockSet_4:
        LDR      R0,??DataTable3_6  ;; 0x4e20
        CMP      R4,R0
        BCS      ??xSysCtlClockSet_5
//  289             {
//  290                 if(xHWREGB(MCG_S) & MCG_S_OSCINIT0)
        LDR      R0,??DataTable3_3  ;; 0x40064006
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+30
        BMI      ??xSysCtlClockSet_5
//  291                 {
//  292                     //
//  293                     // jump out early if OSCINIT sets before loop finishes
//  294                     //
//  295                     break;
//  296                 }
//  297             }
??xSysCtlClockSet_6:
        ADDS     R4,R4,#+1
        B        ??xSysCtlClockSet_4
//  298             //
//  299             // wait for Reference clock Status bit to clear
//  300             //
//  301             for (i = 0 ; i < 20000 ; i++)
??xSysCtlClockSet_5:
        MOVS     R0,#+0
        MOVS     R4,R0
??xSysCtlClockSet_7:
        LDR      R0,??DataTable3_6  ;; 0x4e20
        CMP      R4,R0
        BCS      ??xSysCtlClockSet_8
//  302             {
//  303                 if(xHWREGB(MCG_S) & MCG_S_IREFST)
        LDR      R0,??DataTable3_3  ;; 0x40064006
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+27
        BMI      ??xSysCtlClockSet_8
//  304                 {
//  305                     //
//  306                     // jump out early if OSCINIT sets before loop finishes
//  307                     //
//  308                     break; 
//  309                 }
//  310             }
??xSysCtlClockSet_9:
        ADDS     R4,R4,#+1
        B        ??xSysCtlClockSet_7
//  311 
//  312             //
//  313             // Wait for clock status bits to show clock source is ext ref clk
//  314             //
//  315             for (i = 0 ; i < 20000 ; i++)
??xSysCtlClockSet_8:
        MOVS     R0,#+0
        MOVS     R4,R0
??xSysCtlClockSet_10:
        LDR      R0,??DataTable3_6  ;; 0x4e20
        CMP      R4,R0
        BCS      ??xSysCtlClockSet_11
//  316             {
//  317                 if((xHWREGB(MCG_S) & MCG_S_CLKST_M)==MCG_S_CLKST_EXT)
        LDR      R0,??DataTable3_3  ;; 0x40064006
        LDRB     R0,[R0, #+0]
        UXTB     R0,R0
        MOVS     R1,#+12
        ANDS     R1,R1,R0
        CMP      R1,#+8
        BEQ      ??xSysCtlClockSet_11
//  318                 {
//  319                     //
//  320                     // jump out early if CLKST shows EXT CLK slected before loop finishes
//  321                     //
//  322                     break;
//  323                 }
//  324             }
??xSysCtlClockSet_12:
        ADDS     R4,R4,#+1
        B        ??xSysCtlClockSet_10
//  325 
//  326             xHWREGB(MCG_C6) |= MCG_C6_CME0;
??xSysCtlClockSet_11:
        LDR      R0,??DataTable3_7  ;; 0x40064005
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+32
        ORRS     R1,R1,R0
        LDR      R0,??DataTable3_7  ;; 0x40064005
        STRB     R1,[R0, #+0]
//  327 
//  328             ucTempReg = xHWREGB(MCG_C5);
        LDR      R0,??DataTable3_8  ;; 0x40064004
        LDRB     R0,[R0, #+0]
        MOVS     R5,R0
//  329             ucTempReg &= ~(MCG_C5_PRDIV0_M);
        MOVS     R0,R5
        MOVS     R5,#+224
        ANDS     R5,R5,R0
//  330             ulTemp = ulSysClk/1000000;
        MOVS     R0,R7
        LDR      R1,??DataTable3  ;; 0xf4240
        BL       __aeabi_uidiv
        STR      R0,[SP, #+4]
//  331             ulSysDiv = 192/ulTemp;
        MOVS     R0,#+192
        LDR      R1,[SP, #+4]
        BL       __aeabi_uidiv
        MOVS     R6,R0
//  332             if(ulSysDiv >= 24)
        CMP      R6,#+24
        BCC      ??xSysCtlClockSet_13
//  333             {
//  334                 ulSysDiv = 24;
        MOVS     R0,#+24
        MOVS     R6,R0
//  335             }
//  336             ucTempReg |= (ulSysDiv-1); 
??xSysCtlClockSet_13:
        MOVS     R1,R5
        MOVS     R0,R6
        SUBS     R5,R0,#+1
        ORRS     R5,R5,R1
//  337             xHWREGB(MCG_C5) = ucTempReg;
        LDR      R0,??DataTable3_8  ;; 0x40064004
        STRB     R5,[R0, #+0]
//  338 
//  339             ucTempReg = xHWREGB(MCG_C6);
        LDR      R0,??DataTable3_7  ;; 0x40064005
        LDRB     R0,[R0, #+0]
        MOVS     R5,R0
//  340             ucTempReg &= ~(MCG_C6_VDIV0_M);
        MOVS     R0,R5
        MOVS     R5,#+224
        ANDS     R5,R5,R0
//  341             ucTempReg |= (MCG_C6_PLLS | MCG_C6_VDIV0_24); 
        MOVS     R0,R5
        MOVS     R5,#+64
        ORRS     R5,R5,R0
//  342             xHWREGB(MCG_C6) = ucTempReg;
        LDR      R0,??DataTable3_7  ;; 0x40064005
        STRB     R5,[R0, #+0]
//  343             
//  344             //
//  345             // wait for PLLST status bit to set
//  346             //
//  347             for(i = 0 ; i < 2000 ; i++)
        MOVS     R0,#+0
        MOVS     R4,R0
??xSysCtlClockSet_14:
        MOVS     R0,#+250
        LSLS     R0,R0,#+3        ;; #+2000
        CMP      R4,R0
        BCS      ??xSysCtlClockSet_15
//  348             {
//  349                 if(xHWREGB(MCG_S) & MCG_S_PLLST)
        LDR      R0,??DataTable3_3  ;; 0x40064006
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+26
        BMI      ??xSysCtlClockSet_15
//  350                 {
//  351                     //
//  352                     // jump out early if PLLST sets before loop finishes
//  353                     //
//  354                     break; 
//  355                 }
//  356             }
??xSysCtlClockSet_16:
        ADDS     R4,R4,#+1
        B        ??xSysCtlClockSet_14
//  357             //
//  358             // Wait for LOCK bit to set
//  359             //
//  360             for (i = 0 ; i < 4000 ; i++)
??xSysCtlClockSet_15:
        MOVS     R0,#+0
        MOVS     R4,R0
??xSysCtlClockSet_17:
        MOVS     R0,#+250
        LSLS     R0,R0,#+4        ;; #+4000
        CMP      R4,R0
        BCS      ??xSysCtlClockSet_18
//  361             {
//  362                 if(xHWREGB(MCG_S)&MCG_S_LOCK0)
        LDR      R0,??DataTable3_3  ;; 0x40064006
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+25
        BMI      ??xSysCtlClockSet_18
//  363                 {
//  364                     //
//  365                     // jump out early if LOCK sets before loop finishes
//  366                     //
//  367                     break;
//  368                 }
//  369             }
??xSysCtlClockSet_19:
        ADDS     R4,R4,#+1
        B        ??xSysCtlClockSet_17
//  370 
//  371             SysCtlHClockSourceSet(SYSCTL_HLCK_S_PLL);
??xSysCtlClockSet_18:
        MOVS     R0,#+0
        BL       SysCtlHClockSourceSet
//  372 
//  373             //
//  374             // Wait for clock status bits to update
//  375             //
//  376             for (i = 0 ; i < 2000 ; i++)
        MOVS     R0,#+0
        MOVS     R4,R0
??xSysCtlClockSet_20:
        MOVS     R0,#+250
        LSLS     R0,R0,#+3        ;; #+2000
        CMP      R4,R0
        BCS      ??xSysCtlClockSet_21
//  377             {
//  378                 if((xHWREGB(MCG_S) & MCG_S_CLKST_PLL) == MCG_S_CLKST_PLL)
        LDR      R0,??DataTable3_3  ;; 0x40064006
        LDRB     R0,[R0, #+0]
        UXTB     R0,R0
        MOVS     R1,#+12
        ANDS     R1,R1,R0
        CMP      R1,#+12
        BEQ      ??xSysCtlClockSet_21
//  379                 {
//  380                     break; // jump out early if CLKST = 3 before loop finishes            
//  381                 }
//  382 
//  383             }
??xSysCtlClockSet_22:
        ADDS     R4,R4,#+1
        B        ??xSysCtlClockSet_20
//  384             //
//  385             // set PLLFLLSEL to select the PLL for this clock source
//  386             //
//  387             xHWREG(SIM_SOPT2) |= SIM_SOPT2_PLLFLLSEL;
??xSysCtlClockSet_21:
        LDR      R0,??DataTable3_9  ;; 0x40048004
        LDR      R0,[R0, #+0]
        MOVS     R1,#+128
        LSLS     R1,R1,#+9        ;; #+65536
        ORRS     R1,R1,R0
        LDR      R0,??DataTable3_9  ;; 0x40048004
        STR      R1,[R0, #+0]
//  388 
//  389             if (ulSysClk < ulOscFreq)
        LDR      R0,[SP, #+0]
        CMP      R7,R0
        BCS      ??xSysCtlClockSet_23
//  390             {
//  391                 //
//  392                 // Calc the SysDiv
//  393                 //    
//  394                 xASSERT(ulSysClk <= ulOscFreq);
//  395             
//  396                 for(ulSysDiv = 1; ulSysDiv < 16; ulSysDiv++)
        MOVS     R0,#+1
        MOVS     R6,R0
??xSysCtlClockSet_24:
        CMP      R6,#+16
        BCS      ??xSysCtlClockSet_25
//  397                 {
//  398                     if((ulOscFreq / (ulSysDiv + 1)) <= ulSysClk)
        LDR      R0,[SP, #+0]
        MOVS     R1,R6
        ADDS     R1,R1,#+1
        BL       __aeabi_uidiv
        CMP      R7,R0
        BCS      ??xSysCtlClockSet_25
//  399                     {
//  400                         break;
//  401                     }
//  402                 }
??xSysCtlClockSet_26:
        ADDS     R6,R6,#+1
        B        ??xSysCtlClockSet_24
//  403                 xHWREG(SIM_CLKDIV1) &= ~SIM_CLKDIV1_OUTDIV1_M;
??xSysCtlClockSet_25:
        LDR      R0,??DataTable3_1  ;; 0x40048044
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+4        ;; ZeroExtS R0,R0,#+4,#+4
        LSRS     R0,R0,#+4
        LDR      R1,??DataTable3_1  ;; 0x40048044
        STR      R0,[R1, #+0]
//  404                 xHWREG(SIM_CLKDIV1) |= (ulSysDiv << SIM_CLKDIV1_OUTDIV1_S);
        LDR      R0,??DataTable3_1  ;; 0x40048044
        LDR      R0,[R0, #+0]
        LSLS     R1,R6,#+28
        ORRS     R1,R1,R0
        LDR      R0,??DataTable3_1  ;; 0x40048044
        STR      R1,[R0, #+0]
//  405             }
//  406             break;
??xSysCtlClockSet_23:
        B        ??xSysCtlClockSet_27
//  407         }
//  408         case xSYSCTL_OSC_INTSL:
//  409         {
//  410             if(!((((xHWREGB(MCG_S) & MCG_S_CLKST_M) >> MCG_S_CLKST_S) == 0x0) &&
//  411               (xHWREGB(MCG_S) & MCG_S_IREFST) &&
//  412               (!(xHWREGB(MCG_S) & MCG_S_PLLST))))                                
??xSysCtlClockSet_0:
        LDR      R0,??DataTable3_3  ;; 0x40064006
        LDRB     R0,[R0, #+0]
        UXTB     R0,R0
        ASRS     R0,R0,#+2
        LSLS     R0,R0,#+30       ;; ZeroExtS R0,R0,#+30,#+30
        LSRS     R0,R0,#+30
        CMP      R0,#+0
        BNE      ??xSysCtlClockSet_28
        LDR      R0,??DataTable3_3  ;; 0x40064006
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+27
        BPL      ??xSysCtlClockSet_28
        LDR      R0,??DataTable3_3  ;; 0x40064006
        LDRB     R0,[R0, #+0]
//  413             {
//  414             }
//  415             xHWREGB(MCG_C2) &= ~MCG_C2_IRCS;
??xSysCtlClockSet_28:
        LDR      R0,??DataTable3_4  ;; 0x40064001
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+254
        ANDS     R1,R1,R0
        LDR      R0,??DataTable3_4  ;; 0x40064001
        STRB     R1,[R0, #+0]
//  416             //
//  417             // Change the CLKS mux to select the IRC as the MCGOUT
//  418             //
//  419             ucTempReg = xHWREGB(MCG_C1);
        LDR      R0,??DataTable3_5  ;; 0x40064000
        LDRB     R0,[R0, #+0]
        MOVS     R5,R0
//  420             ucTempReg &= ~MCG_C1_SRC_MCGOUTCLK_M;
        LSLS     R5,R5,#+26       ;; ZeroExtS R5,R5,#+26,#+26
        LSRS     R5,R5,#+26
//  421             //
//  422             // select IRC as the MCG clock sourse
//  423             //
//  424             ucTempReg |= MCG_C1_SRC_MCGOUTCLK_INTERAL;
        MOVS     R0,R5
        MOVS     R5,#+64
        ORRS     R5,R5,R0
//  425             xHWREGB(MCG_C1) = ucTempReg;
        LDR      R0,??DataTable3_5  ;; 0x40064000
        STRB     R5,[R0, #+0]
//  426             //
//  427             // wait until internal reference switches to requested irc.
//  428             //
//  429             for (i = 0 ; i < 2000 ; i++)
        MOVS     R0,#+0
        MOVS     R4,R0
??xSysCtlClockSet_29:
        MOVS     R0,#+250
        LSLS     R0,R0,#+3        ;; #+2000
        CMP      R4,R0
        BCS      ??xSysCtlClockSet_30
//  430             {
//  431                 if((xHWREGB(MCG_S) & MCG_S_IRCST) != MCG_S_IRCST)
        LDR      R0,??DataTable3_3  ;; 0x40064006
        LDRB     R0,[R0, #+0]
        UXTB     R0,R0
        LSLS     R0,R0,#+31
        BPL      ??xSysCtlClockSet_30
//  432                 {
//  433                     break;
//  434                 }
//  435 
//  436             }
??xSysCtlClockSet_31:
        ADDS     R4,R4,#+1
        B        ??xSysCtlClockSet_29
//  437             //
//  438             // Wait for clock status bits to update
//  439             //
//  440             for (i = 0 ; i < 2000 ; i++)
??xSysCtlClockSet_30:
        MOVS     R0,#+0
        MOVS     R4,R0
??xSysCtlClockSet_32:
        MOVS     R0,#+250
        LSLS     R0,R0,#+3        ;; #+2000
        CMP      R4,R0
        BCS      ??xSysCtlClockSet_33
//  441             {
//  442                 if((xHWREGB(MCG_S) & MCG_S_CLKST_INT) == MCG_S_CLKST_INT)
        LDR      R0,??DataTable3_3  ;; 0x40064006
        LDRB     R0,[R0, #+0]
        UXTB     R0,R0
        LSLS     R0,R0,#+29
        BMI      ??xSysCtlClockSet_33
//  443                 {
//  444                     break;            
//  445                 }
//  446 
//  447             }
??xSysCtlClockSet_34:
        ADDS     R4,R4,#+1
        B        ??xSysCtlClockSet_32
//  448             break;
??xSysCtlClockSet_33:
        B        ??xSysCtlClockSet_27
//  449         }
//  450         default:
//  451         {
//  452             xASSERT(0);
//  453             break;
//  454         }       
//  455     }
//  456 }
??xSysCtlClockSet_1:
??xSysCtlClockSet_27:
        POP      {R0-R2,R4-R7,PC}  ;; return
//  457         
//  458 //*****************************************************************************
//  459 //
//  460 //! \brief Enables a peripheral.
//  461 //!
//  462 //! \param ulPeripheralBase a Peripheral base indicate which peripheral to be 
//  463 //! enabled.Details please refer to \ref xLowLayer_Peripheral_Memmap.
//  464 //!
//  465 //! Peripherals are enabled with this function.  At power-up, all peripherals
//  466 //! are disabled; they must be enabled in order to operate or respond to
//  467 //! register reads/writes.
//  468 //!
//  469 //! The \e ulPeripheral parameter must be only one of the following values:
//  470 //! Details please refer to \ref xLowLayer_Peripheral_Memmap.
//  471 //!
//  472 //! \return None.
//  473 //
//  474 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  475 void 
//  476 xSysCtlPeripheralEnable2(unsigned long ulPeripheralBase)
//  477 {
xSysCtlPeripheralEnable2:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
//  478     unsigned long i;
//  479     for(i=0; g_pPeripherals[i].ulPeripheralBase != 0; i++)
        MOVS     R0,#+0
        MOVS     R5,R0
??xSysCtlPeripheralEnable2_0:
        MOVS     R0,#+12
        MULS     R0,R5,R0
        LDR      R1,??DataTable4
        LDR      R0,[R1, R0]
        CMP      R0,#+0
        BEQ      ??xSysCtlPeripheralEnable2_1
//  480     {
//  481         if(ulPeripheralBase == g_pPeripherals[i].ulPeripheralBase)
        MOVS     R0,#+12
        MULS     R0,R5,R0
        LDR      R1,??DataTable4
        LDR      R0,[R1, R0]
        CMP      R4,R0
        BNE      ??xSysCtlPeripheralEnable2_2
//  482         {
//  483             SysCtlPeripheralEnable(g_pPeripherals[i].ulPeripheralID);
        MOVS     R0,#+12
        MULS     R0,R5,R0
        LDR      R1,??DataTable4
        ADDS     R0,R1,R0
        LDR      R0,[R0, #+4]
        BL       SysCtlPeripheralEnable
//  484             break;
        B        ??xSysCtlPeripheralEnable2_1
//  485         }
//  486     }
??xSysCtlPeripheralEnable2_2:
        ADDS     R5,R5,#+1
        B        ??xSysCtlPeripheralEnable2_0
//  487 }
??xSysCtlPeripheralEnable2_1:
        POP      {R0,R4,R5,PC}    ;; return
//  488         
//  489 //*****************************************************************************
//  490 //
//  491 //! \brief Disables a peripheral.
//  492 //!
//  493 //! \param ulPeripheralBase a Peripheral base indicate which peripheral to be 
//  494 //! enabled.Details please refer to \ref xLowLayer_Peripheral_Memmap.
//  495 //!
//  496 //! Peripherals are disabled with this function.  At power-up, all peripherals
//  497 //! are disabled; they must be enabled in order to operate or respond to
//  498 //! register reads/writes.
//  499 //!
//  500 //! The \e ulPeripheral parameter must be only one of the following values:
//  501 //! Details please refer to \ref xLowLayer_Peripheral_Memmap.
//  502 //!
//  503 //! \return None.
//  504 //
//  505 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  506 void 
//  507 xSysCtlPeripheralDisable2(unsigned long ulPeripheralBase)
//  508 {
xSysCtlPeripheralDisable2:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
//  509     unsigned long i;
//  510     for(i=0; g_pPeripherals[i].ulPeripheralBase != 0; i++)
        MOVS     R0,#+0
        MOVS     R5,R0
??xSysCtlPeripheralDisable2_0:
        MOVS     R0,#+12
        MULS     R0,R5,R0
        LDR      R1,??DataTable4
        LDR      R0,[R1, R0]
        CMP      R0,#+0
        BEQ      ??xSysCtlPeripheralDisable2_1
//  511     {
//  512         if(ulPeripheralBase == g_pPeripherals[i].ulPeripheralBase)
        MOVS     R0,#+12
        MULS     R0,R5,R0
        LDR      R1,??DataTable4
        LDR      R0,[R1, R0]
        CMP      R4,R0
        BNE      ??xSysCtlPeripheralDisable2_2
//  513         {
//  514             SysCtlPeripheralDisable(g_pPeripherals[i].ulPeripheralID);
        MOVS     R0,#+12
        MULS     R0,R5,R0
        LDR      R1,??DataTable4
        ADDS     R0,R1,R0
        LDR      R0,[R0, #+4]
        BL       SysCtlPeripheralDisable
//  515             break;
        B        ??xSysCtlPeripheralDisable2_1
//  516         }
//  517     }
??xSysCtlPeripheralDisable2_2:
        ADDS     R5,R5,#+1
        B        ??xSysCtlPeripheralDisable2_0
//  518 }
??xSysCtlPeripheralDisable2_1:
        POP      {R0,R4,R5,PC}    ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable2:
        DC32     s_ulExtClockMHz
//  519  
//  520 //*****************************************************************************
//  521 //
//  522 //! \brief Get the peripheral interrupt number through peripheral base.
//  523 //!
//  524 //! \param ulPeripheral The peripheral's base  
//  525 //!
//  526 //! \note It's especially useful to enable the short pin's corresponding 
//  527 //! peripheral interrupt: Use the short pin to Get the GPIO base through 
//  528 //! \ref xGPIOSPinToPort function, and then use this function to enable the GPIO
//  529 //! interrupt.
//  530 //!
//  531 //! \return None.
//  532 //
//  533 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  534 unsigned long 
//  535 xSysCtlPeripheraIntNumGet(unsigned long ulPeripheralBase)
//  536 {
xSysCtlPeripheraIntNumGet:
        PUSH     {LR}
        MOVS     R1,R0
//  537     unsigned long i;
//  538     
//  539     //
//  540     // Check the arguments.
//  541     //
//  542     xASSERT((ulPeripheralBase == xGPIO_PORTA_BASE)||
//  543             (ulPeripheralBase == xGPIO_PORTD_BASE)||
//  544             (ulPeripheralBase == xUART0_BASE)||   
//  545             (ulPeripheralBase == xUART1_BASE)||   
//  546             (ulPeripheralBase == xUART2_BASE)||   
//  547             (ulPeripheralBase == xTIMER0_BASE)||    
//  548             (ulPeripheralBase == xTIMER1_BASE)||          
//  549             (ulPeripheralBase == xTIMER2_BASE)||    
//  550             (ulPeripheralBase == xSPI0_BASE)||     
//  551             (ulPeripheralBase == xSPI1_BASE)||         
//  552             (ulPeripheralBase == xSPI2_BASE)||           
//  553             (ulPeripheralBase == xSPI3_BASE)||   
//  554             (ulPeripheralBase == xI2C0_BASE)||  
//  555             (ulPeripheralBase == xI2C1_BASE)||
//  556             (ulPeripheralBase == xADC0_BASE)||    
//  557             (ulPeripheralBase == xACMP0_BASE)||       
//  558             (ulPeripheralBase == xPWMA_BASE)||
//  559             (ulPeripheralBase == xPWMB_BASE)||       
//  560             (ulPeripheralBase == xPWMC_BASE)       
//  561             );
//  562             
//  563     for(i=0; g_pPeripherals[i].ulPeripheralBase != 0; i++)
        MOVS     R2,#+0
        MOVS     R0,R2
??xSysCtlPeripheraIntNumGet_0:
        MOVS     R2,#+12
        MULS     R2,R0,R2
        LDR      R3,??DataTable4
        LDR      R2,[R3, R2]
        CMP      R2,#+0
        BEQ      ??xSysCtlPeripheraIntNumGet_1
//  564     {
//  565         if(ulPeripheralBase == g_pPeripherals[i].ulPeripheralBase)
        MOVS     R2,#+12
        MULS     R2,R0,R2
        LDR      R3,??DataTable4
        LDR      R2,[R3, R2]
        CMP      R1,R2
        BEQ      ??xSysCtlPeripheraIntNumGet_1
//  566         {
//  567             break;
//  568         }
//  569     }
??xSysCtlPeripheraIntNumGet_2:
        ADDS     R0,R0,#+1
        B        ??xSysCtlPeripheraIntNumGet_0
//  570     return g_pPeripherals[i].ulPeripheralIntNum;
??xSysCtlPeripheraIntNumGet_1:
        MOVS     R2,#+12
        MULS     R0,R2,R0
        LDR      R2,??DataTable4
        ADDS     R0,R2,R0
        LDR      R0,[R0, #+8]
        POP      {PC}             ;; return
//  571 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3:
        DC32     0xf4240

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_1:
        DC32     0x40048044

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_2:
        DC32     0xfff8ffff

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_3:
        DC32     0x40064006

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_4:
        DC32     0x40064001

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_5:
        DC32     0x40064000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_6:
        DC32     0x4e20

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_7:
        DC32     0x40064005

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_8:
        DC32     0x40064004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_9:
        DC32     0x40048004
//  572 
//  573 //*****************************************************************************
//  574 //
//  575 //! \brief Set a peripheral clock source and peripheral divide.
//  576 //!
//  577 //! \param ulPeripheralSrc is the peripheral clock source to set.
//  578 //! \param ulDivide is the peripheral clock divide to set.
//  579 //!
//  580 //! Peripherals clock source are seted with this function.  At power-up, all 
//  581 //! Peripherals clock source are Peripherals clock source; they must be set in 
//  582 //! order to operate or respond to register reads/writes.
//  583 //!
//  584 //! The \e ulPeripheralSrc parameter must be only one of the following values:
//  585 //! \ref xSysCtl_Peripheral_Src_Clk.
//  586 //!
//  587 //! \return None.
//  588 //
//  589 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  590 void
//  591 xSysCtlPeripheralClockSourceSet(unsigned long ulPeripheralSrc,
//  592                                 unsigned long ulDivide)
//  593 {
xSysCtlPeripheralClockSourceSet:
        PUSH     {LR}
//  594     //
//  595     // Check the arguments.
//  596     //
//  597     xASSERT((ulPeripheralSrc==xSYSCTL_WDT0_INTSL)||
//  598             (ulPeripheralSrc==xSYSCTL_ADC0_MAIN)||
//  599             (ulPeripheralSrc==xSYSCTL_WDT0_HCLK_2)||
//  600             (ulPeripheralSrc==xSYSCTL_TIMER0_MAIN)||
//  601             (ulPeripheralSrc==xSYSCTL_TIMER0_HCLK)||
//  602             (ulPeripheralSrc==xSYSCTL_TIMER0_INT)||
//  603             (ulPeripheralSrc==xSYSCTL_TIMER1_MAIN)||
//  604             (ulPeripheralSrc==xSYSCTL_TIMER1_HCLK)||
//  605             (ulPeripheralSrc==xSYSCTL_TIMER1_INT)||
//  606             (ulPeripheralSrc==xSYSCTL_TIMER2_MAIN)||
//  607             (ulPeripheralSrc==xSYSCTL_TIMER2_HCLK)||
//  608             (ulPeripheralSrc==xSYSCTL_TIMER2_INT)||
//  609             (ulPeripheralSrc==xSYSCTL_UART0_MAIN)||
//  610             (ulPeripheralSrc==xSYSCTL_UART0_PLL)||
//  611             (ulPeripheralSrc==xSYSCTL_UART0_INT)||
//  612             (ulPeripheralSrc==xSYSCTL_PWMA_MAIN)||
//  613             (ulPeripheralSrc==xSYSCTL_PWMA_HCLK)||
//  614             (ulPeripheralSrc==xSYSCTL_PWMA_INT)||
//  615             (ulPeripheralSrc==xSYSCTL_PWMB_MAIN)||
//  616             (ulPeripheralSrc==xSYSCTL_PWMB_HCLK)||
//  617             (ulPeripheralSrc==xSYSCTL_PWMB_INT)||
//  618             (ulPeripheralSrc==xSYSCTL_PWMC_MAIN)||
//  619             (ulPeripheralSrc==xSYSCTL_PWMC_HCLK)||
//  620             (ulPeripheralSrc==xSYSCTL_PWMC_INT));
//  621     xASSERT((ulDivide <= 256) && (ulDivide >= 1));
//  622 
//  623     //
//  624     // Set the peripheral clock source
//  625     //
//  626     ulDivide = 0;
        MOVS     R2,#+0
        MOVS     R1,R2
//  627     if(ulPeripheralSrc == SYSCTL_PERIPH_RTC_S_OSC32KCLK)
        CMP      R0,#+0
        BNE      ??xSysCtlPeripheralClockSourceSet_0
//  628     {
//  629         xHWREG(SIM_SOPT1) &= ~SIM_SOPT1_OSC32KSEL_M;
        LDR      R2,??DataTable6  ;; 0x40047000
        LDR      R2,[R2, #+0]
        LDR      R3,??DataTable6_1  ;; 0xfff3ffff
        ANDS     R3,R3,R2
        LDR      R2,??DataTable6  ;; 0x40047000
        STR      R3,[R2, #+0]
//  630         xHWREG(SIM_SOPT1) |= SIM_SOPT1_OSC32KSEL_OSC32KCLK;
        LDR      R2,??DataTable6  ;; 0x40047000
        LDR      R3,??DataTable6  ;; 0x40047000
        LDR      R3,[R3, #+0]
        STR      R3,[R2, #+0]
        B        ??xSysCtlPeripheralClockSourceSet_1
//  631     }
//  632     else if(ulPeripheralSrc == SYSCTL_PERIPH_RTC_S_RTC_CLKIN)
??xSysCtlPeripheralClockSourceSet_0:
        MOVS     R2,#+128
        LSLS     R2,R2,#+9        ;; #+65536
        CMP      R0,R2
        BNE      ??xSysCtlPeripheralClockSourceSet_2
//  633     {
//  634         xHWREG(SIM_SOPT1) &= ~SIM_SOPT1_OSC32KSEL_M;
        LDR      R2,??DataTable6  ;; 0x40047000
        LDR      R2,[R2, #+0]
        LDR      R3,??DataTable6_1  ;; 0xfff3ffff
        ANDS     R3,R3,R2
        LDR      R2,??DataTable6  ;; 0x40047000
        STR      R3,[R2, #+0]
//  635         xHWREG(SIM_SOPT1) |= SIM_SOPT1_OSC32KSEL_RTC_CLKIN;
        LDR      R2,??DataTable6  ;; 0x40047000
        LDR      R2,[R2, #+0]
        MOVS     R3,#+128
        LSLS     R3,R3,#+12       ;; #+524288
        ORRS     R3,R3,R2
        LDR      R2,??DataTable6  ;; 0x40047000
        STR      R3,[R2, #+0]
        B        ??xSysCtlPeripheralClockSourceSet_1
//  636     }
//  637     else if(ulPeripheralSrc == xSYSCTL_ADC0_MAIN)
??xSysCtlPeripheralClockSourceSet_2:
        MOVS     R2,#+204
        LSLS     R2,R2,#+24       ;; #-872415232
        CMP      R0,R2
        BNE      ??xSysCtlPeripheralClockSourceSet_3
//  638     {
//  639         xHWREG(ADC_BASE + ADC0_CFG1) &= ~ADC0_CFG1_ADICLK_M;
        LDR      R2,??DataTable6_2  ;; 0x4003b008
        LDR      R2,[R2, #+0]
        MOVS     R3,#+3
        BICS     R2,R2,R3
        LDR      R3,??DataTable6_2  ;; 0x4003b008
        STR      R2,[R3, #+0]
//  640         xHWREG(ADC_BASE + ADC0_CFG1) &= ~ADC0_CFG1_ADIV_M;
        LDR      R2,??DataTable6_2  ;; 0x4003b008
        LDR      R2,[R2, #+0]
        MOVS     R3,#+96
        BICS     R2,R2,R3
        LDR      R3,??DataTable6_2  ;; 0x4003b008
        STR      R2,[R3, #+0]
//  641         xHWREG(ADC_BASE + ADC0_CFG1) |= ulDivide;
        LDR      R2,??DataTable6_2  ;; 0x4003b008
        LDR      R2,[R2, #+0]
        ORRS     R2,R2,R1
        LDR      R3,??DataTable6_2  ;; 0x4003b008
        STR      R2,[R3, #+0]
        B        ??xSysCtlPeripheralClockSourceSet_1
//  642     }
//  643     else if(ulPeripheralSrc == SYSCTL_PERIPH_RTC_S_LPO)
??xSysCtlPeripheralClockSourceSet_3:
        MOVS     R2,#+192
        LSLS     R2,R2,#+12       ;; #+786432
        CMP      R0,R2
        BNE      ??xSysCtlPeripheralClockSourceSet_4
//  644     {
//  645         xHWREG(SIM_SOPT1) &= ~SIM_SOPT1_OSC32KSEL_M;
        LDR      R2,??DataTable6  ;; 0x40047000
        LDR      R2,[R2, #+0]
        LDR      R3,??DataTable6_1  ;; 0xfff3ffff
        ANDS     R3,R3,R2
        LDR      R2,??DataTable6  ;; 0x40047000
        STR      R3,[R2, #+0]
//  646         xHWREG(SIM_SOPT1) |= SIM_SOPT1_OSC32KSEL_LPO;
        LDR      R2,??DataTable6  ;; 0x40047000
        LDR      R2,[R2, #+0]
        MOVS     R3,#+192
        LSLS     R3,R3,#+12       ;; #+786432
        ORRS     R3,R3,R2
        LDR      R2,??DataTable6  ;; 0x40047000
        STR      R3,[R2, #+0]
        B        ??xSysCtlPeripheralClockSourceSet_1
//  647     }
//  648     else if(ulPeripheralSrc == SYSCTL_PERIPH_UART0_S_MCGFLLCLK)
??xSysCtlPeripheralClockSourceSet_4:
        MOVS     R2,#+128
        LSLS     R2,R2,#+19       ;; #+67108864
        CMP      R0,R2
        BNE      ??xSysCtlPeripheralClockSourceSet_5
//  649     {
//  650         xHWREG(SIM_SOPT2) &= ~SIM_SOPT2_PLLFLLSEL;
        LDR      R2,??DataTable9  ;; 0x40048004
        LDR      R2,[R2, #+0]
        LDR      R3,??DataTable9_1  ;; 0xfffeffff
        ANDS     R3,R3,R2
        LDR      R2,??DataTable9  ;; 0x40048004
        STR      R3,[R2, #+0]
//  651         xHWREG(SIM_SOPT2) &= ~SIM_SOPT2_UART0SRC_M;
        LDR      R2,??DataTable9  ;; 0x40048004
        LDR      R2,[R2, #+0]
        LDR      R3,??DataTable8  ;; 0xf3ffffff
        ANDS     R3,R3,R2
        LDR      R2,??DataTable9  ;; 0x40048004
        STR      R3,[R2, #+0]
//  652         xHWREG(SIM_SOPT2) |= SIM_SOPT2_UART0SRC_MCGXLL;
        LDR      R2,??DataTable9  ;; 0x40048004
        LDR      R2,[R2, #+0]
        MOVS     R3,#+128
        LSLS     R3,R3,#+19       ;; #+67108864
        ORRS     R3,R3,R2
        LDR      R2,??DataTable9  ;; 0x40048004
        STR      R3,[R2, #+0]
        B        ??xSysCtlPeripheralClockSourceSet_1
//  653     }
//  654     else if(ulPeripheralSrc == SYSCTL_PERIPH_UART0_S_MCGPLLCLK_2)
??xSysCtlPeripheralClockSourceSet_5:
        MOVS     R2,#+164
        LSLS     R2,R2,#+24       ;; #-1543503872
        CMP      R0,R2
        BNE      ??xSysCtlPeripheralClockSourceSet_6
//  655     {
//  656         xHWREG(SIM_SOPT2) |= SIM_SOPT2_PLLFLLSEL;
        LDR      R2,??DataTable9  ;; 0x40048004
        LDR      R2,[R2, #+0]
        MOVS     R3,#+128
        LSLS     R3,R3,#+9        ;; #+65536
        ORRS     R3,R3,R2
        LDR      R2,??DataTable9  ;; 0x40048004
        STR      R3,[R2, #+0]
//  657         xHWREG(SIM_SOPT2) &= ~SIM_SOPT2_UART0SRC_M;
        LDR      R2,??DataTable9  ;; 0x40048004
        LDR      R2,[R2, #+0]
        LDR      R3,??DataTable8  ;; 0xf3ffffff
        ANDS     R3,R3,R2
        LDR      R2,??DataTable9  ;; 0x40048004
        STR      R3,[R2, #+0]
//  658         xHWREG(SIM_SOPT2) |= SIM_SOPT2_UART0SRC_MCGXLL;
        LDR      R2,??DataTable9  ;; 0x40048004
        LDR      R2,[R2, #+0]
        MOVS     R3,#+128
        LSLS     R3,R3,#+19       ;; #+67108864
        ORRS     R3,R3,R2
        LDR      R2,??DataTable9  ;; 0x40048004
        STR      R3,[R2, #+0]
        B        ??xSysCtlPeripheralClockSourceSet_1
//  659     }
//  660     else if(ulPeripheralSrc == SYSCTL_PERIPH_UART0_S_OSCERCLK)
??xSysCtlPeripheralClockSourceSet_6:
        MOVS     R2,#+128
        LSLS     R2,R2,#+20       ;; #+134217728
        CMP      R0,R2
        BNE      ??xSysCtlPeripheralClockSourceSet_7
//  661     {
//  662         xHWREG(SIM_SOPT2) &= ~SIM_SOPT2_UART0SRC_M;
        LDR      R2,??DataTable9  ;; 0x40048004
        LDR      R2,[R2, #+0]
        LDR      R3,??DataTable8  ;; 0xf3ffffff
        ANDS     R3,R3,R2
        LDR      R2,??DataTable9  ;; 0x40048004
        STR      R3,[R2, #+0]
//  663         xHWREG(SIM_SOPT2) |= SIM_SOPT2_UART0SRC_OSCERCLK;
        LDR      R2,??DataTable9  ;; 0x40048004
        LDR      R2,[R2, #+0]
        MOVS     R3,#+128
        LSLS     R3,R3,#+20       ;; #+134217728
        ORRS     R3,R3,R2
        LDR      R2,??DataTable9  ;; 0x40048004
        STR      R3,[R2, #+0]
        B        ??xSysCtlPeripheralClockSourceSet_1
//  664     }
//  665     else if(ulPeripheralSrc == SYSCTL_PERIPH_UART0_S_MCGIRCLK)
??xSysCtlPeripheralClockSourceSet_7:
        MOVS     R2,#+192
        LSLS     R2,R2,#+20       ;; #+201326592
        CMP      R0,R2
        BNE      ??xSysCtlPeripheralClockSourceSet_8
//  666     {
//  667         xHWREG(SIM_SOPT2) &= ~SIM_SOPT2_UART0SRC_M;
        LDR      R2,??DataTable9  ;; 0x40048004
        LDR      R2,[R2, #+0]
        LDR      R3,??DataTable8  ;; 0xf3ffffff
        ANDS     R3,R3,R2
        LDR      R2,??DataTable9  ;; 0x40048004
        STR      R3,[R2, #+0]
//  668         xHWREG(SIM_SOPT2) |= SIM_SOPT2_UART0SRC_MCGIRCLK;
        LDR      R2,??DataTable9  ;; 0x40048004
        LDR      R2,[R2, #+0]
        MOVS     R3,#+192
        LSLS     R3,R3,#+20       ;; #+201326592
        ORRS     R3,R3,R2
        LDR      R2,??DataTable9  ;; 0x40048004
        STR      R3,[R2, #+0]
        B        ??xSysCtlPeripheralClockSourceSet_1
//  669     }
//  670     else if(ulPeripheralSrc == SYSCTL_PERIPH_TPM_S_MCGFLLCLK)
??xSysCtlPeripheralClockSourceSet_8:
        MOVS     R2,#+128
        LSLS     R2,R2,#+17       ;; #+16777216
        CMP      R0,R2
        BNE      ??xSysCtlPeripheralClockSourceSet_9
//  671     {
//  672         xHWREG(SIM_SOPT2) &= ~SIM_SOPT2_PLLFLLSEL;    	
        LDR      R2,??DataTable9  ;; 0x40048004
        LDR      R2,[R2, #+0]
        LDR      R3,??DataTable9_1  ;; 0xfffeffff
        ANDS     R3,R3,R2
        LDR      R2,??DataTable9  ;; 0x40048004
        STR      R3,[R2, #+0]
//  673         xHWREG(SIM_SOPT2) &= ~SIM_SOPT2_TPMSRC_M;
        LDR      R2,??DataTable9  ;; 0x40048004
        LDR      R2,[R2, #+0]
        LDR      R3,??DataTable12  ;; 0xfcffffff
        ANDS     R3,R3,R2
        LDR      R2,??DataTable9  ;; 0x40048004
        STR      R3,[R2, #+0]
//  674         xHWREG(SIM_SOPT2) |= SIM_SOPT2_TPMSRC_MCGXLL;
        LDR      R2,??DataTable9  ;; 0x40048004
        LDR      R2,[R2, #+0]
        MOVS     R3,#+128
        LSLS     R3,R3,#+17       ;; #+16777216
        ORRS     R3,R3,R2
        LDR      R2,??DataTable9  ;; 0x40048004
        STR      R3,[R2, #+0]
        B        ??xSysCtlPeripheralClockSourceSet_1
//  675     }
//  676     else if(ulPeripheralSrc == SYSCTL_PERIPH_TPM_S_MCGPLLCLK_2)
??xSysCtlPeripheralClockSourceSet_9:
        MOVS     R2,#+161
        LSLS     R2,R2,#+24       ;; #-1593835520
        CMP      R0,R2
        BNE      ??xSysCtlPeripheralClockSourceSet_10
//  677     {
//  678         xHWREG(SIM_SOPT2) |= SIM_SOPT2_PLLFLLSEL;
        LDR      R2,??DataTable9  ;; 0x40048004
        LDR      R2,[R2, #+0]
        MOVS     R3,#+128
        LSLS     R3,R3,#+9        ;; #+65536
        ORRS     R3,R3,R2
        LDR      R2,??DataTable9  ;; 0x40048004
        STR      R3,[R2, #+0]
//  679         xHWREG(SIM_SOPT2) &= ~SIM_SOPT2_TPMSRC_M;
        LDR      R2,??DataTable9  ;; 0x40048004
        LDR      R2,[R2, #+0]
        LDR      R3,??DataTable12  ;; 0xfcffffff
        ANDS     R3,R3,R2
        LDR      R2,??DataTable9  ;; 0x40048004
        STR      R3,[R2, #+0]
//  680         xHWREG(SIM_SOPT2) |= SIM_SOPT2_TPMSRC_MCGXLL;
        LDR      R2,??DataTable9  ;; 0x40048004
        LDR      R2,[R2, #+0]
        MOVS     R3,#+128
        LSLS     R3,R3,#+17       ;; #+16777216
        ORRS     R3,R3,R2
        LDR      R2,??DataTable9  ;; 0x40048004
        STR      R3,[R2, #+0]
        B        ??xSysCtlPeripheralClockSourceSet_1
//  681     }
//  682     else if(ulPeripheralSrc == SYSCTL_PERIPH_TPM_S_OSCERCLK)
??xSysCtlPeripheralClockSourceSet_10:
        MOVS     R2,#+128
        LSLS     R2,R2,#+18       ;; #+33554432
        CMP      R0,R2
        BNE      ??xSysCtlPeripheralClockSourceSet_11
//  683     {
//  684         xHWREG(SIM_SOPT2) &= ~SIM_SOPT2_TPMSRC_M;
        LDR      R2,??DataTable9  ;; 0x40048004
        LDR      R2,[R2, #+0]
        LDR      R3,??DataTable12  ;; 0xfcffffff
        ANDS     R3,R3,R2
        LDR      R2,??DataTable9  ;; 0x40048004
        STR      R3,[R2, #+0]
//  685         xHWREG(SIM_SOPT2) |= SIM_SOPT2_TPMSRC_OSCERCLK;
        LDR      R2,??DataTable9  ;; 0x40048004
        LDR      R2,[R2, #+0]
        MOVS     R3,#+128
        LSLS     R3,R3,#+18       ;; #+33554432
        ORRS     R3,R3,R2
        LDR      R2,??DataTable9  ;; 0x40048004
        STR      R3,[R2, #+0]
        B        ??xSysCtlPeripheralClockSourceSet_1
//  686     }
//  687     else if(ulPeripheralSrc == SYSCTL_PERIPH_TPM_S_MCGIRCLK)
??xSysCtlPeripheralClockSourceSet_11:
        MOVS     R2,#+192
        LSLS     R2,R2,#+18       ;; #+50331648
        CMP      R0,R2
        BNE      ??xSysCtlPeripheralClockSourceSet_12
//  688     {
//  689         xHWREG(SIM_SOPT2) &= ~SIM_SOPT2_TPMSRC_M;
        LDR      R2,??DataTable9  ;; 0x40048004
        LDR      R2,[R2, #+0]
        LDR      R3,??DataTable12  ;; 0xfcffffff
        ANDS     R3,R3,R2
        LDR      R2,??DataTable9  ;; 0x40048004
        STR      R3,[R2, #+0]
//  690         xHWREG(SIM_SOPT2) |= SIM_SOPT2_TPMSRC_MCGIRCLK;
        LDR      R2,??DataTable9  ;; 0x40048004
        LDR      R2,[R2, #+0]
        MOVS     R3,#+192
        LSLS     R3,R3,#+18       ;; #+50331648
        ORRS     R3,R3,R2
        LDR      R2,??DataTable9  ;; 0x40048004
        STR      R3,[R2, #+0]
        B        ??xSysCtlPeripheralClockSourceSet_1
//  691     }
//  692     else if(ulPeripheralSrc == SYSCTL_PERIPH_USB_S_USB_CLKIN)
??xSysCtlPeripheralClockSourceSet_12:
        MOVS     R2,#+176
        LSLS     R2,R2,#+24       ;; #-1342177280
        CMP      R0,R2
        BNE      ??xSysCtlPeripheralClockSourceSet_13
//  693     {
//  694         xHWREG(SIM_SOPT2) &= ~SIM_SOPT2_USBSRC;
        LDR      R2,??DataTable9  ;; 0x40048004
        LDR      R2,[R2, #+0]
        LDR      R3,??DataTable14  ;; 0xfffbffff
        ANDS     R3,R3,R2
        LDR      R2,??DataTable9  ;; 0x40048004
        STR      R3,[R2, #+0]
        B        ??xSysCtlPeripheralClockSourceSet_1
//  695     }
//  696     else if(ulPeripheralSrc == SYSCTL_PERIPH_USB_S_MCGPLLCLK_2)
??xSysCtlPeripheralClockSourceSet_13:
        LDR      R2,??DataTable14_1  ;; 0x80704
        CMP      R0,R2
        BNE      ??xSysCtlPeripheralClockSourceSet_14
//  697     {
//  698         xHWREG(SIM_SOPT2) |= SIM_SOPT2_PLLFLLSEL;    	
        LDR      R2,??DataTable9  ;; 0x40048004
        LDR      R2,[R2, #+0]
        MOVS     R3,#+128
        LSLS     R3,R3,#+9        ;; #+65536
        ORRS     R3,R3,R2
        LDR      R2,??DataTable9  ;; 0x40048004
        STR      R3,[R2, #+0]
//  699         xHWREG(SIM_SOPT2) |= SIM_SOPT2_USBSRC;
        LDR      R2,??DataTable9  ;; 0x40048004
        LDR      R2,[R2, #+0]
        MOVS     R3,#+128
        LSLS     R3,R3,#+11       ;; #+262144
        ORRS     R3,R3,R2
        LDR      R2,??DataTable9  ;; 0x40048004
        STR      R3,[R2, #+0]
        B        ??xSysCtlPeripheralClockSourceSet_1
//  700     }
//  701     else if(ulPeripheralSrc == SYSCTL_PERIPH_USB_S_MCGFLLCLK)
??xSysCtlPeripheralClockSourceSet_14:
        LDR      R2,??DataTable14_2  ;; 0xc0700
        CMP      R0,R2
        BNE      ??xSysCtlPeripheralClockSourceSet_15
//  702     {
//  703         xHWREG(SIM_SOPT2) &= ~SIM_SOPT2_PLLFLLSEL;
        LDR      R2,??DataTable9  ;; 0x40048004
        LDR      R2,[R2, #+0]
        LDR      R3,??DataTable9_1  ;; 0xfffeffff
        ANDS     R3,R3,R2
        LDR      R2,??DataTable9  ;; 0x40048004
        STR      R3,[R2, #+0]
//  704         xHWREG(SIM_SOPT2) |= SIM_SOPT2_USBSRC;
        LDR      R2,??DataTable9  ;; 0x40048004
        LDR      R2,[R2, #+0]
        MOVS     R3,#+128
        LSLS     R3,R3,#+11       ;; #+262144
        ORRS     R3,R3,R2
        LDR      R2,??DataTable9  ;; 0x40048004
        STR      R3,[R2, #+0]
        B        ??xSysCtlPeripheralClockSourceSet_1
//  705     }
//  706     else if(ulPeripheralSrc == SYSCTL_PERIPH_WDG_S_1K)
??xSysCtlPeripheralClockSourceSet_15:
        LDR      R2,??DataTable14_3  ;; 0xc0701
        CMP      R0,R2
        BNE      ??xSysCtlPeripheralClockSourceSet_16
//  707     {
//  708         xHWREG(SIM_COPC ) &= ~SIM_COPC_COPCLKS;
        LDR      R2,??DataTable14_4  ;; 0x40048100
        LDR      R2,[R2, #+0]
        MOVS     R3,#+2
        BICS     R2,R2,R3
        LDR      R3,??DataTable14_4  ;; 0x40048100
        STR      R2,[R3, #+0]
        B        ??xSysCtlPeripheralClockSourceSet_1
//  709     }
//  710     else
//  711     {
//  712         xHWREG(SIM_COPC ) |= SIM_COPC_COPCLKS;
??xSysCtlPeripheralClockSourceSet_16:
        LDR      R2,??DataTable14_4  ;; 0x40048100
        LDR      R2,[R2, #+0]
        MOVS     R3,#+2
        ORRS     R3,R3,R2
        LDR      R2,??DataTable14_4  ;; 0x40048100
        STR      R3,[R2, #+0]
//  713     }
//  714 }
??xSysCtlPeripheralClockSourceSet_1:
        POP      {PC}             ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4:
        DC32     g_pPeripherals
//  715 
//  716 //*****************************************************************************
//  717 //
//  718 //! \brief Enables a peripheral.
//  719 //!
//  720 //! \param ulPeripheral is the peripheral to enable.
//  721 //!
//  722 //! Peripherals are enabled with this function.  At power-up, all peripherals
//  723 //! are disabled; they must be enabled in order to operate or respond to
//  724 //! register reads/writes.
//  725 //!
//  726 //! The \e ulPeripheral parameter must be only one of the following values:
//  727 //! \b SYSCTL_PERIPH_DMA,  \b SYSCTL_PERIPH_DAC,  \b SYSCTL_PERIPH_TMR0,
//  728 //! \b SYSCTL_PERIPH_TMR1, \b SYSCTL_PERIPH_TMR2, \b SYSCTL_PERIPH_RTC,
//  729 //! \b SYSCTL_PERIPH_I2C0, \b SYSCTL_PERIPH_I2C1, \b SYSCTL_PERIPH_SPI0,
//  730 //! \b SYSCTL_PERIPH_SPI1, \b SYSCTL_PERIPH_PIT,  \b SYSCTL_PERIPH_DMAMUX,
//  731 //! \b SYSCTL_PERIPH_UART0,\b SYSCTL_PERIPH_UART1,\b SYSCTL_PERIPH_UART2,
//  732 //! \b SYSCTL_PERIPH_PWMA, \b SYSCTL_PERIPH_PWMB, \b SYSCTL_PERIPH_PWMC,
//  733 //! \b SYSCTL_PERIPH_USB,  \b SYSCTL_PERIPH_ADC,  \b SYSCTL_PERIPH_FLASH,
//  734 //! \b SYSCTL_PERIPH_ACMP, \b SYSCTL_PERIPH_GPIOA,\b SYSCTL_PERIPH_GPIOB,
//  735 //! \b SYSCTL_PERIPH_GPIOC,\b SYSCTL_PERIPH_GPIOD,\b SYSCTL_PERIPH_GPIOE.
//  736 //!
//  737 //! \return None.
//  738 //
//  739 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  740 void
//  741 SysCtlPeripheralEnable(unsigned long ulPeripheral)
//  742 {
SysCtlPeripheralEnable:
        PUSH     {R4,R5}
//  743     unsigned long ulReadValue = 0, ulIndex = 0;
        MOVS     R1,#+0
        MOVS     R2,#+0
//  744     //
//  745     // Check the arguments.
//  746     //
//  747     xASSERT(SysCtlPeripheralValid(ulPeripheral));
//  748     ulIndex = SYSCTL_PERIPH_INDEX_E(ulPeripheral);
        MOVS     R3,R0
        LSRS     R3,R3,#+14
        LSLS     R3,R3,#+30       ;; ZeroExtS R3,R3,#+30,#+30
        LSRS     R3,R3,#+30
        MOVS     R2,R3
//  749     ulReadValue = SYSCTL_PERIPH_MASK_E(ulPeripheral);
        UXTB     R3,R0
        MOVS     R4,R0
        LSRS     R4,R4,#+8
        LSLS     R4,R4,#+27       ;; ZeroExtS R4,R4,#+27,#+27
        LSRS     R4,R4,#+27
        LSLS     R3,R3,R4
        MOVS     R1,R3
//  750     //
//  751     // Enable this peripheral.
//  752     //
//  753     xHWREG(g_pulAXBCLKRegs[ulIndex]) |= ulReadValue;
        MOVS     R3,#+4
        MULS     R3,R2,R3
        LDR      R4,??DataTable14_5
        LDR      R3,[R4, R3]
        LDR      R3,[R3, #+0]
        ORRS     R3,R3,R1
        MOVS     R4,#+4
        MULS     R4,R2,R4
        LDR      R5,??DataTable14_5
        LDR      R4,[R5, R4]
        STR      R3,[R4, #+0]
//  754 }
        POP      {R4,R5}
        BX       LR               ;; return
//  755 
//  756 //*****************************************************************************
//  757 //
//  758 //! \brief Disable a peripheral.
//  759 //!
//  760 //! \param ulPeripheral is the peripheral to Disable.
//  761 //!
//  762 //! Peripherals are disabled with this function.  Once disabled, they will not
//  763 //! operate or respond to register reads/writes.
//  764 //!
//  765 //! The \e ulPeripheral parameter must be only one of the following values:
//  766 //! \b SYSCTL_PERIPH_DMA,  \b SYSCTL_PERIPH_DAC,  \b SYSCTL_PERIPH_TMR0,
//  767 //! \b SYSCTL_PERIPH_TMR1, \b SYSCTL_PERIPH_TMR2, \b SYSCTL_PERIPH_RTC,
//  768 //! \b SYSCTL_PERIPH_I2C0, \b SYSCTL_PERIPH_I2C1, \b SYSCTL_PERIPH_SPI0,
//  769 //! \b SYSCTL_PERIPH_SPI1, \b SYSCTL_PERIPH_PIT,  \b SYSCTL_PERIPH_DMAMUX,
//  770 //! \b SYSCTL_PERIPH_UART0,\b SYSCTL_PERIPH_UART1,\b SYSCTL_PERIPH_UART2,
//  771 //! \b SYSCTL_PERIPH_PWMA, \b SYSCTL_PERIPH_PWMB, \b SYSCTL_PERIPH_PWMC,
//  772 //! \b SYSCTL_PERIPH_USB,  \b SYSCTL_PERIPH_ADC,  \b SYSCTL_PERIPH_FLASH,
//  773 //! \b SYSCTL_PERIPH_ACMP, \b SYSCTL_PERIPH_GPIOA,\b SYSCTL_PERIPH_GPIOB,
//  774 //! \b SYSCTL_PERIPH_GPIOC,\b SYSCTL_PERIPH_GPIOD,\b SYSCTL_PERIPH_GPIOE.
//  775 //!
//  776 //! \return None.
//  777 //
//  778 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  779 void
//  780 SysCtlPeripheralDisable(unsigned long ulPeripheral)
//  781 {
//  782     //
//  783     // Check the arguments.
//  784     //
//  785     xASSERT(SysCtlPeripheralValid(ulPeripheral));
//  786 
//  787     //
//  788     // Enable this peripheral.
//  789     //
//  790     xHWREG(g_pulAXBCLKRegs[SYSCTL_PERIPH_INDEX_E(ulPeripheral)]) &=
//  791         ~(SYSCTL_PERIPH_MASK_E(ulPeripheral));
SysCtlPeripheralDisable:
        MOVS     R1,R0
        LSRS     R1,R1,#+14
        LSLS     R1,R1,#+30       ;; ZeroExtS R1,R1,#+30,#+30
        LSRS     R1,R1,#+30
        MOVS     R2,#+4
        MULS     R1,R2,R1
        LDR      R2,??DataTable14_5
        LDR      R1,[R2, R1]
        LDR      R1,[R1, #+0]
        UXTB     R2,R0
        MOVS     R3,R0
        LSRS     R3,R3,#+8
        LSLS     R3,R3,#+27       ;; ZeroExtS R3,R3,#+27,#+27
        LSRS     R3,R3,#+27
        LSLS     R2,R2,R3
        BICS     R1,R1,R2
        MOVS     R2,R0
        LSRS     R2,R2,#+14
        LSLS     R2,R2,#+30       ;; ZeroExtS R2,R2,#+30,#+30
        LSRS     R2,R2,#+30
        MOVS     R3,#+4
        MULS     R2,R3,R2
        LDR      R3,??DataTable14_5
        LDR      R2,[R3, R2]
        STR      R1,[R2, #+0]
//  792 }
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6:
        DC32     0x40047000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_1:
        DC32     0xfff3ffff

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_2:
        DC32     0x4003b008
//  793 
//  794 //*****************************************************************************
//  795 //
//  796 //! \brief Enables and configures the edge detection for the wakeup pin.
//  797 //!
//  798 //! \param bEnable is a boolean that is \b true if Enable wakeup pin,
//  799 //! \b false if not.
//  800 //! \param ulPinIndex is the index of the wakeup pin.
//  801 //! \param ulEdge is mode of wakeup pin edge.
//  802 //!
//  803 //! This function is to Enable and configures the edge detection for the wakeup
//  804 //! pin or not.
//  805 //!
//  806 //! \return This function does not return.
//  807 //
//  808 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  809 void
//  810 SysCtlWakeupPinConfig(xtBoolean bEnable, unsigned long ulPinIndex, unsigned long ulEdge)
//  811 {
SysCtlWakeupPinConfig:
        PUSH     {R3-R7,LR}
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
//  812     xASSERT((ulPinIndex >= 0 && ulPinIndex <= 15));
//  813     xASSERT((ulEdge == SYSCTL_WAKEUP_PIN_DIS) ||
//  814             (ulEdge == SYSCTL_WAKEUP_PIN_ANY) ||
//  815             (ulEdge == SYSCTL_WAKEUP_PIN_RISING) ||
//  816             (ulEdge == SYSCTL_WAKEUP_PIN_FALLING));
//  817     //
//  818     // Enable the edge detection for the wakeup pin.
//  819     //
//  820     if(bEnable)
        UXTB     R4,R4
        CMP      R4,#+0
        BEQ      ??SysCtlWakeupPinConfig_0
//  821     {
//  822         xHWREGB(LLWU_PE1 + ulPinIndex/4) &= ~(LLWU_PE1_WUPE0_M << ((ulPinIndex%4)*2));
        MOVS     R0,R5
        LSRS     R0,R0,#+2
        LDR      R1,??DataTable14_6  ;; 0x4007c000
        LDRB     R0,[R0, R1]
        STR      R0,[SP, #+0]
        MOVS     R7,#+3
        MOVS     R0,R5
        MOVS     R1,#+4
        BL       __aeabi_uidivmod
        MOVS     R0,#+2
        MULS     R1,R0,R1
        LSLS     R7,R7,R1
        LDR      R0,[SP, #+0]
        BICS     R0,R0,R7
        MOVS     R1,R5
        LSRS     R1,R1,#+2
        LDR      R2,??DataTable14_6  ;; 0x4007c000
        STRB     R0,[R1, R2]
//  823         xHWREGB(LLWU_PE1 + ulPinIndex/4) |= ulEdge << ((ulPinIndex%4)*2);
        MOVS     R0,R5
        LSRS     R0,R0,#+2
        LDR      R1,??DataTable14_6  ;; 0x4007c000
        LDRB     R7,[R0, R1]
        MOVS     R0,R5
        MOVS     R1,#+4
        BL       __aeabi_uidivmod
        MOVS     R0,#+2
        MULS     R1,R0,R1
        MOVS     R0,R6
        LSLS     R0,R0,R1
        ORRS     R0,R0,R7
        MOVS     R1,R5
        LSRS     R1,R1,#+2
        LDR      R2,??DataTable14_6  ;; 0x4007c000
        STRB     R0,[R1, R2]
        B        ??SysCtlWakeupPinConfig_1
//  824     }
//  825     else
//  826     {
//  827         xHWREGB(LLWU_PE1 + ulPinIndex/4) &= ~(LLWU_PE1_WUPE0_M << ((ulPinIndex%4)*2));
??SysCtlWakeupPinConfig_0:
        MOVS     R0,R5
        LSRS     R0,R0,#+2
        LDR      R1,??DataTable14_6  ;; 0x4007c000
        LDRB     R0,[R0, R1]
        STR      R0,[SP, #+0]
        MOVS     R7,#+3
        MOVS     R0,R5
        MOVS     R1,#+4
        BL       __aeabi_uidivmod
        MOVS     R0,#+2
        MULS     R1,R0,R1
        LSLS     R7,R7,R1
        LDR      R0,[SP, #+0]
        BICS     R0,R0,R7
        MOVS     R1,R5
        LSRS     R1,R1,#+2
        LDR      R2,??DataTable14_6  ;; 0x4007c000
        STRB     R0,[R1, R2]
//  828     }
//  829 }
??SysCtlWakeupPinConfig_1:
        POP      {R0,R4-R7,PC}    ;; return
//  830 
//  831 //*****************************************************************************
//  832 //
//  833 //! \brief Enables and configures the edge detection for the wakeup pin.
//  834 //!
//  835 //! \param bEnable is a boolean that is \b true if Enable wakeup pin,
//  836 //! \b false if not.
//  837 //! \param ulPinIndex is the index of the wakeup pin.
//  838 //! \param ulEdge is mode of wakeup pin edge.
//  839 //!
//  840 //! This function is to Enable and configures the edge detection for the wakeup
//  841 //! pin or not.
//  842 //!
//  843 //! \return This function does not return.
//  844 //
//  845 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  846 void
//  847 SysCtlWakeupFilterConfig(unsigned long ulFilterIndex, unsigned long ulPinIndex,
//  848                          unsigned long ulEdge)
//  849 {
SysCtlWakeupFilterConfig:
        PUSH     {R4,R5}
//  850     xASSERT((ulFilterIndex >= 1 && ulFilterIndex <= 2));
//  851     xASSERT((ulPinIndex >= 0 && ulPinIndex <= 15));
//  852     xASSERT((ulEdge == SYSCTL_WAKEUP_FILTER_DIS) ||
//  853             (ulEdge == SYSCTL_WAKEUP_FILTER_ANY) ||
//  854             (ulEdge == SYSCTL_WAKEUP_FILTER_RISING) ||
//  855             (ulEdge == SYSCTL_WAKEUP_FILTER_FALLING));
//  856 
//  857     //
//  858     // Controls the digital filter options for the external pin detect
//  859     //
//  860     xHWREGB(LLWU_FILT1+ulFilterIndex/2) &= ~LLWU_FILT1_FILTE_M;
        MOVS     R3,R0
        LSRS     R3,R3,#+1
        LDR      R4,??DataTable14_7  ;; 0x4007c008
        LDRB     R3,[R3, R4]
        MOVS     R4,#+159
        ANDS     R4,R4,R3
        MOVS     R3,R0
        LSRS     R3,R3,#+1
        LDR      R5,??DataTable14_7  ;; 0x4007c008
        STRB     R4,[R3, R5]
//  861     xHWREGB(LLWU_FILT1+ulFilterIndex/2) |= ulEdge;
        MOVS     R3,R0
        LSRS     R3,R3,#+1
        LDR      R4,??DataTable14_7  ;; 0x4007c008
        LDRB     R3,[R3, R4]
        MOVS     R4,R2
        ORRS     R4,R4,R3
        MOVS     R3,R0
        LSRS     R3,R3,#+1
        LDR      R5,??DataTable14_7  ;; 0x4007c008
        STRB     R4,[R3, R5]
//  862     
//  863     //
//  864     // Selects 1 out of the 16 wakeup pins to be muxed into the filter.
//  865     //
//  866     xHWREGB(LLWU_FILT1+ulFilterIndex/2) &= ~LLWU_FILT1_FILTSEL_M;
        MOVS     R3,R0
        LSRS     R3,R3,#+1
        LDR      R4,??DataTable14_7  ;; 0x4007c008
        LDRB     R3,[R3, R4]
        MOVS     R4,#+240
        ANDS     R4,R4,R3
        MOVS     R3,R0
        LSRS     R3,R3,#+1
        LDR      R5,??DataTable14_7  ;; 0x4007c008
        STRB     R4,[R3, R5]
//  867     xHWREGB(LLWU_FILT1+ulFilterIndex/2) |= ulPinIndex;
        MOVS     R3,R0
        LSRS     R3,R3,#+1
        LDR      R4,??DataTable14_7  ;; 0x4007c008
        LDRB     R3,[R3, R4]
        MOVS     R4,R1
        ORRS     R4,R4,R3
        MOVS     R3,R0
        LSRS     R3,R3,#+1
        LDR      R5,??DataTable14_7  ;; 0x4007c008
        STRB     R4,[R3, R5]
//  868 }
        POP      {R4,R5}
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable8:
        DC32     0xf3ffffff
//  869 
//  870 //*****************************************************************************
//  871 //
//  872 //! \brief Get the wakeup pin flag of the specified index.
//  873 //!
//  874 //! \param ulPinIndex is the index of the wakeup pin.
//  875 //!
//  876 //! This function is to Get the wakeup pin flag of the specified index.
//  877 //!
//  878 //! \return This function return the wakeup source Flag,if it is the wakeup
//  879 //!  source, it returns xtrue, xfalse if not.
//  880 //
//  881 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  882 xtBoolean
//  883 SysCtlWakeupPinFlagGet(unsigned long ulPinIndex)
//  884 {
SysCtlWakeupPinFlagGet:
        PUSH     {LR}
        MOVS     R1,R0
//  885     xtBoolean xtFlag = 0;
        MOVS     R2,#+0
//  886     xASSERT((ulPinIndex >= 0 && ulPinIndex <= 15));
//  887 
//  888     xtFlag = (xHWREGB(LLWU_F1+ulPinIndex/8) & (LLWU_F1_WUF0 << ulPinIndex));
        MOVS     R0,R1
        LSRS     R0,R0,#+3
        LDR      R3,??DataTable14_8  ;; 0x4007c005
        LDRB     R0,[R0, R3]
        MOVS     R3,#+1
        LSLS     R3,R3,R1
        ANDS     R3,R3,R0
        MOVS     R2,R3
//  889     if(xtFlag)
        UXTB     R2,R2
        CMP      R2,#+0
        BEQ      ??SysCtlWakeupPinFlagGet_0
//  890     {
//  891         return xtrue;
        MOVS     R0,#+1
        B        ??SysCtlWakeupPinFlagGet_1
//  892     }
//  893     else
//  894     {
//  895         return xfalse;
??SysCtlWakeupPinFlagGet_0:
        MOVS     R0,#+0
??SysCtlWakeupPinFlagGet_1:
        POP      {PC}             ;; return
//  896     }
//  897 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9:
        DC32     0x40048004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable9_1:
        DC32     0xfffeffff
//  898 
//  899 //*****************************************************************************
//  900 //
//  901 //! \brief Get the wakeup pin Filter flag of the specified index.
//  902 //!
//  903 //! \param ulFilterIndex is the index of the wakeup pin filter.
//  904 //!
//  905 //! This function is to Get the wakeup pin filter flag of the specified index.
//  906 //!
//  907 //! \return This function return the wakeup filter source Flag,if it is the wakeup
//  908 //!  source, it returns xtrue, xfalse if not.
//  909 //
//  910 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  911 xtBoolean
//  912 SysCtlWakeupPinFilterFlagGet(unsigned long ulFilterIndex)
//  913 {
SysCtlWakeupPinFilterFlagGet:
        PUSH     {LR}
        MOVS     R1,R0
//  914     xtBoolean xtFlag = 0;
        MOVS     R2,#+0
//  915     xASSERT((ulFilterIndex >= 1 && ulFilterIndex <= 2));
//  916 
//  917     xtFlag = (xHWREGB(LLWU_FILT1+ulFilterIndex/2) & LLWU_FILT1_FILTSEL_FILTF);
        MOVS     R0,R1
        LSRS     R0,R0,#+1
        LDR      R3,??DataTable14_7  ;; 0x4007c008
        LDRB     R0,[R0, R3]
        MOVS     R3,#+128
        ANDS     R0,R0,R3
        MOVS     R2,R0
//  918     if(xtFlag)
        UXTB     R2,R2
        CMP      R2,#+0
        BEQ      ??SysCtlWakeupPinFilterFlagGet_0
//  919     {
//  920         return xtrue;
        MOVS     R0,#+1
        B        ??SysCtlWakeupPinFilterFlagGet_1
//  921     }
//  922     else
//  923     {
//  924         return xfalse;
??SysCtlWakeupPinFilterFlagGet_0:
        MOVS     R0,#+0
??SysCtlWakeupPinFilterFlagGet_1:
        POP      {PC}             ;; return
//  925     }
//  926 }
//  927 //*****************************************************************************
//  928 //
//  929 //! \brief Get the wakeup Module flag of the specified index.
//  930 //!
//  931 //! \param ulModuleIndex is the index of the wakeup Module.
//  932 //!
//  933 //! This function is to Get the wakeup module flag of the specified index.
//  934 //!
//  935 //! \return This function return the wakeup source Flag,if it is the wakeup
//  936 //!  source, it returns xtrue, xfalse if not.
//  937 //
//  938 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  939 xtBoolean
//  940 SysCtlWakeupModuleFlagGet(unsigned long ulModuleIndex)
//  941 {
SysCtlWakeupModuleFlagGet:
        PUSH     {LR}
        MOVS     R1,R0
//  942     xtBoolean xtFlag = 0;
        MOVS     R2,#+0
//  943     xASSERT((ulModuleIndex >= 0 && ulModuleIndex <= 7));
//  944 
//  945     xtFlag = (xHWREGB(LLWU_F3) & (LLWU_F3_MWUF0 << ulModuleIndex));
        LDR      R0,??DataTable14_9  ;; 0x4007c007
        LDRB     R0,[R0, #+0]
        MOVS     R3,#+1
        LSLS     R3,R3,R1
        ANDS     R3,R3,R0
        MOVS     R2,R3
//  946     if(xtFlag)
        UXTB     R2,R2
        CMP      R2,#+0
        BEQ      ??SysCtlWakeupModuleFlagGet_0
//  947     {
//  948         return xtrue;
        MOVS     R0,#+1
        B        ??SysCtlWakeupModuleFlagGet_1
//  949     }
//  950     else
//  951     {
//  952         return xfalse;
??SysCtlWakeupModuleFlagGet_0:
        MOVS     R0,#+0
??SysCtlWakeupModuleFlagGet_1:
        POP      {PC}             ;; return
//  953     }
//  954 }
//  955 
//  956 //*****************************************************************************
//  957 //
//  958 //! \brief Enables Wakeup Module or not.
//  959 //!
//  960 //! \param bEnable is a boolean that is \b true if Enable wakeup pin,
//  961 //! \b false if not.
//  962 //! \param ulModuleIndex is the index of the wakeup pin.
//  963 //!
//  964 //! This function is to Enable Wakeup Module or not.
//  965 //!
//  966 //! \return This function does not return.
//  967 //
//  968 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  969 void
//  970 SysCtlWakeupModuleEnable(xtBoolean bEnable, unsigned long ulModuleIndex)
//  971 {
SysCtlWakeupModuleEnable:
        PUSH     {R4,LR}
//  972     xASSERT((ulModuleIndex >= 0 && ulModuleIndex <= 15));
//  973 
//  974     //
//  975     // Enable wakeup module.
//  976     //
//  977     if(bEnable)
        UXTB     R0,R0
        CMP      R0,#+0
        BEQ      ??SysCtlWakeupModuleEnable_0
//  978     {
//  979         xHWREGB(LLWU_ME) &= 0x00;
        LDR      R2,??DataTable15  ;; 0x4007c004
        LDRB     R2,[R2, #+0]
        LDR      R3,??DataTable15  ;; 0x4007c004
        MOVS     R4,#+0
        STRB     R4,[R3, #+0]
//  980         xHWREGB(LLWU_ME) |= LLWU_ME_WUME0 << ulModuleIndex;
        LDR      R3,??DataTable15  ;; 0x4007c004
        LDRB     R3,[R3, #+0]
        MOVS     R4,#+1
        LSLS     R4,R4,R1
        ORRS     R4,R4,R3
        LDR      R3,??DataTable15  ;; 0x4007c004
        STRB     R4,[R3, #+0]
        B        ??SysCtlWakeupModuleEnable_1
//  981     }
//  982     else
//  983     {
//  984         xHWREGB(LLWU_ME) &= ~(LLWU_ME_WUME0 << ulModuleIndex);
??SysCtlWakeupModuleEnable_0:
        LDR      R2,??DataTable15  ;; 0x4007c004
        LDRB     R2,[R2, #+0]
        MOVS     R3,#+1
        LSLS     R3,R3,R1
        BICS     R2,R2,R3
        LDR      R3,??DataTable15  ;; 0x4007c004
        STRB     R2,[R3, #+0]
//  985     }
//  986 }
??SysCtlWakeupModuleEnable_1:
        POP      {R4,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12:
        DC32     0xfcffffff
//  987 //*****************************************************************************
//  988 //
//  989 //! \brief Puts the processor into sleep mode.
//  990 //!
//  991 //! This function places the processor into sleep mode; it will not return
//  992 //! until the processor returns to run mode.
//  993 //!
//  994 //! \return None.
//  995 //
//  996 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  997 void
//  998 SysCtlSleep(void)
//  999 {
SysCtlSleep:
        PUSH     {R7,LR}
// 1000     //
// 1001     // Clear the SLEEPDEEP bit to make sure we go into WAIT(sleep) mode 
// 1002     // instead of deep sleep
// 1003     //
// 1004     xHWREG(SCB_SCR) &= ~SCB_SCR_SLEEPDEEP;
        LDR      R0,??DataTable16  ;; 0xe000e000
        LDR      R0,[R0, #+0]
        MOVS     R1,#+4
        BICS     R0,R0,R1
        LDR      R1,??DataTable16  ;; 0xe000e000
        STR      R0,[R1, #+0]
// 1005     //
// 1006     // WFI instruction will start entry into STOP mode
// 1007     //
// 1008     xCPUwfi();
        BL       xCPUwfi
// 1009 }
        POP      {R0,PC}          ;; return
// 1010 
// 1011 //*****************************************************************************
// 1012 //
// 1013 //! \brief Puts the processor into deep-sleep mode.
// 1014 //!
// 1015 //! This function places the processor into deep-sleep mode; it will not return
// 1016 //! until the processor returns to run mode.
// 1017 //!
// 1018 //! \return None.
// 1019 //
// 1020 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1021 void
// 1022 SysCtlDeepSleep(void)
// 1023 {
SysCtlDeepSleep:
        PUSH     {R7,LR}
// 1024     //
// 1025     // Set the SLEEPDEEP bit to enable deep sleep mode(STOP).
// 1026     //
// 1027     xHWREG(SCB_SCR) |= SCB_SCR_SLEEPDEEP;
        LDR      R0,??DataTable16  ;; 0xe000e000
        LDR      R0,[R0, #+0]
        MOVS     R1,#+4
        ORRS     R1,R1,R0
        LDR      R0,??DataTable16  ;; 0xe000e000
        STR      R1,[R0, #+0]
// 1028     
// 1029     //
// 1030     // WFI instruction will start entry into STOP mode
// 1031     //
// 1032     xCPUwfi();
        BL       xCPUwfi
// 1033 }
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14:
        DC32     0xfffbffff

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_1:
        DC32     0x80704

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_2:
        DC32     0xc0700

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_3:
        DC32     0xc0701

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_4:
        DC32     0x40048100

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_5:
        DC32     g_pulAXBCLKRegs

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_6:
        DC32     0x4007c000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_7:
        DC32     0x4007c008

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_8:
        DC32     0x4007c005

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14_9:
        DC32     0x4007c007
// 1034 
// 1035 //*****************************************************************************
// 1036 //
// 1037 //! \brief Set a peripheral clock source.
// 1038 //!
// 1039 //! \param ulPeripheralSrc is the peripheral clock source to set.
// 1040 //!
// 1041 //! Peripherals clock source are seted with this function.  At power-up, all 
// 1042 //! Peripherals clock source are Peripherals clock source; they must be set in 
// 1043 //! order to operate or respond to register reads/writes.
// 1044 //!
// 1045 //! The \e ulPeripheralSrc parameter must be only one of the following values:
// 1046 //! \b SYSCTL_PERIPH_RTC_S_OSC32KCLK,  \b SYSCTL_PERIPH_RTC_S_RTC_CLKIN, 
// 1047 //! \b SYSCTL_PERIPH_RTC_S_LPO,        \b SYSCTL_PERIPH_LPTMR_S_OSC32KCLK, 
// 1048 //! \b SYSCTL_PERIPH_LPTMR_S_RTC_CLKIN,\b SYSCTL_PERIPH_LPTMR_S_LPO, 
// 1049 //! \b SYSCTL_PERIPH_TPM_S_MCGFLLCLK,  \b SYSCTL_PERIPH_TPM_S_MCGPLLCLK_2, 
// 1050 //! \b SYSCTL_PERIPH_TPM_S_OSCERCLK,   \b SYSCTL_PERIPH_TPM_S_MCGIRCLK, 
// 1051 //! \b SYSCTL_PERIPH_UART0_S_MCGFLLCLK,\b SYSCTL_PERIPH_UART0_S_MCGPLLCLK_2,
// 1052 //! \b SYSCTL_PERIPH_UART0_S_OSCERCLK, \b SYSCTL_PERIPH_UART0_S_MCGIRCLK, 
// 1053 //! \b SYSCTL_PERIPH_USB_S_USB_CLKIN,  \b SYSCTL_PERIPH_USB_S_MCGPLLCLK_2, 
// 1054 //! \b SYSCTL_PERIPH_USB_S_MCGFLLCLK,  \b SYSCTL_PERIPH_WDG_S_1K,
// 1055 //! \b SYSCTL_PERIPH_WDG_S_BUS,        \b SYSCTL_PERIPH_ADC_S_BUSCLK,
// 1056 //! \b SYSCTL_PERIPH_ADC_S_BUSCLK_2,   \b SYSCTL_PERIPH_ADC_S_ATCLK,
// 1057 //! \b SYSCTL_PERIPH_ADC_S_ADACK.
// 1058 //!
// 1059 //! \return None.
// 1060 //
// 1061 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1062 void
// 1063 SysCtlPeripheralClockSourceSet(unsigned long ulPeripheralSrc)
// 1064 {
SysCtlPeripheralClockSourceSet:
        PUSH     {LR}
// 1065     //
// 1066     // Check the arguments.
// 1067     //
// 1068     xASSERT((ulPeripheralSrc == SYSCTL_PERIPH_RTC_S_OSC32KCLK) ||
// 1069             (ulPeripheralSrc == SYSCTL_PERIPH_RTC_S_RTC_CLKIN) ||
// 1070             (ulPeripheralSrc == SYSCTL_PERIPH_LPTMR_S_OSC32KCLK)||
// 1071             (ulPeripheralSrc == SYSCTL_PERIPH_LPTMR_S_RTC_CLKIN) ||
// 1072             (ulPeripheralSrc == SYSCTL_PERIPH_LPTMR_S_LPO) ||
// 1073             (ulPeripheralSrc == SYSCTL_PERIPH_RTC_S_LPO) ||
// 1074             (ulPeripheralSrc == SYSCTL_PERIPH_WDG_S_1K) ||
// 1075             (ulPeripheralSrc == SYSCTL_PERIPH_ADC_S_BUSCLK) ||
// 1076             (ulPeripheralSrc == SYSCTL_PERIPH_ADC_S_BUSCLK_2) ||
// 1077             (ulPeripheralSrc == SYSCTL_PERIPH_ADC_S_ATCLK) ||
// 1078             (ulPeripheralSrc == SYSCTL_PERIPH_ADC_S_ADACK) ||
// 1079             (ulPeripheralSrc == SYSCTL_PERIPH_TPM_S_MCGFLLCLK)||
// 1080             (ulPeripheralSrc == SYSCTL_PERIPH_TPM_S_MCGPLLCLK_2) ||
// 1081             (ulPeripheralSrc == SYSCTL_PERIPH_TPM_S_OSCERCLK) ||
// 1082             (ulPeripheralSrc == SYSCTL_PERIPH_TPM_S_MCGIRCLK)||
// 1083             (ulPeripheralSrc == SYSCTL_PERIPH_UART0_S_MCGFLLCLK) ||
// 1084             (ulPeripheralSrc == SYSCTL_PERIPH_UART0_S_MCGPLLCLK_2) ||
// 1085             (ulPeripheralSrc == SYSCTL_PERIPH_UART0_S_OSCERCLK) ||
// 1086             (ulPeripheralSrc == SYSCTL_PERIPH_UART0_S_MCGIRCLK) ||
// 1087             (ulPeripheralSrc == SYSCTL_PERIPH_USB_S_USB_CLKIN) ||
// 1088             (ulPeripheralSrc == SYSCTL_PERIPH_USB_S_MCGPLLCLK_2) ||
// 1089             (ulPeripheralSrc == SYSCTL_PERIPH_USB_S_MCGFLLCLK) ||
// 1090             (ulPeripheralSrc == SYSCTL_PERIPH_WDG_S_BUS));
// 1091 
// 1092     //
// 1093     // Set this peripheral clock source
// 1094     //
// 1095     if(ulPeripheralSrc == SYSCTL_PERIPH_RTC_S_OSC32KCLK)
        CMP      R0,#+0
        BNE      ??SysCtlPeripheralClockSourceSet_0
// 1096     {
// 1097         xHWREG(SIM_SOPT1) &= ~SIM_SOPT1_OSC32KSEL_M;
        LDR      R1,??DataTable16_1  ;; 0x40047000
        LDR      R1,[R1, #+0]
        LDR      R2,??DataTable16_2  ;; 0xfff3ffff
        ANDS     R2,R2,R1
        LDR      R1,??DataTable16_1  ;; 0x40047000
        STR      R2,[R1, #+0]
// 1098         xHWREG(SIM_SOPT1) |= SIM_SOPT1_OSC32KSEL_OSC32KCLK;
        LDR      R1,??DataTable16_1  ;; 0x40047000
        LDR      R2,??DataTable16_1  ;; 0x40047000
        LDR      R2,[R2, #+0]
        STR      R2,[R1, #+0]
        B        ??SysCtlPeripheralClockSourceSet_1
// 1099     }
// 1100     else if(ulPeripheralSrc == SYSCTL_PERIPH_RTC_S_RTC_CLKIN)
??SysCtlPeripheralClockSourceSet_0:
        MOVS     R1,#+128
        LSLS     R1,R1,#+9        ;; #+65536
        CMP      R0,R1
        BNE      ??SysCtlPeripheralClockSourceSet_2
// 1101     {
// 1102         xHWREG(SIM_SOPT1) &= ~SIM_SOPT1_OSC32KSEL_M;
        LDR      R1,??DataTable16_1  ;; 0x40047000
        LDR      R1,[R1, #+0]
        LDR      R2,??DataTable16_2  ;; 0xfff3ffff
        ANDS     R2,R2,R1
        LDR      R1,??DataTable16_1  ;; 0x40047000
        STR      R2,[R1, #+0]
// 1103         xHWREG(SIM_SOPT1) |= SIM_SOPT1_OSC32KSEL_RTC_CLKIN;
        LDR      R1,??DataTable16_1  ;; 0x40047000
        LDR      R1,[R1, #+0]
        MOVS     R2,#+128
        LSLS     R2,R2,#+12       ;; #+524288
        ORRS     R2,R2,R1
        LDR      R1,??DataTable16_1  ;; 0x40047000
        STR      R2,[R1, #+0]
        B        ??SysCtlPeripheralClockSourceSet_1
// 1104     }
// 1105     else if(ulPeripheralSrc == SYSCTL_PERIPH_RTC_S_LPO)
??SysCtlPeripheralClockSourceSet_2:
        MOVS     R1,#+192
        LSLS     R1,R1,#+12       ;; #+786432
        CMP      R0,R1
        BNE      ??SysCtlPeripheralClockSourceSet_3
// 1106     {
// 1107         xHWREG(SIM_SOPT1) &= ~SIM_SOPT1_OSC32KSEL_M;
        LDR      R1,??DataTable16_1  ;; 0x40047000
        LDR      R1,[R1, #+0]
        LDR      R2,??DataTable16_2  ;; 0xfff3ffff
        ANDS     R2,R2,R1
        LDR      R1,??DataTable16_1  ;; 0x40047000
        STR      R2,[R1, #+0]
// 1108         xHWREG(SIM_SOPT1) |= SIM_SOPT1_OSC32KSEL_LPO;
        LDR      R1,??DataTable16_1  ;; 0x40047000
        LDR      R1,[R1, #+0]
        MOVS     R2,#+192
        LSLS     R2,R2,#+12       ;; #+786432
        ORRS     R2,R2,R1
        LDR      R1,??DataTable16_1  ;; 0x40047000
        STR      R2,[R1, #+0]
        B        ??SysCtlPeripheralClockSourceSet_1
// 1109     }
// 1110     else if(ulPeripheralSrc == SYSCTL_PERIPH_ADC_S_BUSCLK)
??SysCtlPeripheralClockSourceSet_3:
        MOVS     R1,#+204
        LSLS     R1,R1,#+24       ;; #-872415232
        CMP      R0,R1
        BNE      ??SysCtlPeripheralClockSourceSet_4
// 1111     {
// 1112         xHWREG(ADC_BASE + ADC0_CFG1) &= ~ADC0_CFG1_ADICLK_M;
        LDR      R1,??DataTable18  ;; 0x4003b008
        LDR      R1,[R1, #+0]
        MOVS     R2,#+3
        BICS     R1,R1,R2
        LDR      R2,??DataTable18  ;; 0x4003b008
        STR      R1,[R2, #+0]
        B        ??SysCtlPeripheralClockSourceSet_1
// 1113     }
// 1114     else if(ulPeripheralSrc == SYSCTL_PERIPH_ADC_S_BUSCLK_2)
??SysCtlPeripheralClockSourceSet_4:
        MOVS     R1,#+205
        LSLS     R1,R1,#+24       ;; #-855638016
        CMP      R0,R1
        BNE      ??SysCtlPeripheralClockSourceSet_5
// 1115     {
// 1116         xHWREG(ADC_BASE + ADC0_CFG1) &= ~ADC0_CFG1_ADICLK_M;
        LDR      R1,??DataTable18  ;; 0x4003b008
        LDR      R1,[R1, #+0]
        MOVS     R2,#+3
        BICS     R1,R1,R2
        LDR      R2,??DataTable18  ;; 0x4003b008
        STR      R1,[R2, #+0]
// 1117         xHWREG(ADC_BASE + ADC0_CFG1) |= ADC0_CFG1_ADICLK_BUSCLK_2;
        LDR      R1,??DataTable18  ;; 0x4003b008
        LDR      R1,[R1, #+0]
        MOVS     R2,#+1
        ORRS     R2,R2,R1
        LDR      R1,??DataTable18  ;; 0x4003b008
        STR      R2,[R1, #+0]
        B        ??SysCtlPeripheralClockSourceSet_1
// 1118     }
// 1119     else if(ulPeripheralSrc == SYSCTL_PERIPH_ADC_S_ATCLK)
??SysCtlPeripheralClockSourceSet_5:
        MOVS     R1,#+206
        LSLS     R1,R1,#+24       ;; #-838860800
        CMP      R0,R1
        BNE      ??SysCtlPeripheralClockSourceSet_6
// 1120     {
// 1121         xHWREG(ADC_BASE + ADC0_CFG1) &= ~ADC0_CFG1_ADICLK_M;
        LDR      R1,??DataTable18  ;; 0x4003b008
        LDR      R1,[R1, #+0]
        MOVS     R2,#+3
        BICS     R1,R1,R2
        LDR      R2,??DataTable18  ;; 0x4003b008
        STR      R1,[R2, #+0]
// 1122         xHWREG(ADC_BASE + ADC0_CFG1) |= ADC0_CFG1_ADICLK_ALTCLK;
        LDR      R1,??DataTable18  ;; 0x4003b008
        LDR      R1,[R1, #+0]
        MOVS     R2,#+2
        ORRS     R2,R2,R1
        LDR      R1,??DataTable18  ;; 0x4003b008
        STR      R2,[R1, #+0]
        B        ??SysCtlPeripheralClockSourceSet_1
// 1123     }
// 1124     else if(ulPeripheralSrc == SYSCTL_PERIPH_ADC_S_ADACK)
??SysCtlPeripheralClockSourceSet_6:
        MOVS     R1,#+207
        LSLS     R1,R1,#+24       ;; #-822083584
        CMP      R0,R1
        BNE      ??SysCtlPeripheralClockSourceSet_7
// 1125     {
// 1126         xHWREG(ADC_BASE + ADC0_CFG1) &= ~ADC0_CFG1_ADICLK_M;
        LDR      R1,??DataTable18  ;; 0x4003b008
        LDR      R1,[R1, #+0]
        MOVS     R2,#+3
        BICS     R1,R1,R2
        LDR      R2,??DataTable18  ;; 0x4003b008
        STR      R1,[R2, #+0]
// 1127         xHWREG(ADC_BASE + ADC0_CFG1) |= ADC0_CFG1_ADICLK_ADACK;
        LDR      R1,??DataTable18  ;; 0x4003b008
        LDR      R1,[R1, #+0]
        MOVS     R2,#+3
        ORRS     R2,R2,R1
        LDR      R1,??DataTable18  ;; 0x4003b008
        STR      R2,[R1, #+0]
        B        ??SysCtlPeripheralClockSourceSet_1
// 1128     }
// 1129     else if(ulPeripheralSrc == SYSCTL_PERIPH_UART0_S_MCGFLLCLK)
??SysCtlPeripheralClockSourceSet_7:
        MOVS     R1,#+128
        LSLS     R1,R1,#+19       ;; #+67108864
        CMP      R0,R1
        BNE      ??SysCtlPeripheralClockSourceSet_8
// 1130     {
// 1131         xHWREG(SIM_SOPT2) &= ~SIM_SOPT2_PLLFLLSEL;    
        LDR      R1,??DataTable25  ;; 0x40048004
        LDR      R1,[R1, #+0]
        LDR      R2,??DataTable24  ;; 0xfffeffff
        ANDS     R2,R2,R1
        LDR      R1,??DataTable25  ;; 0x40048004
        STR      R2,[R1, #+0]
// 1132         xHWREG(SIM_SOPT2) &= ~SIM_SOPT2_UART0SRC_M;
        LDR      R1,??DataTable25  ;; 0x40048004
        LDR      R1,[R1, #+0]
        LDR      R2,??DataTable23  ;; 0xf3ffffff
        ANDS     R2,R2,R1
        LDR      R1,??DataTable25  ;; 0x40048004
        STR      R2,[R1, #+0]
// 1133         xHWREG(SIM_SOPT2) |= SIM_SOPT2_UART0SRC_MCGXLL;
        LDR      R1,??DataTable25  ;; 0x40048004
        LDR      R1,[R1, #+0]
        MOVS     R2,#+128
        LSLS     R2,R2,#+19       ;; #+67108864
        ORRS     R2,R2,R1
        LDR      R1,??DataTable25  ;; 0x40048004
        STR      R2,[R1, #+0]
        B        ??SysCtlPeripheralClockSourceSet_1
// 1134     }
// 1135     else if(ulPeripheralSrc == SYSCTL_PERIPH_UART0_S_MCGPLLCLK_2)
??SysCtlPeripheralClockSourceSet_8:
        MOVS     R1,#+164
        LSLS     R1,R1,#+24       ;; #-1543503872
        CMP      R0,R1
        BNE      ??SysCtlPeripheralClockSourceSet_9
// 1136     {
// 1137         xHWREG(SIM_SOPT2) |= SIM_SOPT2_PLLFLLSEL;    
        LDR      R1,??DataTable25  ;; 0x40048004
        LDR      R1,[R1, #+0]
        MOVS     R2,#+128
        LSLS     R2,R2,#+9        ;; #+65536
        ORRS     R2,R2,R1
        LDR      R1,??DataTable25  ;; 0x40048004
        STR      R2,[R1, #+0]
// 1138         xHWREG(SIM_SOPT2) &= ~SIM_SOPT2_UART0SRC_M;
        LDR      R1,??DataTable25  ;; 0x40048004
        LDR      R1,[R1, #+0]
        LDR      R2,??DataTable23  ;; 0xf3ffffff
        ANDS     R2,R2,R1
        LDR      R1,??DataTable25  ;; 0x40048004
        STR      R2,[R1, #+0]
// 1139         xHWREG(SIM_SOPT2) |= SIM_SOPT2_UART0SRC_MCGXLL;
        LDR      R1,??DataTable25  ;; 0x40048004
        LDR      R1,[R1, #+0]
        MOVS     R2,#+128
        LSLS     R2,R2,#+19       ;; #+67108864
        ORRS     R2,R2,R1
        LDR      R1,??DataTable25  ;; 0x40048004
        STR      R2,[R1, #+0]
        B        ??SysCtlPeripheralClockSourceSet_1
// 1140     }
// 1141     else if(ulPeripheralSrc == SYSCTL_PERIPH_UART0_S_OSCERCLK)
??SysCtlPeripheralClockSourceSet_9:
        MOVS     R1,#+128
        LSLS     R1,R1,#+20       ;; #+134217728
        CMP      R0,R1
        BNE      ??SysCtlPeripheralClockSourceSet_10
// 1142     {
// 1143         xHWREG(SIM_SOPT2) &= ~SIM_SOPT2_UART0SRC_M;
        LDR      R1,??DataTable25  ;; 0x40048004
        LDR      R1,[R1, #+0]
        LDR      R2,??DataTable23  ;; 0xf3ffffff
        ANDS     R2,R2,R1
        LDR      R1,??DataTable25  ;; 0x40048004
        STR      R2,[R1, #+0]
// 1144         xHWREG(SIM_SOPT2) |= SIM_SOPT2_UART0SRC_OSCERCLK;
        LDR      R1,??DataTable25  ;; 0x40048004
        LDR      R1,[R1, #+0]
        MOVS     R2,#+128
        LSLS     R2,R2,#+20       ;; #+134217728
        ORRS     R2,R2,R1
        LDR      R1,??DataTable25  ;; 0x40048004
        STR      R2,[R1, #+0]
        B        ??SysCtlPeripheralClockSourceSet_1
// 1145     }
// 1146     else if(ulPeripheralSrc == SYSCTL_PERIPH_UART0_S_MCGIRCLK)
??SysCtlPeripheralClockSourceSet_10:
        MOVS     R1,#+192
        LSLS     R1,R1,#+20       ;; #+201326592
        CMP      R0,R1
        BNE      ??SysCtlPeripheralClockSourceSet_11
// 1147     {
// 1148         xHWREG(SIM_SOPT2) &= ~SIM_SOPT2_UART0SRC_M;
        LDR      R1,??DataTable25  ;; 0x40048004
        LDR      R1,[R1, #+0]
        LDR      R2,??DataTable23  ;; 0xf3ffffff
        ANDS     R2,R2,R1
        LDR      R1,??DataTable25  ;; 0x40048004
        STR      R2,[R1, #+0]
// 1149         xHWREG(SIM_SOPT2) |= SIM_SOPT2_UART0SRC_MCGIRCLK;
        LDR      R1,??DataTable25  ;; 0x40048004
        LDR      R1,[R1, #+0]
        MOVS     R2,#+192
        LSLS     R2,R2,#+20       ;; #+201326592
        ORRS     R2,R2,R1
        LDR      R1,??DataTable25  ;; 0x40048004
        STR      R2,[R1, #+0]
        B        ??SysCtlPeripheralClockSourceSet_1
// 1150     }
// 1151     else if(ulPeripheralSrc == SYSCTL_PERIPH_TPM_S_MCGFLLCLK)
??SysCtlPeripheralClockSourceSet_11:
        MOVS     R1,#+128
        LSLS     R1,R1,#+17       ;; #+16777216
        CMP      R0,R1
        BNE      ??SysCtlPeripheralClockSourceSet_12
// 1152     {
// 1153         xHWREG(SIM_SOPT2) &= ~SIM_SOPT2_PLLFLLSEL;  
        LDR      R1,??DataTable25  ;; 0x40048004
        LDR      R1,[R1, #+0]
        LDR      R2,??DataTable24  ;; 0xfffeffff
        ANDS     R2,R2,R1
        LDR      R1,??DataTable25  ;; 0x40048004
        STR      R2,[R1, #+0]
// 1154         xHWREG(SIM_SOPT2) &= ~SIM_SOPT2_TPMSRC_M;
        LDR      R1,??DataTable25  ;; 0x40048004
        LDR      R1,[R1, #+0]
        LDR      R2,??DataTable28  ;; 0xfcffffff
        ANDS     R2,R2,R1
        LDR      R1,??DataTable25  ;; 0x40048004
        STR      R2,[R1, #+0]
// 1155         xHWREG(SIM_SOPT2) |= SIM_SOPT2_TPMSRC_MCGXLL;
        LDR      R1,??DataTable25  ;; 0x40048004
        LDR      R1,[R1, #+0]
        MOVS     R2,#+128
        LSLS     R2,R2,#+17       ;; #+16777216
        ORRS     R2,R2,R1
        LDR      R1,??DataTable25  ;; 0x40048004
        STR      R2,[R1, #+0]
        B        ??SysCtlPeripheralClockSourceSet_1
// 1156     }
// 1157     else if(ulPeripheralSrc == SYSCTL_PERIPH_TPM_S_MCGPLLCLK_2)
??SysCtlPeripheralClockSourceSet_12:
        MOVS     R1,#+161
        LSLS     R1,R1,#+24       ;; #-1593835520
        CMP      R0,R1
        BNE      ??SysCtlPeripheralClockSourceSet_13
// 1158     {
// 1159         xHWREG(SIM_SOPT2)|= SIM_SOPT2_PLLFLLSEL;  
        LDR      R1,??DataTable25  ;; 0x40048004
        LDR      R1,[R1, #+0]
        MOVS     R2,#+128
        LSLS     R2,R2,#+9        ;; #+65536
        ORRS     R2,R2,R1
        LDR      R1,??DataTable25  ;; 0x40048004
        STR      R2,[R1, #+0]
// 1160         xHWREG(SIM_SOPT2) &= ~SIM_SOPT2_TPMSRC_M;
        LDR      R1,??DataTable25  ;; 0x40048004
        LDR      R1,[R1, #+0]
        LDR      R2,??DataTable28  ;; 0xfcffffff
        ANDS     R2,R2,R1
        LDR      R1,??DataTable25  ;; 0x40048004
        STR      R2,[R1, #+0]
// 1161         xHWREG(SIM_SOPT2) |= SIM_SOPT2_TPMSRC_MCGXLL;
        LDR      R1,??DataTable25  ;; 0x40048004
        LDR      R1,[R1, #+0]
        MOVS     R2,#+128
        LSLS     R2,R2,#+17       ;; #+16777216
        ORRS     R2,R2,R1
        LDR      R1,??DataTable25  ;; 0x40048004
        STR      R2,[R1, #+0]
        B        ??SysCtlPeripheralClockSourceSet_1
// 1162     }
// 1163     else if(ulPeripheralSrc == SYSCTL_PERIPH_TPM_S_OSCERCLK)
??SysCtlPeripheralClockSourceSet_13:
        MOVS     R1,#+128
        LSLS     R1,R1,#+18       ;; #+33554432
        CMP      R0,R1
        BNE      ??SysCtlPeripheralClockSourceSet_14
// 1164     {
// 1165         xHWREG(SIM_SOPT2) &= ~SIM_SOPT2_TPMSRC_M;
        LDR      R1,??DataTable25  ;; 0x40048004
        LDR      R1,[R1, #+0]
        LDR      R2,??DataTable28  ;; 0xfcffffff
        ANDS     R2,R2,R1
        LDR      R1,??DataTable25  ;; 0x40048004
        STR      R2,[R1, #+0]
// 1166         xHWREG(SIM_SOPT2) |= SIM_SOPT2_TPMSRC_OSCERCLK;
        LDR      R1,??DataTable25  ;; 0x40048004
        LDR      R1,[R1, #+0]
        MOVS     R2,#+128
        LSLS     R2,R2,#+18       ;; #+33554432
        ORRS     R2,R2,R1
        LDR      R1,??DataTable25  ;; 0x40048004
        STR      R2,[R1, #+0]
        B        ??SysCtlPeripheralClockSourceSet_1
// 1167     }
// 1168     else if(ulPeripheralSrc == SYSCTL_PERIPH_TPM_S_MCGIRCLK)
??SysCtlPeripheralClockSourceSet_14:
        MOVS     R1,#+192
        LSLS     R1,R1,#+18       ;; #+50331648
        CMP      R0,R1
        BNE      ??SysCtlPeripheralClockSourceSet_15
// 1169     {
// 1170         xHWREG(SIM_SOPT2) &= ~SIM_SOPT2_TPMSRC_M;
        LDR      R1,??DataTable25  ;; 0x40048004
        LDR      R1,[R1, #+0]
        LDR      R2,??DataTable28  ;; 0xfcffffff
        ANDS     R2,R2,R1
        LDR      R1,??DataTable25  ;; 0x40048004
        STR      R2,[R1, #+0]
// 1171         xHWREG(SIM_SOPT2) |= SIM_SOPT2_TPMSRC_MCGIRCLK;
        LDR      R1,??DataTable25  ;; 0x40048004
        LDR      R1,[R1, #+0]
        MOVS     R2,#+192
        LSLS     R2,R2,#+18       ;; #+50331648
        ORRS     R2,R2,R1
        LDR      R1,??DataTable25  ;; 0x40048004
        STR      R2,[R1, #+0]
        B        ??SysCtlPeripheralClockSourceSet_1
// 1172     }
// 1173     else if(ulPeripheralSrc == SYSCTL_PERIPH_USB_S_USB_CLKIN)
??SysCtlPeripheralClockSourceSet_15:
        MOVS     R1,#+176
        LSLS     R1,R1,#+24       ;; #-1342177280
        CMP      R0,R1
        BNE      ??SysCtlPeripheralClockSourceSet_16
// 1174     {
// 1175         xHWREG(SIM_SOPT2) &= ~SIM_SOPT2_USBSRC;
        LDR      R1,??DataTable25  ;; 0x40048004
        LDR      R1,[R1, #+0]
        LDR      R2,??DataTable31  ;; 0xfffbffff
        ANDS     R2,R2,R1
        LDR      R1,??DataTable25  ;; 0x40048004
        STR      R2,[R1, #+0]
        B        ??SysCtlPeripheralClockSourceSet_1
// 1176     }
// 1177     else if(ulPeripheralSrc == SYSCTL_PERIPH_USB_S_MCGFLLCLK)
??SysCtlPeripheralClockSourceSet_16:
        LDR      R1,??DataTable31_1  ;; 0xc0700
        CMP      R0,R1
        BNE      ??SysCtlPeripheralClockSourceSet_17
// 1178     {
// 1179         xHWREG(SIM_SOPT2) &= ~SIM_SOPT2_PLLFLLSEL; 
        LDR      R1,??DataTable25  ;; 0x40048004
        LDR      R1,[R1, #+0]
        LDR      R2,??DataTable24  ;; 0xfffeffff
        ANDS     R2,R2,R1
        LDR      R1,??DataTable25  ;; 0x40048004
        STR      R2,[R1, #+0]
// 1180         xHWREG(SIM_SOPT2) |= SIM_SOPT2_USBSRC;
        LDR      R1,??DataTable25  ;; 0x40048004
        LDR      R1,[R1, #+0]
        MOVS     R2,#+128
        LSLS     R2,R2,#+11       ;; #+262144
        ORRS     R2,R2,R1
        LDR      R1,??DataTable25  ;; 0x40048004
        STR      R2,[R1, #+0]
        B        ??SysCtlPeripheralClockSourceSet_1
// 1181     }
// 1182     else if(ulPeripheralSrc == SYSCTL_PERIPH_USB_S_MCGPLLCLK_2)
??SysCtlPeripheralClockSourceSet_17:
        LDR      R1,??DataTable31_2  ;; 0x80704
        CMP      R0,R1
        BNE      ??SysCtlPeripheralClockSourceSet_18
// 1183     {
// 1184         xHWREG(SIM_SOPT2) |= SIM_SOPT2_PLLFLLSEL; 
        LDR      R1,??DataTable25  ;; 0x40048004
        LDR      R1,[R1, #+0]
        MOVS     R2,#+128
        LSLS     R2,R2,#+9        ;; #+65536
        ORRS     R2,R2,R1
        LDR      R1,??DataTable25  ;; 0x40048004
        STR      R2,[R1, #+0]
// 1185         xHWREG(SIM_SOPT2) |= SIM_SOPT2_USBSRC;
        LDR      R1,??DataTable25  ;; 0x40048004
        LDR      R1,[R1, #+0]
        MOVS     R2,#+128
        LSLS     R2,R2,#+11       ;; #+262144
        ORRS     R2,R2,R1
        LDR      R1,??DataTable25  ;; 0x40048004
        STR      R2,[R1, #+0]
        B        ??SysCtlPeripheralClockSourceSet_1
// 1186     }
// 1187     else if(ulPeripheralSrc == SYSCTL_PERIPH_WDG_S_1K)
??SysCtlPeripheralClockSourceSet_18:
        LDR      R1,??DataTable31_3  ;; 0xc0701
        CMP      R0,R1
        BNE      ??SysCtlPeripheralClockSourceSet_19
// 1188     {
// 1189         xHWREG(SIM_COPC ) &= ~SIM_COPC_COPCLKS;
        LDR      R1,??DataTable31_4  ;; 0x40048100
        LDR      R1,[R1, #+0]
        MOVS     R2,#+2
        BICS     R1,R1,R2
        LDR      R2,??DataTable31_4  ;; 0x40048100
        STR      R1,[R2, #+0]
        B        ??SysCtlPeripheralClockSourceSet_1
// 1190     }
// 1191     else
// 1192     {
// 1193         xHWREG(SIM_COPC ) |= SIM_COPC_COPCLKS;
??SysCtlPeripheralClockSourceSet_19:
        LDR      R1,??DataTable31_4  ;; 0x40048100
        LDR      R1,[R1, #+0]
        MOVS     R2,#+2
        ORRS     R2,R2,R1
        LDR      R1,??DataTable31_4  ;; 0x40048100
        STR      R2,[R1, #+0]
// 1194     }
// 1195 }
??SysCtlPeripheralClockSourceSet_1:
        POP      {PC}             ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable15:
        DC32     0x4007c004
// 1196 
// 1197 //*****************************************************************************
// 1198 //
// 1199 //! \brief Set a HCLK clock source.
// 1200 //!
// 1201 //! \param ucHclkSrcSel is the HCLK clock source to set.
// 1202 //!
// 1203 //! The function is used to select HCLK clock source
// 1204 //!
// 1205 //! The \e ucHclkSrcSel parameter must be only one of the following values:
// 1206 //! \b SYSCTL_HLCK_S_PLL, \b SYSCTL_HLCK_S_INT, \b SYSCTL_HLCK_S_MAIN.
// 1207 //!
// 1208 //! \return None.
// 1209 //
// 1210 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1211 void
// 1212 SysCtlHClockSourceSet(unsigned char ucHclkSrcSel)
// 1213 {
// 1214     //
// 1215     // Check the arguments.
// 1216     //
// 1217     xASSERT((ucHclkSrcSel==SYSCTL_HLCK_S_MAIN) ||
// 1218             (ucHclkSrcSel==SYSCTL_HLCK_S_PLL) ||
// 1219             (ucHclkSrcSel==SYSCTL_HLCK_S_INT));
// 1220 
// 1221     xHWREGB(MCG_C1) &= ~MCG_C1_SRC_MCGOUTCLK_M;
SysCtlHClockSourceSet:
        LDR      R1,??DataTable31_5  ;; 0x40064000
        LDRB     R1,[R1, #+0]
        LSLS     R1,R1,#+26       ;; ZeroExtS R1,R1,#+26,#+26
        LSRS     R1,R1,#+26
        LDR      R2,??DataTable31_5  ;; 0x40064000
        STRB     R1,[R2, #+0]
// 1222     xHWREGB(MCG_C1) |= ucHclkSrcSel;
        LDR      R1,??DataTable31_5  ;; 0x40064000
        LDRB     R1,[R1, #+0]
        ORRS     R1,R1,R0
        LDR      R2,??DataTable31_5  ;; 0x40064000
        STRB     R1,[R2, #+0]
// 1223 }
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable16:
        DC32     0xe000e000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable16_1:
        DC32     0x40047000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable16_2:
        DC32     0xfff3ffff
// 1224 
// 1225 //*****************************************************************************
// 1226 //
// 1227 //! \brief The function is used to Get reset source from last operation
// 1228 //!
// 1229 //! \param None.
// 1230 //!
// 1231 //! The function is used to Get reset source from last operation
// 1232 //!
// 1233 //! \return Reset source enumerated as a bit field of
// 1234 //! \b SYSCTL_RSTSRC_POR, \b SYSCTL_RSTSRC_PAD, \b SYSCTL_RSTSRC_WDG,
// 1235 //! \b SYSCTL_RSTSRC_LOL, \b SYSCTL_RSTSRC_LOC, \b SYSCTL_RSTSRC_LVD, 
// 1236 //! \b SYSCTL_RSTSRC_WAKEUP, \b SYSCTL_RSTSRC_SACKERR, \b SYSCTL_RSTSRC_MDM_AP
// 1237 //! \b SYSCTL_RSTSRC_SW, and \b SYSCTL_RSTSRC_LOCKUP.
// 1238 //
// 1239 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1240 unsigned long 
// 1241 SysCtlResetSrcGet(void)
// 1242 {
SysCtlResetSrcGet:
        PUSH     {LR}
// 1243     
// 1244     unsigned long ulResetSrc = 0;
        MOVS     R1,#+0
// 1245     //
// 1246     // Get reset source from last operation.
// 1247     //
// 1248     if((xHWREGB(RCM_SRS0)&SYSCTL_RSTSRC_PAD))
        LDR      R0,??DataTable31_6  ;; 0x4007f000
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+25
        BPL      ??SysCtlResetSrcGet_0
// 1249     {
// 1250         return SYSCTL_RSTSRC_PAD;
        MOVS     R0,#+64
        B        ??SysCtlResetSrcGet_1
// 1251     }
// 1252     if((xHWREGB(RCM_SRS0)&SYSCTL_RSTSRC_LOC))
??SysCtlResetSrcGet_0:
        LDR      R0,??DataTable31_6  ;; 0x4007f000
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+29
        BPL      ??SysCtlResetSrcGet_2
// 1253     {
// 1254         return SYSCTL_RSTSRC_LOC;
        MOVS     R0,#+4
        B        ??SysCtlResetSrcGet_1
// 1255     }
// 1256     if((xHWREGB(RCM_SRS0)&SYSCTL_RSTSRC_LOL))
??SysCtlResetSrcGet_2:
        LDR      R0,??DataTable31_6  ;; 0x4007f000
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+28
        BPL      ??SysCtlResetSrcGet_3
// 1257     {
// 1258         return SYSCTL_RSTSRC_LOL;
        MOVS     R0,#+8
        B        ??SysCtlResetSrcGet_1
// 1259     }
// 1260     if((xHWREGB(RCM_SRS0)&SYSCTL_RSTSRC_WDG))
??SysCtlResetSrcGet_3:
        LDR      R0,??DataTable31_6  ;; 0x4007f000
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+26
        BPL      ??SysCtlResetSrcGet_4
// 1261     {
// 1262         return SYSCTL_RSTSRC_WDG;
        MOVS     R0,#+32
        B        ??SysCtlResetSrcGet_1
// 1263     }
// 1264     else
// 1265     {
// 1266         ulResetSrc = xHWREGB(RCM_SRS0);
??SysCtlResetSrcGet_4:
        LDR      R0,??DataTable31_6  ;; 0x4007f000
        LDRB     R0,[R0, #+0]
        UXTB     R0,R0
        MOVS     R1,R0
// 1267         ulResetSrc = ulResetSrc | xHWREGB(RCM_SRS1);
        MOVS     R2,R1
        LDR      R0,??DataTable31_7  ;; 0x4007f001
        LDRB     R1,[R0, #+0]
        UXTB     R1,R1
        ORRS     R1,R1,R2
// 1268         return ulResetSrc;
        MOVS     R0,R1
??SysCtlResetSrcGet_1:
        POP      {PC}             ;; return
// 1269     }
// 1270 }
// 1271 
// 1272 //*****************************************************************************
// 1273 //
// 1274 //! \brief The function is used to Get The Current Power Mode
// 1275 //!
// 1276 //! \param None.
// 1277 //!
// 1278 //! The function is used to The Current Power Mode
// 1279 //!
// 1280 //! \return Reset source enumerated as a bit field of
// 1281 //! \b SYSCTL_POWER_MODE_RUN,  \b SYSCTL_POWER_MODE_STOP, 
// 1282 //! \b SYSCTL_POWER_MODE_VLPR, \b SYSCTL_POWER_MODE_VLPW,
// 1283 //! \b SYSCTL_POWER_MODE_VLPS, \b SYSCTL_POWER_MODE_LLS, SYSCTL_POWER_MODE_VLLS
// 1284 //
// 1285 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1286 unsigned long 
// 1287 SysCtlPowerModeGet(void)
// 1288 {
// 1289     //
// 1290     // Get The Current Power Mode.
// 1291     //
// 1292     return (xHWREGB(SMC_PMSTAT)&SMC_PMSTAT_PMSTAT_M);
SysCtlPowerModeGet:
        LDR      R0,??DataTable31_8  ;; 0x4007e003
        LDRB     R0,[R0, #+0]
        UXTB     R0,R0
        LSLS     R0,R0,#+25       ;; ZeroExtS R0,R0,#+25,#+25
        LSRS     R0,R0,#+25
        BX       LR               ;; return
// 1293 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable18:
        DC32     0x4003b008
// 1294 //*****************************************************************************
// 1295 //
// 1296 //! \brief The function is to Enable or Disbale Reset Pin Filter Select in Stop Mode 
// 1297 //!
// 1298 //! \param bEnable is a boolean that is \b true if Enable Reset Pin Filter Select
// 1299 //! in Stop Mode, \b false if not.
// 1300 //!
// 1301 //! \return None.
// 1302 //
// 1303 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1304 void 
// 1305 SysCtlResetPinFilterStopModeEnable(xtBoolean bEnable)
// 1306 {
SysCtlResetPinFilterStopModeEnable:
        PUSH     {LR}
// 1307     //
// 1308     // Enable Reset Pin Filter Select in Stop Mode or not.
// 1309     //
// 1310     if(bEnable)
        UXTB     R0,R0
        CMP      R0,#+0
        BEQ      ??SysCtlResetPinFilterStopModeEnable_0
// 1311     {
// 1312         xHWREGB(RCM_RPFC) |= RCM_RPFC_RSTFLTSRW_LPO;
        LDR      R1,??DataTable31_9  ;; 0x4007f004
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+2
        ORRS     R2,R2,R1
        LDR      R1,??DataTable31_9  ;; 0x4007f004
        STRB     R2,[R1, #+0]
        B        ??SysCtlResetPinFilterStopModeEnable_1
// 1313     }
// 1314     else
// 1315     {
// 1316         xHWREGB(RCM_RPFC) &= ~RCM_RPFC_RSTFLTSRW_LPO;
??SysCtlResetPinFilterStopModeEnable_0:
        LDR      R1,??DataTable31_9  ;; 0x4007f004
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+253
        ANDS     R2,R2,R1
        LDR      R1,??DataTable31_9  ;; 0x4007f004
        STRB     R2,[R1, #+0]
// 1317     }
// 1318 }
??SysCtlResetPinFilterStopModeEnable_1:
        POP      {PC}             ;; return
// 1319 
// 1320 //*****************************************************************************
// 1321 //
// 1322 //! \brief The function is used to Selects the reset pin bus clock filter width
// 1323 //!
// 1324 //! \param ulBusClkWidth the volt will be Select.
// 1325 //!
// 1326 //! The function is used to Select Reset Pin Filter in Run and Wait Modes
// 1327 //!
// 1328 //! The \e ulFilter parameter must be only one of the following values:1~32. 
// 1329 //!
// 1330 //! \return None.
// 1331 //
// 1332 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1333 void 
// 1334 SysCtlResetPinFilterBusClkWidthSet(unsigned char ulBusClkWidth)
// 1335 {
// 1336     //
// 1337     // Check the arguments.
// 1338     //
// 1339     xASSERT((ulBusClkWidth > 0 && ulBusClkWidth <= 32));
// 1340 
// 1341     //
// 1342     // Reset Pin Filter Bus Clock Select.
// 1343     //
// 1344     xHWREGB(RCM_RPFW) &= ~RCM_RPFW_RSTFLTSEL_M;
SysCtlResetPinFilterBusClkWidthSet:
        LDR      R1,??DataTable32  ;; 0x4007f005
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+224
        ANDS     R2,R2,R1
        LDR      R1,??DataTable32  ;; 0x4007f005
        STRB     R2,[R1, #+0]
// 1345     xHWREGB(RCM_RPFW) |= ulBusClkWidth;
        LDR      R1,??DataTable32  ;; 0x4007f005
        LDRB     R1,[R1, #+0]
        ORRS     R1,R1,R0
        LDR      R2,??DataTable32  ;; 0x4007f005
        STRB     R1,[R2, #+0]
// 1346 }
        BX       LR               ;; return
// 1347 
// 1348 //*****************************************************************************
// 1349 //
// 1350 //! \brief The function is used to Select Reset Pin Filter in Run and Wait Modes.
// 1351 //!
// 1352 //! \param ulFilter the volt will be Select.
// 1353 //!
// 1354 //! The function is used to Select Reset Pin Filter in Run and Wait Modes
// 1355 //!
// 1356 //! The \e ulFilter parameter must be only one of the following values:
// 1357 //! \b SYSCTL_RESET_PIN_FILTER_RUN_DIS, \b SYSCTL_RESET_PIN_FILTER_RUN_BUS, 
// 1358 //! \b SYSCTL_RESET_PIN_FILTER_RUN_LPO. 
// 1359 //!
// 1360 //! \return None.
// 1361 //
// 1362 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1363 void 
// 1364 SysCtlResetPinFilterRunModeSelect(unsigned long ulFilter)
// 1365 {
// 1366     //
// 1367     // Check the arguments.
// 1368     //
// 1369     xASSERT((ulFilter == SYSCTL_RESET_PIN_FILTER_RUN_DIS) ||
// 1370             (ulFilter == SYSCTL_RESET_PIN_FILTER_RUN_BUS) ||
// 1371             (ulFilter == SYSCTL_RESET_PIN_FILTER_RUN_LPO));
// 1372     //
// 1373     // Reset Pin Filter in Run and Wait Modes.
// 1374     //
// 1375     xHWREGB(RCM_RPFC) &= ~RCM_RPFC_RSTFLTSRW_M;
SysCtlResetPinFilterRunModeSelect:
        LDR      R1,??DataTable31_9  ;; 0x4007f004
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+252
        ANDS     R2,R2,R1
        LDR      R1,??DataTable31_9  ;; 0x4007f004
        STRB     R2,[R1, #+0]
// 1376     xHWREGB(RCM_RPFC) |= ulFilter;
        LDR      R1,??DataTable31_9  ;; 0x4007f004
        LDRB     R1,[R1, #+0]
        MOVS     R2,R0
        ORRS     R2,R2,R1
        LDR      R1,??DataTable31_9  ;; 0x4007f004
        STRB     R2,[R1, #+0]
// 1377 }
        BX       LR               ;; return
// 1378 
// 1379 //*****************************************************************************
// 1380 //
// 1381 //! \brief The function is used to Select Low-Voltage Detect Voltage.
// 1382 //!
// 1383 //! \param ulVoltage the volt will be Select.
// 1384 //!
// 1385 //! The function is used to Select Low-Voltage Detect Voltage.
// 1386 //!
// 1387 //! The \e ulVoltage parameter must be only one of the following values:
// 1388 //! \b SYSCTL_LVD_DET_LOW, \b SYSCTL_LVD_DET_HIGH. 
// 1389 //!
// 1390 //! \return None.
// 1391 //
// 1392 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1393 void 
// 1394 SysCtlLVDVolSet(unsigned long ulVoltage)
// 1395 {
// 1396     //
// 1397     // Check the arguments.
// 1398     //
// 1399     xASSERT((ulVoltage == SYSCTL_LVD_DET_LOW) ||
// 1400             (ulVoltage == SYSCTL_LVD_DET_HIGH));
// 1401     //
// 1402     // Select Low-Voltage Detect Voltage.
// 1403     //
// 1404     xHWREGB(PMC_LVDSC1) &= ~PMC_LVDSC1_LVDV_M;
SysCtlLVDVolSet:
        LDR      R1,??DataTable32_1  ;; 0x4007d000
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+252
        ANDS     R2,R2,R1
        LDR      R1,??DataTable32_1  ;; 0x4007d000
        STRB     R2,[R1, #+0]
// 1405     xHWREGB(PMC_LVDSC1) |= ulVoltage;
        LDR      R1,??DataTable32_1  ;; 0x4007d000
        LDRB     R1,[R1, #+0]
        MOVS     R2,R0
        ORRS     R2,R2,R1
        LDR      R1,??DataTable32_1  ;; 0x4007d000
        STRB     R2,[R1, #+0]
// 1406 }
        BX       LR               ;; return
// 1407 
// 1408 //*****************************************************************************
// 1409 //
// 1410 //! \brief The function is used to Select Low-Voltage Warning Voltage.
// 1411 //!
// 1412 //! \param ulVoltage the volt will be Select.
// 1413 //!
// 1414 //! The function is used to Select Low-Voltage Warning Voltage.
// 1415 //!
// 1416 //! The \e ulVoltage parameter must be only one of the following values:
// 1417 //! \b SYSCTL_LVD_WARNING_LOW, \b SYSCTL_LVD_WARNING_MID1,
// 1418 //! \b SYSCTL_LVD_WARNING_MID2, \b SYSCTL_LVD_WARNING_HIGH.
// 1419 //!
// 1420 //! \return None.
// 1421 //
// 1422 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1423 void 
// 1424 SysCtlLVDWarningVolSet(unsigned long ulVoltage)
// 1425 {
// 1426     //
// 1427     // Check the arguments.
// 1428     //
// 1429     xASSERT((ulVoltage == SYSCTL_LVD_WARNING_LOW) ||
// 1430             (ulVoltage == SYSCTL_LVD_WARNING_MID1) ||
// 1431             (ulVoltage == SYSCTL_LVD_WARNING_MID2) ||
// 1432             (ulVoltage == SYSCTL_LVD_WARNING_HIGH));
// 1433     //
// 1434     // Select Low-Voltage Warning Voltage.
// 1435     //
// 1436     xHWREGB(PMC_LVDSC2) &= ~PMC_LVDSC2_LVWV_M;
SysCtlLVDWarningVolSet:
        LDR      R1,??DataTable32_2  ;; 0x4007d001
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+252
        ANDS     R2,R2,R1
        LDR      R1,??DataTable32_2  ;; 0x4007d001
        STRB     R2,[R1, #+0]
// 1437     xHWREGB(PMC_LVDSC2) |= ulVoltage;
        LDR      R1,??DataTable32_2  ;; 0x4007d001
        LDRB     R1,[R1, #+0]
        MOVS     R2,R0
        ORRS     R2,R2,R1
        LDR      R1,??DataTable32_2  ;; 0x4007d001
        STRB     R2,[R1, #+0]
// 1438 }
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable23:
        DC32     0xf3ffffff
// 1439 
// 1440 //*****************************************************************************
// 1441 //
// 1442 //! \brief Get Low-Voltage Detect Flag.
// 1443 //!
// 1444 //! \param None.
// 1445 //!
// 1446 //! This function is to Get Low-Voltage Detect Flag
// 1447 //!
// 1448 //! \return This function return the LVD Detect Flag,if a low-voltage detect
// 1449 //! event happens, it returns xtrue, xfalse if not.
// 1450 //
// 1451 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1452 xtBoolean
// 1453 SysCtlLVDEventFlagGet(void)
// 1454 {
SysCtlLVDEventFlagGet:
        PUSH     {LR}
// 1455     xtBoolean xtFlag = 0;
        MOVS     R1,#+0
// 1456 
// 1457     xtFlag = xHWREGB(PMC_LVDSC1) & PMC_LVDSC1_LVDF;
        LDR      R0,??DataTable32_1  ;; 0x4007d000
        LDRB     R0,[R0, #+0]
        MOVS     R2,#+128
        ANDS     R0,R0,R2
        MOVS     R1,R0
// 1458     if(xtFlag)
        UXTB     R1,R1
        CMP      R1,#+0
        BEQ      ??SysCtlLVDEventFlagGet_0
// 1459     {
// 1460         return xtrue;
        MOVS     R0,#+1
        B        ??SysCtlLVDEventFlagGet_1
// 1461     }
// 1462     else
// 1463     {
// 1464         return xfalse;
??SysCtlLVDEventFlagGet_0:
        MOVS     R0,#+0
??SysCtlLVDEventFlagGet_1:
        POP      {PC}             ;; return
// 1465     }
// 1466 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable24:
        DC32     0xfffeffff
// 1467 
// 1468 //*****************************************************************************
// 1469 //
// 1470 //! \brief Clear Low-Voltage Detect Flag.
// 1471 //!
// 1472 //! \param None.
// 1473 //!
// 1474 //! This function is to Clear Low-Voltage Detect Flag
// 1475 //!
// 1476 //! \return None.
// 1477 //
// 1478 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1479 void
// 1480 SysCtlLVDEventFlagClear(void)
// 1481 {
// 1482     xHWREGB(PMC_LVDSC1) |= PMC_LVDSC1_LVDACK;
SysCtlLVDEventFlagClear:
        LDR      R0,??DataTable32_1  ;; 0x4007d000
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+64
        ORRS     R1,R1,R0
        LDR      R0,??DataTable32_1  ;; 0x4007d000
        STRB     R1,[R0, #+0]
// 1483 }
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable25:
        DC32     0x40048004
// 1484 
// 1485 //*****************************************************************************
// 1486 //
// 1487 //! \brief Get Low-Voltage Warning Flag.
// 1488 //!
// 1489 //! \param None.
// 1490 //!
// 1491 //! This function is to Get Low-Voltage Warning Flag
// 1492 //!
// 1493 //! \return This function return LVD Warning Flag,if a low-voltage Warning
// 1494 //! event happens, it returns xtrue, xfalse if not.
// 1495 //
// 1496 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1497 xtBoolean
// 1498 SysCtlLVDWaringFlagGet(void)
// 1499 {
SysCtlLVDWaringFlagGet:
        PUSH     {LR}
// 1500     xtBoolean xtFlag = 0;
        MOVS     R1,#+0
// 1501 
// 1502     xtFlag = xHWREGB(PMC_LVDSC2) & PMC_LVDSC2_LVWF;
        LDR      R0,??DataTable32_2  ;; 0x4007d001
        LDRB     R0,[R0, #+0]
        MOVS     R2,#+128
        ANDS     R0,R0,R2
        MOVS     R1,R0
// 1503     if(xtFlag)
        UXTB     R1,R1
        CMP      R1,#+0
        BEQ      ??SysCtlLVDWaringFlagGet_0
// 1504     {
// 1505         return xtrue;
        MOVS     R0,#+1
        B        ??SysCtlLVDWaringFlagGet_1
// 1506     }
// 1507     else
// 1508     {
// 1509         return xfalse;
??SysCtlLVDWaringFlagGet_0:
        MOVS     R0,#+0
??SysCtlLVDWaringFlagGet_1:
        POP      {PC}             ;; return
// 1510     }
// 1511 }
// 1512 
// 1513 //*****************************************************************************
// 1514 //
// 1515 //! \brief Clear Low-Voltage Warning Flag.
// 1516 //!
// 1517 //! \param None.
// 1518 //!
// 1519 //! This function is to Clear Low-Voltage Warning Flag
// 1520 //!
// 1521 //! \return None.
// 1522 //
// 1523 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1524 void
// 1525 SysCtlLVDWarningFlagClear(void)
// 1526 {
// 1527     xHWREGB(PMC_LVDSC2) |= PMC_LVDSC2_LVWACK;
SysCtlLVDWarningFlagClear:
        LDR      R0,??DataTable32_2  ;; 0x4007d001
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+64
        ORRS     R1,R1,R0
        LDR      R0,??DataTable32_2  ;; 0x4007d001
        STRB     R1,[R0, #+0]
// 1528 }
        BX       LR               ;; return
// 1529 
// 1530 //*****************************************************************************
// 1531 //
// 1532 //! \brief The function is to Enter very low power run mode or not
// 1533 //!
// 1534 //! \param bEnable is a boolean that is \b true if Enter very low power run mode
// 1535 //! and \b false if exit very low power run mode to run mode.
// 1536 //!
// 1537 //! The function is used to Enter very low power run mode or not
// 1538 //!
// 1539 //! \return None.
// 1540 //
// 1541 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1542 void 
// 1543 SysCtlVeryLowPowerRunModeEnable(xtBoolean bEnable)
// 1544 {
SysCtlVeryLowPowerRunModeEnable:
        PUSH     {LR}
// 1545     //
// 1546     // Enter very low power run mode.
// 1547     //
// 1548     if(bEnable)
        UXTB     R0,R0
        CMP      R0,#+0
        BEQ      ??SysCtlVeryLowPowerRunModeEnable_0
// 1549     {
// 1550         xHWREGB(SMC_PMPROT) |= SMC_PMPROT_AVLP;
        LDR      R1,??DataTable32_3  ;; 0x4007e000
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+32
        ORRS     R2,R2,R1
        LDR      R1,??DataTable32_3  ;; 0x4007e000
        STRB     R2,[R1, #+0]
// 1551         xHWREGB(SMC_PMCTRL) &= ~SMC_PMCTRL_RUNM_M;
        LDR      R1,??DataTable33  ;; 0x4007e001
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+159
        ANDS     R2,R2,R1
        LDR      R1,??DataTable33  ;; 0x4007e001
        STRB     R2,[R1, #+0]
// 1552         xHWREGB(SMC_PMCTRL) |= SMC_PMCTRL_RUNM_VLPR;
        LDR      R1,??DataTable33  ;; 0x4007e001
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+64
        ORRS     R2,R2,R1
        LDR      R1,??DataTable33  ;; 0x4007e001
        STRB     R2,[R1, #+0]
        B        ??SysCtlVeryLowPowerRunModeEnable_1
// 1553     }
// 1554     //
// 1555     // Exit very low power run mode.
// 1556     //
// 1557     else
// 1558     {
// 1559         xHWREGB(SMC_PMPROT) &= ~SMC_PMPROT_AVLP;
??SysCtlVeryLowPowerRunModeEnable_0:
        LDR      R1,??DataTable32_3  ;; 0x4007e000
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+223
        ANDS     R2,R2,R1
        LDR      R1,??DataTable32_3  ;; 0x4007e000
        STRB     R2,[R1, #+0]
// 1560         xHWREGB(SMC_PMCTRL) &= ~SMC_PMCTRL_RUNM_M;
        LDR      R1,??DataTable33  ;; 0x4007e001
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+159
        ANDS     R2,R2,R1
        LDR      R1,??DataTable33  ;; 0x4007e001
        STRB     R2,[R1, #+0]
// 1561     }
// 1562 }
??SysCtlVeryLowPowerRunModeEnable_1:
        POP      {PC}             ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable28:
        DC32     0xfcffffff
// 1563 
// 1564 //*****************************************************************************
// 1565 //
// 1566 //! \brief The function is to Enable Low-Voltage Detect Interrupt or not
// 1567 //!
// 1568 //! \param bEnable is a boolean that is \b true if Enable Low-Voltage Detect 
// 1569 //!  Interrupt and \b false if not.
// 1570 //!
// 1571 //! The function is used to Enable Low-Voltage Detect Interrupt or not
// 1572 //!
// 1573 //! \return None.
// 1574 //
// 1575 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1576 void 
// 1577 SysCtlLVDIntEnable(xtBoolean bEnable)
// 1578 {
SysCtlLVDIntEnable:
        PUSH     {LR}
// 1579     //
// 1580     // Enable Low-Voltage Detect Interrupt.
// 1581     //
// 1582     if(bEnable)
        UXTB     R0,R0
        CMP      R0,#+0
        BEQ      ??SysCtlLVDIntEnable_0
// 1583     {
// 1584         xHWREGB(PMC_LVDSC1) |= PMC_LVDSC1_LVDIE;
        LDR      R1,??DataTable32_1  ;; 0x4007d000
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+32
        ORRS     R2,R2,R1
        LDR      R1,??DataTable32_1  ;; 0x4007d000
        STRB     R2,[R1, #+0]
        B        ??SysCtlLVDIntEnable_1
// 1585     }
// 1586     //
// 1587     // Disable Low-Voltage Detect Interrupt.
// 1588     //
// 1589     else
// 1590     {
// 1591         xHWREGB(PMC_LVDSC1) &= ~PMC_LVDSC1_LVDIE;
??SysCtlLVDIntEnable_0:
        LDR      R1,??DataTable32_1  ;; 0x4007d000
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+223
        ANDS     R2,R2,R1
        LDR      R1,??DataTable32_1  ;; 0x4007d000
        STRB     R2,[R1, #+0]
// 1592     }
// 1593 }
??SysCtlLVDIntEnable_1:
        POP      {PC}             ;; return
// 1594 
// 1595 //*****************************************************************************
// 1596 //
// 1597 //! \brief The function is to Enable Low-Voltage Detect Warning Interrupt or not
// 1598 //!
// 1599 //! \param bEnable is a boolean that is \b true if Enable Low-Voltage Warning 
// 1600 //!  Interrupt and \b false if not.
// 1601 //!
// 1602 //! The function is used to Enable Low-Voltage Detect Warning Interrupt or not
// 1603 //!
// 1604 //! \return None.
// 1605 //
// 1606 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1607 void 
// 1608 SysCtlLVDWarningIntEnable(xtBoolean bEnable)
// 1609 {
SysCtlLVDWarningIntEnable:
        PUSH     {LR}
// 1610     //
// 1611     // Enable Low-Voltage Detect Warning Interrupt.
// 1612     //
// 1613     if(bEnable)
        UXTB     R0,R0
        CMP      R0,#+0
        BEQ      ??SysCtlLVDWarningIntEnable_0
// 1614     {
// 1615         xHWREGB(PMC_LVDSC2) |= PMC_LVDSC2_LVDRE;
        LDR      R1,??DataTable32_2  ;; 0x4007d001
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+32
        ORRS     R2,R2,R1
        LDR      R1,??DataTable32_2  ;; 0x4007d001
        STRB     R2,[R1, #+0]
        B        ??SysCtlLVDWarningIntEnable_1
// 1616     }
// 1617     //
// 1618     // Disable Low-Voltage Detect Warning Interrupt.
// 1619     //
// 1620     else
// 1621     {
// 1622         xHWREGB(PMC_LVDSC2) &= ~PMC_LVDSC2_LVDRE;
??SysCtlLVDWarningIntEnable_0:
        LDR      R1,??DataTable32_2  ;; 0x4007d001
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+223
        ANDS     R2,R2,R1
        LDR      R1,??DataTable32_2  ;; 0x4007d001
        STRB     R2,[R1, #+0]
// 1623     }
// 1624 }
??SysCtlLVDWarningIntEnable_1:
        POP      {PC}             ;; return
// 1625 //*****************************************************************************
// 1626 //
// 1627 //! \brief The function is to Enable Low-Voltage Detect Reset or not
// 1628 //!
// 1629 //! \param bEnable is a boolean that is \b true if Enable Low-Voltage Detect 
// 1630 //!  Reset and \b false if not.
// 1631 //!
// 1632 //! The function is used to Enable Low-Voltage Detect Reset or not
// 1633 //!
// 1634 //! \return None.
// 1635 //
// 1636 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1637 void 
// 1638 SysCtlLVDResetEnable(xtBoolean bEnable)
// 1639 {
SysCtlLVDResetEnable:
        PUSH     {LR}
// 1640     //
// 1641     // Enable Low-Voltage Detect Reset.
// 1642     //
// 1643     if(bEnable)
        UXTB     R0,R0
        CMP      R0,#+0
        BEQ      ??SysCtlLVDResetEnable_0
// 1644     {
// 1645         xHWREGB(PMC_LVDSC1) |= PMC_LVDSC1_LVDRE;
        LDR      R1,??DataTable32_1  ;; 0x4007d000
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+16
        ORRS     R2,R2,R1
        LDR      R1,??DataTable32_1  ;; 0x4007d000
        STRB     R2,[R1, #+0]
        B        ??SysCtlLVDResetEnable_1
// 1646     }
// 1647     //
// 1648     // Disable Low-Voltage Detect Reset.
// 1649     //
// 1650     else
// 1651     {
// 1652         xHWREGB(PMC_LVDSC1) &= ~PMC_LVDSC1_LVDRE;
??SysCtlLVDResetEnable_0:
        LDR      R1,??DataTable32_1  ;; 0x4007d000
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+239
        ANDS     R2,R2,R1
        LDR      R1,??DataTable32_1  ;; 0x4007d000
        STRB     R2,[R1, #+0]
// 1653     }
// 1654 }
??SysCtlLVDResetEnable_1:
        POP      {PC}             ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable31:
        DC32     0xfffbffff

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable31_1:
        DC32     0xc0700

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable31_2:
        DC32     0x80704

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable31_3:
        DC32     0xc0701

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable31_4:
        DC32     0x40048100

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable31_5:
        DC32     0x40064000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable31_6:
        DC32     0x4007f000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable31_7:
        DC32     0x4007f001

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable31_8:
        DC32     0x4007e003

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable31_9:
        DC32     0x4007f004
// 1655 //*****************************************************************************
// 1656 //
// 1657 //! \brief The function is to Enter the various Stop mode.
// 1658 //!
// 1659 //! \param ulStopMode is the Stop mode which will enter.
// 1660 //!
// 1661 //! The function is used to Enter the various Stop mode
// 1662 //!
// 1663 //! \return None.
// 1664 //
// 1665 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1666 void 
// 1667 SysCtlStopModeSet(unsigned long ulStopMode)
// 1668 {
SysCtlStopModeSet:
        PUSH     {R4,LR}
        MOVS     R4,R0
// 1669     //
// 1670     // Check the arguments.
// 1671     //
// 1672     xASSERT((ulStopMode == SYSCTL_STOP_MODE_VLPS) ||
// 1673             (ulStopMode == SYSCTL_STOP_MODE_LLS)  ||
// 1674             (ulStopMode == SYSCTL_STOP_MODE_VLLS0)||
// 1675             (ulStopMode == SYSCTL_STOP_MODE_VLLS1)||
// 1676             (ulStopMode == SYSCTL_STOP_MODE_VLLS2)||
// 1677             (ulStopMode == SYSCTL_STOP_MODE_VLLS3)||
// 1678             (ulStopMode == SYSCTL_STOP_MODE_NORMAL));
// 1679 
// 1680     //
// 1681     // Set the SLEEPDEEP bit to enable deep sleep mode(STOP).
// 1682     //
// 1683     xHWREG(SCB_SCR) |= SCB_SCR_SLEEPDEEP;
        LDR      R0,??DataTable33_1  ;; 0xe000e000
        LDR      R0,[R0, #+0]
        MOVS     R1,#+4
        ORRS     R1,R1,R0
        LDR      R0,??DataTable33_1  ;; 0xe000e000
        STR      R1,[R0, #+0]
// 1684     //
// 1685     // Enter the various Stop mode.
// 1686     //
// 1687     if(ulStopMode == SYSCTL_STOP_MODE_VLPS)
        CMP      R4,#+0
        BNE      ??SysCtlStopModeSet_0
// 1688     {
// 1689         xHWREGB(SMC_PMPROT) |= SMC_PMPROT_AVLP;
        LDR      R0,??DataTable32_3  ;; 0x4007e000
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+32
        ORRS     R1,R1,R0
        LDR      R0,??DataTable32_3  ;; 0x4007e000
        STRB     R1,[R0, #+0]
// 1690         xHWREGB(SMC_PMCTRL) &= ~SMC_PMCTRL_STOPM_M;
        LDR      R0,??DataTable33  ;; 0x4007e001
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+248
        ANDS     R1,R1,R0
        LDR      R0,??DataTable33  ;; 0x4007e001
        STRB     R1,[R0, #+0]
// 1691         xHWREGB(SMC_PMCTRL) |= SMC_PMCTRL_STOPM_VLPS;
        LDR      R0,??DataTable33  ;; 0x4007e001
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+1
        ORRS     R1,R1,R0
        LDR      R0,??DataTable33  ;; 0x4007e001
        STRB     R1,[R0, #+0]
        B        ??SysCtlStopModeSet_1
// 1692     }
// 1693     else if(ulStopMode == SYSCTL_STOP_MODE_NORMAL)
??SysCtlStopModeSet_0:
        CMP      R4,#+6
        BNE      ??SysCtlStopModeSet_2
// 1694     {
// 1695         xHWREGB(SMC_PMCTRL) &= ~SMC_PMCTRL_RUNM_M;
        LDR      R0,??DataTable33  ;; 0x4007e001
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+159
        ANDS     R1,R1,R0
        LDR      R0,??DataTable33  ;; 0x4007e001
        STRB     R1,[R0, #+0]
// 1696         xHWREGB(SMC_PMCTRL) &= ~SMC_PMCTRL_STOPM_M;
        LDR      R0,??DataTable33  ;; 0x4007e001
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+248
        ANDS     R1,R1,R0
        LDR      R0,??DataTable33  ;; 0x4007e001
        STRB     R1,[R0, #+0]
        B        ??SysCtlStopModeSet_1
// 1697     }
// 1698     else if(ulStopMode == SYSCTL_STOP_MODE_LLS)
??SysCtlStopModeSet_2:
        CMP      R4,#+1
        BNE      ??SysCtlStopModeSet_3
// 1699     {
// 1700         xHWREGB(SMC_PMPROT) |= SMC_PMPROT_ALLS;
        LDR      R0,??DataTable32_3  ;; 0x4007e000
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+8
        ORRS     R1,R1,R0
        LDR      R0,??DataTable32_3  ;; 0x4007e000
        STRB     R1,[R0, #+0]
// 1701         xHWREGB(SMC_PMCTRL) &= ~SMC_PMCTRL_STOPM_M;
        LDR      R0,??DataTable33  ;; 0x4007e001
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+248
        ANDS     R1,R1,R0
        LDR      R0,??DataTable33  ;; 0x4007e001
        STRB     R1,[R0, #+0]
// 1702         xHWREGB(SMC_PMCTRL) |= SMC_PMCTRL_STOPM_LLS;
        LDR      R0,??DataTable33  ;; 0x4007e001
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+3
        ORRS     R1,R1,R0
        LDR      R0,??DataTable33  ;; 0x4007e001
        STRB     R1,[R0, #+0]
        B        ??SysCtlStopModeSet_1
// 1703     }
// 1704     else if(ulStopMode == SYSCTL_STOP_MODE_VLLS0)
??SysCtlStopModeSet_3:
        CMP      R4,#+2
        BNE      ??SysCtlStopModeSet_4
// 1705     {
// 1706         xHWREGB(SMC_PMPROT) |= SMC_PMPROT_AVLLS;
        LDR      R0,??DataTable32_3  ;; 0x4007e000
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+2
        ORRS     R1,R1,R0
        LDR      R0,??DataTable32_3  ;; 0x4007e000
        STRB     R1,[R0, #+0]
// 1707         xHWREGB(SMC_PMCTRL) &= ~SMC_PMCTRL_STOPM_M;
        LDR      R0,??DataTable33  ;; 0x4007e001
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+248
        ANDS     R1,R1,R0
        LDR      R0,??DataTable33  ;; 0x4007e001
        STRB     R1,[R0, #+0]
// 1708         xHWREGB(SMC_PMCTRL) |= SMC_PMCTRL_STOPM_VLLS;
        LDR      R0,??DataTable33  ;; 0x4007e001
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+4
        ORRS     R1,R1,R0
        LDR      R0,??DataTable33  ;; 0x4007e001
        STRB     R1,[R0, #+0]
// 1709         xHWREGB(SMC_STOPCTRL) &= ~SMC_STOPCTRL_VLLSM_M;
        LDR      R0,??DataTable33_2  ;; 0x4007e002
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+248
        ANDS     R1,R1,R0
        LDR      R0,??DataTable33_2  ;; 0x4007e002
        STRB     R1,[R0, #+0]
// 1710         xHWREGB(SMC_STOPCTRL) |= SMC_STOPCTRL_VLLSM_VLLS0;
        LDR      R0,??DataTable33_2  ;; 0x4007e002
        LDR      R1,??DataTable33_2  ;; 0x4007e002
        LDRB     R1,[R1, #+0]
        STRB     R1,[R0, #+0]
        B        ??SysCtlStopModeSet_1
// 1711     }
// 1712     else if(ulStopMode == SYSCTL_STOP_MODE_VLLS1)
??SysCtlStopModeSet_4:
        CMP      R4,#+3
        BNE      ??SysCtlStopModeSet_5
// 1713     {
// 1714         xHWREGB(SMC_PMPROT) |= SMC_PMPROT_AVLLS;
        LDR      R0,??DataTable32_3  ;; 0x4007e000
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+2
        ORRS     R1,R1,R0
        LDR      R0,??DataTable32_3  ;; 0x4007e000
        STRB     R1,[R0, #+0]
// 1715         xHWREGB(SMC_PMCTRL) &= ~SMC_PMCTRL_STOPM_M;
        LDR      R0,??DataTable33  ;; 0x4007e001
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+248
        ANDS     R1,R1,R0
        LDR      R0,??DataTable33  ;; 0x4007e001
        STRB     R1,[R0, #+0]
// 1716         xHWREGB(SMC_PMCTRL) |= SMC_PMCTRL_STOPM_VLLS;
        LDR      R0,??DataTable33  ;; 0x4007e001
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+4
        ORRS     R1,R1,R0
        LDR      R0,??DataTable33  ;; 0x4007e001
        STRB     R1,[R0, #+0]
// 1717         xHWREGB(SMC_STOPCTRL) &= ~SMC_STOPCTRL_VLLSM_M;
        LDR      R0,??DataTable33_2  ;; 0x4007e002
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+248
        ANDS     R1,R1,R0
        LDR      R0,??DataTable33_2  ;; 0x4007e002
        STRB     R1,[R0, #+0]
// 1718         xHWREGB(SMC_STOPCTRL) |= SMC_STOPCTRL_VLLSM_VLLS1;
        LDR      R0,??DataTable33_2  ;; 0x4007e002
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+1
        ORRS     R1,R1,R0
        LDR      R0,??DataTable33_2  ;; 0x4007e002
        STRB     R1,[R0, #+0]
        B        ??SysCtlStopModeSet_1
// 1719     }
// 1720     else if(ulStopMode == SYSCTL_STOP_MODE_VLLS2)
??SysCtlStopModeSet_5:
        CMP      R4,#+4
        BNE      ??SysCtlStopModeSet_6
// 1721     {
// 1722         xHWREGB(SMC_PMPROT) |= SMC_PMPROT_AVLLS;
        LDR      R0,??DataTable32_3  ;; 0x4007e000
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+2
        ORRS     R1,R1,R0
        LDR      R0,??DataTable32_3  ;; 0x4007e000
        STRB     R1,[R0, #+0]
// 1723         xHWREGB(SMC_PMCTRL) &= ~SMC_PMCTRL_STOPM_M;
        LDR      R0,??DataTable33  ;; 0x4007e001
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+248
        ANDS     R1,R1,R0
        LDR      R0,??DataTable33  ;; 0x4007e001
        STRB     R1,[R0, #+0]
// 1724         xHWREGB(SMC_PMCTRL) |= SMC_PMCTRL_STOPM_VLLS;
        LDR      R0,??DataTable33  ;; 0x4007e001
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+4
        ORRS     R1,R1,R0
        LDR      R0,??DataTable33  ;; 0x4007e001
        STRB     R1,[R0, #+0]
// 1725         xHWREGB(SMC_STOPCTRL) &= ~SMC_STOPCTRL_VLLSM_M;
        LDR      R0,??DataTable33_2  ;; 0x4007e002
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+248
        ANDS     R1,R1,R0
        LDR      R0,??DataTable33_2  ;; 0x4007e002
        STRB     R1,[R0, #+0]
// 1726         xHWREGB(SMC_STOPCTRL) |= SMC_STOPCTRL_VLLSM_VLLS2;
        LDR      R0,??DataTable33_2  ;; 0x4007e002
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+2
        ORRS     R1,R1,R0
        LDR      R0,??DataTable33_2  ;; 0x4007e002
        STRB     R1,[R0, #+0]
        B        ??SysCtlStopModeSet_1
// 1727     }
// 1728     else
// 1729     {
// 1730         xHWREGB(SMC_PMPROT) |= SMC_PMPROT_AVLLS;
??SysCtlStopModeSet_6:
        LDR      R0,??DataTable32_3  ;; 0x4007e000
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+2
        ORRS     R1,R1,R0
        LDR      R0,??DataTable32_3  ;; 0x4007e000
        STRB     R1,[R0, #+0]
// 1731         xHWREGB(SMC_PMCTRL) &= ~SMC_PMCTRL_STOPM_M;
        LDR      R0,??DataTable33  ;; 0x4007e001
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+248
        ANDS     R1,R1,R0
        LDR      R0,??DataTable33  ;; 0x4007e001
        STRB     R1,[R0, #+0]
// 1732         xHWREGB(SMC_PMCTRL) |= SMC_PMCTRL_STOPM_VLLS;
        LDR      R0,??DataTable33  ;; 0x4007e001
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+4
        ORRS     R1,R1,R0
        LDR      R0,??DataTable33  ;; 0x4007e001
        STRB     R1,[R0, #+0]
// 1733         xHWREGB(SMC_STOPCTRL) &= ~SMC_STOPCTRL_VLLSM_M;
        LDR      R0,??DataTable33_2  ;; 0x4007e002
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+248
        ANDS     R1,R1,R0
        LDR      R0,??DataTable33_2  ;; 0x4007e002
        STRB     R1,[R0, #+0]
// 1734         xHWREGB(SMC_STOPCTRL) |= SMC_STOPCTRL_VLLSM_VLLS3;
        LDR      R0,??DataTable33_2  ;; 0x4007e002
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+3
        ORRS     R1,R1,R0
        LDR      R0,??DataTable33_2  ;; 0x4007e002
        STRB     R1,[R0, #+0]
// 1735     }
// 1736     //
// 1737     // WFI instruction will start entry into STOP mode
// 1738     //
// 1739     xCPUwfi();
??SysCtlStopModeSet_1:
        BL       xCPUwfi
// 1740 }
        POP      {R4,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable32:
        DC32     0x4007f005

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable32_1:
        DC32     0x4007d000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable32_2:
        DC32     0x4007d001

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable32_3:
        DC32     0x4007e000
// 1741 
// 1742 //*****************************************************************************
// 1743 //
// 1744 //! \brief The function is used to Get HCLK clock and the UNIT is in Hz
// 1745 //!
// 1746 //! \param None.
// 1747 //!
// 1748 //! The function is used to Get HCLK clock and the UNIT is in Hz
// 1749 //!
// 1750 //! \return HCLK clock frequency in Hz 
// 1751 //
// 1752 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1753 unsigned long 
// 1754 SysCtlHClockGet(void)
// 1755 {
SysCtlHClockGet:
        PUSH     {R4-R6,LR}
// 1756     unsigned long  ulFreqout = 0, ulDivider = 0, ulDividerPll = 0;
        MOVS     R6,#+0
        MOVS     R4,#+0
        MOVS     R5,#+0
// 1757 
// 1758     //
// 1759     // external 12MHz crystal clock.
// 1760     //
// 1761     if((xHWREG(MCG_C1)&SYSCTL_HLCK_S_MAIN) == SYSCTL_HLCK_S_MAIN)
        LDR      R0,??DataTable33_3  ;; 0x40064000
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+24
        BPL      ??SysCtlHClockGet_0
// 1762     {
// 1763         ulFreqout = s_ulExtClockMHz*1000000;
        LDR      R0,??DataTable33_4
        LDR      R0,[R0, #+0]
        LDR      R1,??DataTable33_5  ;; 0xf4240
        MULS     R0,R1,R0
        MOVS     R6,R0
// 1764         ulDivider = (xHWREG(SIM_CLKDIV1) & SIM_CLKDIV1_OUTDIV1_M) >> SIM_CLKDIV1_OUTDIV1_S;
        LDR      R0,??DataTable33_6  ;; 0x40048044
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+28
        MOVS     R4,R0
// 1765         ulFreqout = ulFreqout/(ulDivider+1);  
        MOVS     R0,R6
        MOVS     R1,R4
        ADDS     R1,R1,#+1
        BL       __aeabi_uidiv
        MOVS     R6,R0
        B        ??SysCtlHClockGet_1
// 1766     }
// 1767     //
// 1768     // internal 32KHz crystal clock.
// 1769     //
// 1770     else if((xHWREG(MCG_C1)&SYSCTL_HLCK_S_INT) == SYSCTL_HLCK_S_INT)     
??SysCtlHClockGet_0:
        LDR      R0,??DataTable33_3  ;; 0x40064000
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+25
        BPL      ??SysCtlHClockGet_2
// 1771     {
// 1772         if((xHWREGB(MCG_C2)&MCG_C2_IRCS) == MCG_C2_IRCS)
        LDR      R0,??DataTable33_7  ;; 0x40064001
        LDRB     R0,[R0, #+0]
        UXTB     R0,R0
        LSLS     R0,R0,#+31
        BPL      ??SysCtlHClockGet_3
// 1773         {
// 1774             ulFreqout = 32768;
        MOVS     R0,#+128
        LSLS     R0,R0,#+8        ;; #+32768
        MOVS     R6,R0
        B        ??SysCtlHClockGet_1
// 1775         }
// 1776         else
// 1777         {
// 1778             ulDivider = (xHWREG(SIM_CLKDIV1) & SIM_CLKDIV1_OUTDIV1_M) >> SIM_CLKDIV1_OUTDIV1_S;
??SysCtlHClockGet_3:
        LDR      R0,??DataTable33_6  ;; 0x40048044
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+28
        MOVS     R4,R0
// 1779             ulFreqout = 4000000/(ulDivider+1);
        LDR      R0,??DataTable33_8  ;; 0x3d0900
        MOVS     R1,R4
        ADDS     R1,R1,#+1
        BL       __aeabi_uidiv
        MOVS     R6,R0
        B        ??SysCtlHClockGet_1
// 1780         }
// 1781     }
// 1782     //
// 1783     // PLL or FLL clock.
// 1784     //
// 1785     else    
// 1786     {
// 1787         //
// 1788         // PLL
// 1789         //
// 1790         if((xHWREGB(MCG_C6) & MCG_C6_PLLS) == MCG_C6_PLLS)
??SysCtlHClockGet_2:
        LDR      R0,??DataTable33_9  ;; 0x40064005
        LDRB     R0,[R0, #+0]
        UXTB     R0,R0
        LSLS     R0,R0,#+25
        BPL      ??SysCtlHClockGet_4
// 1791         {
// 1792             ulFreqout = s_ulExtClockMHz* ((xHWREGB(MCG_C6)&MCG_C6_VDIV0_M)+24)*1000000;
        LDR      R0,??DataTable33_4
        LDR      R0,[R0, #+0]
        LDR      R1,??DataTable33_9  ;; 0x40064005
        LDRB     R1,[R1, #+0]
        UXTB     R1,R1
        LSLS     R1,R1,#+27       ;; ZeroExtS R1,R1,#+27,#+27
        LSRS     R1,R1,#+27
        ADDS     R1,R1,#+24
        MULS     R0,R1,R0
        LDR      R1,??DataTable33_5  ;; 0xf4240
        MULS     R0,R1,R0
        MOVS     R6,R0
// 1793             ulDivider = (xHWREG(SIM_CLKDIV1) & SIM_CLKDIV1_OUTDIV1_M) >> SIM_CLKDIV1_OUTDIV1_S;
        LDR      R0,??DataTable33_6  ;; 0x40048044
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+28
        MOVS     R4,R0
// 1794             ulDividerPll = (xHWREGB(MCG_C5)&MCG_C5_PRDIV0_M);
        LDR      R0,??DataTable33_10  ;; 0x40064004
        LDRB     R0,[R0, #+0]
        UXTB     R0,R0
        LSLS     R0,R0,#+27       ;; ZeroExtS R0,R0,#+27,#+27
        LSRS     R0,R0,#+27
        MOVS     R5,R0
// 1795             ulFreqout = ulFreqout/((ulDivider+1)*(ulDividerPll+1));
        MOVS     R0,R6
        MOVS     R1,R4
        ADDS     R1,R1,#+1
        MOVS     R2,R5
        ADDS     R2,R2,#+1
        MULS     R1,R2,R1
        BL       __aeabi_uidiv
        MOVS     R6,R0
        B        ??SysCtlHClockGet_1
// 1796         }
// 1797         //
// 1798         // FLL
// 1799         //
// 1800         else
// 1801         {
// 1802             //
// 1803             // The slow internal reference clock is FLL Source
// 1804             //
// 1805             if((xHWREG(MCG_C1)&MCG_C1_IREFS) == MCG_C1_IREFS)
??SysCtlHClockGet_4:
        LDR      R0,??DataTable33_3  ;; 0x40064000
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+29
        BPL      ??SysCtlHClockGet_5
// 1806             {
// 1807                 ulFreqout = 96000000;
        LDR      R0,??DataTable33_11  ;; 0x5b8d800
        MOVS     R6,R0
// 1808                 ulDivider = (xHWREG(SIM_CLKDIV1) & SIM_CLKDIV1_OUTDIV1_M) >> SIM_CLKDIV1_OUTDIV1_S;
        LDR      R0,??DataTable33_6  ;; 0x40048044
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+28
        MOVS     R4,R0
// 1809                 ulFreqout = ulFreqout/(ulDivider+1);            
        MOVS     R0,R6
        MOVS     R1,R4
        ADDS     R1,R1,#+1
        BL       __aeabi_uidiv
        MOVS     R6,R0
        B        ??SysCtlHClockGet_1
// 1810             }
// 1811             //
// 1812             // The external reference clock is FLL Source
// 1813             //
// 1814             else
// 1815             {
// 1816                 ulFreqout = s_ulExtClockMHz * 1000000;
??SysCtlHClockGet_5:
        LDR      R0,??DataTable33_4
        LDR      R0,[R0, #+0]
        LDR      R1,??DataTable33_5  ;; 0xf4240
        MULS     R0,R1,R0
        MOVS     R6,R0
// 1817                 ulDivider = (xHWREG(SIM_CLKDIV1) & SIM_CLKDIV1_OUTDIV1_M) >> SIM_CLKDIV1_OUTDIV1_S;
        LDR      R0,??DataTable33_6  ;; 0x40048044
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+28
        MOVS     R4,R0
// 1818                 ulFreqout = ulFreqout/(ulDivider+1);            
        MOVS     R0,R6
        MOVS     R1,R4
        ADDS     R1,R1,#+1
        BL       __aeabi_uidiv
        MOVS     R6,R0
// 1819             }
// 1820         }
// 1821     }
// 1822 
// 1823     return ulFreqout;
??SysCtlHClockGet_1:
        MOVS     R0,R6
        POP      {R4-R6,PC}       ;; return
// 1824 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable33:
        DC32     0x4007e001

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable33_1:
        DC32     0xe000e000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable33_2:
        DC32     0x4007e002

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable33_3:
        DC32     0x40064000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable33_4:
        DC32     s_ulExtClockMHz

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable33_5:
        DC32     0xf4240

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable33_6:
        DC32     0x40048044

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable33_7:
        DC32     0x40064001

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable33_8:
        DC32     0x3d0900

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable33_9:
        DC32     0x40064005

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable33_10:
        DC32     0x40064004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable33_11:
        DC32     0x5b8d800
// 1825 
// 1826 //*****************************************************************************
// 1827 //
// 1828 //! \brief This function is used to set HCLK for the system
// 1829 //!
// 1830 //! \param ulSysClk is the clock rate you will set.
// 1831 //! \param ulConfig is the required configuration of the device clock.
// 1832 //!
// 1833 //! The \e ulConfig parameter is the logical OR of several different values,
// 1834 //! many of which are grouped into sets where only one can be chosen.
// 1835 //! 
// 1836 //! The external crystal frequency is chosen with one of the following values:
// 1837 //! \b SYSCTL_XTAL_3MHZ, \b SYSCTL_XTAL_4MHZ, 
// 1838 //! \b SYSCTL_XTAL_5MHZ, \b SYSCTL_XTAL_6MHZ, ...
// 1839 //! \b SYSCTL_XTAL_32MHZ, 
// 1840 //!
// 1841 //! The HCLK source is chosen with one of the following values:
// 1842 //! \b SYSCTL_OSC_MAIN, \b SYSCTL_OSC_PLL, \b SYSCTL_OSC_INT_FAST,
// 1843 //! \b SYSCTL_OSC_FLL_INT, \b SYSCTL_OSC_FLL_MAIN, \b SYSCTL_OSC_INT. 
// 1844 //! 
// 1845 //! \note The ulSysClk should be External Reference Clock Rate if you Set the 
// 1846 //! parameter ulConfig is SYSCTL_OSC_FLL_MAIN.
// 1847 //! \return None.
// 1848 //
// 1849 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
// 1850 void
// 1851 SysCtlHClockSet(unsigned long ulSysClk, unsigned long ulConfig)
// 1852 {
SysCtlHClockSet:
        PUSH     {R0,R1,R4-R7,LR}
        SUB      SP,SP,#+12
// 1853 
// 1854     unsigned long ulOscFreq=0, ulSysDiv, ulCount, i, ucTempReg, ulTemp;
        MOVS     R7,#+0
// 1855     xASSERT((ulSysClk > 0 && ulSysClk <= 48000000));
// 1856 
// 1857     ulSysDiv = 0;
        MOVS     R0,#+0
        MOVS     R5,R0
// 1858     //
// 1859     // Calc oscillator freq
// 1860     //
// 1861     s_ulExtClockMHz = ((ulConfig & SYSCTL_XTAL_MASK) >> 8);
        LDR      R0,[SP, #+16]
        LSRS     R0,R0,#+8
        UXTB     R0,R0
        LDR      R1,??SysCtlHClockSet_0
        STR      R0,[R1, #+0]
// 1862 
// 1863     //
// 1864     // HLCK clock source is SYSCTL_OSC_FLL_INT
// 1865     //
// 1866     if((ulConfig & 0x0F) == SYSCTL_OSC_FLL_INT)
        LDR      R0,[SP, #+16]
        LSLS     R0,R0,#+28       ;; ZeroExtS R0,R0,#+28,#+28
        LSRS     R0,R0,#+28
        CMP      R0,#+1
        BNE      ??SysCtlHClockSet_1
// 1867     {
// 1868         ulOscFreq = 96000000;
        LDR      R0,??SysCtlHClockSet_0+0x4  ;; 0x5b8d800
        MOVS     R7,R0
// 1869         xHWREG(MCG_C1) &= 0x3F;
        LDR      R0,??SysCtlHClockSet_0+0x8  ;; 0x40064000
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+26       ;; ZeroExtS R0,R0,#+26,#+26
        LSRS     R0,R0,#+26
        LDR      R1,??SysCtlHClockSet_0+0x8  ;; 0x40064000
        STR      R0,[R1, #+0]
// 1870         xHWREG(MCG_C1) |= MCG_C1_IREFS;
        LDR      R0,??SysCtlHClockSet_0+0x8  ;; 0x40064000
        LDR      R0,[R0, #+0]
        MOVS     R1,#+4
        ORRS     R1,R1,R0
        LDR      R0,??SysCtlHClockSet_0+0x8  ;; 0x40064000
        STR      R1,[R0, #+0]
// 1871         xHWREG(MCG_C6) &= ~MCG_C6_PLLS;
        LDR      R0,??SysCtlHClockSet_0+0xC  ;; 0x40064005
        LDR      R0,[R0, #+0]
        MOVS     R1,#+64
        BICS     R0,R0,R1
        LDR      R1,??SysCtlHClockSet_0+0xC  ;; 0x40064005
        STR      R0,[R1, #+0]
// 1872         SysCtlHClockSourceSet(SYSCTL_HLCK_S_INT);
        MOVS     R0,#+64
        BL       SysCtlHClockSourceSet
// 1873         SysCtlDelay(100);
        MOVS     R0,#+100
        BL       SysCtlDelay
// 1874         if((ulConfig & OSC0_CR_ERCLKEN)!=0)
        LDR      R0,[SP, #+16]
        LSLS     R0,R0,#+24
        BPL      ??SysCtlHClockSet_2
// 1875         {
// 1876             xHWREG(OSC0_CR) &= ~OSC0_CR_ERCLKEN;
        LDR      R0,??SysCtlHClockSet_0+0x10  ;; 0x40065000
        LDR      R0,[R0, #+0]
        MOVS     R1,#+128
        BICS     R0,R0,R1
        LDR      R1,??SysCtlHClockSet_0+0x10  ;; 0x40065000
        STR      R0,[R1, #+0]
// 1877         }
// 1878         xHWREG(MCG_C5) &= ~MCG_C5_PLLCLKEN0;
??SysCtlHClockSet_2:
        LDR      R0,??SysCtlHClockSet_0+0x14  ;; 0x40064004
        LDR      R0,[R0, #+0]
        MOVS     R1,#+64
        BICS     R0,R0,R1
        LDR      R1,??SysCtlHClockSet_0+0x14  ;; 0x40064004
        STR      R0,[R1, #+0]
// 1879         xHWREG(MCG_C4) |= MCG_C4_DMX32;
        LDR      R0,??SysCtlHClockSet_0+0x18  ;; 0x40064003
        LDR      R0,[R0, #+0]
        MOVS     R1,#+128
        ORRS     R1,R1,R0
        LDR      R0,??SysCtlHClockSet_0+0x18  ;; 0x40064003
        STR      R1,[R0, #+0]
// 1880         xHWREG(MCG_C4) |= MCG_C4_DRST_DRS_MID_HIGH;
        LDR      R0,??SysCtlHClockSet_0+0x18  ;; 0x40064003
        LDR      R0,[R0, #+0]
        MOVS     R1,#+64
        ORRS     R1,R1,R0
        LDR      R0,??SysCtlHClockSet_0+0x18  ;; 0x40064003
        STR      R1,[R0, #+0]
// 1881         if(ulSysClk <= ulOscFreq)
        LDR      R0,[SP, #+12]
        CMP      R7,R0
        BCC      ??SysCtlHClockSet_3
// 1882         {
// 1883             //
// 1884             // Calc the SysDiv
// 1885             //    
// 1886             xASSERT(ulSysClk <= ulOscFreq);
// 1887             
// 1888             for(ulSysDiv = 1; ulSysDiv < 16; ulSysDiv++)
        MOVS     R0,#+1
        MOVS     R5,R0
??SysCtlHClockSet_4:
        CMP      R5,#+16
        BCS      ??SysCtlHClockSet_3
// 1889             {
// 1890                 if((ulOscFreq / (ulSysDiv + 1)) <= ulSysClk)
        MOVS     R0,R7
        MOVS     R1,R5
        ADDS     R1,R1,#+1
        BL       __aeabi_uidiv
        LDR      R1,[SP, #+12]
        CMP      R1,R0
        BCS      ??SysCtlHClockSet_3
// 1891                 {
// 1892                     break;
// 1893                 }
// 1894             }
??SysCtlHClockSet_5:
        ADDS     R5,R5,#+1
        B        ??SysCtlHClockSet_4
// 1895         }
// 1896         xHWREG(SIM_CLKDIV1) &= ~SIM_CLKDIV1_OUTDIV1_M;
??SysCtlHClockSet_3:
        LDR      R0,??SysCtlHClockSet_6  ;; 0x40048044
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+4        ;; ZeroExtS R0,R0,#+4,#+4
        LSRS     R0,R0,#+4
        LDR      R1,??SysCtlHClockSet_6  ;; 0x40048044
        STR      R0,[R1, #+0]
// 1897         xHWREG(SIM_CLKDIV1) |= (ulSysDiv << SIM_CLKDIV1_OUTDIV1_S);
        LDR      R0,??SysCtlHClockSet_6  ;; 0x40048044
        LDR      R0,[R0, #+0]
        LSLS     R1,R5,#+28
        ORRS     R1,R1,R0
        LDR      R0,??SysCtlHClockSet_6  ;; 0x40048044
        STR      R1,[R0, #+0]
        B        ??SysCtlHClockSet_7
// 1898     }
// 1899     //
// 1900     // HLCK clock source is SYSCTL_OSC_FLL_MAIN
// 1901     //
// 1902     else if((ulConfig & 0x0F) == SYSCTL_OSC_FLL_MAIN)
??SysCtlHClockSet_1:
        LDR      R0,[SP, #+16]
        LSLS     R0,R0,#+28       ;; ZeroExtS R0,R0,#+28,#+28
        LSRS     R0,R0,#+28
        CMP      R0,#+8
        BNE      ??SysCtlHClockSet_8
// 1903     {
// 1904         if(!((((xHWREGB(MCG_S) & MCG_S_CLKST_M) >> MCG_S_CLKST_S) == 0x0) &&
// 1905           (xHWREGB(MCG_S) & MCG_S_IREFST) &&
// 1906           (!(xHWREGB(MCG_S) & MCG_S_PLLST))))                                
        LDR      R0,??SysCtlHClockSet_6+0x4  ;; 0x40064006
        LDRB     R0,[R0, #+0]
        UXTB     R0,R0
        ASRS     R0,R0,#+2
        LSLS     R0,R0,#+30       ;; ZeroExtS R0,R0,#+30,#+30
        LSRS     R0,R0,#+30
        CMP      R0,#+0
        BNE      ??SysCtlHClockSet_9
        LDR      R0,??SysCtlHClockSet_6+0x4  ;; 0x40064006
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+27
        BPL      ??SysCtlHClockSet_9
        LDR      R0,??SysCtlHClockSet_6+0x4  ;; 0x40064006
        LDRB     R0,[R0, #+0]
// 1907         {
// 1908         }
// 1909            
// 1910         ucTempReg = xHWREGB(MCG_C2);
??SysCtlHClockSet_9:
        LDR      R0,??SysCtlHClockSet_6+0x8  ;; 0x40064001
        LDRB     R0,[R0, #+0]
        UXTB     R0,R0
        MOVS     R6,R0
// 1911         ucTempReg &= ~(MCG_C2_RANGE0_M | MCG_C2_HGO0 | MCG_C2_EREFS0);
        MOVS     R0,#+60
        BICS     R6,R6,R0
// 1912         ucTempReg |= (MCG_C2_RANGE0_HIGH | MCG_C2_EREFS0); 
        MOVS     R0,R6
        MOVS     R6,#+20
        ORRS     R6,R6,R0
// 1913         xHWREGB(MCG_C2) = ucTempReg;
        LDR      R0,??SysCtlHClockSet_6+0x8  ;; 0x40064001
        MOVS     R1,R6
        STRB     R1,[R0, #+0]
// 1914 
// 1915         ucTempReg = xHWREGB(MCG_C1);
        LDR      R0,??SysCtlHClockSet_0+0x8  ;; 0x40064000
        LDRB     R0,[R0, #+0]
        UXTB     R0,R0
        MOVS     R6,R0
// 1916         ucTempReg &= ~(MCG_C1_SRC_MCGOUTCLK_M | MCG_C1_FRDIV_M | MCG_C1_IREFS);
        MOVS     R0,#+252
        BICS     R6,R6,R0
// 1917         ucTempReg |= (MCG_C1_SRC_MCGOUTCLK_EXTERAL | MCG_C1_FRDIV_256); 
        MOVS     R0,R6
        MOVS     R6,#+152
        ORRS     R6,R6,R0
// 1918         xHWREGB(MCG_C1) = ucTempReg;
        LDR      R0,??SysCtlHClockSet_0+0x8  ;; 0x40064000
        MOVS     R1,R6
        STRB     R1,[R0, #+0]
// 1919 
// 1920         for (i = 0 ; i < 20000 ; i++)
        MOVS     R0,#+0
        MOVS     R4,R0
??SysCtlHClockSet_10:
        LDR      R0,??SysCtlHClockSet_6+0xC  ;; 0x4e20
        CMP      R4,R0
        BCS      ??SysCtlHClockSet_11
// 1921         {
// 1922             if(xHWREGB(MCG_S) & MCG_S_OSCINIT0)
        LDR      R0,??SysCtlHClockSet_6+0x4  ;; 0x40064006
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+30
        BMI      ??SysCtlHClockSet_11
// 1923             {
// 1924                 //
// 1925                 // jump out early if OSCINIT sets before loop finishes
// 1926                 //
// 1927                 break;
// 1928             }
// 1929         }
??SysCtlHClockSet_12:
        ADDS     R4,R4,#+1
        B        ??SysCtlHClockSet_10
// 1930         //
// 1931         // wait for Reference clock Status bit to clear
// 1932         //
// 1933         for (i = 0 ; i < 20000 ; i++)
??SysCtlHClockSet_11:
        MOVS     R0,#+0
        MOVS     R4,R0
??SysCtlHClockSet_13:
        LDR      R0,??SysCtlHClockSet_6+0xC  ;; 0x4e20
        CMP      R4,R0
        BCS      ??SysCtlHClockSet_14
// 1934         {
// 1935             if(xHWREGB(MCG_S) & MCG_S_IREFST)
        LDR      R0,??SysCtlHClockSet_6+0x4  ;; 0x40064006
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+27
        BMI      ??SysCtlHClockSet_14
// 1936             {
// 1937                 //
// 1938                 // jump out early if OSCINIT sets before loop finishes
// 1939                 //
// 1940                 break; 
// 1941             }
// 1942         }
??SysCtlHClockSet_15:
        ADDS     R4,R4,#+1
        B        ??SysCtlHClockSet_13
// 1943         //
// 1944         // Wait for clock status bits to show clock source is ext ref clk
// 1945         //
// 1946         for (i = 0 ; i < 20000 ; i++)
??SysCtlHClockSet_14:
        MOVS     R0,#+0
        MOVS     R4,R0
??SysCtlHClockSet_16:
        LDR      R0,??SysCtlHClockSet_6+0xC  ;; 0x4e20
        CMP      R4,R0
        BCS      ??SysCtlHClockSet_17
// 1947         {
// 1948             if((xHWREGB(MCG_S) & MCG_S_CLKST_M)==MCG_S_CLKST_EXT)
        LDR      R0,??SysCtlHClockSet_6+0x4  ;; 0x40064006
        LDRB     R0,[R0, #+0]
        UXTB     R0,R0
        MOVS     R1,#+12
        ANDS     R1,R1,R0
        CMP      R1,#+8
        BEQ      ??SysCtlHClockSet_17
// 1949             {
// 1950                 //
// 1951                 // jump out early if CLKST shows EXT CLK slected before loop finishes
// 1952                 //
// 1953                 break;
// 1954             }
// 1955         }
??SysCtlHClockSet_18:
        ADDS     R4,R4,#+1
        B        ??SysCtlHClockSet_16
// 1956         xHWREGB(MCG_C6) |= MCG_C6_CME0;
??SysCtlHClockSet_17:
        LDR      R0,??SysCtlHClockSet_0+0xC  ;; 0x40064005
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+32
        ORRS     R1,R1,R0
        LDR      R0,??SysCtlHClockSet_0+0xC  ;; 0x40064005
        STRB     R1,[R0, #+0]
// 1957         ulOscFreq = s_ulExtClockMHz * 1000000;
        LDR      R0,??SysCtlHClockSet_0
        LDR      R0,[R0, #+0]
        LDR      R1,??SysCtlHClockSet_19  ;; 0xf4240
        MULS     R0,R1,R0
        MOVS     R7,R0
// 1958         if(ulSysClk <= ulOscFreq)
        LDR      R0,[SP, #+12]
        CMP      R7,R0
        BCS      .+4
        B        ??SysCtlHClockSet_7
// 1959         {
// 1960             //
// 1961             // Calc the SysDiv
// 1962             //    
// 1963             xASSERT(ulSysClk <= ulOscFreq);
// 1964             
// 1965             for(ulSysDiv = 1; ulSysDiv < 16; ulSysDiv++)
        MOVS     R0,#+1
        MOVS     R5,R0
??SysCtlHClockSet_20:
        CMP      R5,#+16
        BCS      ??SysCtlHClockSet_21
// 1966             {
// 1967                 if((ulOscFreq / (ulSysDiv + 1)) <= ulSysClk)
        MOVS     R0,R7
        MOVS     R1,R5
        ADDS     R1,R1,#+1
        BL       __aeabi_uidiv
        LDR      R1,[SP, #+12]
        CMP      R1,R0
        BCS      ??SysCtlHClockSet_21
// 1968                 {
// 1969                     break;
// 1970                 }
// 1971             }
??SysCtlHClockSet_22:
        ADDS     R5,R5,#+1
        B        ??SysCtlHClockSet_20
// 1972             xHWREG(SIM_CLKDIV1) &= ~SIM_CLKDIV1_OUTDIV1_M;
??SysCtlHClockSet_21:
        LDR      R0,??SysCtlHClockSet_6  ;; 0x40048044
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+4        ;; ZeroExtS R0,R0,#+4,#+4
        LSRS     R0,R0,#+4
        LDR      R1,??SysCtlHClockSet_6  ;; 0x40048044
        STR      R0,[R1, #+0]
// 1973             xHWREG(SIM_CLKDIV1) |= (ulSysDiv << SIM_CLKDIV1_OUTDIV1_S);
        LDR      R0,??SysCtlHClockSet_6  ;; 0x40048044
        LDR      R0,[R0, #+0]
        LSLS     R1,R5,#+28
        ORRS     R1,R1,R0
        LDR      R0,??SysCtlHClockSet_6  ;; 0x40048044
        STR      R1,[R0, #+0]
        B        ??SysCtlHClockSet_7
// 1974         }
// 1975     }
// 1976     //
// 1977     // HLCK clock source is SYSCTL_OSC_INT_FAST
// 1978     //
// 1979     else if((ulConfig & 0x0F) == SYSCTL_OSC_INT_FAST)
??SysCtlHClockSet_8:
        LDR      R0,[SP, #+16]
        LSLS     R0,R0,#+28       ;; ZeroExtS R0,R0,#+28,#+28
        LSRS     R0,R0,#+28
        CMP      R0,#+4
        BNE      ??SysCtlHClockSet_23
// 1980     {
// 1981         ulOscFreq = 4000000;
        LDR      R0,??SysCtlHClockSet_19+0x4  ;; 0x3d0900
        MOVS     R7,R0
// 1982         xHWREG(OSC0_CR) &= ~OSC0_CR_ERCLKEN;
        LDR      R0,??SysCtlHClockSet_0+0x10  ;; 0x40065000
        LDR      R0,[R0, #+0]
        MOVS     R1,#+128
        BICS     R0,R0,R1
        LDR      R1,??SysCtlHClockSet_0+0x10  ;; 0x40065000
        STR      R0,[R1, #+0]
// 1983         SysCtlHClockSourceSet(SYSCTL_HLCK_S_INT);
        MOVS     R0,#+64
        BL       SysCtlHClockSourceSet
// 1984         xHWREG(MCG_C6) &= ~MCG_C6_PLLS;
        LDR      R0,??SysCtlHClockSet_0+0xC  ;; 0x40064005
        LDR      R0,[R0, #+0]
        MOVS     R1,#+64
        BICS     R0,R0,R1
        LDR      R1,??SysCtlHClockSet_0+0xC  ;; 0x40064005
        STR      R0,[R1, #+0]
// 1985         xHWREG(MCG_C2) &= ~MCG_C2_LP;
        LDR      R0,??SysCtlHClockSet_6+0x8  ;; 0x40064001
        LDR      R0,[R0, #+0]
        MOVS     R1,#+2
        BICS     R0,R0,R1
        LDR      R1,??SysCtlHClockSet_6+0x8  ;; 0x40064001
        STR      R0,[R1, #+0]
// 1986         xHWREG(MCG_C2) |= MCG_C2_IRCS;
        LDR      R0,??SysCtlHClockSet_6+0x8  ;; 0x40064001
        LDR      R0,[R0, #+0]
        MOVS     R1,#+1
        ORRS     R1,R1,R0
        LDR      R0,??SysCtlHClockSet_6+0x8  ;; 0x40064001
        STR      R1,[R0, #+0]
// 1987         SysCtlDelay(100);
        MOVS     R0,#+100
        BL       SysCtlDelay
// 1988         if((ulConfig & OSC0_CR_ERCLKEN)!=0)
        LDR      R0,[SP, #+16]
        LSLS     R0,R0,#+24
        BPL      ??SysCtlHClockSet_24
// 1989         {
// 1990             xHWREG(OSC0_CR) &= ~OSC0_CR_ERCLKEN;
        LDR      R0,??SysCtlHClockSet_0+0x10  ;; 0x40065000
        LDR      R0,[R0, #+0]
        MOVS     R1,#+128
        BICS     R0,R0,R1
        LDR      R1,??SysCtlHClockSet_0+0x10  ;; 0x40065000
        STR      R0,[R1, #+0]
// 1991         }
// 1992         while(!(xHWREG(MCG_S)&MCG_S_CLKST_INT));
??SysCtlHClockSet_24:
        LDR      R0,??SysCtlHClockSet_6+0x4  ;; 0x40064006
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+29
        BPL      ??SysCtlHClockSet_24
// 1993         if(ulSysClk <= ulOscFreq)
        LDR      R0,[SP, #+12]
        CMP      R7,R0
        BCC      ??SysCtlHClockSet_25
// 1994         {
// 1995             //
// 1996             // Calc the SysDiv
// 1997             //    
// 1998             xASSERT(ulSysClk <= ulOscFreq);
// 1999             
// 2000             for(ulSysDiv = 1; ulSysDiv < 16; ulSysDiv++)
        MOVS     R0,#+1
        MOVS     R5,R0
??SysCtlHClockSet_26:
        CMP      R5,#+16
        BCS      ??SysCtlHClockSet_25
// 2001             {
// 2002                 if((ulOscFreq / (ulSysDiv + 1)) <= ulSysClk)
        MOVS     R0,R7
        MOVS     R1,R5
        ADDS     R1,R1,#+1
        BL       __aeabi_uidiv
        LDR      R1,[SP, #+12]
        CMP      R1,R0
        BCS      ??SysCtlHClockSet_25
// 2003                 {
// 2004                     break;
// 2005                 }
// 2006             }
??SysCtlHClockSet_27:
        ADDS     R5,R5,#+1
        B        ??SysCtlHClockSet_26
// 2007         }
// 2008         xHWREG(SIM_CLKDIV1) &= ~SIM_CLKDIV1_OUTDIV1_M;
??SysCtlHClockSet_25:
        LDR      R0,??SysCtlHClockSet_6  ;; 0x40048044
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+4        ;; ZeroExtS R0,R0,#+4,#+4
        LSRS     R0,R0,#+4
        LDR      R1,??SysCtlHClockSet_6  ;; 0x40048044
        STR      R0,[R1, #+0]
// 2009         xHWREG(SIM_CLKDIV1) |= (ulSysDiv << SIM_CLKDIV1_OUTDIV1_S);
        LDR      R0,??SysCtlHClockSet_6  ;; 0x40048044
        LDR      R0,[R0, #+0]
        LSLS     R1,R5,#+28
        ORRS     R1,R1,R0
        LDR      R0,??SysCtlHClockSet_6  ;; 0x40048044
        STR      R1,[R0, #+0]
        B        ??SysCtlHClockSet_7
// 2010     }
// 2011     //
// 2012     // HLCK clock source is SYSCTL_OSC_INT
// 2013     //
// 2014     else if((ulConfig & 0x0F) == SYSCTL_OSC_INT)
// 2015     {
// 2016         if(!((((xHWREGB(MCG_S) & MCG_S_CLKST_M) >> MCG_S_CLKST_S) == 0x0) &&
// 2017           (xHWREGB(MCG_S) & MCG_S_IREFST) &&
// 2018           (!(xHWREGB(MCG_S) & MCG_S_PLLST))))                                
// 2019         {
// 2020         }
// 2021         xHWREG(MCG_C2) &= ~MCG_C2_IRCS;
// 2022         //
// 2023         // Change the CLKS mux to select the IRC as the MCGOUT
// 2024         //
// 2025         ucTempReg = xHWREGB(MCG_C1);
// 2026         ucTempReg &= ~MCG_C1_SRC_MCGOUTCLK_M;
// 2027         //
// 2028         // select IRC as the MCG clock sourse
// 2029         //
// 2030         ucTempReg |= MCG_C1_SRC_MCGOUTCLK_INTERAL;
// 2031         xHWREGB(MCG_C1) = ucTempReg;
// 2032         //
// 2033         // wait until internal reference switches to requested irc.
// 2034         //
// 2035         for (i = 0 ; i < 2000 ; i++)
// 2036         {
// 2037             if((xHWREGB(MCG_S) & MCG_S_IRCST) != MCG_S_IRCST)
// 2038             {
// 2039                 break;
// 2040             }
// 2041 
// 2042         }
// 2043         //
// 2044         // Wait for clock status bits to update
// 2045         //
// 2046         for (i = 0 ; i < 2000 ; i++)
// 2047         {
// 2048             if((xHWREGB(MCG_S) & MCG_S_CLKST_INT) == MCG_S_CLKST_INT)
// 2049             {
// 2050                 break;            
// 2051             }
// 2052 
// 2053         }
// 2054     }
// 2055     //
// 2056     // HLCK clock source is SYSCTL_OSC_PLL
// 2057     //
// 2058     else if((ulConfig & 0xF0) == SYSCTL_OSC_PLL)
??SysCtlHClockSet_23:
        LDR      R0,[SP, #+16]
        MOVS     R1,#+240
        ANDS     R1,R1,R0
        CMP      R1,#+32
        BEQ      .+4
        B        ??SysCtlHClockSet_28
// 2059     {
// 2060         ulCount = 4096;
        MOVS     R0,#+128
        LSLS     R0,R0,#+5        ;; #+4096
        STR      R0,[SP, #+0]
// 2061         xHWREG(OSC0_CR) |= OSC0_CR_ERCLKEN;
        LDR      R0,??SysCtlHClockSet_0+0x10  ;; 0x40065000
        LDR      R0,[R0, #+0]
        MOVS     R1,#+128
        ORRS     R1,R1,R0
        LDR      R0,??SysCtlHClockSet_0+0x10  ;; 0x40065000
        STR      R1,[R0, #+0]
// 2062         while(ulCount--);
??SysCtlHClockSet_29:
        LDR      R0,[SP, #+0]
        SUBS     R1,R0,#+1
        STR      R1,[SP, #+0]
        CMP      R0,#+0
        BNE      ??SysCtlHClockSet_29
// 2063         xHWREG(MCG_C2) |= MCG_C2_RANGE0_HIGH;
        LDR      R0,??SysCtlHClockSet_6+0x8  ;; 0x40064001
        LDR      R0,[R0, #+0]
        MOVS     R1,#+16
        ORRS     R1,R1,R0
        LDR      R0,??SysCtlHClockSet_6+0x8  ;; 0x40064001
        STR      R1,[R0, #+0]
// 2064         xHWREG(MCG_C2) |= MCG_C2_HGO0;
        LDR      R0,??SysCtlHClockSet_6+0x8  ;; 0x40064001
        LDR      R0,[R0, #+0]
        MOVS     R1,#+8
        ORRS     R1,R1,R0
        LDR      R0,??SysCtlHClockSet_6+0x8  ;; 0x40064001
        STR      R1,[R0, #+0]
// 2065         xHWREG(MCG_C2) &= ~MCG_C2_EREFS0;
        LDR      R0,??SysCtlHClockSet_6+0x8  ;; 0x40064001
        LDR      R0,[R0, #+0]
        MOVS     R1,#+4
        BICS     R0,R0,R1
        LDR      R1,??SysCtlHClockSet_6+0x8  ;; 0x40064001
        STR      R0,[R1, #+0]
// 2066         xHWREG(MCG_C1) |= MCG_C1_SRC_MCGOUTCLK_EXTERAL;
        LDR      R0,??SysCtlHClockSet_0+0x8  ;; 0x40064000
        LDR      R0,[R0, #+0]
        MOVS     R1,#+128
        ORRS     R1,R1,R0
        LDR      R0,??SysCtlHClockSet_0+0x8  ;; 0x40064000
        STR      R1,[R0, #+0]
// 2067         xHWREG(MCG_C1) |= MCG_C1_FRDIV_128;
        LDR      R0,??SysCtlHClockSet_0+0x8  ;; 0x40064000
        LDR      R0,[R0, #+0]
        MOVS     R1,#+16
        ORRS     R1,R1,R0
        LDR      R0,??SysCtlHClockSet_0+0x8  ;; 0x40064000
        STR      R1,[R0, #+0]
// 2068         xHWREG(MCG_C1) &= ~MCG_C1_IREFS;
        LDR      R0,??SysCtlHClockSet_0+0x8  ;; 0x40064000
        LDR      R0,[R0, #+0]
        MOVS     R1,#+4
        BICS     R0,R0,R1
        LDR      R1,??SysCtlHClockSet_0+0x8  ;; 0x40064000
        STR      R0,[R1, #+0]
// 2069         while(!(xHWREG(MCG_S)&MCG_S_OSCINIT0));
??SysCtlHClockSet_30:
        LDR      R0,??SysCtlHClockSet_6+0x4  ;; 0x40064006
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+30
        BPL      ??SysCtlHClockSet_30
// 2070         while((xHWREG(MCG_S)&MCG_S_IREFST));
??SysCtlHClockSet_31:
        LDR      R0,??SysCtlHClockSet_6+0x4  ;; 0x40064006
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+27
        BMI      ??SysCtlHClockSet_31
// 2071         while(!(xHWREG(MCG_S)&MCG_S_CLKST_EXT));
??SysCtlHClockSet_32:
        LDR      R0,??SysCtlHClockSet_6+0x4  ;; 0x40064006
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+28
        BPL      ??SysCtlHClockSet_32
// 2072         xHWREG(MCG_C5) &= ~MCG_C5_PRDIV0_M;
        LDR      R0,??SysCtlHClockSet_0+0x14  ;; 0x40064004
        LDR      R0,[R0, #+0]
        MOVS     R1,#+31
        BICS     R0,R0,R1
        LDR      R1,??SysCtlHClockSet_0+0x14  ;; 0x40064004
        STR      R0,[R1, #+0]
// 2073             
// 2074         ulOscFreq = s_ulExtClockMHz*1000000;
        LDR      R0,??SysCtlHClockSet_0
        LDR      R0,[R0, #+0]
        LDR      R1,??SysCtlHClockSet_19  ;; 0xf4240
        MULS     R0,R1,R0
        MOVS     R7,R0
// 2075         if (ulSysClk <= ulOscFreq)
        LDR      R0,[SP, #+12]
        CMP      R7,R0
        BCC      ??SysCtlHClockSet_33
// 2076         {
// 2077             //
// 2078             // Calc the SysDiv
// 2079             //    
// 2080             xASSERT(ulSysClk <= ulOscFreq);
// 2081             
// 2082             for(ulSysDiv = 1; ulSysDiv < 16; ulSysDiv++)
        MOVS     R0,#+1
        MOVS     R5,R0
??SysCtlHClockSet_34:
        CMP      R5,#+16
        BCS      ??SysCtlHClockSet_35
// 2083             {
// 2084                 if((ulOscFreq / (ulSysDiv + 1)) <= ulSysClk)
        MOVS     R0,R7
        MOVS     R1,R5
        ADDS     R1,R1,#+1
        BL       __aeabi_uidiv
        LDR      R1,[SP, #+12]
        CMP      R1,R0
        BCS      ??SysCtlHClockSet_35
// 2085                 {
// 2086                     break;
// 2087                 }
// 2088             }
??SysCtlHClockSet_36:
        ADDS     R5,R5,#+1
        B        ??SysCtlHClockSet_34
        Nop      
        DATA
??SysCtlHClockSet_0:
        DC32     s_ulExtClockMHz
        DC32     0x5b8d800
        DC32     0x40064000
        DC32     0x40064005
        DC32     0x40065000
        DC32     0x40064004
        DC32     0x40064003
        THUMB
// 2089             xHWREG(SIM_CLKDIV1) &= ~SIM_CLKDIV1_OUTDIV1_M;
??SysCtlHClockSet_35:
        LDR      R0,??SysCtlHClockSet_6  ;; 0x40048044
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+4        ;; ZeroExtS R0,R0,#+4,#+4
        LSRS     R0,R0,#+4
        LDR      R1,??SysCtlHClockSet_6  ;; 0x40048044
        STR      R0,[R1, #+0]
// 2090             xHWREG(SIM_CLKDIV1) |= (ulSysDiv << SIM_CLKDIV1_OUTDIV1_S);
        LDR      R0,??SysCtlHClockSet_6  ;; 0x40048044
        LDR      R0,[R0, #+0]
        LSLS     R1,R5,#+28
        ORRS     R1,R1,R0
        LDR      R0,??SysCtlHClockSet_6  ;; 0x40048044
        STR      R1,[R0, #+0]
        B        ??SysCtlHClockSet_7
// 2091         }
// 2092         else
// 2093         {
// 2094             xHWREG(MCG_C6) |= MCG_C6_PLLS;
??SysCtlHClockSet_33:
        LDR      R0,??DataTable37  ;; 0x40064005
        LDR      R0,[R0, #+0]
        MOVS     R1,#+64
        ORRS     R1,R1,R0
        LDR      R0,??DataTable37  ;; 0x40064005
        STR      R1,[R0, #+0]
// 2095             while(!(xHWREG(MCG_S)&MCG_S_PLLST));
??SysCtlHClockSet_37:
        LDR      R0,??SysCtlHClockSet_6+0x4  ;; 0x40064006
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+26
        BPL      ??SysCtlHClockSet_37
// 2096             while(!(xHWREG(MCG_S)&MCG_S_LOCK0));
??SysCtlHClockSet_38:
        LDR      R0,??SysCtlHClockSet_6+0x4  ;; 0x40064006
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+25
        BPL      ??SysCtlHClockSet_38
// 2097             SysCtlHClockSourceSet(SYSCTL_HLCK_S_PLL);
        MOVS     R0,#+0
        BL       SysCtlHClockSourceSet
// 2098             while(!((xHWREG(MCG_S)&MCG_S_CLKST_PLL)==MCG_S_CLKST_PLL));
??SysCtlHClockSet_39:
        LDR      R0,??SysCtlHClockSet_6+0x4  ;; 0x40064006
        LDR      R0,[R0, #+0]
        MOVS     R1,#+12
        ANDS     R1,R1,R0
        CMP      R1,#+12
        BNE      ??SysCtlHClockSet_39
// 2099             xHWREG(MCG_C6) |= MCG_C6_VDIV0_48;
        LDR      R0,??DataTable37  ;; 0x40064005
        LDR      R0,[R0, #+0]
        MOVS     R1,#+24
        ORRS     R1,R1,R0
        LDR      R0,??DataTable37  ;; 0x40064005
        STR      R1,[R0, #+0]
// 2100             ulOscFreq = 48*ulOscFreq;
        MOVS     R0,#+48
        MULS     R7,R0,R7
// 2101             for(ulSysDiv = 1; ulSysDiv < 16; ulSysDiv++)
        MOVS     R0,#+1
        MOVS     R5,R0
??SysCtlHClockSet_40:
        CMP      R5,#+16
        BCS      ??SysCtlHClockSet_41
// 2102             {
// 2103                 if((ulOscFreq / (ulSysDiv + 1)) <= ulSysClk)
        MOVS     R0,R7
        MOVS     R1,R5
        ADDS     R1,R1,#+1
        BL       __aeabi_uidiv
        LDR      R1,[SP, #+12]
        CMP      R1,R0
        BCS      ??SysCtlHClockSet_41
// 2104                 {
// 2105                     break;
// 2106                 }
// 2107             }
??SysCtlHClockSet_42:
        ADDS     R5,R5,#+1
        B        ??SysCtlHClockSet_40
// 2108             xHWREG(SIM_CLKDIV1) &= ~SIM_CLKDIV1_OUTDIV1_M;
??SysCtlHClockSet_41:
        LDR      R0,??SysCtlHClockSet_6  ;; 0x40048044
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+4        ;; ZeroExtS R0,R0,#+4,#+4
        LSRS     R0,R0,#+4
        LDR      R1,??SysCtlHClockSet_6  ;; 0x40048044
        STR      R0,[R1, #+0]
// 2109             xHWREG(SIM_CLKDIV1) |= (ulSysDiv << SIM_CLKDIV1_OUTDIV1_S);
        LDR      R0,??SysCtlHClockSet_6  ;; 0x40048044
        LDR      R0,[R0, #+0]
        LSLS     R1,R5,#+28
        ORRS     R1,R1,R0
        LDR      R0,??SysCtlHClockSet_6  ;; 0x40048044
        STR      R1,[R0, #+0]
        B        ??SysCtlHClockSet_7
        Nop      
        DATA
??SysCtlHClockSet_6:
        DC32     0x40048044
        DC32     0x40064006
        DC32     0x40064001
        DC32     0x4e20
        THUMB
// 2110         }
// 2111     }
// 2112     //
// 2113     // HLCK clock source is SYSCTL_OSC_MAIN
// 2114     //
// 2115     else 
// 2116     {
// 2117         xHWREG(SIM_CLKDIV1) &= ~SIM_CLKDIV1_OUTDIV1_M;
??SysCtlHClockSet_28:
        LDR      R0,??DataTable40  ;; 0x40048044
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+4        ;; ZeroExtS R0,R0,#+4,#+4
        LSRS     R0,R0,#+4
        LDR      R1,??DataTable40  ;; 0x40048044
        STR      R0,[R1, #+0]
// 2118         xHWREG(SIM_CLKDIV1) &= ~SIM_CLKDIV1_OUTDIV4_M;
        LDR      R0,??DataTable40  ;; 0x40048044
        LDR      R0,[R0, #+0]
        LDR      R1,??DataTable40_1  ;; 0xfff8ffff
        ANDS     R1,R1,R0
        LDR      R0,??DataTable40  ;; 0x40048044
        STR      R1,[R0, #+0]
// 2119         xHWREG(SIM_CLKDIV1) |= SIM_CLKDIV1_OUTDIV4_2;
        LDR      R0,??DataTable40  ;; 0x40048044
        LDR      R0,[R0, #+0]
        MOVS     R1,#+128
        LSLS     R1,R1,#+9        ;; #+65536
        ORRS     R1,R1,R0
        LDR      R0,??DataTable40  ;; 0x40048044
        STR      R1,[R0, #+0]
// 2120 
// 2121         if(!((((xHWREGB(MCG_S) & MCG_S_CLKST_M) >> MCG_S_CLKST_S) == 0x0) &&
// 2122           (xHWREGB(MCG_S) & MCG_S_IREFST) &&
// 2123           (!(xHWREGB(MCG_S) & MCG_S_PLLST))))                                
        LDR      R0,??DataTable40_2  ;; 0x40064006
        LDRB     R0,[R0, #+0]
        UXTB     R0,R0
        ASRS     R0,R0,#+2
        LSLS     R0,R0,#+30       ;; ZeroExtS R0,R0,#+30,#+30
        LSRS     R0,R0,#+30
        CMP      R0,#+0
        BNE      ??SysCtlHClockSet_43
        LDR      R0,??DataTable40_2  ;; 0x40064006
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+27
        BPL      ??SysCtlHClockSet_43
        LDR      R0,??DataTable40_2  ;; 0x40064006
        LDRB     R0,[R0, #+0]
// 2124         {
// 2125         }
// 2126            
// 2127         ucTempReg = xHWREGB(MCG_C2);
??SysCtlHClockSet_43:
        LDR      R0,??DataTable40_3  ;; 0x40064001
        LDRB     R0,[R0, #+0]
        UXTB     R0,R0
        MOVS     R6,R0
// 2128         ucTempReg &= ~(MCG_C2_RANGE0_M | MCG_C2_HGO0 | MCG_C2_EREFS0);
        MOVS     R0,#+60
        BICS     R6,R6,R0
// 2129         ucTempReg |= (MCG_C2_RANGE0_HIGH | MCG_C2_EREFS0); 
        MOVS     R0,R6
        MOVS     R6,#+20
        ORRS     R6,R6,R0
// 2130         xHWREGB(MCG_C2) = ucTempReg;
        LDR      R0,??DataTable40_3  ;; 0x40064001
        MOVS     R1,R6
        STRB     R1,[R0, #+0]
// 2131 
// 2132         ucTempReg = xHWREGB(MCG_C1);
        LDR      R0,??DataTable40_4  ;; 0x40064000
        LDRB     R0,[R0, #+0]
        UXTB     R0,R0
        MOVS     R6,R0
// 2133         ucTempReg &= ~(MCG_C1_SRC_MCGOUTCLK_M | MCG_C1_FRDIV_M | MCG_C1_IREFS);
        MOVS     R0,#+252
        BICS     R6,R6,R0
// 2134         ucTempReg |= (MCG_C1_SRC_MCGOUTCLK_EXTERAL | MCG_C1_FRDIV_256); 
        MOVS     R0,R6
        MOVS     R6,#+152
        ORRS     R6,R6,R0
// 2135         xHWREGB(MCG_C1) = ucTempReg;
        LDR      R0,??DataTable40_4  ;; 0x40064000
        MOVS     R1,R6
        STRB     R1,[R0, #+0]
// 2136 
// 2137         for (i = 0 ; i < 20000 ; i++)
        MOVS     R0,#+0
        MOVS     R4,R0
??SysCtlHClockSet_44:
        LDR      R0,??DataTable41  ;; 0x4e20
        CMP      R4,R0
        BCS      ??SysCtlHClockSet_45
// 2138         {
// 2139             if(xHWREGB(MCG_S) & MCG_S_OSCINIT0)
        LDR      R0,??DataTable40_2  ;; 0x40064006
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+30
        BMI      ??SysCtlHClockSet_45
// 2140             {
// 2141                 //
// 2142                 // jump out early if OSCINIT sets before loop finishes
// 2143                 //
// 2144                 break;
// 2145             }
// 2146         }
??SysCtlHClockSet_46:
        ADDS     R4,R4,#+1
        B        ??SysCtlHClockSet_44
// 2147         //
// 2148         // wait for Reference clock Status bit to clear
// 2149         //
// 2150         for (i = 0 ; i < 20000 ; i++)
??SysCtlHClockSet_45:
        MOVS     R0,#+0
        MOVS     R4,R0
??SysCtlHClockSet_47:
        LDR      R0,??DataTable41  ;; 0x4e20
        CMP      R4,R0
        BCS      ??SysCtlHClockSet_48
// 2151         {
// 2152             if(xHWREGB(MCG_S) & MCG_S_IREFST)
        LDR      R0,??DataTable40_2  ;; 0x40064006
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+27
        BMI      ??SysCtlHClockSet_48
// 2153             {
// 2154                 //
// 2155                 // jump out early if OSCINIT sets before loop finishes
// 2156                 //
// 2157                 break; 
// 2158             }
// 2159         }
??SysCtlHClockSet_49:
        ADDS     R4,R4,#+1
        B        ??SysCtlHClockSet_47
// 2160         //
// 2161         // Wait for clock status bits to show clock source is ext ref clk
// 2162         //
// 2163         for (i = 0 ; i < 20000 ; i++)
??SysCtlHClockSet_48:
        MOVS     R0,#+0
        MOVS     R4,R0
??SysCtlHClockSet_50:
        LDR      R0,??DataTable41  ;; 0x4e20
        CMP      R4,R0
        BCS      ??SysCtlHClockSet_51
// 2164         {
// 2165             if((xHWREGB(MCG_S) & MCG_S_CLKST_M)==MCG_S_CLKST_EXT)
        LDR      R0,??DataTable40_2  ;; 0x40064006
        LDRB     R0,[R0, #+0]
        UXTB     R0,R0
        MOVS     R1,#+12
        ANDS     R1,R1,R0
        CMP      R1,#+8
        BEQ      ??SysCtlHClockSet_51
// 2166             {
// 2167                 //
// 2168                 // jump out early if CLKST shows EXT CLK slected before loop finishes
// 2169                 //
// 2170                 break;
// 2171             }
// 2172         }
??SysCtlHClockSet_52:
        ADDS     R4,R4,#+1
        B        ??SysCtlHClockSet_50
        Nop      
        DATA
??SysCtlHClockSet_19:
        DC32     0xf4240
        DC32     0x3d0900
        THUMB
// 2173         xHWREGB(MCG_C6) |= MCG_C6_CME0;
??SysCtlHClockSet_51:
        LDR      R0,??DataTable37  ;; 0x40064005
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+32
        ORRS     R1,R1,R0
        LDR      R0,??DataTable37  ;; 0x40064005
        STRB     R1,[R0, #+0]
// 2174 
// 2175         ucTempReg = xHWREGB(MCG_C5);
        LDR      R0,??DataTable41_1  ;; 0x40064004
        LDRB     R0,[R0, #+0]
        UXTB     R0,R0
        MOVS     R6,R0
// 2176         ucTempReg &= ~(MCG_C5_PRDIV0_M);
        MOVS     R0,#+31
        BICS     R6,R6,R0
// 2177         ulTemp = ulSysClk/1000000;
        LDR      R0,[SP, #+12]
        LDR      R1,??DataTable41_2  ;; 0xf4240
        BL       __aeabi_uidiv
        STR      R0,[SP, #+4]
// 2178         ulSysDiv = 192/ulTemp;
        MOVS     R0,#+192
        LDR      R1,[SP, #+4]
        BL       __aeabi_uidiv
        MOVS     R5,R0
// 2179         if(ulSysDiv >= 24)
        CMP      R5,#+24
        BCC      ??SysCtlHClockSet_53
// 2180         {
// 2181             ulSysDiv = 24;
        MOVS     R0,#+24
        MOVS     R5,R0
// 2182         }
// 2183         ucTempReg |= (ulSysDiv-1); 
??SysCtlHClockSet_53:
        MOVS     R0,R6
        SUBS     R6,R5,#+1
        ORRS     R6,R6,R0
// 2184         xHWREGB(MCG_C5) = ucTempReg;
        LDR      R0,??DataTable41_1  ;; 0x40064004
        MOVS     R1,R6
        STRB     R1,[R0, #+0]
// 2185 
// 2186         ucTempReg = xHWREGB(MCG_C6);
        LDR      R0,??DataTable37  ;; 0x40064005
        LDRB     R0,[R0, #+0]
        UXTB     R0,R0
        MOVS     R6,R0
// 2187         ucTempReg &= ~(MCG_C6_VDIV0_M);
        MOVS     R0,#+31
        BICS     R6,R6,R0
// 2188         ucTempReg |= (MCG_C6_PLLS | MCG_C6_VDIV0_24); 
        MOVS     R0,R6
        MOVS     R6,#+64
        ORRS     R6,R6,R0
// 2189         xHWREGB(MCG_C6) = ucTempReg;
        LDR      R0,??DataTable37  ;; 0x40064005
        MOVS     R1,R6
        STRB     R1,[R0, #+0]
// 2190             
// 2191         //
// 2192         // wait for PLLST status bit to set
// 2193         //
// 2194         for(i = 0 ; i < 2000 ; i++)
        MOVS     R0,#+0
        MOVS     R4,R0
??SysCtlHClockSet_54:
        MOVS     R0,#+250
        LSLS     R0,R0,#+3        ;; #+2000
        CMP      R4,R0
        BCS      ??SysCtlHClockSet_55
// 2195         {
// 2196             if(xHWREGB(MCG_S) & MCG_S_PLLST)
        LDR      R0,??DataTable40_2  ;; 0x40064006
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+26
        BMI      ??SysCtlHClockSet_55
// 2197             {
// 2198                 //
// 2199                 // jump out early if PLLST sets before loop finishes
// 2200                 //
// 2201                 break; 
// 2202             }
// 2203         }
??SysCtlHClockSet_56:
        ADDS     R4,R4,#+1
        B        ??SysCtlHClockSet_54
// 2204         //
// 2205         // Wait for LOCK bit to set
// 2206         //
// 2207         for(i = 0 ; i < 4000 ; i++)
??SysCtlHClockSet_55:
        MOVS     R0,#+0
        MOVS     R4,R0
??SysCtlHClockSet_57:
        MOVS     R0,#+250
        LSLS     R0,R0,#+4        ;; #+4000
        CMP      R4,R0
        BCS      ??SysCtlHClockSet_58
// 2208         {
// 2209             if(xHWREGB(MCG_S)&MCG_S_LOCK0)
        LDR      R0,??DataTable40_2  ;; 0x40064006
        LDRB     R0,[R0, #+0]
        LSLS     R0,R0,#+25
        BMI      ??SysCtlHClockSet_58
// 2210             {
// 2211                 //
// 2212                 // jump out early if LOCK sets before loop finishes
// 2213                 //
// 2214                 break;
// 2215             }
// 2216         }
??SysCtlHClockSet_59:
        ADDS     R4,R4,#+1
        B        ??SysCtlHClockSet_57
// 2217 
// 2218         SysCtlHClockSourceSet(SYSCTL_HLCK_S_PLL);
??SysCtlHClockSet_58:
        MOVS     R0,#+0
        BL       SysCtlHClockSourceSet
// 2219 
// 2220         //
// 2221         // Wait for clock status bits to update
// 2222         //
// 2223         for (i = 0 ; i < 2000 ; i++)
        MOVS     R0,#+0
        MOVS     R4,R0
??SysCtlHClockSet_60:
        MOVS     R0,#+250
        LSLS     R0,R0,#+3        ;; #+2000
        CMP      R4,R0
        BCS      ??SysCtlHClockSet_61
// 2224         {
// 2225             if((xHWREGB(MCG_S) & MCG_S_CLKST_PLL) == MCG_S_CLKST_PLL)
        LDR      R0,??DataTable40_2  ;; 0x40064006
        LDRB     R0,[R0, #+0]
        UXTB     R0,R0
        MOVS     R1,#+12
        ANDS     R1,R1,R0
        CMP      R1,#+12
        BEQ      ??SysCtlHClockSet_61
// 2226             {
// 2227                 break; // jump out early if CLKST = 3 before loop finishes            
// 2228             }
// 2229 
// 2230         }
??SysCtlHClockSet_62:
        ADDS     R4,R4,#+1
        B        ??SysCtlHClockSet_60
// 2231         //
// 2232         // set PLLFLLSEL to select the PLL for this clock source
// 2233         //
// 2234         xHWREG(SIM_SOPT2) |= SIM_SOPT2_PLLFLLSEL;
??SysCtlHClockSet_61:
        LDR      R0,??DataTable41_3  ;; 0x40048004
        LDR      R0,[R0, #+0]
        MOVS     R1,#+128
        LSLS     R1,R1,#+9        ;; #+65536
        ORRS     R1,R1,R0
        LDR      R0,??DataTable41_3  ;; 0x40048004
        STR      R1,[R0, #+0]
// 2235 
// 2236         if (ulSysClk <= ulOscFreq)
        LDR      R0,[SP, #+12]
        CMP      R7,R0
        BCC      ??SysCtlHClockSet_7
// 2237         {
// 2238             //
// 2239             // Calc the SysDiv
// 2240             //    
// 2241             xASSERT(ulSysClk <= ulOscFreq);
// 2242             
// 2243             for(ulSysDiv = 1; ulSysDiv < 16; ulSysDiv++)
        MOVS     R0,#+1
        MOVS     R5,R0
??SysCtlHClockSet_63:
        CMP      R5,#+16
        BCS      ??SysCtlHClockSet_64
// 2244             {
// 2245                 if((ulOscFreq / (ulSysDiv + 1)) <= ulSysClk)
        MOVS     R0,R7
        MOVS     R1,R5
        ADDS     R1,R1,#+1
        BL       __aeabi_uidiv
        LDR      R1,[SP, #+12]
        CMP      R1,R0
        BCS      ??SysCtlHClockSet_64
// 2246                 {
// 2247                     break;
// 2248                 }
// 2249             }
??SysCtlHClockSet_65:
        ADDS     R5,R5,#+1
        B        ??SysCtlHClockSet_63
// 2250             xHWREG(SIM_CLKDIV1) &= ~SIM_CLKDIV1_OUTDIV1_M;
??SysCtlHClockSet_64:
        LDR      R0,??DataTable40  ;; 0x40048044
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+4        ;; ZeroExtS R0,R0,#+4,#+4
        LSRS     R0,R0,#+4
        LDR      R1,??DataTable40  ;; 0x40048044
        STR      R0,[R1, #+0]
// 2251             xHWREG(SIM_CLKDIV1) |= (ulSysDiv << SIM_CLKDIV1_OUTDIV1_S);
        LDR      R0,??DataTable40  ;; 0x40048044
        LDR      R0,[R0, #+0]
        LSLS     R1,R5,#+28
        ORRS     R1,R1,R0
        LDR      R0,??DataTable40  ;; 0x40048044
        STR      R1,[R0, #+0]
// 2252         }
// 2253     }
// 2254 }
??SysCtlHClockSet_7:
        ADD      SP,SP,#+20
        POP      {R4-R7,PC}       ;; return
// 2255 
// 2256 //*****************************************************************************
// 2257 //
// 2258 //! \brief The function is used to Set Clock Output source. 
// 2259 //!
// 2260 //! \param ulClkOutSrc is the clock source of Clock Output.
// 2261 //!
// 2262 //! The function is used to Set Clock Output source.
// 2263 //!
// 2264 //! \return None.
// 2265 //
// 2266 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2267 void SysCtlClkOututSrcSet(unsigned long ulClkOutSrc)
// 2268 {
// 2269     //
// 2270     // Check the arguments.
// 2271     //
// 2272     xASSERT((ulClkOutSrc == SYSCTL_OUTPUT_CLKSRC_BUS)||
// 2273             (ulClkOutSrc == SYSCTL_OUTPUT_CLKSRC_LPO)||
// 2274             (ulClkOutSrc == SYSCTL_OUTPUT_CLKSRC_MCGIRCLK)||
// 2275             (ulClkOutSrc == SYSCTL_OUTPUT_CLKSRC_OSCERCLK));
// 2276     //
// 2277     // Select Output Clock Source.
// 2278     //
// 2279     xHWREG(SIM_SOPT2) &= ~SIM_SOPT2_CLKOUTSEL_M;
SysCtlClkOututSrcSet:
        LDR      R1,??DataTable41_3  ;; 0x40048004
        LDR      R1,[R1, #+0]
        MOVS     R2,#+224
        BICS     R1,R1,R2
        LDR      R2,??DataTable41_3  ;; 0x40048004
        STR      R1,[R2, #+0]
// 2280     xHWREG(SIM_SOPT2) |= ulClkOutSrc;
        LDR      R1,??DataTable41_3  ;; 0x40048004
        LDR      R1,[R1, #+0]
        ORRS     R1,R1,R0
        LDR      R2,??DataTable41_3  ;; 0x40048004
        STR      R1,[R2, #+0]
// 2281 }
        BX       LR               ;; return
// 2282 
// 2283 //*****************************************************************************
// 2284 //
// 2285 //! \brief The function is used to Set Bus Clock. 
// 2286 //!
// 2287 //! \param ulBusClk is the bus clock you will set.
// 2288 //!
// 2289 //! The function is used to Set Bus Clock.
// 2290 //!
// 2291 //! \return None.
// 2292 //
// 2293 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2294 void SysCtlBusClkSet(unsigned long ulBusClk)
// 2295 {
SysCtlBusClkSet:
        PUSH     {R4-R6,LR}
        MOVS     R6,R0
// 2296     unsigned long ulHclk = 0, ulSysDiv;
        MOVS     R5,#+0
// 2297 
// 2298     //
// 2299     // Check the arguments.
// 2300     //
// 2301     xASSERT((ulBusClk > 0 && ulBusClk <= 24000000));
// 2302 
// 2303     //
// 2304     // Get the Hclk.
// 2305     //
// 2306     ulHclk = SysCtlHClockGet();
        BL       SysCtlHClockGet
        MOVS     R5,R0
// 2307     
// 2308     if (ulBusClk <= ulHclk)
        CMP      R5,R6
        BCC      ??SysCtlBusClkSet_0
// 2309     {
// 2310         //
// 2311         // Calc the SysDiv
// 2312         //    
// 2313         xASSERT(ulBusClk <= ulHclk);
// 2314         
// 2315         for(ulSysDiv = 1; ulSysDiv < 8; ulSysDiv++)
        MOVS     R0,#+1
        MOVS     R4,R0
??SysCtlBusClkSet_1:
        CMP      R4,#+8
        BCS      ??SysCtlBusClkSet_2
// 2316         {
// 2317             if((ulHclk / (ulSysDiv + 1)) <= ulBusClk)
        MOVS     R0,R5
        MOVS     R1,R4
        ADDS     R1,R1,#+1
        BL       __aeabi_uidiv
        CMP      R6,R0
        BCS      ??SysCtlBusClkSet_2
// 2318             {
// 2319                 break;
// 2320             }
// 2321         }
??SysCtlBusClkSet_3:
        ADDS     R4,R4,#+1
        B        ??SysCtlBusClkSet_1
// 2322         xHWREG(SIM_CLKDIV1) &= ~SIM_CLKDIV1_OUTDIV4_M;
??SysCtlBusClkSet_2:
        LDR      R0,??DataTable40  ;; 0x40048044
        LDR      R0,[R0, #+0]
        LDR      R1,??DataTable40_1  ;; 0xfff8ffff
        ANDS     R1,R1,R0
        LDR      R0,??DataTable40  ;; 0x40048044
        STR      R1,[R0, #+0]
// 2323         xHWREG(SIM_CLKDIV1) |= (ulSysDiv << SIM_CLKDIV1_OUTDIV4_S);
        LDR      R0,??DataTable40  ;; 0x40048044
        LDR      R0,[R0, #+0]
        LSLS     R1,R4,#+16
        ORRS     R1,R1,R0
        LDR      R0,??DataTable40  ;; 0x40048044
        STR      R1,[R0, #+0]
// 2324     }
// 2325 }
??SysCtlBusClkSet_0:
        POP      {R4-R6,PC}       ;; return
// 2326 //*****************************************************************************
// 2327 //
// 2328 //! \brief The function is used to Get Bus Clock. 
// 2329 //!
// 2330 //! \param None.
// 2331 //!
// 2332 //! The function is used to Get Bus Clock.
// 2333 //!
// 2334 //! \return the Bus clock.
// 2335 //
// 2336 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2337 unsigned long SysCtlBusClkGet(void)
// 2338 {
SysCtlBusClkGet:
        PUSH     {R4-R6,LR}
// 2339     unsigned long ulHclk = 0, ulBusClk = 0, ulSysDiv;
        MOVS     R6,#+0
        MOVS     R5,#+0
// 2340 
// 2341     //
// 2342     // Get the Hclk.
// 2343     //
// 2344     ulHclk = SysCtlHClockGet();
        BL       SysCtlHClockGet
        MOVS     R6,R0
// 2345     
// 2346     //
// 2347     // Calc the SysDiv
// 2348     //    
// 2349     ulSysDiv = (xHWREG(SIM_CLKDIV1) & SIM_CLKDIV1_OUTDIV4_M) >> SIM_CLKDIV1_OUTDIV4_S;
        LDR      R0,??DataTable40  ;; 0x40048044
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+16
        LSLS     R0,R0,#+29       ;; ZeroExtS R0,R0,#+29,#+29
        LSRS     R0,R0,#+29
        MOVS     R4,R0
// 2350     
// 2351     ulBusClk = ulHclk/(ulSysDiv+1);
        MOVS     R0,R6
        MOVS     R1,R4
        ADDS     R1,R1,#+1
        BL       __aeabi_uidiv
        MOVS     R5,R0
// 2352     
// 2353     return ulBusClk;
        MOVS     R0,R5
        POP      {R4-R6,PC}       ;; return
// 2354 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable37:
        DC32     0x40064005
// 2355 
// 2356 //*****************************************************************************
// 2357 //
// 2358 //! \brief The function is to Enable Bandgap In VLPx Operation or not
// 2359 //!
// 2360 //! \param bEnable is a boolean that is \b true if Enable Bandgap In VLPx 
// 2361 //! Operation and \b false if Disable it.
// 2362 //!
// 2363 //! The function is used to Enable Bandgap In VLPx Operation or not
// 2364 //!
// 2365 //! \return None.
// 2366 //
// 2367 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2368 void 
// 2369 SysCtlBandgapEnable(xtBoolean bEnable)
// 2370 {
SysCtlBandgapEnable:
        PUSH     {LR}
// 2371     //
// 2372     // Enable Bandgap In VLPx Operation.
// 2373     //
// 2374     if(bEnable)
        UXTB     R0,R0
        CMP      R0,#+0
        BEQ      ??SysCtlBandgapEnable_0
// 2375     {
// 2376         xHWREGB(PMC_REGSC) |= PMC_REGSC_BGEN;
        LDR      R1,??DataTable41_4  ;; 0x4007d002
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+16
        ORRS     R2,R2,R1
        LDR      R1,??DataTable41_4  ;; 0x4007d002
        STRB     R2,[R1, #+0]
        B        ??SysCtlBandgapEnable_1
// 2377     }
// 2378     //
// 2379     // Disable Bandgap In VLPx Operation.
// 2380     //
// 2381     else
// 2382     {
// 2383         xHWREGB(PMC_REGSC) &= ~PMC_REGSC_BGEN;
??SysCtlBandgapEnable_0:
        LDR      R1,??DataTable41_4  ;; 0x4007d002
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+239
        ANDS     R2,R2,R1
        LDR      R1,??DataTable41_4  ;; 0x4007d002
        STRB     R2,[R1, #+0]
// 2384     }
// 2385 }
??SysCtlBandgapEnable_1:
        POP      {PC}             ;; return
// 2386 
// 2387 //*****************************************************************************
// 2388 //
// 2389 //! \brief The function is to Enable Bandgap Buffer or not
// 2390 //!
// 2391 //! \param bEnable is a boolean that is \b true if Enable Bandgap Buffer 
// 2392 //! and \b false if Disable it.
// 2393 //!
// 2394 //! The function is used to Enable Bandgap Buffer or not
// 2395 //!
// 2396 //! \return None.
// 2397 //
// 2398 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2399 void 
// 2400 SysCtlBandgapBufferEnable(xtBoolean bEnable)
// 2401 {
SysCtlBandgapBufferEnable:
        PUSH     {LR}
// 2402     //
// 2403     // Enable Bandgap Buffer.
// 2404     //
// 2405     if(bEnable)
        UXTB     R0,R0
        CMP      R0,#+0
        BEQ      ??SysCtlBandgapBufferEnable_0
// 2406     {
// 2407         xHWREGB(PMC_REGSC) |= PMC_REGSC_BGBE;
        LDR      R1,??DataTable41_4  ;; 0x4007d002
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+1
        ORRS     R2,R2,R1
        LDR      R1,??DataTable41_4  ;; 0x4007d002
        STRB     R2,[R1, #+0]
        B        ??SysCtlBandgapBufferEnable_1
// 2408     }
// 2409     //
// 2410     // Disable Bandgap Buffer.
// 2411     //
// 2412     else
// 2413     {
// 2414         xHWREGB(PMC_REGSC) &= ~PMC_REGSC_BGBE;
??SysCtlBandgapBufferEnable_0:
        LDR      R1,??DataTable41_4  ;; 0x4007d002
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+254
        ANDS     R2,R2,R1
        LDR      R1,??DataTable41_4  ;; 0x4007d002
        STRB     R2,[R1, #+0]
// 2415     }
// 2416 }
??SysCtlBandgapBufferEnable_1:
        POP      {PC}             ;; return
// 2417 
// 2418 //*****************************************************************************
// 2419 //
// 2420 //! \brief Get Status of Regulator In Run Regulation.
// 2421 //!
// 2422 //! \param None.
// 2423 //!
// 2424 //! This function is to Get Status of Regulator In Run Regulation.
// 2425 //!
// 2426 //! \return This function return Status of Regulator In Run Regulation,if Regulator
// 2427 //! is in run regulation, it returns xtrue, xfalse if not.
// 2428 //
// 2429 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2430 xtBoolean
// 2431 SysCtlRegulatorStatusGet(void)
// 2432 {
SysCtlRegulatorStatusGet:
        PUSH     {LR}
// 2433     xtBoolean xtFlag = 0;
        MOVS     R1,#+0
// 2434 
// 2435     xtFlag = xHWREGB(PMC_REGSC) & PMC_REGSC_REGONS;
        LDR      R0,??DataTable41_4  ;; 0x4007d002
        LDRB     R0,[R0, #+0]
        MOVS     R2,#+4
        ANDS     R0,R0,R2
        MOVS     R1,R0
// 2436     if(xtFlag)
        UXTB     R1,R1
        CMP      R1,#+0
        BEQ      ??SysCtlRegulatorStatusGet_0
// 2437     {
// 2438         return xtrue;
        MOVS     R0,#+1
        B        ??SysCtlRegulatorStatusGet_1
// 2439     }
// 2440     else
// 2441     {
// 2442         return xfalse;
??SysCtlRegulatorStatusGet_0:
        MOVS     R0,#+0
??SysCtlRegulatorStatusGet_1:
        POP      {PC}             ;; return
// 2443     }
// 2444 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable40:
        DC32     0x40048044

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable40_1:
        DC32     0xfff8ffff

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable40_2:
        DC32     0x40064006

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable40_3:
        DC32     0x40064001

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable40_4:
        DC32     0x40064000
// 2445 
// 2446 //*****************************************************************************
// 2447 //
// 2448 //! \brief The function is used to Get PWM and UART0 Clock Rate. 
// 2449 //!
// 2450 //! \param None.
// 2451 //!
// 2452 //! The function is used to Get PWM and UART0 Clock Rate.
// 2453 //!
// 2454 //! \return the PWM and UART0 Clock Rate clock.
// 2455 //
// 2456 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 2457 unsigned long SysCtlPWMAndUART0ClkGet(void)
// 2458 {
SysCtlPWMAndUART0ClkGet:
        PUSH     {R3-R5,LR}
// 2459     unsigned long ulHclk = 0, ulPWMClk = 0;
        MOVS     R4,#+0
        MOVS     R5,#+0
// 2460 
// 2461     //
// 2462     // Check the PWM Clock Source.
// 2463     //
// 2464     if((xHWREG(SIM_SOPT2) & SIM_SOPT2_TPMSRC_MCGXLL)
// 2465                          == SIM_SOPT2_TPMSRC_MCGXLL)
        LDR      R0,??DataTable41_3  ;; 0x40048004
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+7
        BPL      ??SysCtlPWMAndUART0ClkGet_0
// 2466     {
// 2467         ulHclk = SysCtlHClockGet();
        BL       SysCtlHClockGet
        MOVS     R4,R0
// 2468         ulPWMClk = ulHclk/2;
        MOVS     R0,R4
        LSRS     R0,R0,#+1
        MOVS     R5,R0
// 2469         return ulPWMClk;
        MOVS     R0,R5
        B        ??SysCtlPWMAndUART0ClkGet_1
// 2470     }
// 2471     else if((xHWREG(SIM_SOPT2) & SIM_SOPT2_TPMSRC_OSCERCLK)
// 2472                          == SIM_SOPT2_TPMSRC_OSCERCLK)
??SysCtlPWMAndUART0ClkGet_0:
        LDR      R0,??DataTable41_3  ;; 0x40048004
        LDR      R0,[R0, #+0]
        LSLS     R0,R0,#+6
        BPL      ??SysCtlPWMAndUART0ClkGet_2
// 2473     {
// 2474         xHWREGB(OSC0_CR) |= OSC0_CR_ERCLKEN;
        LDR      R0,??DataTable41_5  ;; 0x40065000
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+128
        ORRS     R1,R1,R0
        LDR      R0,??DataTable41_5  ;; 0x40065000
        STRB     R1,[R0, #+0]
// 2475         xHWREGB(MCG_C2) |= MCG_C2_EREFS0;
        LDR      R0,??DataTable41_6  ;; 0x40064001
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+4
        ORRS     R1,R1,R0
        LDR      R0,??DataTable41_6  ;; 0x40064001
        STRB     R1,[R0, #+0]
// 2476         ulPWMClk = s_ulExtClockMHz*1000000;
        LDR      R0,??DataTable41_7
        LDR      R0,[R0, #+0]
        LDR      R1,??DataTable41_2  ;; 0xf4240
        MULS     R0,R1,R0
        MOVS     R5,R0
// 2477         return ulPWMClk;    
        MOVS     R0,R5
        B        ??SysCtlPWMAndUART0ClkGet_1
// 2478     }
// 2479     else
// 2480     {
// 2481         xHWREGB(MCG_C1) |= MCG_C1_IRCLKEN;
??SysCtlPWMAndUART0ClkGet_2:
        LDR      R0,??DataTable41_8  ;; 0x40064000
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+2
        ORRS     R1,R1,R0
        LDR      R0,??DataTable41_8  ;; 0x40064000
        STRB     R1,[R0, #+0]
// 2482         xHWREGB(MCG_C2) |= MCG_C2_IRCS;
        LDR      R0,??DataTable41_6  ;; 0x40064001
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+1
        ORRS     R1,R1,R0
        LDR      R0,??DataTable41_6  ;; 0x40064001
        STRB     R1,[R0, #+0]
// 2483         ulPWMClk = 4000000;
        LDR      R0,??DataTable41_9  ;; 0x3d0900
        MOVS     R5,R0
// 2484         return ulPWMClk;    
        MOVS     R0,R5
??SysCtlPWMAndUART0ClkGet_1:
        POP      {R1,R4,R5,PC}    ;; return
// 2485     }
// 2486 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable41:
        DC32     0x4e20

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable41_1:
        DC32     0x40064004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable41_2:
        DC32     0xf4240

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable41_3:
        DC32     0x40048004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable41_4:
        DC32     0x4007d002

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable41_5:
        DC32     0x40065000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable41_6:
        DC32     0x40064001

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable41_7:
        DC32     s_ulExtClockMHz

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable41_8:
        DC32     0x40064000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable41_9:
        DC32     0x3d0900

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        END
// 
//     4 bytes in section .data
//   232 bytes in section .rodata
// 5 794 bytes in section .text
// 
// 5 794 bytes of CODE  memory
//   232 bytes of CONST memory
//     4 bytes of DATA  memory
//
//Errors: none
//Warnings: none
