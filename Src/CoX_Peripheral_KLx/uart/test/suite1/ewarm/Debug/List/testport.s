///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.40.1.53790/W32 for ARM    24/Feb/2013  09:52:11 /
// Copyright 1999-2012 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  C:\Users\renjun\Desktop\Cox\CoX_Peripheral\CoX_Peripher /
//                    al_KLx\testframe\testport.c                             /
//    Command line =  C:\Users\renjun\Desktop\Cox\CoX_Peripheral\CoX_Peripher /
//                    al_KLx\testframe\testport.c -D ewarm -lCN               /
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
//                    al_KLx\uart\test\suite1\ewarm\Debug\List\testport.s     /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME testport

        #define SHT_PROGBITS 0x1

        EXTERN SysCtlBusClkGet
        EXTERN __aeabi_uidiv
        EXTERN xCPUcpsid
        EXTERN xCPUcpsie
        EXTERN xSysCtlClockSet

        PUBLIC TestDisableIRQ
        PUBLIC TestEnableIRQ
        PUBLIC TestIOInit
        PUBLIC TestIOPut
        PUBLIC tmp

// C:\Users\renjun\Desktop\Cox\CoX_Peripheral\CoX_Peripheral_KLx\testframe\testport.c
//    1 #include "test.h"
//    2 
//    3 #define _PORTC_PCR3             (0x4004B00C)
//    4 #define _PORTC_PCR4             (0x4004B010)
//    5 
//    6 #define UART_DIV                16UL
//    7 #define UART_BAUD               115200UL
//    8 
//    9 
//   10 //*****************************************************************************
//   11 //
//   12 //! \brief Init uart to print.
//   13 //!
//   14 //! \param None
//   15 //!
//   16 //! \details uart config as (115200, 8 data bit, 1 stop bit , no partiy)
//   17 //!
//   18 //! \return None.
//   19 //
//   20 //*****************************************************************************

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   21 unsigned long tmp = 0;
tmp:
        DS8 4
//   22 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   23 void 
//   24 TestIOInit(void)
//   25 {
TestIOInit:
        PUSH     {R4-R6,LR}
//   26     unsigned long ulBaud     = 0;
        MOVS     R5,#+0
//   27     unsigned long ulTmpReg   = 0;
        MOVS     R4,#+0
//   28     unsigned long ulBusClock = 0;
        MOVS     R6,#+0
//   29 
//   30     //
//   31     // Configure System clock
//   32     //
//   33     xSysCtlClockSet(48000000, xSYSCTL_OSC_MAIN | xSYSCTL_XTAL_8MHZ);
        MOVS     R1,#+136
        LSLS     R1,R1,#+4        ;; #+2176
        LDR      R0,??DataTable1  ;; 0x2dc6c00
        BL       xSysCtlClockSet
//   34 
//   35     //
//   36     // Get Bus Clock
//   37     //
//   38     ulBusClock = SysCtlBusClkGet();
        BL       SysCtlBusClkGet
        MOVS     R6,R0
