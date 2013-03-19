///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.40.1.53790/W32 for ARM    24/Feb/2013  09:52:17 /
// Copyright 1999-2012 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  C:\Users\renjun\Desktop\Cox\CoX_Peripheral\CoX_Peripher /
//                    al_KLx\uart\test\suite1\src\xuarttest03.c               /
//    Command line =  C:\Users\renjun\Desktop\Cox\CoX_Peripheral\CoX_Peripher /
//                    al_KLx\uart\test\suite1\src\xuarttest03.c -D ewarm      /
//                    -lCN C:\Users\renjun\Desktop\Cox\CoX_Peripheral\CoX_Per /
//                    ipheral_KLx\uart\test\suite1\ewarm\Debug\List\ -lB      /
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
//                    al_KLx\uart\test\suite1\ewarm\Debug\List\xuarttest03.s  /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME xuarttest03

        #define SHT_PROGBITS 0x1

        EXTERN FILE_Print
        EXTERN UARTCharGet
        EXTERN UARTCharPut
        EXTERN UARTCharsAvail
        EXTERN UART_Print
        EXTERN _TestAssert

        PUBLIC psPatternxUART03
        PUBLIC sTestxuart0301

// C:\Users\renjun\Desktop\Cox\CoX_Peripheral\CoX_Peripheral_KLx\uart\test\suite1\src\xuarttest03.c
//    1 //*****************************************************************************
//    2 //
//    3 //! @page xuart_testcase xuart  test
//    4 //!  
//    5 //! File: @ref xuart_testcase.c
//    6 //! 
//    7 //! <h2>Description</h2>
//    8 //! This module implements the test sequence for the xuart sub component.<br><br>
//    9 //! - \p Board: KLxx <br><br>
//   10 //! - \p Last-Time(about): 0.5s <br><br>
//   11 //! - \p Phenomenon: Success or failure information will be printed on the VCOM UART.
//   12 //!   <br><br>
//   13 //! .
//   14 //! 
//   15 //! <h2>Preconditions</h2>
//   16 //! The module requires the following options:<br><br>
//   17 //! - \p Option-define: 
//   18 //! <br>(1)None.<br><br>
//   19 //! - \p Option-hardware: 
//   20 //! <br>(1)Connect an USB cable to the development board.<br><br>
//   21 //! - \p Option-OtherModule:         
//   22 //! <br>None.<br>
//   23 //! .
//   24 //! In case some of the required options are not enabled then some or all tests
//   25 //! may be skipped or result FAILED.<br>
//   26 //! 
//   27 //! <h2>Test Cases</h2>
//   28 //! The module contain those sub tests:<br><br>
//   29 //! - \subpage test_xuart_Config
//   30 //! .
//   31 //! \file xuart_testcase.c
//   32 //! \brief xuart test source file
//   33 //! \file xuart_testcase.h
//   34 //! \brief xuart test header file <br>
//   35 //
//   36 //*****************************************************************************
//   37 
//   38 #include "test.h"
//   39 #include "testcase.h"
//   40 
//   41 #define UART_BASE UART1_BASE
//   42 
//   43 #define UART_BAUD 9600UL
//   44 
//   45 
//   46 //*****************************************************************************
//   47 //
//   48 //! \page test_xuart test_xuart
//   49 //!
//   50 //! <h2>Description</h2>
//   51 //! 
//   52 //! Test xuart . <br> 
//   53 //!
//   54 //
//   55 //*****************************************************************************
//   56 
//   57 //*****************************************************************************
//   58 //
//   59 //! Get the Test description of xuart0301  test.
//   60 //!
//   61 //! \return the desccription of the xuart0301 test.
//   62 //
//   63 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   64 static char* xuart0301GetTest(void)
//   65 {
//   66     return "UART 0301 : UART Send/Receive test";
xuart0301GetTest:
        LDR      R0,??DataTable3
        BX       LR               ;; return
