///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.40.1.53790/W32 for ARM    24/Feb/2013  09:52:14 /
// Copyright 1999-2012 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  C:\Users\renjun\Desktop\Cox\CoX_Peripheral\CoX_Peripher /
//                    al_KLx\libcox\xgpio.c                                   /
//    Command line =  C:\Users\renjun\Desktop\Cox\CoX_Peripheral\CoX_Peripher /
//                    al_KLx\libcox\xgpio.c -D ewarm -lCN                     /
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
//                    al_KLx\uart\test\suite1\ewarm\Debug\List\xgpio.s        /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME xgpio

        #define SHT_PROGBITS 0x1

        PUBLIC GPIODMAEdgeSet
        PUBLIC GPIODirModeGet
        PUBLIC GPIODirModeSet
        PUBLIC GPIOPadConfigSet
        PUBLIC GPIOPassiveConfigure
        PUBLIC GPIOPinConfigure
        PUBLIC GPIOPinIntCallbackInit
        PUBLIC GPIOPinIntClear
        PUBLIC GPIOPinIntDisable
        PUBLIC GPIOPinIntEnable
        PUBLIC GPIOPinIntStatus
        PUBLIC GPIOPinMaskSet
        PUBLIC GPIOPinPortDoutGet
        PUBLIC GPIOPinRead
        PUBLIC GPIOPinReset
        PUBLIC GPIOPinSet
        PUBLIC GPIOPinToPin
        PUBLIC GPIOPinToPort
        PUBLIC GPIOPinWrite
        PUBLIC GPIOPortMaskGet
        PUBLIC GPIOPullConfigure
        PUBLIC GPIOSlewRataConfigure
        PUBLIC PORTAIntHandler
        PUBLIC PORTDIntHandler
        PUBLIC xGPIODirModeGet
        PUBLIC xGPIODirModeSet

// C:\Users\renjun\Desktop\Cox\CoX_Peripheral\CoX_Peripheral_KLx\libcox\xgpio.c
//    1 //*****************************************************************************
//    2 //
//    3 //! \file xgpio.c
//    4 //! \brief Driver for the GPIO AFIO and EXTI controller
//    5 //! \version V2.2.1.0
//    6 //! \date 7/31/2012
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
//   45 #include "xdebug.h"
//   46 #include "xsysctl.h"
//   47 #include "xcore.h"
//   48 #include "xgpio.h"
//   49 
//   50 
//   51 typedef struct
//   52 {
//   53     //
//   54     // Pin ID.
//   55     //
//   56     unsigned long ulpinID;
//   57 
//   58     //
//   59     // 
//   60     //
//   61     xtEventCallback pfnGPIOPinHandlerCallback;
//   62 }
//   63 tGPIOPinIntAsssign;
//   64 
//   65 //
//   66 // GPIO Pins Interrupt Assignment table.
//   67 //

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   68 static tGPIOPinIntAsssign g_psGPIOPinIntAssignTable[xGPIO_INT_NUMBER] = 
g_psGPIOPinIntAssignTable:
        DS8 64
//   69 {
//   70     {0,0},
//   71 };
//   72 
//   73 //*****************************************************************************
//   74 //
//   75 // An array that maps Port base.
//   76 //
//   77 //*****************************************************************************

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
//   78 static const unsigned long g_pulPortBase[] =
g_pulPortBase:
        DATA
        DC32 1074040832, 1074044928, 1074049024, 1074053120, 1074057216
//   79 {
//   80     PORTA_BASE,
//   81     PORTB_BASE,
//   82     PORTC_BASE,
//   83     PORTD_BASE,
//   84     PORTE_BASE
//   85 };
//   86 
//   87 //*****************************************************************************
//   88 //
//   89 //! \internal
//   90 //! Checks a GPIO base address.
//   91 //!
//   92 //! \param ulPort is the base address of the GPIO port.
//   93 //!
//   94 //! This function determines if a GPIO port base address is valid.
//   95 //!
//   96 //! \return Returns \b true if the base address is valid and \b false
//   97 //! otherwise.
//   98 //
//   99 //*****************************************************************************
//  100 #ifdef xDEBUG
//  101 static xtBoolean
//  102 GPIOBaseValid(unsigned long ulPort)
//  103 {
//  104     return((ulPort == GPIOA_BASE) || 
//  105            (ulPort == GPIOB_BASE) || 
//  106            (ulPort == GPIOC_BASE) || 
//  107            (ulPort == GPIOD_BASE) || 
//  108            (ulPort == GPIOE_BASE));
//  109 }
//  110 #endif
//  111 
//  112 //*****************************************************************************
//  113 //
//  114 //! \internal
//  115 //! \brief GPIO A  ISR.
//  116 //!
//  117 //! \param None
//  118 //!
//  119 //! \return None.
//  120 //
//  121 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  122 void PORTAIntHandler(void)
//  123 {
PORTAIntHandler:
        PUSH     {R3-R7,LR}