//   39 
//   40     //
//   41     // Enable GPIO/UART Clock
//   42     //
//   43     
//   44     xHWREG(SIM_SCGC5) |= SIM_SCGC5_PORTC_EN;    
        LDR      R0,??DataTable1_1  ;; 0x40048038
        LDR      R0,[R0, #+0]
        MOVS     R1,#+128
        LSLS     R1,R1,#+4        ;; #+2048
        ORRS     R1,R1,R0
        LDR      R0,??DataTable1_1  ;; 0x40048038
        STR      R1,[R0, #+0]
//   45     xHWREG(SIM_SCGC4) |= SIM_SCGC4_UART1_EN;
        LDR      R0,??DataTable1_2  ;; 0x40048034
        LDR      R0,[R0, #+0]
        MOVS     R1,#+128
        LSLS     R1,R1,#+4        ;; #+2048
        ORRS     R1,R1,R0
        LDR      R0,??DataTable1_2  ;; 0x40048034
        STR      R1,[R0, #+0]
//   46     
//   47 
//   48     
//   49 
//   50     //
//   51     // Remap UART pin to GPIO Port
//   52     //
//   53     
//   54     // UART1_RX --> PC3
//   55     ulTmpReg = xHWREG(_PORTC_PCR3);
        LDR      R0,??DataTable1_3  ;; 0x4004b00c
        LDR      R0,[R0, #+0]
        MOVS     R4,R0
//   56     ulTmpReg &= ~(PORT_PCR_PIN_MUX_M);
        MOVS     R0,R4
        LDR      R4,??DataTable1_4  ;; 0xfffff8ff
        ANDS     R4,R4,R0
//   57     ulTmpReg |= PORT_PCR_PIN_ALT3;
        MOVS     R0,R4
        MOVS     R4,#+192
        LSLS     R4,R4,#+2        ;; #+768
        ORRS     R4,R4,R0
//   58     xHWREG(_PORTC_PCR3) = ulTmpReg;
        LDR      R0,??DataTable1_3  ;; 0x4004b00c
        STR      R4,[R0, #+0]
//   59 
//   60     
//   61     
//   62 
//   63     // UART1_TX --> PC4
//   64     ulTmpReg = xHWREG(_PORTC_PCR4);
        LDR      R0,??DataTable1_5  ;; 0x4004b010
        LDR      R0,[R0, #+0]
        MOVS     R4,R0
//   65     ulTmpReg &= ~(PORT_PCR_PIN_MUX_M);
        MOVS     R0,R4
        LDR      R4,??DataTable1_4  ;; 0xfffff8ff
        ANDS     R4,R4,R0
//   66     ulTmpReg |= PORT_PCR_PIN_ALT3;
        MOVS     R0,R4
        MOVS     R4,#+192
        LSLS     R4,R4,#+2        ;; #+768
        ORRS     R4,R4,R0
//   67     xHWREG(_PORTC_PCR4) = ulTmpReg;
        LDR      R0,??DataTable1_5  ;; 0x4004b010
        STR      R4,[R0, #+0]
//   68 
//   69    
//   70     
//   71     //
//   72     // Disable UART Receive/Transmit
//   73     //
//   74     xHWREGB(UART1_BASE + UART_012_C2) &= (unsigned char)(~UART_012_C2_TE_MASK);
        LDR      R0,??DataTable1_6  ;; 0x4006b003
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+247
        ANDS     R1,R1,R0
        LDR      R0,??DataTable1_6  ;; 0x4006b003
        STRB     R1,[R0, #+0]
//   75     xHWREGB(UART1_BASE + UART_012_C2) &= (unsigned char)(~UART_012_C2_RE_MASK);
        LDR      R0,??DataTable1_6  ;; 0x4006b003
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+251
        ANDS     R1,R1,R0
        LDR      R0,??DataTable1_6  ;; 0x4006b003
        STRB     R1,[R0, #+0]
//   76 
//   77     //
//   78     // Configure UART1 to 8-N-1
//   79     // Set register to default value
//   80     xHWREGB(UART1_BASE + UART_012_C1) = (unsigned char)(0x00);
        LDR      R0,??DataTable1_7  ;; 0x4006b002
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//   81 
//   82     //
//   83     // Configure UART Baud 115200
//   84     //
//   85     ulBaud = ulBusClock/(UART_DIV*UART_BAUD);
        MOVS     R0,R6
        MOVS     R1,#+225
        LSLS     R1,R1,#+13       ;; #+1843200
        BL       __aeabi_uidiv
        MOVS     R5,R0
//   86 
//   87     xHWREGB(UART1_BASE + UART_012_BDH) &= (unsigned char)(~UART_012_BDH_SBR_MASK);
        LDR      R0,??DataTable1_8  ;; 0x4006b000
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+224
        ANDS     R1,R1,R0
        LDR      R0,??DataTable1_8  ;; 0x4006b000
        STRB     R1,[R0, #+0]
//   88     xHWREGB(UART1_BASE + UART_012_BDH) |= 
//   89                         (unsigned char)((ulBaud >> 8) & UART_012_BDH_SBR_MASK);
        LDR      R0,??DataTable1_8  ;; 0x4006b000
        LDRB     R0,[R0, #+0]
        MOVS     R1,R5
        LSRS     R1,R1,#+8
        LSLS     R1,R1,#+27       ;; ZeroExtS R1,R1,#+27,#+27
        LSRS     R1,R1,#+27
        ORRS     R1,R1,R0
        LDR      R0,??DataTable1_8  ;; 0x4006b000
        STRB     R1,[R0, #+0]
//   90 
//   91     xHWREGB(UART1_BASE + UART_012_BDL) = (unsigned char)(ulBaud);
        LDR      R0,??DataTable1_9  ;; 0x4006b001
        MOVS     R1,R5
        STRB     R1,[R0, #+0]
//   92  
//   93     tmp = xHWREGB(UART1_BASE + UART_012_BDH);
        LDR      R0,??DataTable1_10
        LDR      R1,??DataTable1_8  ;; 0x4006b000
        LDRB     R1,[R1, #+0]
        UXTB     R1,R1
        STR      R1,[R0, #+0]
//   94     tmp = xHWREGB(UART1_BASE + UART_012_BDL);
        LDR      R0,??DataTable1_10
        LDR      R1,??DataTable1_9  ;; 0x4006b001
        LDRB     R1,[R1, #+0]
        UXTB     R1,R1
        STR      R1,[R0, #+0]
//   95     
//   96     //
//   97     // Enable UART Receive/Transmit
//   98     //
//   99     xHWREGB(UART1_BASE + UART_012_C2) |= (unsigned char)(UART_012_C2_TE_MASK);
        LDR      R0,??DataTable1_6  ;; 0x4006b003
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+8
        ORRS     R1,R1,R0
        LDR      R0,??DataTable1_6  ;; 0x4006b003
        STRB     R1,[R0, #+0]
//  100     xHWREGB(UART1_BASE + UART_012_C2) |= (unsigned char)(UART_012_C2_RE_MASK);
        LDR      R0,??DataTable1_6  ;; 0x4006b003
        LDRB     R0,[R0, #+0]
        MOVS     R1,#+4
        ORRS     R1,R1,R0
        LDR      R0,??DataTable1_6  ;; 0x4006b003
        STRB     R1,[R0, #+0]
//  101 
//  102 }
        POP      {R4-R6,PC}       ;; return
//  103 
//  104 //*****************************************************************************
//  105 //
//  106 //! \brief print a char.
//  107 //!
//  108 //! \param None
//  109 //!
//  110 //! \return None.
//  111 //
//  112 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  113 void 
//  114 TestIOPut(char ch)
//  115 {
TestIOPut:
        PUSH     {R7,LR}
//  116     volatile unsigned char ulStatus = 0;
        MOV      R1,SP
        MOVS     R2,#+0
        STRB     R2,[R1, #+0]
//  117 
//  118     //
//  119     // Wait until transmit register availavle
//  120     //
//  121     do
//  122     {
//  123         ulStatus = xHWREGB(UART1_BASE + UART_012_S1) &
//  124                    ((unsigned char) UART_012_S1_TDRE_MASK);
??TestIOPut_0:
        LDR      R1,??DataTable1_11  ;; 0x4006b004
        LDRB     R1,[R1, #+0]
        MOVS     R2,#+128
        ANDS     R1,R1,R2
        MOV      R2,SP
        STRB     R1,[R2, #+0]
//  125     }while(0 == ulStatus);
        MOV      R1,SP
        LDRB     R1,[R1, #+0]
        CMP      R1,#+0
        BEQ      ??TestIOPut_0
//  126 
//  127     //
//  128     // Send the char
//  129     //
//  130     xHWREGB(UART1_BASE + UART_012_D) = ch;
        LDR      R1,??DataTable1_12  ;; 0x4006b007
        STRB     R0,[R1, #+0]
//  131 
//  132 }
        POP      {R0,PC}          ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1:
        DC32     0x2dc6c00

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_1:
        DC32     0x40048038

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_2:
        DC32     0x40048034

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_3:
        DC32     0x4004b00c

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_4:
        DC32     0xfffff8ff

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_5:
        DC32     0x4004b010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_6:
        DC32     0x4006b003

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_7:
        DC32     0x4006b002

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_8:
        DC32     0x4006b000

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_9:
        DC32     0x4006b001

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_10:
        DC32     tmp

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_11:
        DC32     0x4006b004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_12:
        DC32     0x4006b007
//  133 
//  134 //*****************************************************************************
//  135 //
//  136 //! \brief Enable IRQ.
//  137 //!
//  138 //! \param None
//  139 //!
//  140 //! \return None.
//  141 //
//  142 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  143 void TestEnableIRQ(void)
//  144 {
TestEnableIRQ:
        PUSH     {R7,LR}
//  145     xCPUcpsie();
        BL       xCPUcpsie
//  146 }
        POP      {R0,PC}          ;; return
//  147 
//  148 //*****************************************************************************
//  149 //
//  150 //! \brief Disable IRQ.
//  151 //!
//  152 //! \param None
//  153 //!
//  154 //! \return None.
//  155 //
//  156 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  157 void TestDisableIRQ(void)
//  158 {
TestDisableIRQ:
        PUSH     {R7,LR}
//  159     xCPUcpsid();
        BL       xCPUcpsid
//  160 }
        POP      {R0,PC}          ;; return

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//  161 
//  162 //*****************************************************************************
//  163 //
//  164 // The error routine that is called if the driver library encounters an error.(COX)
//  165 //
//  166 //*****************************************************************************
//  167 #ifdef xDEBUG
//  168 void
//  169 __xerror__(char *pcFilename, unsigned long ulLine)
//  170 {
//  171     while(1);
//  172 }
//  173 #endif
//  174 
// 
//   4 bytes in section .bss
// 326 bytes in section .text
// 
// 326 bytes of CODE memory
//   4 bytes of DATA memory
//
//Errors: none
//Warnings: none
