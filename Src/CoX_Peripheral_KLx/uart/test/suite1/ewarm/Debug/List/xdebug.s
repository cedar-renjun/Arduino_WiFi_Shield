///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.40.1.53790/W32 for ARM    24/Feb/2013  09:52:13 /
// Copyright 1999-2012 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  C:\Users\renjun\Desktop\Cox\CoX_Peripheral\CoX_Peripher /
//                    al_KLx\libcox\xdebug.c                                  /
//    Command line =  C:\Users\renjun\Desktop\Cox\CoX_Peripheral\CoX_Peripher /
//                    al_KLx\libcox\xdebug.c -D ewarm -lCN                    /
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
//                    al_KLx\uart\test\suite1\ewarm\Debug\List\xdebug.s       /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME xdebug

        #define SHT_PROGBITS 0x1



        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        END
// C:\Users\renjun\Desktop\Cox\CoX_Peripheral\CoX_Peripheral_KLx\libcox\xdebug.c
//    1 //*****************************************************************************
//    2 //
//    3 //! \file xdebug.h
//    4 //! \brief Drivers for assisting debug of the peripheral library.
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
//   39 
//   40 //*****************************************************************************
//   41 //
//   42 //! \brief Error Function to be called when assert runs false.
//   43 //!
//   44 //! \param pcFilename is the current file name.
//   45 //! \param ulLine is the current line number.
//   46 //!
//   47 //! This is just an default error handler function, Users should implement 
//   48 //! this function with your own way when debug. 
//   49 //!
//   50 //! \note This is only used when doing a \b xDEBUG build. 
//   51 //!
//   52 //! \return None.
//   53 //
//   54 //*****************************************************************************
//   55 #ifdef xDEBUG
//   56 void __xerror__(char *pcFilename, unsigned long ulLine)
//   57 {
//   58     //
//   59     // Add your own error handling 
//   60     //
//   61     while(1)
//   62     {
//   63 
//   64     }
//   65 }
//   66 #endif
// 
//
// 
//
//
//Errors: none
//Warnings: none