//   67 }
//   68 
//   69 //*****************************************************************************
//   70 //
//   71 //! Something should do before the test execute of xuart0301 test.
//   72 //!
//   73 //! \return None.
//   74 //
//   75 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   76 static void xuart0301Setup(void)
//   77 {
//   78     xHWREG(SIM_SCGC4) |= SIM_SCGC4_UART0_EN;
xuart0301Setup:
        LDR      R0,??DataTable3_1  ;; 0x40048034
        LDR      R0,[R0, #+0]
        MOVS     R1,#+128
        LSLS     R1,R1,#+3        ;; #+1024
        ORRS     R1,R1,R0
        LDR      R0,??DataTable3_1  ;; 0x40048034
        STR      R1,[R0, #+0]
//   79 }
        BX       LR               ;; return
//   80 
//   81 //*****************************************************************************
//   82 //
//   83 //! Something should do after the test execute of xuart0301 test.
//   84 //!
//   85 //! \return None.
//   86 //
//   87 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   88 static void xuart0301TearDown(void)
//   89 {
//   90     xHWREG(SIM_SCGC4) &= (~SIM_SCGC4_UART0_EN);
xuart0301TearDown:
        LDR      R0,??DataTable3_1  ;; 0x40048034
        LDR      R0,[R0, #+0]
        LDR      R1,??DataTable3_2  ;; 0xfffffbff
        ANDS     R1,R1,R0
        LDR      R0,??DataTable3_1  ;; 0x40048034
        STR      R1,[R0, #+0]
//   91 }
        BX       LR               ;; return
//   92 
//   93 
//   94 //*****************************************************************************
//   95 //
//   96 //! xuart0301 test execute main body.
//   97 //
//   98 //! \return None.
//   99 //
//  100 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  101 static void xuart0301Execute(void)
//  102 {
xuart0301Execute:
        PUSH     {R4-R6,LR}
//  103     unsigned char UartData = 0;
        MOVS     R4,#+0
//  104     unsigned char i = 0;
        MOVS     R5,#+0
//  105     xtBoolean bTmpBoolean = xfalse;
        MOVS     R6,#+0
//  106 
//  107     UART_Print("\r\nPlease wait 1 s then type the follow string\r\n");
        LDR      R0,??DataTable3_3
        BL       UART_Print
//  108     UART_Print("123456789ABCDE\r\n");
        LDR      R0,??DataTable3_4
        BL       UART_Print
//  109 
//  110     bTmpBoolean = UARTCharsAvail(UART_BASE);
        LDR      R0,??DataTable3_5  ;; 0x4006b000
        BL       UARTCharsAvail
        MOVS     R6,R0
//  111     TestAssert((xfalse == bTmpBoolean),
//  112             "UART 0301: Function UARTCharsAvail failed!\r\n");
        UXTB     R6,R6
        CMP      R6,#+0
        BEQ      ??xuart0301Execute_0
        LDR      R0,??DataTable3_6
        BL       _TestAssert
        LDR      R1,??DataTable3_7
        LDR      R0,??DataTable3_8
        BL       FILE_Print
        MOVS     R1,#+112
        LDR      R0,??DataTable3_9
        BL       FILE_Print
//  113     
//  114     while((UartData = UARTCharGet(UART_BASE)) != '\n')
??xuart0301Execute_0:
??xuart0301Execute_1:
        LDR      R0,??DataTable3_5  ;; 0x4006b000
        BL       UARTCharGet
        MOVS     R4,R0
        UXTB     R0,R0
        CMP      R0,#+10
        BEQ      ??xuart0301Execute_2
//  115     {
//  116         UARTCharPut(UART_BASE, UartData);
        MOVS     R1,R4
        UXTB     R1,R1
        LDR      R0,??DataTable3_5  ;; 0x4006b000
        BL       UARTCharPut
//  117         if(++i >= 15)
        ADDS     R5,R5,#+1
        MOVS     R0,R5
        MOVS     R5,R0
        UXTB     R0,R0
        CMP      R0,#+15
        BCC      ??xuart0301Execute_1
//  118         {
//  119             break;
//  120         }
//  121     }
//  122     UARTCharPut(UART_BASE, '\r');
??xuart0301Execute_2:
        MOVS     R1,#+13
        LDR      R0,??DataTable3_5  ;; 0x4006b000
        BL       UARTCharPut
//  123     UARTCharPut(UART_BASE, '\n');
        MOVS     R1,#+10
        LDR      R0,??DataTable3_5  ;; 0x4006b000
        BL       UARTCharPut
//  124 
//  125 }
        POP      {R4-R6,PC}       ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3:
        DC32     `?<Constant "UART 0301 : UART Send...">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_1:
        DC32     0x40048034

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_2:
        DC32     0xfffffbff

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_3:
        DC32     `?<Constant "\\r\\nPlease wait 1 s the...">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_4:
        DC32     `?<Constant "123456789ABCDE\\r\\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_5:
        DC32     0x4006b000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_6:
        DC32     `?<Constant "UART 0301: Function U...">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_7:
        DC32     `?<Constant "C:\\\\Users\\\\renjun\\\\Deskt...">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_8:
        DC32     `?<Constant "\\r\\nFILE\\t:%s\\r\\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable3_9:
        DC32     `?<Constant "\\r\\nLINE\\t:%d\\r\\n">`

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "UART 0301 : UART Send...">`:
        DATA
        DC8 "UART 0301 : UART Send/Receive test"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "\\r\\nPlease wait 1 s the...">`:
        DATA
        DC8 "\015\012Please wait 1 s then type the follow string\015\012"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "123456789ABCDE\\r\\n">`:
        DATA
        DC8 "123456789ABCDE\015\012"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "UART 0301: Function U...">`:
        DATA
        DC8 "UART 0301: Function UARTCharsAvail failed!\015\012"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "\\r\\nFILE\\t:%s\\r\\n">`:
        DATA
        DC8 "\015\012FILE\t:%s\015\012"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "C:\\\\Users\\\\renjun\\\\Deskt...">`:
        DATA
        DC8 43H, 3AH, 5CH, 55H, 73H, 65H, 72H, 73H
        DC8 5CH, 72H, 65H, 6EH, 6AH, 75H, 6EH, 5CH
        DC8 44H, 65H, 73H, 6BH, 74H, 6FH, 70H, 5CH
        DC8 43H, 6FH, 78H, 5CH, 43H, 6FH, 58H, 5FH
        DC8 50H, 65H, 72H, 69H, 70H, 68H, 65H, 72H
        DC8 61H, 6CH, 5CH, 43H, 6FH, 58H, 5FH, 50H
        DC8 65H, 72H, 69H, 70H, 68H, 65H, 72H, 61H
        DC8 6CH, 5FH, 4BH, 4CH, 78H, 5CH, 75H, 61H
        DC8 72H, 74H, 5CH, 74H, 65H, 73H, 74H, 5CH
        DC8 73H, 75H, 69H, 74H, 65H, 31H, 5CH, 73H
        DC8 72H, 63H, 5CH, 78H, 75H, 61H, 72H, 74H
        DC8 74H, 65H, 73H, 74H, 30H, 33H, 2EH, 63H
        DC8 0
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "\\r\\nLINE\\t:%d\\r\\n">`:
        DATA
        DC8 "\015\012LINE\t:%d\015\012"
        DC8 0, 0, 0
//  126 
//  127 //
//  128 // xuart Config test case struct.
//  129 //

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
//  130 const tTestCase sTestxuart0301 = {
sTestxuart0301:
        DATA
        DC32 xuart0301GetTest, xuart0301Setup, xuart0301TearDown
        DC32 xuart0301Execute
//  131     xuart0301GetTest,
//  132     xuart0301Setup,
//  133     xuart0301TearDown,
//  134     xuart0301Execute
//  135 };
//  136 
//  137 //
//  138 // xuart test suits.
//  139 //

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
//  140 const tTestCase * const psPatternxUART03[] =
psPatternxUART03:
        DATA
        DC32 sTestxuart0301, 0H

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  141 {
//  142     &sTestxuart0301,
//  143     0
//  144 };
//  145 
//  146 
//  147 
//  148 
//  149 
//  150 
//  151 
//  152 
// 
// 308 bytes in section .rodata
// 184 bytes in section .text
// 
// 184 bytes of CODE  memory
// 308 bytes of CONST memory
//
//Errors: none
//Warnings: none
