///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.40.1.53790/W32 for ARM    24/Feb/2013  09:54:13 /
// Copyright 1999-2012 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  C:\Users\renjun\Desktop\Cox\CoX_Peripheral\CoX_Peripher /
//                    al_KLx\testframe\main.c                                 /
//    Command line =  C:\Users\renjun\Desktop\Cox\CoX_Peripheral\CoX_Peripher /
//                    al_KLx\testframe\main.c -D ewarm -lCN                   /
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
//                    al_KLx\uart\test\suite1\ewarm\Debug\List\main.s         /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME main

        #define SHT_PROGBITS 0x1

        EXTERN TestMain

        PUBLIC main

// C:\Users\renjun\Desktop\Cox\CoX_Peripheral\CoX_Peripheral_KLx\testframe\main.c
//    1 //*****************************************************************************
//    2 //
//    3 //! \file main.c
//    4 //! \brief Test main.
//    5 //! \version 1.0
//    6 //! \date 5/17/2011
//    7 //! \author CooCox
//    8 //! \copy
//    9 //!
//   10 //! Copyright (c) 2009-2011 CooCox.  All rights reserved.
//   11 //
//   12 //*****************************************************************************
//   13 
//   14 #include "test.h"
//   15 
//   16 #pragma section = ".data"
//   17 #pragma section = ".data_init"
//   18 #pragma section = ".bss"
//   19 #pragma section = "CodeRelocate"
//   20 #pragma section = "CodeRelocateRam" 
//   21 
//   22 #if 0
//   23 void
//   24 common_startup(void)
//   25 {
//   26 //    extern char __DATA_ROM[];
//   27 //    extern char __DATA_RAM[];
//   28 //    extern char __DATA_END[];
//   29   
//   30     /* Declare a counter we'll use in all of the copy loops */
//   31     unsigned long n;
//   32  
//   33  
//   34     /* Addresses for VECTOR_TABLE and VECTOR_RAM come from the linker file */  
//   35     extern unsigned long __VECTOR_TABLE[];
//   36     extern unsigned long __VECTOR_RAM[];
//   37 
//   38     /* Copy the vector table to RAM */
//   39     if (__VECTOR_RAM != __VECTOR_TABLE)
//   40     {
//   41         for (n = 0; n < 0x410; n++)
//   42             __VECTOR_RAM[n] = __VECTOR_TABLE[n];
//   43     }
//   44     /* Point the VTOR to the new copy of the vector table */
//   45     xHWREG(0xE000ED08) = ((unsigned long)__VECTOR_RAM);    
//   46     
//   47     /* Get the addresses for the .data section (initialized data section) */
//   48     unsigned char* data_ram = __section_begin(".data");
//   49     unsigned char* data_rom = __section_begin(".data_init");
//   50     unsigned char* data_rom_end = __section_end(".data_init");
//   51     
//   52     /* Copy initialized data from ROM to RAM */
//   53     n = data_rom_end - data_rom;
//   54     while (n--)
//   55       *data_ram++ = *data_rom++;
//   56  
//   57  
//   58     /* Get the addresses for the .bss section (zero-initialized data) */
//   59     unsigned char* bss_start = __section_begin(".bss");
//   60     unsigned char* bss_end = __section_end(".bss");
//   61     
//   62     /* Clear the zero-initialized data section */
//   63     n = bss_end - bss_start;
//   64     while(n--)
//   65       *bss_start++ = 0;    
//   66     
//   67     /* Get addresses for any code sections that need to be copied from ROM to RAM.
//   68      * The IAR tools have a predefined keyword that can be used to mark individual
//   69      * functions for execution from RAM. Add "__ramfunc" before the return type in
//   70      * the function prototype for any routines you need to execute from RAM instead 
//   71      * of ROM. ex: __ramfunc void foo(void);
//   72      */
//   73     unsigned char* code_relocate_ram = __section_begin("CodeRelocateRam");
//   74     unsigned char* code_relocate = __section_begin("CodeRelocate");
//   75     unsigned char* code_relocate_end = __section_end("CodeRelocate");
//   76     
//   77     /* Copy functions from ROM to RAM */
//   78     n = code_relocate_end - code_relocate;
//   79     while (n--)
//   80       *code_relocate_ram++ = *code_relocate++;
//   81 }
//   82 #endif
//   83 
//   84 

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//   85 int main(void)
//   86 {
//   87     //
//   88     // Do the main test
//   89     //
//   90     (*((volatile unsigned long *)(0x40048100))) = 0x00;
main:
        LDR      R0,??main_0      ;; 0x40048100
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//   91     //common_startup();
//   92     TestMain();
        BL       TestMain
//   93 
//   94     while(1)
??main_1:
        B        ??main_1
        DATA
??main_0:
        DC32     0x40048100
//   95     {
//   96       //xHWREG(SIM_SRVCOP) = 0x55;
//   97       //xHWREG(SIM_SRVCOP) = 0xAA;
//   98     }
//   99 }

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION `.data`:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION `.data_init`:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION CodeRelocate:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION CodeRelocateRam:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
// 
// 16 bytes in section .text
// 
// 16 bytes of CODE memory
//
//Errors: none
//Warnings: none