//  124     unsigned long ulGpaStatus;
//  125     unsigned long i;
//  126     
//  127     /* Keep the interrupt source */
//  128     ulGpaStatus = xHWREG(PORTA_BASE+PORT_ISFR);
        LDR      R0,??DataTable6  ;; 0x400490a0
        LDR      R0,[R0, #+0]
        MOVS     R5,R0
//  129 
//  130     /* Clear the interrupt */
//  131     xHWREG(PORTA_BASE+PORT_ISFR) |= ulGpaStatus;
        LDR      R0,??DataTable6  ;; 0x400490a0
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,R5
        LDR      R1,??DataTable6  ;; 0x400490a0
        STR      R0,[R1, #+0]
//  132 
//  133     /* Call the callback function of GPIOA interrupt */
//  134     for(i=0; i<xGPIO_INT_NUMBER; i++)
        MOVS     R0,#+0
        MOVS     R4,R0
??PORTAIntHandler_0:
        CMP      R4,#+8
        BCS      ??PORTAIntHandler_1
//  135     {
//  136         if((g_psGPIOPinIntAssignTable[i].ulpinID & 0xFFFF0000) == 
//  137            (unsigned long)((GPIOA_BASE & 0x0000FFFF) << 16))
        MOVS     R0,#+8
        MULS     R0,R4,R0
        LDR      R1,??DataTable6_1
        LDR      R0,[R1, R0]
        LSRS     R0,R0,#+16
        LSLS     R0,R0,#+16
        MOVS     R1,#+240
        LSLS     R1,R1,#+24       ;; #-268435456
        CMP      R0,R1
        BNE      ??PORTAIntHandler_2
//  138         {
//  139             if((g_psGPIOPinIntAssignTable[i].ulpinID & 0x0000FFFF & 
//  140                 ulGpaStatus))
        MOVS     R0,#+8
        MULS     R0,R4,R0
        LDR      R1,??DataTable6_1
        LDR      R0,[R1, R0]
        ANDS     R0,R0,R5
        UXTH     R0,R0
        CMP      R0,#+0
        BEQ      ??PORTAIntHandler_2
//  141             {
//  142                 if(g_psGPIOPinIntAssignTable[i].pfnGPIOPinHandlerCallback != 0)
        MOVS     R0,#+8
        MULS     R0,R4,R0
        LDR      R1,??DataTable6_1
        ADDS     R0,R1,R0
        LDR      R0,[R0, #+4]
        CMP      R0,#+0
        BEQ      ??PORTAIntHandler_2
//  143                 {
//  144                     g_psGPIOPinIntAssignTable[i].pfnGPIOPinHandlerCallback
//  145                     (0,ulGpaStatus,0,0);
        MOVS     R3,#+0
        MOVS     R2,#+0
        MOVS     R1,R5
        MOVS     R0,#+0
        MOVS     R6,#+8
        MULS     R6,R4,R6
        LDR      R7,??DataTable6_1
        ADDS     R6,R7,R6
        LDR      R6,[R6, #+4]
        BLX      R6
//  146                 }
//  147             }
//  148         }
//  149     } 
??PORTAIntHandler_2:
        ADDS     R4,R4,#+1
        B        ??PORTAIntHandler_0
//  150 }
??PORTAIntHandler_1:
        POP      {R0,R4-R7,PC}    ;; return
//  151 
//  152 //*****************************************************************************
//  153 //
//  154 //! \internal
//  155 //! \brief GPIO D ISR.
//  156 //!
//  157 //! \param None
//  158 //!
//  159 //! \return None.
//  160 //
//  161 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  162 void PORTDIntHandler(void)
//  163 {
PORTDIntHandler:
        PUSH     {R3-R7,LR}
//  164     unsigned long ulGpdStatus;
//  165     unsigned long i;
//  166     
//  167     /* Keep the interrupt source */
//  168     ulGpdStatus = xHWREG(PORTD_BASE+PORT_ISFR);
        LDR      R0,??DataTable6_2  ;; 0x4004c0a0
        LDR      R0,[R0, #+0]
        MOVS     R5,R0
//  169 
//  170     /* Clear the interrupt */
//  171     xHWREG(PORTD_BASE+PORT_ISFR) |= ulGpdStatus;
        LDR      R0,??DataTable6_2  ;; 0x4004c0a0
        LDR      R0,[R0, #+0]
        ORRS     R0,R0,R5
        LDR      R1,??DataTable6_2  ;; 0x4004c0a0
        STR      R0,[R1, #+0]
//  172 
//  173     /* Call the callback function of GPIOCDE interrupt */
//  174     for(i=0; i<xGPIO_INT_NUMBER; i++)
        MOVS     R0,#+0
        MOVS     R4,R0
??PORTDIntHandler_0:
        CMP      R4,#+8
        BCS      ??PORTDIntHandler_1
//  175     {
//  176         if((g_psGPIOPinIntAssignTable[i].ulpinID & 0xFFFF0000) == 
//  177            (unsigned long)((GPIOD_BASE & 0x0000FFFF) << 16))
        MOVS     R0,#+8
        MULS     R0,R4,R0
        LDR      R1,??DataTable6_1
        LDR      R0,[R1, R0]
        LSRS     R0,R0,#+16
        LSLS     R0,R0,#+16
        LDR      R1,??DataTable6_3  ;; 0xf0c00000
        CMP      R0,R1
        BNE      ??PORTDIntHandler_2
//  178         {
//  179             if((g_psGPIOPinIntAssignTable[i].ulpinID & 0x0000FFFF & 
//  180                 ulGpdStatus))
        MOVS     R0,#+8
        MULS     R0,R4,R0
        LDR      R1,??DataTable6_1
        LDR      R0,[R1, R0]
        ANDS     R0,R0,R5
        UXTH     R0,R0
        CMP      R0,#+0
        BEQ      ??PORTDIntHandler_2
//  181             {
//  182                 if(g_psGPIOPinIntAssignTable[i].pfnGPIOPinHandlerCallback != 0)
        MOVS     R0,#+8
        MULS     R0,R4,R0
        LDR      R1,??DataTable6_1
        ADDS     R0,R1,R0
        LDR      R0,[R0, #+4]
        CMP      R0,#+0
        BEQ      ??PORTDIntHandler_2
//  183                 {
//  184                     g_psGPIOPinIntAssignTable[i].pfnGPIOPinHandlerCallback
//  185                     (0,ulGpdStatus,0,0);
        MOVS     R3,#+0
        MOVS     R2,#+0
        MOVS     R1,R5
        MOVS     R0,#+0
        MOVS     R6,#+8
        MULS     R6,R4,R6
        LDR      R7,??DataTable6_1
        ADDS     R6,R7,R6
        LDR      R6,[R6, #+4]
        BLX      R6
//  186                 }
//  187             }
//  188         }
//  189     } 
??PORTDIntHandler_2:
        ADDS     R4,R4,#+1
        B        ??PORTDIntHandler_0
//  190 }
??PORTDIntHandler_1:
        POP      {R0,R4-R7,PC}    ;; return
//  191 
//  192 //*****************************************************************************
//  193 //
//  194 //! \brief Sets the direction and mode of the specified pin(s).
//  195 //!
//  196 //! \param ulPort is the base address of the GPIO port
//  197 //! \param ulPins is the bit-packed representation of the pin(s).
//  198 //! \param ulPinIO is the pin direction and/or mode.
//  199 //!
//  200 //! This function will set the specified pin(s) on the selected GPIO port
//  201 //! as either an input or output under software control, or it will set the
//  202 //! pin to be under hardware control.
//  203 //!
//  204 //! The parameter \e ulPinIO is an enumerated data type that can be one of
//  205 //! the following values:
//  206 //!
//  207 //! - \b xGPIO_DIR_MODE_IN
//  208 //! - \b xGPIO_DIR_MODE_OUT
//  209 //! - \b xGPIO_DIR_MODE_HW
//  210 //!
//  211 //! where \b GPIO_DIR_MODE_IN specifies that the pin will be programmed as
//  212 //! a software controlled input, \b GPIO_DIR_MODE_OUT specifies that the pin
//  213 //! will be programmed as a software controlled output, and
//  214 //! \b GPIO_DIR_MODE_HW specifies that the pin will be placed under
//  215 //! hardware control.
//  216 //!
//  217 //! The pin(s) are specified using a bit-packed byte, where each bit that is
//  218 //! set identifies the pin to be accessed, and where bit 0 of the byte
//  219 //! represents GPIO port pin 0, bit 1 represents GPIO port pin 1, and so on.
//  220 //!
//  221 //! \return None.
//  222 //
//  223 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  224 void
//  225 xGPIODirModeSet(unsigned long ulPort, unsigned long ulPins,
//  226                unsigned long ulPinIO)
//  227 {
xGPIODirModeSet:
        PUSH     {R3-R7,LR}
        MOVS     R6,R0
        MOVS     R4,R1
        MOVS     R7,R2
//  228     unsigned long ulBit;
//  229         
//  230     //
//  231     // Check the arguments.
//  232     //
//  233     xASSERT(GPIOBaseValid(ulPort));
//  234     xASSERT((ulPinIO == xGPIO_DIR_MODE_IN) || (ulPinIO == xGPIO_DIR_MODE_OUT) ||
//  235             (ulPinIO == xGPIO_DIR_MODE_HW));
//  236 
//  237     //
//  238     // Set the pin direction and mode.
//  239     //
//  240     for(ulBit=0; ulBit<32; ulBit++)
        MOVS     R0,#+0
        MOVS     R5,R0
??xGPIODirModeSet_0:
        CMP      R5,#+32
        BCS      ??xGPIODirModeSet_1
//  241     {
//  242         if(ulPins & (1 << ulBit))
        MOVS     R0,#+1
        LSLS     R0,R0,R5
        ANDS     R0,R0,R4
        CMP      R0,#+0
        BEQ      ??xGPIODirModeSet_2
//  243         {
//  244             GPIODirModeSet(ulPort, ulBit, ulPinIO);
        MOVS     R2,R7
        MOVS     R1,R5
        MOVS     R0,R6
        BL       GPIODirModeSet
//  245         }
//  246     }                              
??xGPIODirModeSet_2:
        ADDS     R5,R5,#+1
        B        ??xGPIODirModeSet_0
//  247 }
??xGPIODirModeSet_1:
        POP      {R0,R4-R7,PC}    ;; return
//  248 
//  249 //*****************************************************************************
//  250 //
//  251 //! \brief Gets the direction and mode of a pin.
//  252 //!
//  253 //! \param ulPort is the base address of the GPIO port.
//  254 //! \param ulPin is the bit-packed representation of the pin.
//  255 //!
//  256 //! This function gets the direction and control mode for a specified pin on
//  257 //! the selected GPIO port.  The pin can be configured as either an input or
//  258 //! output under software control, or it can be under hardware control.  The
//  259 //! type of control and direction are returned as an enumerated data type.
//  260 //!
//  261 //! \return Returns one of the enumerated data types described for
//  262 //! GPIODirModeSet().
//  263 //
//  264 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  265 unsigned long
//  266 xGPIODirModeGet(unsigned long ulPort, unsigned long ulPin)
//  267 {
xGPIODirModeGet:
        PUSH     {R4-R6,LR}
        MOVS     R4,R0
        MOVS     R5,R1
//  268     unsigned long ulBits;
//  269     //
//  270     // Check the arguments.
//  271     //
//  272     xASSERT(GPIOBaseValid(ulPort));
//  273 
//  274     for(ulBits=0; ulBits<32; ulBits++)
        MOVS     R0,#+0
        MOVS     R6,R0
??xGPIODirModeGet_0:
        CMP      R6,#+32
        BCS      ??xGPIODirModeGet_1
//  275     {
//  276         if(ulPin & (1 << ulBits))
        MOVS     R0,#+1
        LSLS     R0,R0,R6
        ANDS     R0,R0,R5
        CMP      R0,#+0
        BNE      ??xGPIODirModeGet_1
//  277         {
//  278             break;
//  279         }
//  280     } 
??xGPIODirModeGet_2:
        ADDS     R6,R6,#+1
        B        ??xGPIODirModeGet_0
//  281     
//  282     //
//  283     // Return the pin direction and mode.
//  284     //
//  285     return GPIODirModeGet(ulPort, ulBits);
??xGPIODirModeGet_1:
        MOVS     R1,R6
        MOVS     R0,R4
        BL       GPIODirModeGet
        POP      {R4-R6,PC}       ;; return
//  286 }
//  287 
//  288 //*****************************************************************************
//  289 //
//  290 //! \brief Gets the GPIO corresponding Port base.
//  291 //!
//  292 //! \param ulPort is the base address of the GPIO port.
//  293 //!
//  294 //! \return Returns the GPIO corresponding Port base.
//  295 //
//  296 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  297 static 
//  298 unsigned long GPIOToPortGet(unsigned long ulPort)
//  299 {
GPIOToPortGet:
        PUSH     {LR}
        MOVS     R1,R0
//  300     //
//  301     // Check the arguments.
//  302     //
//  303     xASSERT(GPIOBaseValid(ulPort));
//  304 
//  305     if(ulPort == GPIOA_BASE)
        LDR      R0,??DataTable6_4  ;; 0x400ff000
        CMP      R1,R0
        BNE      ??GPIOToPortGet_0
//  306     {
//  307 	return PORTA_BASE;
        LDR      R0,??DataTable6_5  ;; 0x40049000
        B        ??GPIOToPortGet_1
//  308     }
//  309     else if(ulPort == GPIOB_BASE)
??GPIOToPortGet_0:
        LDR      R0,??DataTable6_6  ;; 0x400ff040
        CMP      R1,R0
        BNE      ??GPIOToPortGet_2
//  310     {
//  311         return PORTB_BASE;
        LDR      R0,??DataTable6_7  ;; 0x4004a000
        B        ??GPIOToPortGet_1
//  312     }
//  313     else if(ulPort == GPIOC_BASE)
??GPIOToPortGet_2:
        LDR      R0,??DataTable6_8  ;; 0x400ff080
        CMP      R1,R0
        BNE      ??GPIOToPortGet_3
//  314     {
//  315         return PORTC_BASE;
        LDR      R0,??DataTable6_9  ;; 0x4004b000
        B        ??GPIOToPortGet_1
//  316     }
//  317     else if(ulPort == GPIOD_BASE)
??GPIOToPortGet_3:
        LDR      R0,??DataTable6_10  ;; 0x400ff0c0
        CMP      R1,R0
        BNE      ??GPIOToPortGet_4
//  318     {
//  319         return PORTD_BASE;
        LDR      R0,??DataTable6_11  ;; 0x4004c000
        B        ??GPIOToPortGet_1
//  320     }
//  321     else if(ulPort == GPIOE_BASE)
??GPIOToPortGet_4:
        LDR      R0,??DataTable6_12  ;; 0x400ff100
        CMP      R1,R0
        BNE      ??GPIOToPortGet_5
//  322     {
//  323         return PORTE_BASE;
        LDR      R0,??DataTable6_13  ;; 0x4004d000
        B        ??GPIOToPortGet_1
//  324     }
//  325     return 0;
??GPIOToPortGet_5:
        MOVS     R0,#+0
??GPIOToPortGet_1:
        POP      {PC}             ;; return
//  326 }
//  327 
//  328 //*****************************************************************************
//  329 //
//  330 //! \brief Sets the direction and mode of the specified pin.
//  331 //!
//  332 //! \param ulPort is the base address of the GPIO port
//  333 //! \param ulBit is the bit number of a port.
//  334 //! \param ulPinIO is the pin direction and/or mode.
//  335 //!
//  336 //! This function will set the specified pin(Only 1 pin) on the selected GPIO 
//  337 //! port as either an input or output under software control, or it will set 
//  338 //! the pin to be under hardware control.
//  339 //!
//  340 //! The parameter \e ulPinIO is an enumerated data type that can be one of
//  341 //! the following values:
//  342 //!
//  343 //! - \b GPIO_DIR_MODE_IN
//  344 //! - \b GPIO_DIR_MODE_OUT
//  345 //!
//  346 //! where \b GPIO_DIR_MODE_IN specifies that the pin will be programmed as
//  347 //! a software controlled input, \b GPIO_DIR_MODE_OUT specifies that the pin
//  348 //! will be programmed as a software controlled output.
//  349 //!
//  350 //! \return None.
//  351 //
//  352 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  353 void
//  354 GPIODirModeSet(unsigned long ulPort, unsigned long ulBit,
//  355                unsigned long ulPinIO)
//  356 {
GPIODirModeSet:
        PUSH     {R4}
//  357     //
//  358     // Check the arguments.
//  359     //
//  360     xASSERT(GPIOBaseValid(ulPort));
//  361     xASSERT((ulPinIO == GPIO_DIR_MODE_IN) || (ulPinIO == GPIO_DIR_MODE_OUT));
//  362 
//  363     //
//  364     // Set the pin direction and mode.
//  365     //
//  366     xHWREG(ulPort + GPIO_PDDR) &= ~(1 << ulBit);
        LDR      R3,[R0, #+20]
        MOVS     R4,#+1
        LSLS     R4,R4,R1
        BICS     R3,R3,R4
        STR      R3,[R0, #+20]
//  367     xHWREG(ulPort + GPIO_PDDR) |= (ulPinIO << ulBit);
        LDR      R3,[R0, #+20]
        MOVS     R4,R2
        LSLS     R4,R4,R1
        ORRS     R4,R4,R3
        STR      R4,[R0, #+20]
//  368 	
//  369 }
        POP      {R4}
        BX       LR               ;; return
//  370 //*****************************************************************************
//  371 //
//  372 //! Gets the direction and mode of a pin.
//  373 //!
//  374 //! \param ulPort is the base address of the GPIO port.
//  375 //! \param ulBit is the pin number.
//  376 //!
//  377 //! This function gets the direction and control mode for a specified pin on
//  378 //! the selected GPIO port.  The pin can be configured as either an input or
//  379 //! output under software control, or it can be under hardware control.  The
//  380 //! type of control and direction are returned as an enumerated data type.
//  381 //!
//  382 //! \return Returns one of the enumerated data types described for
//  383 //! GPIODirModeSet().
//  384 //
//  385 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  386 unsigned long
//  387 GPIODirModeGet(unsigned long ulPort, unsigned long ulBit)
//  388 {
//  389     //
//  390     // Check the arguments.
//  391     //
//  392     xASSERT(GPIOBaseValid(ulPort));
//  393     xASSERT(ulBit < 16);
//  394     
//  395     //
//  396     // Return the pin direction and mode.
//  397     //
//  398     return ((xHWREG(ulPort + GPIO_PDDR) >> ulBit) & 0x00000001);
GPIODirModeGet:
        LDR      R2,[R0, #+20]
        LSRS     R2,R2,R1
        MOVS     R0,R2
        LSLS     R0,R0,#+31       ;; ZeroExtS R0,R0,#+31,#+31
        LSRS     R0,R0,#+31
        BX       LR               ;; return
//  399 }
//  400 
//  401 //*****************************************************************************
//  402 //
//  403 //! \brief Sets the interrupt type and Enables interrupts for the specified pin(s).
//  404 //!
//  405 //! \param ulPort is the base address of the GPIO port.
//  406 //! \param ulPins is the bit-packed representation of the pin(s).
//  407 //! \param ulIntType specifies the type of interrupt trigger mechanism.
//  408 //!
//  409 //! This function sets up the various interrupt trigger mechanisms for the
//  410 //! specified pin(only one pin) on the selected GPIO port.
//  411 //!
//  412 //! The parameter \e ulIntType is an enumerated data type that can be one of
//  413 //! the following values:
//  414 //!
//  415 //! - \b GPIO_FALLING_EDGE
//  416 //! - \b GPIO_RISING_EDGE
//  417 //! - \b GPIO_BOTH_EDGES
//  418 //! - \b GPIO_LEVEL_LOW
//  419 //! - \b GPIO_LEVEL_HIGH
//  420 //!
//  421 //! where the different values describe the interrupt detection mechanism
//  422 //! (edge or level) and the particular triggering event (falling, rising,
//  423 //! or both edges for edge detect, low or high for level detect).
//  424 //!
//  425 //! \note In order to avoid any spurious interrupts, the user must
//  426 //! ensure that the GPIO inputs remain stable for the duration of
//  427 //! this function.
//  428 //!
//  429 //! \return None.
//  430 //
//  431 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  432 void
//  433 GPIOPinIntEnable(unsigned long ulPort, unsigned long ulPins,
//  434                  unsigned long ulIntType)
//  435 {
GPIOPinIntEnable:
        PUSH     {R0,R4-R7,LR}
        MOVS     R4,R1
        MOVS     R7,R2
//  436     unsigned long ulBit;
//  437     unsigned long ulPortBase;
//  438     
//  439     ulPortBase = GPIOToPortGet(ulPort); 
        LDR      R0,[SP, #+0]
        BL       GPIOToPortGet
        MOVS     R6,R0
//  440 
//  441     //
//  442     // Check the arguments.
//  443     //
//  444     xASSERT(GPIOBaseValid(ulPort));
//  445     xASSERT((ulIntType == GPIO_FALLING_EDGE) ||
//  446             (ulIntType == GPIO_RISING_EDGE) || 
//  447             (ulIntType == GPIO_BOTH_EDGES) || 
//  448 	    (ulIntType == GPIO_LEVEL_LOW) ||
//  449 	    (ulIntType == GPIO_LEVEL_HIGH));
//  450     
//  451     for(ulBit = 0; ulBit < 32; ulBit++)
        MOVS     R0,#+0
        MOVS     R5,R0
??GPIOPinIntEnable_0:
        CMP      R5,#+32
        BCS      ??GPIOPinIntEnable_1
//  452     {
//  453         if(((ulPins >> ulBit) & 1) != 0)
        MOVS     R0,R4
        LSRS     R0,R0,R5
        LSLS     R0,R0,#+31
        BPL      ??GPIOPinIntEnable_2
//  454         { 
//  455 	    xHWREG(ulPortBase + PORT_PCR + ulBit * 4) &= ~PORT_PCR_IRQC_M;
        MOVS     R0,#+4
        MULS     R0,R5,R0
        LDR      R0,[R6, R0]
        LDR      R1,??DataTable7  ;; 0xff00ffff
        ANDS     R1,R1,R0
        MOVS     R0,#+4
        MULS     R0,R5,R0
        STR      R1,[R6, R0]
//  456             xHWREG(ulPortBase + PORT_PCR + ulBit * 4) |= ulIntType;
        MOVS     R0,#+4
        MULS     R0,R5,R0
        LDR      R0,[R6, R0]
        ORRS     R0,R0,R7
        MOVS     R1,#+4
        MULS     R1,R5,R1
        STR      R0,[R6, R1]
//  457         }
//  458     }
??GPIOPinIntEnable_2:
        ADDS     R5,R5,#+1
        B        ??GPIOPinIntEnable_0
//  459 }
??GPIOPinIntEnable_1:
        POP      {R0,R4-R7,PC}    ;; return
//  460 
//  461 //*****************************************************************************
//  462 //
//  463 //! \brief Disables interrupts for the specified pin.
//  464 //!
//  465 //! \param ulPort is the base address of the GPIO port.
//  466 //! \param ulPins is the bit-packed representation of the pin(s).
//  467 //!
//  468 //! Masks the interrupt for the specified pin.
//  469 //!
//  470 //! \return None.
//  471 //
//  472 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  473 void
//  474 GPIOPinIntDisable(unsigned long ulPort, unsigned long ulPins)
//  475 {
GPIOPinIntDisable:
        PUSH     {R3-R7,LR}
        MOVS     R7,R0
        MOVS     R4,R1
//  476     unsigned long ulBit;
//  477     unsigned long ulPortBase;
//  478     ulPortBase = GPIOToPortGet(ulPort); 
        MOVS     R0,R7
        BL       GPIOToPortGet
        MOVS     R6,R0
//  479 
//  480     //
//  481     // Check the arguments.
//  482     //
//  483     xASSERT(GPIOBaseValid(ulPort));
//  484     
//  485     for(ulBit = 0; ulBit < 32; ulBit++)
        MOVS     R0,#+0
        MOVS     R5,R0
??GPIOPinIntDisable_0:
        CMP      R5,#+32
        BCS      ??GPIOPinIntDisable_1
//  486     {
//  487         if(((ulPins >> ulBit) & 1) != 0)
        MOVS     R0,R4
        LSRS     R0,R0,R5
        LSLS     R0,R0,#+31
        BPL      ??GPIOPinIntDisable_2
//  488         { 
//  489 	    xHWREG(ulPortBase + PORT_PCR + ulBit * 4) &= ~PORT_PCR_IRQC_M;
        MOVS     R0,#+4
        MULS     R0,R5,R0
        LDR      R0,[R6, R0]
        LDR      R1,??DataTable7  ;; 0xff00ffff
        ANDS     R1,R1,R0
        MOVS     R0,#+4
        MULS     R0,R5,R0
        STR      R1,[R6, R0]
//  490         }
//  491     }
??GPIOPinIntDisable_2:
        ADDS     R5,R5,#+1
        B        ??GPIOPinIntDisable_0
//  492 }
??GPIOPinIntDisable_1:
        POP      {R0,R4-R7,PC}    ;; return
//  493 
//  494 
//  495 //*****************************************************************************
//  496 //
//  497 //! \brief Init interrupts callback for the specified Port.
//  498 //!
//  499 //! \param ulPort is the base address of the GPIO port.
//  500 //! \param ulPin is the bit-packed representation of the pin.
//  501 //! \param xtPortCallback is callback for the specified Port.
//  502 //!
//  503 //! Init interrupts callback for the specified Port.
//  504 //!
//  505 //! \return None.
//  506 //
//  507 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  508 void
//  509 GPIOPinIntCallbackInit(unsigned long ulPort, unsigned long ulPin,
//  510                        xtEventCallback xtPortCallback)
//  511 {
GPIOPinIntCallbackInit:
        PUSH     {R4-R6,LR}
//  512     int i;
//  513     unsigned long ulPinID;
//  514     //
//  515     // Check the arguments.
//  516     //
//  517     xASSERT(GPIOBaseValid(ulPort));
//  518 
//  519     //
//  520     // changed ?? (ulPort  << 16) | i ?? to ?? (ulPort  << 16) | ulPin ?? by 
//  521     // niuyj 09/09/2011
//  522     //
//  523     ulPinID = (ulPort  << 16) | ulPin;
        LSLS     R5,R0,#+16
        ORRS     R5,R5,R1
        MOVS     R4,R5
//  524 
//  525     //
//  526     // Init the interrupts callback.
//  527     //
//  528     for(i=0; i<xGPIO_INT_NUMBER; i++)
        MOVS     R5,#+0
        MOVS     R3,R5
??GPIOPinIntCallbackInit_0:
        CMP      R3,#+8
        BGE      ??GPIOPinIntCallbackInit_1
//  529     {
//  530         if(g_psGPIOPinIntAssignTable[i].ulpinID == ulPinID)
        MOVS     R5,#+8
        MULS     R5,R3,R5
        LDR      R6,??DataTable6_1
        LDR      R5,[R6, R5]
        CMP      R5,R4
        BNE      ??GPIOPinIntCallbackInit_2
//  531         {
//  532             g_psGPIOPinIntAssignTable[i].pfnGPIOPinHandlerCallback =
//  533                                          xtPortCallback;
        MOVS     R5,#+8
        MULS     R5,R3,R5
        LDR      R6,??DataTable6_1
        ADDS     R5,R6,R5
        STR      R2,[R5, #+4]
//  534             break;
        B        ??GPIOPinIntCallbackInit_1
//  535         }
//  536         if (g_psGPIOPinIntAssignTable[i].ulpinID == 0)
??GPIOPinIntCallbackInit_2:
        MOVS     R5,#+8
        MULS     R5,R3,R5
        LDR      R6,??DataTable6_1
        LDR      R5,[R6, R5]
        CMP      R5,#+0
        BNE      ??GPIOPinIntCallbackInit_3
//  537         {
//  538             g_psGPIOPinIntAssignTable[i].ulpinID = ulPinID;
        MOVS     R5,#+8
        MULS     R5,R3,R5
        LDR      R6,??DataTable6_1
        STR      R4,[R6, R5]
//  539             g_psGPIOPinIntAssignTable[i].pfnGPIOPinHandlerCallback =
//  540                                          xtPortCallback;
        MOVS     R5,#+8
        MULS     R5,R3,R5
        LDR      R6,??DataTable6_1
        ADDS     R5,R6,R5
        STR      R2,[R5, #+4]
//  541             break;
        B        ??GPIOPinIntCallbackInit_1
//  542         }
//  543     } 
??GPIOPinIntCallbackInit_3:
        ADDS     R3,R3,#+1
        B        ??GPIOPinIntCallbackInit_0
//  544 }
??GPIOPinIntCallbackInit_1:
        POP      {R4-R6,PC}       ;; return
//  545 
//  546 //*****************************************************************************
//  547 //
//  548 //! \brief Gets interrupt status for the specified GPIO port.
//  549 //!
//  550 //! \param ulPort is the base address of the GPIO port.
//  551 //!
//  552 //! \return Returns a bit-packed byte, where each bit that is set identifies
//  553 //! an active masked or raw interrupt, and where bit 0 of the byte
//  554 //! represents GPIO port pin 0, bit 1 represents GPIO port pin 1, and so on.
//  555 //
//  556 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  557 unsigned long
//  558 GPIOPinIntStatus(unsigned long ulPort)
//  559 {
GPIOPinIntStatus:
        PUSH     {R3-R5,LR}
        MOVS     R4,R0
//  560     unsigned long ulPortBase;
//  561 
//  562     //
//  563     // Check the arguments.
//  564     //
//  565     xASSERT(GPIOBaseValid(ulPort));
//  566     
//  567     ulPortBase = GPIOToPortGet(ulPort); 
        MOVS     R0,R4
        BL       GPIOToPortGet
        MOVS     R5,R0
//  568 	
//  569     //
//  570     // Return the interrupt status.
//  571     //
//  572     return(xHWREG(ulPortBase + PORT_ISFR));
        ADDS     R5,R5,#+160
        LDR      R0,[R5, #+0]
        POP      {R1,R4,R5,PC}    ;; return
//  573 
//  574 }
//  575 
//  576 //*****************************************************************************
//  577 //
//  578 //! \brief Clears the interrupt for the specified pin(s).
//  579 //!
//  580 //! \param ulPins is the bit-packed representation of the pin(s).
//  581 //!
//  582 //! Clears the interrupt for the specified pin(s).
//  583 //!
//  584 //! The pin(s) are specified using a bit-packed byte, where each bit that is
//  585 //! set identifies the pin to be accessed, and where bit 0 of the byte
//  586 //! represents GPIO port pin 0, bit 1 represents GPIO port pin 1, and so on.
//  587 //!
//  588 //!
//  589 //! \return None.
//  590 //
//  591 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  592 void
//  593 GPIOPinIntClear(unsigned long ulPort, unsigned long ulPins)
//  594 {
GPIOPinIntClear:
        PUSH     {R4-R6,LR}
        MOVS     R5,R0
        MOVS     R4,R1
//  595     unsigned long ulPortBase;
//  596  
//  597     //
//  598     // Check the arguments.
//  599     //
//  600     xASSERT(GPIOBaseValid(ulPort));
//  601 
//  602     ulPortBase = GPIOToPortGet(ulPort); 
        MOVS     R0,R5
        BL       GPIOToPortGet
        MOVS     R6,R0
//  603 
//  604     //
//  605     // Clear the interrupts.
//  606     //
//  607     xHWREG(ulPortBase + PORT_ISFR) |= ulPins; 
        MOVS     R0,#+160
        LDR      R0,[R6, R0]
        ORRS     R0,R0,R4
        MOVS     R1,#+160
        STR      R0,[R6, R1]
//  608 }
        POP      {R4-R6,PC}       ;; return
//  609 
//  610 //*****************************************************************************
//  611 //
//  612 //! \brief Sets the DMA Edge for the specified pin(s).
//  613 //!
//  614 //! \param ulPort is the base address of the GPIO port.
//  615 //! \param ulPins is the bit-packed representation of the pin(s).
//  616 //! \param ulDMAEdge specifies the type of DMA trigger mechanism.
//  617 //!
//  618 //! The parameter ulDMAEdge can be one of the following values:
//  619 //!
//  620 //! - \b GPIO_DMA_DIS
//  621 //! - \b GPIO_DMA_RISE
//  622 //! - \b GPIO_DMA_FALL
//  623 //! - \b GPIO_DMA_BOTH
//  624 //!
//  625 //! \return None.
//  626 //
//  627 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  628 void 
//  629 GPIODMAEdgeSet(unsigned long ulPort, unsigned long ulPins,
//  630                            unsigned long ulDMAEdge)
//  631 {
GPIODMAEdgeSet:
        PUSH     {R0,R4-R7,LR}
        MOVS     R4,R1
        MOVS     R7,R2
//  632     unsigned long ulPortBase;
//  633     unsigned long ulBit;
//  634 
//  635     //
//  636     // Check the arguments.
//  637     //
//  638     xASSERT(GPIOBaseValid(ulPort));
//  639     
//  640     ulPortBase = GPIOToPortGet(ulPort);
        LDR      R0,[SP, #+0]
        BL       GPIOToPortGet
        MOVS     R5,R0
//  641 
//  642     for(ulBit = 0; ulBit < 32; ulBit++)
        MOVS     R0,#+0
        MOVS     R6,R0
??GPIODMAEdgeSet_0:
        CMP      R6,#+32
        BCS      ??GPIODMAEdgeSet_1
//  643     {
//  644         if(((ulPins >> ulBit) & 1) != 0)
        MOVS     R0,R4
        LSRS     R0,R0,R6
        LSLS     R0,R0,#+31
        BPL      ??GPIODMAEdgeSet_2
//  645         { 
//  646 	    xHWREG(ulPortBase + PORT_PCR + ulBit * 4) &= ~PORT_PCR_IRQC_M;
        MOVS     R0,#+4
        MULS     R0,R6,R0
        LDR      R0,[R5, R0]
        LDR      R1,??DataTable7  ;; 0xff00ffff
        ANDS     R1,R1,R0
        MOVS     R0,#+4
        MULS     R0,R6,R0
        STR      R1,[R5, R0]
//  647     	    xHWREG(ulPortBase + PORT_PCR + ulBit * 4) |= ulDMAEdge;
        MOVS     R0,#+4
        MULS     R0,R6,R0
        LDR      R0,[R5, R0]
        ORRS     R0,R0,R7
        MOVS     R1,#+4
        MULS     R1,R6,R1
        STR      R0,[R5, R1]
//  648         }
//  649     }
??GPIODMAEdgeSet_2:
        ADDS     R6,R6,#+1
        B        ??GPIODMAEdgeSet_0
//  650 }
??GPIODMAEdgeSet_1:
        POP      {R0,R4-R7,PC}    ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6:
        DC32     0x400490a0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_1:
        DC32     g_psGPIOPinIntAssignTable

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_2:
        DC32     0x4004c0a0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_3:
        DC32     0xf0c00000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_4:
        DC32     0x400ff000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_5:
        DC32     0x40049000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_6:
        DC32     0x400ff040

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_7:
        DC32     0x4004a000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_8:
        DC32     0x400ff080

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_9:
        DC32     0x4004b000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_10:
        DC32     0x400ff0c0

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_11:
        DC32     0x4004c000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_12:
        DC32     0x400ff100

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_13:
        DC32     0x4004d000
//  651 
//  652 //*****************************************************************************
//  653 //
//  654 //! \brief Reads the values present of the specified pin(s).
//  655 //!
//  656 //! \param ulPort is the base address of the GPIO port.
//  657 //! \param ulPins is the bit-packed representation of the pin(s).
//  658 //!
//  659 //! The values at the specified pin(s) are read, as specified by \e ucPins.
//  660 //! Values are returned for both input and output pin(s), and the value
//  661 //! for pin(s) that are not specified by \e ucPins are set to 0.
//  662 //!
//  663 //! The pin(s) are specified using a bit-packed byte, where each bit that is
//  664 //! set identifies the pin to be accessed, and where bit 0 of the byte
//  665 //! represents GPIO port pin 0, bit 1 represents GPIO port pin 1, and so on.
//  666 //!
//  667 //! \return Returns a bit-packed byte providing the state of the specified
//  668 //! pin, where bit 0 of the byte represents GPIO port pin 0, bit 1 represents
//  669 //! GPIO port pin 1, and so on.  Any bit that is not specified by \e ucPins
//  670 //! is returned as a 0.  Bits 31:16 should be ignored.
//  671 //
//  672 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  673 long
//  674 GPIOPinRead(unsigned long ulPort, unsigned long ulPins)
//  675 {
GPIOPinRead:
        MOVS     R2,R0
        MOVS     R0,R1
//  676     //
//  677     // Check the arguments.
//  678     //
//  679     xASSERT(GPIOBaseValid(ulPort));
//  680 
//  681     //
//  682     // Return the pin value(s).
//  683     //
//  684     return(xHWREG(ulPort + GPIO_PDIR) & (ulPins));
        LDR      R1,[R2, #+16]
        ANDS     R0,R0,R1
        BX       LR               ;; return
//  685 }
//  686 
//  687 //*****************************************************************************
//  688 //
//  689 //! \brief Writes a value to the specified pin(s).
//  690 //!
//  691 //! \param ulPort is the base address of the GPIO port.
//  692 //! \param ulPins is the bit-packed representation of the pin(s).
//  693 //! \param ucVal is the value to write to the pin(s).
//  694 //!
//  695 //! Writes the corresponding bit values to the output pin(s) specified by
//  696 //! \e ucPins.  Writing to a pin configured as an input pin has no effect.
//  697 //!
//  698 //! The pin(s) are specified using a bit-packed byte, where each bit that is
//  699 //! set identifies the pin to be accessed, and where bit 0 of the byte
//  700 //! represents GPIO port pin 0, bit 1 represents GPIO port pin 1, and so on.
//  701 //!
//  702 //! \return None.
//  703 //
//  704 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  705 void
//  706 GPIOPinWrite(unsigned long ulPort, unsigned long ulPins, unsigned char ucVal)
//  707 {
GPIOPinWrite:
        PUSH     {LR}
//  708     //
//  709     // Check the arguments.
//  710     //
//  711     xASSERT(GPIOBaseValid(ulPort));
//  712 
//  713     //
//  714     // Write the pins.
//  715     //
//  716     xHWREG(ulPort + GPIO_PDOR) = ((ucVal & 1) ?
//  717                                 (xHWREG(ulPort + GPIO_PDOR) | ulPins) :
//  718                                 (xHWREG(ulPort + GPIO_PDOR) & ~(ulPins)));
        LSLS     R3,R2,#+31
        BPL      ??GPIOPinWrite_0
        LDR      R3,[R0, #+0]
        ORRS     R3,R3,R1
        B        ??GPIOPinWrite_1
??GPIOPinWrite_0:
        LDR      R3,[R0, #+0]
        BICS     R3,R3,R1
??GPIOPinWrite_1:
        STR      R3,[R0, #+0]
//  719 }
        POP      {PC}             ;; return
//  720 
//  721 //*****************************************************************************
//  722 //
//  723 //! \brief Set a value 1 to the specified pin(s).
//  724 //!
//  725 //! \param ulPort is the base address of the GPIO port.
//  726 //! \param ulPins is the bit-packed representation of the pin(s).
//  727 //!
//  728 //! Writes the corresponding bit value 1 to the output pin(s) specified by
//  729 //! \e ucPins.  Writing to a pin configured as an input pin has no effect.
//  730 //!
//  731 //! The pin(s) are specified using a bit-packed byte, where each bit that is
//  732 //! set identifies the pin to be accessed, and where bit 0 of the byte
//  733 //! represents GPIO port pin 0, bit 1 represents GPIO port pin 1, and so on.
//  734 //!
//  735 //! \return None.
//  736 //
//  737 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  738 void
//  739 GPIOPinSet(unsigned long ulPort, unsigned long ulPins)
//  740 {
//  741     //
//  742     // Check the arguments.
//  743     //
//  744     xASSERT(GPIOBaseValid(ulPort));
//  745 
//  746     //
//  747     // Write the pins.
//  748     //
//  749     xHWREG(ulPort + GPIO_PSOR) = ulPins;
GPIOPinSet:
        STR      R1,[R0, #+4]
//  750 }
        BX       LR               ;; return
//  751 
//  752 //*****************************************************************************
//  753 //
//  754 //! \brief Set a value 0 to the specified pin(s).
//  755 //!
//  756 //! \param ulPort is the base address of the GPIO port.
//  757 //! \param ulPins is the bit-packed representation of the pin(s).
//  758 //!
//  759 //! Writes the corresponding bit value 0 to the output pin(s) specified by
//  760 //! \e ucPins.  Writing to a pin configured as an input pin has no effect.
//  761 //!
//  762 //! The pin(s) are specified using a bit-packed byte, where each bit that is
//  763 //! set identifies the pin to be accessed, and where bit 0 of the byte
//  764 //! represents GPIO port pin 0, bit 1 represents GPIO port pin 1, and so on.
//  765 //!
//  766 //! \return None.
//  767 //
//  768 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  769 void
//  770 GPIOPinReset(unsigned long ulPort, unsigned long ulPins)
//  771 {
//  772     //
//  773     // Check the arguments.
//  774     //
//  775     xASSERT(GPIOBaseValid(ulPort));
//  776 
//  777     //
//  778     // Write the pins.
//  779     //
//  780     xHWREG(ulPort + GPIO_PCOR) = ulPins;
GPIOPinReset:
        STR      R1,[R0, #+8]
//  781 }
        BX       LR               ;; return
//  782 
//  783 //*****************************************************************************
//  784 //
//  785 //! \brief Set GPIO port mask register of the specified GPIO pin(s).
//  786 //!
//  787 //! \param ulPort is the base address of the GPIO port.
//  788 //! \param ulPins is the bit-packed representation of the pin(s).
//  789 //!
//  790 //! Set GPIO port mask register of the specified GPIO pin(s) specified by
//  791 //! \e ucPins.  
//  792 //!
//  793 //! The pin(s) are specified using a bit-packed byte, where each bit that is
//  794 //! set identifies the pin to be accessed, and where bit 0 of the byte
//  795 //! represents GPIO port pin 0, bit 1 represents GPIO port pin 1, and so on.
//  796 //!
//  797 //! \return None.
//  798 //
//  799 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  800 void 
//  801 GPIOPinMaskSet(unsigned long ulPort, unsigned long ulPins)
//  802 {
GPIOPinMaskSet:
        PUSH     {R3-R7,LR}
        MOVS     R7,R0
        MOVS     R4,R1
//  803     unsigned long ulPortBase;
//  804     unsigned long ulBit;
//  805 
//  806     //
//  807     // Check the arguments.
//  808     //
//  809     xASSERT(GPIOBaseValid(ulPort));
//  810     
//  811 	ulPortBase = GPIOToPortGet(ulPort);
        MOVS     R0,R7
        BL       GPIOToPortGet
        MOVS     R5,R0
//  812 
//  813     for(ulBit = 0; ulBit < 32; ulBit++)
        MOVS     R0,#+0
        MOVS     R6,R0
??GPIOPinMaskSet_0:
        CMP      R6,#+32
        BCS      ??GPIOPinMaskSet_1
//  814     {
//  815         if(((ulPins >> ulBit) & 1) != 0)
        MOVS     R0,R4
        LSRS     R0,R0,R6
        LSLS     R0,R0,#+31
        BPL      ??GPIOPinMaskSet_2
//  816         { 
//  817 	    if(ulBit < 16)
        CMP      R6,#+16
        BCS      ??GPIOPinMaskSet_3
//  818             {
//  819 	        xHWREG(ulPortBase + PORT_GPCLR) |= (1 << (ulBit + 16));
        MOVS     R0,#+128
        LDR      R0,[R5, R0]
        MOVS     R1,#+1
        MOVS     R2,R6
        ADDS     R2,R2,#+16
        LSLS     R1,R1,R2
        ORRS     R1,R1,R0
        MOVS     R0,#+128
        STR      R1,[R5, R0]
        B        ??GPIOPinMaskSet_2
//  820             }
//  821             else
//  822 	    {
//  823 	        xHWREG(ulPortBase + PORT_GPCHR) |= (1 << (ulBit + 16)); 
??GPIOPinMaskSet_3:
        MOVS     R0,#+132
        LDR      R0,[R5, R0]
        MOVS     R1,#+1
        MOVS     R2,R6
        ADDS     R2,R2,#+16
        LSLS     R1,R1,R2
        ORRS     R1,R1,R0
        MOVS     R0,#+132
        STR      R1,[R5, R0]
//  824 	    }
//  825         }
//  826     }
??GPIOPinMaskSet_2:
        ADDS     R6,R6,#+1
        B        ??GPIOPinMaskSet_0
//  827 }
??GPIOPinMaskSet_1:
        POP      {R0,R4-R7,PC}    ;; return
//  828 
//  829 //*****************************************************************************
//  830 //
//  831 //! \brief Get GPIO port mask register of the specified GPIO pin(s).
//  832 //!
//  833 //! \param ulPort is the base address of the GPIO port.
//  834 //!
//  835 //! \return None.
//  836 //
//  837 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  838 long 
//  839 GPIOPortMaskGet(unsigned long ulPort)
//  840 {
GPIOPortMaskGet:
        PUSH     {R4-R6,LR}
        MOVS     R4,R0
//  841     unsigned long ulPortBase;
//  842 	unsigned long ulPinMask;
//  843 
//  844     //
//  845     // Check the arguments.
//  846     //
//  847     xASSERT(GPIOBaseValid(ulPort));
//  848     
//  849 	ulPortBase = GPIOToPortGet(ulPort);
        MOVS     R0,R4
        BL       GPIOToPortGet
        MOVS     R5,R0
//  850 
//  851 	ulPinMask = xHWREG(ulPortBase + PORT_GPCHR);
        MOVS     R0,#+132
        LDR      R0,[R5, R0]
        MOVS     R6,R0
//  852 	ulPinMask = ulPinMask << 16;
        LSLS     R6,R6,#+16
//  853 	ulPinMask |= xHWREG(ulPortBase + PORT_GPCLR);  
        MOVS     R1,R6
        MOVS     R0,#+128
        LDR      R6,[R5, R0]
        ORRS     R6,R6,R1
//  854 
//  855     return ulPinMask;
        MOVS     R0,R6
        POP      {R4-R6,PC}       ;; return
//  856 }
//  857 
//  858 //*****************************************************************************
//  859 //
//  860 //! \brief Get GPIO port Dout register of the specified GPIO.
//  861 //!
//  862 //! \param ulPort is the base address of the GPIO port.
//  863 //!
//  864 //! \return The value of the specified GPIO DOUT.
//  865 //
//  866 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  867 long 
//  868 GPIOPinPortDoutGet(unsigned long ulPort)
//  869 {
//  870     //
//  871     // Check the arguments.
//  872     //
//  873     xASSERT(GPIOBaseValid(ulPort));
//  874 
//  875 	return(xHWREG(ulPort + GPIO_PDOR));
GPIOPinPortDoutGet:
        LDR      R0,[R0, #+0]
        BX       LR               ;; return
//  876 }
//  877 
//  878 //*****************************************************************************
//  879 //
//  880 //! \brief Selects the driving current of specified GPIO pin(s).
//  881 //!
//  882 //! \param ulPort is the base address of the GPIO port.
//  883 //! \param ulPins is the bit-packed representation of the pin(s).
//  884 //! \param ulStrength is Selection of output driving current.it can be selected
//  885 //! one of the following values:
//  886 //! 
//  887 //! - \ref GPIO_DRIVER_STR_DIS
//  888 //! - \ref GPIO_DRIVER_STR_ENA
//  889 //!
//  890 //! The pin(s) are specified using a bit-packed byte, where each bit that is
//  891 //! set identifies the pin to be accessed, and where bit 0 of the byte
//  892 //! represents GPIO port pin 0, bit 1 represents GPIO port pin 1, and so on.
//  893 //!
//  894 //! \return None.
//  895 //
//  896 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  897 void 
//  898 GPIOPadConfigSet(unsigned long ulPort, unsigned long ulPins, 
//  899                  unsigned long ulStrength)
//  900 {
GPIOPadConfigSet:
        PUSH     {R0,R4-R7,LR}
        MOVS     R4,R1
        MOVS     R7,R2
//  901     unsigned long ulPortBase;
//  902 	unsigned long ulBit;
//  903 
//  904     //
//  905     // Check the arguments.
//  906     //
//  907     xASSERT(GPIOBaseValid(ulPort));
//  908     
//  909 	ulPortBase = GPIOToPortGet(ulPort);
        LDR      R0,[SP, #+0]
        BL       GPIOToPortGet
        MOVS     R5,R0
//  910 
//  911     for(ulBit = 0; ulBit < 32; ulBit++)
        MOVS     R0,#+0
        MOVS     R6,R0
??GPIOPadConfigSet_0:
        CMP      R6,#+32
        BCS      ??GPIOPadConfigSet_1
//  912     {
//  913         if(((ulPins >> ulBit) & 1) != 0)
        MOVS     R0,R4
        LSRS     R0,R0,R6
        LSLS     R0,R0,#+31
        BPL      ??GPIOPadConfigSet_2
//  914         {
//  915 	    //
//  916             // Drive Strength select
//  917             //
//  918             xHWREG(ulPortBase + PORT_PCR + ulBit * 4) &= ~PORT_PCR_DSE_HIGH ;
        MOVS     R0,#+4
        MULS     R0,R6,R0
        LDR      R0,[R5, R0]
        MOVS     R1,#+64
        BICS     R0,R0,R1
        MOVS     R1,#+4
        MULS     R1,R6,R1
        STR      R0,[R5, R1]
//  919             xHWREG(ulPortBase + PORT_PCR + ulBit * 4) |= ulStrength ;
        MOVS     R0,#+4
        MULS     R0,R6,R0
        LDR      R0,[R5, R0]
        ORRS     R0,R0,R7
        MOVS     R1,#+4
        MULS     R1,R6,R1
        STR      R0,[R5, R1]
//  920 
//  921         }
//  922     }
??GPIOPadConfigSet_2:
        ADDS     R6,R6,#+1
        B        ??GPIOPadConfigSet_0
//  923 }
??GPIOPadConfigSet_1:
        POP      {R0,R4-R7,PC}    ;; return
//  924 
//  925 //*****************************************************************************
//  926 //
//  927 //! \brief Enable the Port pin Pull. 
//  928 //!
//  929 //! \param ulPort is the base address of the GPIO port.
//  930 //! \param ulPins is the bit-packed representation of the pin(s).
//  931 //! \param ulPullType is Selection of pull register.
//  932 //! \param ulPullCfg is pull enable configure.
//  933 //!
//  934 //! The pull ulPullCfg configure is chosen with one of the following values:
//  935 //! - \ref GPIO_PULL_ENABLE
//  936 //! - \ref GPIO_PULL_DISABLE
//  937 //!
//  938 //! \param ulPadType is the one of the following values:
//  939 //! - \ref GPIO_PULL_DOWN
//  940 //! - \ref GPIO_PULL_UP
//  941 //!
//  942 //! The pin(s) are specified using a bit-packed byte, where each bit that is
//  943 //! set identifies the pin to be accessed, and where bit 0 of the byte
//  944 //! represents GPIO port pin 0, bit 1 represents GPIO port pin 1, and so on.
//  945 //!
//  946 //! \note there are some problem in this API,will modify it later.
//  947 //!
//  948 //! \return None.
//  949 //
//  950 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  951 void 
//  952 GPIOPullConfigure(unsigned long ulPort, unsigned long ulPins, 
//  953                   unsigned long ulPullCfg, unsigned long ulPullType)
//  954 {
GPIOPullConfigure:
        PUSH     {R0,R2,R4-R7,LR}
        SUB      SP,SP,#+4
        MOVS     R4,R1
        MOVS     R7,R3
//  955     unsigned long ulPortBase;
//  956 	unsigned long ulBit;
//  957 
//  958     //
//  959     // Check the arguments.
//  960     //
//  961     xASSERT(GPIOBaseValid(ulPort));
//  962     
//  963 	ulPortBase = GPIOToPortGet(ulPort);
        LDR      R0,[SP, #+4]
        BL       GPIOToPortGet
        MOVS     R5,R0
//  964 
//  965     for(ulBit = 0; ulBit < 32; ulBit++)
        MOVS     R0,#+0
        MOVS     R6,R0
??GPIOPullConfigure_0:
        CMP      R6,#+32
        BCS      ??GPIOPullConfigure_1
//  966     {
//  967         if(((ulPins >> ulBit) & 1) != 0)
        MOVS     R0,R4
        LSRS     R0,R0,R6
        LSLS     R0,R0,#+31
        BPL      ??GPIOPullConfigure_2
//  968         {
//  969 
//  970             //
//  971             // Pull enable select
//  972             //
//  973             xHWREG(ulPortBase + PORT_PCR + ulBit * 4) &= ~PORT_PCR_PE_ENABLE ;
        MOVS     R0,#+4
        MULS     R0,R6,R0
        LDR      R0,[R5, R0]
        MOVS     R1,#+2
        BICS     R0,R0,R1
        MOVS     R1,#+4
        MULS     R1,R6,R1
        STR      R0,[R5, R1]
//  974             xHWREG(ulPortBase + PORT_PCR + ulBit * 4) |= ulPullCfg ;
        MOVS     R0,#+4
        MULS     R0,R6,R0
        LDR      R0,[R5, R0]
        LDR      R1,[SP, #+8]
        ORRS     R1,R1,R0
        MOVS     R0,#+4
        MULS     R0,R6,R0
        STR      R1,[R5, R0]
//  975             
//  976             //
//  977             // pull resistor configure
//  978             //
//  979 	    xHWREG(ulPortBase + PORT_PCR + ulBit * 4) &= ~PORT_PCR_PS_ENABLE ;
        MOVS     R0,#+4
        MULS     R0,R6,R0
        LDR      R0,[R5, R0]
        MOVS     R1,#+1
        BICS     R0,R0,R1
        MOVS     R1,#+4
        MULS     R1,R6,R1
        STR      R0,[R5, R1]
//  980             xHWREG(ulPortBase + PORT_PCR + ulBit * 4) |= ulPullType ;
        MOVS     R0,#+4
        MULS     R0,R6,R0
        LDR      R0,[R5, R0]
        ORRS     R0,R0,R7
        MOVS     R1,#+4
        MULS     R1,R6,R1
        STR      R0,[R5, R1]
//  981         }
//  982     }
??GPIOPullConfigure_2:
        ADDS     R6,R6,#+1
        B        ??GPIOPullConfigure_0
//  983 }
??GPIOPullConfigure_1:
        POP      {R0-R2,R4-R7,PC}  ;; return
//  984 
//  985 //*****************************************************************************
//  986 //
//  987 //! \brief Configure the pin passive 
//  988 //!
//  989 //! \param ulPort is the base address of the GPIO port.
//  990 //! \param ulPins is the bit-packed representation of the pin(s).
//  991 //! \param ulPassiveCfg is Selection of pull register.
//  992 //! 
//  993 //! \param ulPassiveCfg is the one of the following values:
//  994 //! - \ref GPIO_PASSIVE_FILTER_DIS
//  995 //! - \ref GPIO_PASSIVE_FILTER_ENA
//  996 //!
//  997 //! The pin(s) are specified using a bit-packed byte, where each bit that is
//  998 //! set identifies the pin to be accessed, and where bit 0 of the byte
//  999 //! represents GPIO port pin 0, bit 1 represents GPIO port pin 1, and so on.
// 1000 //!
// 1001 //! \note there are some problem in this API,will modify it later.
// 1002 //!
// 1003 //! \return None.
// 1004 //
// 1005 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1006 void 
// 1007 GPIOPassiveConfigure(unsigned long ulPort, unsigned long ulPins, 
// 1008                                     unsigned long ulPassiveCfg)
// 1009 {
GPIOPassiveConfigure:
        PUSH     {R0,R4-R7,LR}
        MOVS     R4,R1
        MOVS     R7,R2
// 1010     unsigned long ulPortBase;
// 1011 	unsigned long ulBit;
// 1012 
// 1013     //
// 1014     // Check the arguments.
// 1015     //
// 1016     xASSERT(GPIOBaseValid(ulPort));
// 1017     ulPortBase = GPIOToPortGet(ulPort);
        LDR      R0,[SP, #+0]
        BL       GPIOToPortGet
        MOVS     R5,R0
// 1018 
// 1019     for(ulBit = 0; ulBit < 32; ulBit++)
        MOVS     R0,#+0
        MOVS     R6,R0
??GPIOPassiveConfigure_0:
        CMP      R6,#+32
        BCS      ??GPIOPassiveConfigure_1
// 1020     {
// 1021         if(((ulPins >> ulBit) & 1) != 0)
        MOVS     R0,R4
        LSRS     R0,R0,R6
        LSLS     R0,R0,#+31
        BPL      ??GPIOPassiveConfigure_2
// 1022         {
// 1023             //
// 1024             // Passive Filter configure
// 1025             //
// 1026             xHWREG(ulPortBase + PORT_PCR + ulBit * 4) &= ~PORT_PCR_PFE_ENABLE ;
        MOVS     R0,#+4
        MULS     R0,R6,R0
        LDR      R0,[R5, R0]
        MOVS     R1,#+16
        BICS     R0,R0,R1
        MOVS     R1,#+4
        MULS     R1,R6,R1
        STR      R0,[R5, R1]
// 1027             xHWREG(ulPortBase + PORT_PCR + ulBit * 4) |= ulPassiveCfg ;
        MOVS     R0,#+4
        MULS     R0,R6,R0
        LDR      R0,[R5, R0]
        ORRS     R0,R0,R7
        MOVS     R1,#+4
        MULS     R1,R6,R1
        STR      R0,[R5, R1]
// 1028         }
// 1029     }
??GPIOPassiveConfigure_2:
        ADDS     R6,R6,#+1
        B        ??GPIOPassiveConfigure_0
// 1030 }
??GPIOPassiveConfigure_1:
        POP      {R0,R4-R7,PC}    ;; return
// 1031 
// 1032 //*****************************************************************************
// 1033 //
// 1034 //! \brief Configure the Slew Rate 
// 1035 //!
// 1036 //! \param ulPort is the base address of the GPIO port.
// 1037 //! \param ulPins is the bit-packed representation of the pin(s).
// 1038 //! \param ulPassiveCfg is Selection of pull register.
// 1039 //! 
// 1040 //! \param ulSlewRateCfg is the one of the following values:
// 1041 //! - \ref GPIO_SLEW_RATE_FAST
// 1042 //! - \ref GPIO_SLEW_RATE_SLOW
// 1043 //!
// 1044 //! The pin(s) are specified using a bit-packed byte, where each bit that is
// 1045 //! set identifies the pin to be accessed, and where bit 0 of the byte
// 1046 //! represents GPIO port pin 0, bit 1 represents GPIO port pin 1, and so on.
// 1047 //!
// 1048 //! \note there are some problem in this API,will modify it later.
// 1049 //!
// 1050 //! \return None.
// 1051 //

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1052 void 
// 1053 GPIOSlewRataConfigure(unsigned long ulPort, unsigned long ulPins,
// 1054                                             unsigned long ulSlewRateCfg)
// 1055 {
GPIOSlewRataConfigure:
        PUSH     {R0,R4-R7,LR}
        MOVS     R4,R1
        MOVS     R7,R2
// 1056     unsigned long ulPortBase;
// 1057 	unsigned long ulBit;
// 1058 
// 1059     //
// 1060     // Check the arguments.
// 1061     //
// 1062     xASSERT(GPIOBaseValid(ulPort));
// 1063     
// 1064 	ulPortBase = GPIOToPortGet(ulPort);
        LDR      R0,[SP, #+0]
        BL       GPIOToPortGet
        MOVS     R5,R0
// 1065 
// 1066     for(ulBit = 0; ulBit < 32; ulBit++)
        MOVS     R0,#+0
        MOVS     R6,R0
??GPIOSlewRataConfigure_0:
        CMP      R6,#+32
        BCS      ??GPIOSlewRataConfigure_1
// 1067     {
// 1068         if(((ulPins >> ulBit) & 1) != 0)
        MOVS     R0,R4
        LSRS     R0,R0,R6
        LSLS     R0,R0,#+31
        BPL      ??GPIOSlewRataConfigure_2
// 1069         {
// 1070             //
// 1071             // Passive Filter configure
// 1072             //
// 1073             xHWREG(ulPortBase + PORT_PCR + ulBit * 4) &= ~PORT_PCR_SRE_ENABLE ;
        MOVS     R0,#+4
        MULS     R0,R6,R0
        LDR      R0,[R5, R0]
        MOVS     R1,#+4
        BICS     R0,R0,R1
        MOVS     R1,#+4
        MULS     R1,R6,R1
        STR      R0,[R5, R1]
// 1074             xHWREG(ulPortBase + PORT_PCR + ulBit * 4) |= ulSlewRateCfg ;
        MOVS     R0,#+4
        MULS     R0,R6,R0
        LDR      R0,[R5, R0]
        ORRS     R0,R0,R7
        MOVS     R1,#+4
        MULS     R1,R6,R1
        STR      R0,[R5, R1]
// 1075         }
// 1076     }
??GPIOSlewRataConfigure_2:
        ADDS     R6,R6,#+1
        B        ??GPIOSlewRataConfigure_0
// 1077 }
??GPIOSlewRataConfigure_1:
        POP      {R0,R4-R7,PC}    ;; return
// 1078 
// 1079 //*****************************************************************************
// 1080 //
// 1081 //! \brief Configures the alternate function of a GPIO pin.
// 1082 //!
// 1083 //! \param ulPinConfig is the pin configuration value, specified as only one of
// 1084 //! the \b GPIO_P??_??? values.
// 1085 //!
// 1086 //! This function configures the pin mux that selects the peripheral function
// 1087 //! associated with a particular GPIO pin.  Only one peripheral function at a
// 1088 //! time can be associated with a GPIO pin, and each peripheral function should
// 1089 //! only be associated with a single GPIO pin at a time (despite the fact that
// 1090 //! many of them can be associated with more than one GPIO pin).
// 1091 //!
// 1092 //! \note None.
// 1093 //!
// 1094 //! \return None.
// 1095 //
// 1096 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1097 void
// 1098 GPIOPinConfigure(unsigned long ulPinConfig)
// 1099 {
GPIOPinConfigure:
        PUSH     {R4-R6}
// 1100     unsigned long ulPortBase, ulPinBase, ulMux;
// 1101     unsigned long ulShift;
// 1102 
// 1103     //
// 1104     // Extract the Port Base shift.
// 1105     //
// 1106     ulShift = (ulPinConfig >> 12) & 0x0f;
        MOVS     R5,R0
        LSRS     R5,R5,#+12
        LSLS     R5,R5,#+28       ;; ZeroExtS R5,R5,#+28,#+28
        LSRS     R5,R5,#+28
        MOVS     R4,R5
// 1107     ulPortBase = g_pulPortBase[ulShift]; 
        MOVS     R5,#+4
        MULS     R5,R4,R5
        LDR      R6,??DataTable7_1
        LDR      R5,[R6, R5]
        MOVS     R1,R5
// 1108 
// 1109     //
// 1110     // Extract the pin shift number.
// 1111     // 
// 1112     ulShift = (ulPinConfig >> 4) & 0xff; 
        MOVS     R5,R0
        LSRS     R5,R5,#+4
        UXTB     R5,R5
        MOVS     R4,R5
// 1113     ulPinBase = ulShift * 4;
        MOVS     R5,#+4
        MULS     R5,R4,R5
        MOVS     R2,R5
// 1114 
// 1115     //
// 1116     // Extract the pin mux.
// 1117     // 
// 1118     ulMux = ulPinConfig & 0x0f; 
        LSLS     R5,R0,#+28       ;; ZeroExtS R5,R0,#+28,#+28
        LSRS     R5,R5,#+28
        MOVS     R3,R5
// 1119     
// 1120     //
// 1121     // Clear the corresponding pin mux first.
// 1122     //
// 1123     xHWREG(ulPortBase + ulPinBase) &= ~PORT_PCR_PIN_MUX_M;
        LDR      R5,[R1, R2]
        LDR      R6,??DataTable7_2  ;; 0xfffff8ff
        ANDS     R6,R6,R5
        STR      R6,[R1, R2]
// 1124 
// 1125     //
// 1126     // Set the corresponding pin mux.
// 1127     //
// 1128     xHWREG(ulPortBase + ulPinBase) |= (ulMux << 8);
        LDR      R5,[R1, R2]
        LSLS     R6,R3,#+8
        ORRS     R6,R6,R5
        STR      R6,[R1, R2]
// 1129 }
        POP      {R4-R6}
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7:
        DC32     0xff00ffff

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_1:
        DC32     g_pulPortBase

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable7_2:
        DC32     0xfffff8ff
// 1130 
// 1131 //*****************************************************************************
// 1132 //
// 1133 //! \brief Get the GPIO port from a short Pin.
// 1134 //!
// 1135 //! \param eShortPin is the base address of the GPIO port
// 1136 //!
// 1137 //! \note None.
// 1138 //! 
// 1139 //! \return GPIO port address which is used by GPIO API.
// 1140 //
// 1141 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1142 unsigned long 
// 1143 GPIOPinToPort(unsigned long ulPort, unsigned long ulPin)
// 1144 {      
// 1145     //
// 1146     // Check the arguments.
// 1147     //
// 1148     xASSERT(GPIOBaseValid(ulPort));
// 1149 
// 1150     return ulPort;
GPIOPinToPort:
        BX       LR               ;; return
// 1151 }
// 1152 
// 1153 //*****************************************************************************
// 1154 //
// 1155 //! \brief Get the GPIO pin number from a short Pin.
// 1156 //!
// 1157 //! \param ulPort is the base address of the GPIO port
// 1158 //!
// 1159 //! \note None.
// 1160 //! 
// 1161 //! \return GPIO pin number which is used by GPIO API.
// 1162 //
// 1163 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1164 unsigned long 
// 1165 GPIOPinToPin(unsigned long ulPort, unsigned long ulPin)
// 1166 {        
GPIOPinToPin:
        MOVS     R2,R0
        MOVS     R0,R1
// 1167     //
// 1168     // Check the arguments.
// 1169     //
// 1170     xASSERT(GPIOBaseValid(ulPort));
// 1171 
// 1172     return ulPin;
        BX       LR               ;; return
// 1173 }

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        END
// 1174 
// 
//    64 bytes in section .bss
//    20 bytes in section .rodata
// 1 272 bytes in section .text
// 
// 1 272 bytes of CODE  memory
//    20 bytes of CONST memory
//    64 bytes of DATA  memory
//
//Errors: none
//Warnings: none
