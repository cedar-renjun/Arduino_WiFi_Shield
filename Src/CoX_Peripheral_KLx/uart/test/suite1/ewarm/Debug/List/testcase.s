///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.40.1.53790/W32 for ARM    24/Feb/2013  09:52:12 /
// Copyright 1999-2012 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  C:\Users\renjun\Desktop\Cox\CoX_Peripheral\CoX_Peripher /
//                    al_KLx\uart\test\suite1\src\testcase.c                  /
//    Command line =  C:\Users\renjun\Desktop\Cox\CoX_Peripheral\CoX_Peripher /
//                    al_KLx\uart\test\suite1\src\testcase.c -D ewarm -lCN    /
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
//                    al_KLx\uart\test\suite1\ewarm\Debug\List\testcase.s     /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME testcase

        #define SHT_PROGBITS 0x1

        EXTERN psPatternxUART03

        PUBLIC g_psPatterns

// C:\Users\renjun\Desktop\Cox\CoX_Peripheral\CoX_Peripheral_KLx\uart\test\suite1\src\testcase.c
//    1 //*****************************************************************************
//    2 //
//    3 //! \file testcase.c
//    4 //! \brief add new testcases.
//    5 //! \version 1.0
//    6 //! \date 8/21/2012
//    7 //! \author CooCox
//    8 //! \copy
//    9 //!
//   10 //! Copyright (c) 2009-2012 CooCox.  All rights reserved.
//   11 //
//   12 //*****************************************************************************
//   13 
//   14 #include "test.h"
//   15 #include "testcase.h"
//   16 
//   17 //*****************************************************************************
//   18 //
//   19 // Array of all the test.
//   20 //
//   21 //*****************************************************************************

        SECTION `.data`:DATA:REORDER:NOROOT(2)
//   22 const tTestCase * const* g_psPatterns[] =  {
g_psPatterns:
        DATA
        DC32 psPatternxUART03, 0H

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
//   23     //
//   24     // UART test
//   25     //
//   26     //psPatternxUART01,
//   27     //psPatternxUART02,
//   28     psPatternxUART03,
//   29     //
//   30     // end
//   31     //
//   32     0
//   33 };
//   34 
//   35 
// 
// 8 bytes in section .data
// 
// 8 bytes of DATA memory
//
//Errors: none
//Warnings: none
