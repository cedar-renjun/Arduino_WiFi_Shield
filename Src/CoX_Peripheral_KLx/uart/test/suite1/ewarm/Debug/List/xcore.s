///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.40.1.53790/W32 for ARM    24/Feb/2013  09:52:13 /
// Copyright 1999-2012 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  C:\Users\renjun\Desktop\Cox\CoX_Peripheral\CoX_Peripher /
//                    al_KLx\libcox\xcore.c                                   /
//    Command line =  C:\Users\renjun\Desktop\Cox\CoX_Peripheral\CoX_Peripher /
//                    al_KLx\libcox\xcore.c -D ewarm -lCN                     /
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
//                    al_KLx\uart\test\suite1\ewarm\Debug\List\xcore.s        /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME xcore

        #define SHT_PROGBITS 0x1

        EXTERN __aeabi_uidivmod

        PUBLIC IntDefaultHandler
        PUBLIC xCPUbasepriGet
        PUBLIC xCPUbasepriSet
        PUBLIC xCPUcpsid
        PUBLIC xCPUcpsie
        PUBLIC xCPUmspGet
        PUBLIC xCPUmspSet
        PUBLIC xCPUprimask
        PUBLIC xCPUpspGet
        PUBLIC xCPUpspSet
        PUBLIC xCPUwfi
        PUBLIC xIntDisable
        PUBLIC xIntEnable
        PUBLIC xIntMasterDisable
        PUBLIC xIntMasterEnable
        PUBLIC xIntPendClear
        PUBLIC xIntPendSet
        PUBLIC xIntPriorityGet
        PUBLIC xIntPriorityMaskGet
        PUBLIC xIntPriorityMaskSet
        PUBLIC xIntPrioritySet
        PUBLIC xPendSVPendClr
        PUBLIC xPendSVPendSet
        PUBLIC xSysTickDisable
        PUBLIC xSysTickEnable
        PUBLIC xSysTickIntDisable
        PUBLIC xSysTickIntEnable
        PUBLIC xSysTickPendClr
        PUBLIC xSysTickPendSet
        PUBLIC xSysTickPeriodGet
        PUBLIC xSysTickPeriodSet
        PUBLIC xSysTickValueGet

// C:\Users\renjun\Desktop\Cox\CoX_Peripheral\CoX_Peripheral_KLx\libcox\xcore.c
//    1 //*****************************************************************************
//    2 //
//    3 //! \file xcore.c
//    4 //! \brief Instruction wrappers for special CPU instructions.
//    5 //! Driver for the NVIC Interrupt Controller.
//    6 //! Driver for the SysTick driver.
//    7 //! \version V2.2.1.0
//    8 //! \date 7/31/2012
//    9 //! \author CooCox
//   10 //! \copy
//   11 //!
//   12 //! Copyright (c)  2011, CooCox 
//   13 //! All rights reserved.
//   14 //! 
//   15 //! Redistribution and use in source and binary forms, with or without 
//   16 //! modification, are permitted provided that the following conditions 
//   17 //! are met: 
//   18 //! 
//   19 //!     * Redistributions of source code must retain the above copyright 
//   20 //! notice, this list of conditions and the following disclaimer. 
//   21 //!     * Redistributions in binary form must reproduce the above copyright
//   22 //! notice, this list of conditions and the following disclaimer in the
//   23 //! documentation and/or other materials provided with the distribution. 
//   24 //!     * Neither the name of the <ORGANIZATION> nor the names of its 
//   25 //! contributors may be used to endorse or promote products derived 
//   26 //! from this software without specific prior written permission. 
//   27 //! 
//   28 //! THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//   29 //! AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
//   30 //! IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//   31 //! ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE 
//   32 //! LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
//   33 //! CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
//   34 //! SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//   35 //! INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
//   36 //! CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
//   37 //! ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF 
//   38 //! THE POSSIBILITY OF SUCH DAMAGE.
//   39 //
//   40 //*****************************************************************************
//   41 
//   42 #include "xhw_types.h"
//   43 #include "xhw_ints.h"
//   44 #include "xhw_memmap.h"
//   45 #include "xhw_nvic.h"
//   46 #include "xdebug.h"
//   47 #include "xcore.h"
//   48 
//   49 //*****************************************************************************
//   50 //
//   51 // This is a mapping between interrupt number and the register that contains
//   52 // the priority encoding for that interrupt.
//   53 //
//   54 //*****************************************************************************

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
//   55 static const unsigned long g_pulRegs[] =
g_pulRegs:
        DATA
        DC32 0, 0, 3758157084, 3758157088, 3758154752, 3758154756, 3758154760
        DC32 3758154764, 3758154768, 3758154772, 3758154776, 3758154780
        DC32 3758154784, 3758154788, 3758154792, 3758154796
//   56 {
//   57     0, 0, NVIC_SYS_PRI2, NVIC_SYS_PRI3, NVIC_PRI0, NVIC_PRI1,
//   58     NVIC_PRI2, NVIC_PRI3, NVIC_PRI4, NVIC_PRI5, NVIC_PRI6, NVIC_PRI7, 
//   59     NVIC_PRI8, NVIC_PRI9, NVIC_PRI10, NVIC_PRI11 
//   60    
//   61 };
//   62 
//   63 //*****************************************************************************
//   64 //
//   65 //! \brief The default interrupt handler.
//   66 //!
//   67 //! This is the default interrupt handler for all interrupts.  It simply loops
//   68 //! forever so that the system state is preserved for observation by a
//   69 //! debugger.  Since interrupts should be disabled before unregistering the
//   70 //! corresponding handler, this should never be called.
//   71 //!
//   72 //! \return None.
//   73 //
//   74 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   75 void
//   76 IntDefaultHandler(void)
//   77 {
//   78     //
//   79     // Go into an infinite loop.
//   80     //
//   81     while(1)
IntDefaultHandler:
??IntDefaultHandler_0:
        B        ??IntDefaultHandler_0
//   82     {
//   83     }
//   84 }
//   85 
//   86 //*****************************************************************************
//   87 //
//   88 // Wrapper function for the CPSID instruction. Returns the state of 
//   89 // PRIMASK on entry. 
//   90 //
//   91 //*****************************************************************************
//   92 #if defined(gcc) || defined(__GNUC__)
//   93 unsigned long __attribute__((naked))
//   94 xCPUcpsid(void)
//   95 {
//   96     unsigned long ulRet;
//   97 
//   98     //
//   99     // Read PRIMASK and disable interrupts.
//  100     //
//  101     __asm("    mrs     r0, PRIMASK\n"
//  102           "    cpsid   i\n"
//  103           "    bx      lr\n"
//  104           : "=r" (ulRet));
//  105 
//  106     //
//  107     // The return is handled in the inline assembly, but the compiler will
//  108     // still complain if there is not an explicit return here (despite the fact
//  109     // that this does not result in any code being produced because of the
//  110     // naked attribute).
//  111     //
//  112     return(ulRet);
//  113 }
//  114 #endif
//  115 #if defined(ewarm) || defined(__ICCARM__)

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  116 unsigned long
//  117 xCPUcpsid(void)
//  118 {
//  119     //
//  120     // Read PRIMASK and disable interrupts.
//  121     //
//  122     __asm("    mrs     r0, PRIMASK\n"
//  123           "    cpsid   i\n");
xCPUcpsid:
        mrs     r0, PRIMASK
        cpsid   i
//  124 
//  125     //
//  126     // "Warning[Pe940]: missing return statement at end of non-void function"
//  127     // is suppressed here to avoid putting a "bx lr" in the inline assembly
//  128     // above and a superfluous return statement here.
//  129     //
//  130 #pragma diag_suppress=Pe940
//  131 }
        BX       LR               ;; return
//  132 #pragma diag_default=Pe940
//  133 #endif
//  134 #if defined(rvmdk) || defined(__CC_ARM)
//  135 __asm unsigned long
//  136 xCPUcpsid(void)
//  137 {
//  138     //
//  139     // Read PRIMASK and disable interrupts.
//  140     //
//  141     mrs     r0, PRIMASK;
//  142     cpsid   i;
//  143     bx      lr
//  144 }
//  145 #endif
//  146 
//  147 //*****************************************************************************
//  148 //
//  149 // Wrapper function returning the state of PRIMASK (indicating whether
//  150 // interrupts are enabled or disabled).
//  151 //
//  152 //*****************************************************************************
//  153 #if defined(gcc) || defined(__GNUC__)
//  154 unsigned long __attribute__((naked))
//  155 xCPUprimask(void)
//  156 {
//  157     unsigned long ulRet;
//  158 
//  159     //
//  160     // Read PRIMASK and disable interrupts.
//  161     //
//  162     __asm("    mrs     r0, PRIMASK\n"
//  163           "    bx      lr\n"
//  164           : "=r" (ulRet));
//  165 
//  166     //
//  167     // The return is handled in the inline assembly, but the compiler will
//  168     // still complain if there is not an explicit return here (despite the fact
//  169     // that this does not result in any code being produced because of the
//  170     // naked attribute).
//  171     //
//  172     return(ulRet);
//  173 }
//  174 #endif
//  175 #if defined(ewarm) || defined(__ICCARM__)

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  176 unsigned long
//  177 xCPUprimask(void)
//  178 {
//  179     //
//  180     // Read PRIMASK and disable interrupts.
//  181     //
//  182     __asm("    mrs     r0, PRIMASK\n");
xCPUprimask:
        mrs     r0, PRIMASK
//  183 
//  184     //
//  185     // "Warning[Pe940]: missing return statement at end of non-void function"
//  186     // is suppressed here to avoid putting a "bx lr" in the inline assembly
//  187     // above and a superfluous return statement here.
//  188     //
//  189 #pragma diag_suppress=Pe940
//  190 }
        BX       LR               ;; return
//  191 #pragma diag_default=Pe940
//  192 #endif
//  193 #if defined(rvmdk) || defined(__CC_ARM)
//  194 __asm unsigned long
//  195 xCPUprimask(void)
//  196 {
//  197     //
//  198     // Read PRIMASK and disable interrupts.
//  199     //
//  200     mrs     r0, PRIMASK;
//  201     bx      lr
//  202 }
//  203 #endif
//  204 
//  205 //*****************************************************************************
//  206 //
//  207 // Wrapper function for the CPSIE instruction.  Returns the state of PRIMASK
//  208 // on entry.
//  209 //
//  210 //*****************************************************************************
//  211 #if defined(gcc) || defined(__GNUC__)
//  212 unsigned long __attribute__((naked))
//  213 xCPUcpsie(void)
//  214 {
//  215     unsigned long ulRet;
//  216 
//  217     //
//  218     // Read PRIMASK and enable interrupts.
//  219     //
//  220     __asm("    mrs     r0, PRIMASK\n"
//  221           "    cpsie   i\n"
//  222           "    bx      lr\n"
//  223           : "=r" (ulRet));
//  224 
//  225     //
//  226     // The return is handled in the inline assembly, but the compiler will
//  227     // still complain if there is not an explicit return here (despite the fact
//  228     // that this does not result in any code being produced because of the
//  229     // naked attribute).
//  230     //
//  231     return(ulRet);
//  232 }
//  233 #endif
//  234 #if defined(ewarm) || defined(__ICCARM__)

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  235 unsigned long
//  236 xCPUcpsie(void)
//  237 {
//  238     //
//  239     // Read PRIMASK and enable interrupts.
//  240     //
//  241     __asm("    mrs     r0, PRIMASK\n"
//  242           "    cpsie   i\n");
xCPUcpsie:
        mrs     r0, PRIMASK
        cpsie   i
//  243 
//  244     //
//  245     // "Warning[Pe940]: missing return statement at end of non-void function"
//  246     // is suppressed here to avoid putting a "bx lr" in the inline assembly
//  247     // above and a superfluous return statement here.
//  248     //
//  249 #pragma diag_suppress=Pe940
//  250 }
        BX       LR               ;; return
//  251 #pragma diag_default=Pe940
//  252 #endif
//  253 #if defined(rvmdk) || defined(__CC_ARM)
//  254 __asm unsigned long
//  255 xCPUcpsie(void)
//  256 {
//  257     //
//  258     // Read PRIMASK and enable interrupts.
//  259     //
//  260     mrs     r0, PRIMASK;
//  261     cpsie   i;
//  262     bx      lr
//  263 }
//  264 #endif
//  265 
//  266 //*****************************************************************************
//  267 //
//  268 // Wrapper function for the WFI instruction.
//  269 //
//  270 //*****************************************************************************
//  271 #if defined(gcc) || defined(__GNUC__)
//  272 void __attribute__((naked))
//  273 xCPUwfi(void)
//  274 {
//  275     //
//  276     // Wait for the next interrupt.
//  277     //
//  278     __asm("    wfi\n"
//  279           "    bx      lr\n");
//  280 }
//  281 #endif
//  282 #if defined(ewarm) || defined(__ICCARM__)

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  283 void
//  284 xCPUwfi(void)
//  285 {
//  286     //
//  287     // Wait for the next interrupt.
//  288     //
//  289     __asm("    wfi\n");
xCPUwfi:
        wfi
//  290 }
        BX       LR               ;; return
//  291 #endif
//  292 #if defined(rvmdk) || defined(__CC_ARM)
//  293 __asm void
//  294 xCPUwfi(void)
//  295 {
//  296     //
//  297     // Wait for the next interrupt.
//  298     //
//  299     wfi;
//  300     bx      lr
//  301 }
//  302 #endif
//  303 
//  304 //*****************************************************************************
//  305 //
//  306 // Wrapper function for writing the BASEPRI register.
//  307 //
//  308 //*****************************************************************************
//  309 #if defined(gcc) || defined(__GNUC__)
//  310 void __attribute__((naked))
//  311 xCPUbasepriSet(unsigned long ulNewBasepri)
//  312 {
//  313 
//  314     //
//  315     // Set the BASEPRI register
//  316     //
//  317     __asm("    msr     BASEPRI, r0\n"
//  318           "    bx      lr\n");
//  319 }
//  320 #endif
//  321 #if defined(ewarm) || defined(__ICCARM__)

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  322 void
//  323 xCPUbasepriSet(unsigned long ulNewBasepri)
//  324 {
//  325     //
//  326     // Set the BASEPRI register
//  327     //
//  328 //    __asm("    msr     BASEPRI, r0\n");
//  329 }
xCPUbasepriSet:
        BX       LR               ;; return
//  330 #endif
//  331 #if defined(rvmdk) || defined(__CC_ARM)
//  332 __asm void
//  333 xCPUbasepriSet(unsigned long ulNewBasepri)
//  334 {
//  335     //
//  336     // Set the BASEPRI register
//  337     //
//  338 //    msr     BASEPRI, r0;
//  339 //    bx      lr
//  340 }
//  341 #endif
//  342 
//  343 //*****************************************************************************
//  344 //
//  345 // Wrapper function for reading the BASEPRI register.
//  346 //
//  347 //*****************************************************************************
//  348 #if defined(gcc) || defined(__GNUC__)
//  349 unsigned long __attribute__((naked))
//  350 xCPUbasepriGet(void)
//  351 {
//  352     unsigned long ulRet;
//  353 
//  354     //
//  355     // Read BASEPRI
//  356     //
//  357     __asm("    mrs     r0, BASEPRI\n"
//  358           "    bx      lr\n"
//  359           : "=r" (ulRet));
//  360 
//  361     //
//  362     // The return is handled in the inline assembly, but the compiler will
//  363     // still complain if there is not an explicit return here (despite the fact
//  364     // that this does not result in any code being produced because of the
//  365     // naked attribute).
//  366     //
//  367     return(ulRet);
//  368 }
//  369 #endif
//  370 #if defined(ewarm) || defined(__ICCARM__)

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  371 unsigned long
//  372 xCPUbasepriGet(void)
//  373 {
//  374     //
//  375     // Read BASEPRI
//  376     //
//  377  //   __asm("    mrs     r0, BASEPRI\n");
//  378 
//  379     //
//  380     // "Warning[Pe940]: missing return statement at end of non-void function"
//  381     // is suppressed here to avoid putting a "bx lr" in the inline assembly
//  382     // above and a superfluous return statement here.
//  383     //
//  384 #pragma diag_suppress=Pe940
//  385 }
xCPUbasepriGet:
        BX       LR               ;; return
//  386 #pragma diag_default=Pe940
//  387 #endif
//  388 #if defined(rvmdk) || defined(__CC_ARM)
//  389 __asm unsigned long
//  390 xCPUbasepriGet(void)
//  391 {
//  392     //
//  393     // Read BASEPRI
//  394     //
//  395 //    mrs     r0, BASEPRI;
//  396 //    bx      lr
//  397 }
//  398 #endif
//  399 
//  400 //*****************************************************************************
//  401 //
//  402 // Wrapper function for writing the PSP register.
//  403 //
//  404 //*****************************************************************************
//  405 #if defined(gcc) || defined(__GNUC__)
//  406 void __attribute__((naked))
//  407 xCPUpspSet(unsigned long ulNewPspStack)
//  408 {
//  409 
//  410     //
//  411     // Set the psp register
//  412     //
//  413     __asm("    msr     psp, r0\n"
//  414           "    bx      lr\n");
//  415 }
//  416 #endif
//  417 #if defined(ewarm) || defined(__ICCARM__)

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  418 void
//  419 xCPUpspSet(unsigned long ulNewPspStack)
//  420 {
//  421     //
//  422     // Set the psp register
//  423     //
//  424     __asm("    msr     psp, r0\n");
xCPUpspSet:
        msr     psp, r0
//  425 }
        BX       LR               ;; return
//  426 #endif
//  427 #if defined(rvmdk) || defined(__CC_ARM)
//  428 __asm void
//  429 xCPUpspSet(unsigned long ulNewPspStack)
//  430 {
//  431     //
//  432     // Set the psp register
//  433     //
//  434     msr psp, r0
//  435     bx lr
//  436 }
//  437 #endif
//  438 
//  439 //*****************************************************************************
//  440 //
//  441 // Wrapper function for reading the psp register.
//  442 //
//  443 //*****************************************************************************
//  444 #if defined(gcc) || defined(__GNUC__)
//  445 unsigned long __attribute__((naked))
//  446 xCPUpspGet(void)
//  447 {
//  448     unsigned long ulRet;
//  449 
//  450     //
//  451     // Read psp
//  452     //
//  453     __asm("    mrs     r0, psp\n"
//  454           "    bx      lr\n"
//  455           : "=r" (ulRet));
//  456 
//  457     //
//  458     // The return is handled in the inline assembly, but the compiler will
//  459     // still complain if there is not an explicit return here (despite the fact
//  460     // that this does not result in any code being produced because of the
//  461     // naked attribute).
//  462     //
//  463     return(ulRet);
//  464 }
//  465 #endif
//  466 #if defined(ewarm) || defined(__ICCARM__)

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  467 unsigned long
//  468 xCPUpspGet(void)
//  469 {
//  470     //
//  471     // Read psp
//  472     //
//  473     __asm("    mrs     r0, psp\n");
xCPUpspGet:
        mrs     r0, psp
//  474 
//  475     //
//  476     // "Warning[Pe940]: missing return statement at end of non-void function"
//  477     // is suppressed here to avoid putting a "bx lr" in the inline assembly
//  478     // above and a superfluous return statement here.
//  479     //
//  480 #pragma diag_suppress=Pe940
//  481 }
        BX       LR               ;; return
//  482 #pragma diag_default=Pe940
//  483 #endif
//  484 #if defined(rvmdk) || defined(__CC_ARM)
//  485 __asm unsigned long
//  486 xCPUpspGet(void)
//  487 {
//  488     //
//  489     // Read psp
//  490     //
//  491     mrs     r0, psp;
//  492     bx      lr
//  493 }
//  494 #endif
//  495 
//  496 //*****************************************************************************
//  497 //
//  498 // Wrapper function for writing the msp register.
//  499 //
//  500 //*****************************************************************************
//  501 #if defined(gcc) || defined(__GNUC__)
//  502 void __attribute__((naked))
//  503 xCPUmspSet(unsigned long ulNewmspStack)
//  504 {
//  505 
//  506     //
//  507     // Set the msp register
//  508     //
//  509     __asm("    msr     msp, r0\n"
//  510           "    bx      lr\n");
//  511 }
//  512 #endif
//  513 #if defined(ewarm) || defined(__ICCARM__)

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  514 void
//  515 xCPUmspSet(unsigned long ulNewmspStack)
//  516 {
//  517     //
//  518     // Set the msp register
//  519     //
//  520     __asm("    msr     msp, r0\n");
xCPUmspSet:
        msr     msp, r0
//  521 }
        BX       LR               ;; return
//  522 #endif
//  523 #if defined(rvmdk) || defined(__CC_ARM)
//  524 __asm void
//  525 xCPUmspSet(unsigned long ulNewmspStack)
//  526 {
//  527     //
//  528     // Set the msp register
//  529     //
//  530     msr msp, r0
//  531     bx lr
//  532 }
//  533 #endif
//  534 
//  535 //*****************************************************************************
//  536 //
//  537 // Wrapper function for reading the msp register.
//  538 //
//  539 //*****************************************************************************
//  540 #if defined(gcc) || defined(__GNUC__)
//  541 unsigned long __attribute__((naked))
//  542 xCPUmspGet(void)
//  543 {
//  544     unsigned long ulRet;
//  545 
//  546     //
//  547     // Read msp
//  548     //
//  549     __asm("    mrs     r0, msp\n"
//  550           "    bx      lr\n"
//  551           : "=r" (ulRet));
//  552 
//  553     //
//  554     // The return is handled in the inline assembly, but the compiler will
//  555     // still complain if there is not an explicit return here (despite the fact
//  556     // that this does not result in any code being produced because of the
//  557     // naked attribute).
//  558     //
//  559     return(ulRet);
//  560 }
//  561 #endif
//  562 #if defined(ewarm) || defined(__ICCARM__)

        SECTION `.text`:CODE:NOROOT(2)
        THUMB
//  563 unsigned long
//  564 xCPUmspGet(void)
//  565 {
//  566     //
//  567     // Read msp
//  568     //
//  569     __asm("    mrs     r0, msp\n");
xCPUmspGet:
        mrs     r0, msp
//  570 
//  571     //
//  572     // "Warning[Pe940]: missing return statement at end of non-void function"
//  573     // is suppressed here to avoid putting a "bx lr" in the inline assembly
//  574     // above and a superfluous return statement here.
//  575     //
//  576 #pragma diag_suppress=Pe940
//  577 }
        BX       LR               ;; return
//  578 #pragma diag_default=Pe940
//  579 #endif
//  580 #if defined(rvmdk) || defined(__CC_ARM)
//  581 __asm unsigned long
//  582 xCPUmspGet(void)
//  583 {
//  584     //
//  585     // Read msp
//  586     //
//  587     mrs     r0, msp;
//  588     bx      lr
//  589 }
//  590 #endif
//  591 
//  592 
//  593 //*****************************************************************************
//  594 //
//  595 //! \brief Enables the processor interrupt.
//  596 //!
//  597 //! Allows the processor to respond to interrupts.  This does not affect the
//  598 //! set of interrupts enabled in the interrupt controller; it just gates the
//  599 //! single interrupt from the controller to the processor.
//  600 //!
//  601 //! \return Returns \b true if interrupts were disabled when the function was
//  602 //! called or \b false if they were initially enabled.
//  603 //
//  604 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  605 xtBoolean
//  606 xIntMasterEnable(void)
//  607 {
xIntMasterEnable:
        PUSH     {R7,LR}
//  608     //
//  609     // Enable processor interrupts.
//  610     //
//  611     return(xCPUcpsie());
        BL       xCPUcpsie
        UXTB     R0,R0
        POP      {R1,PC}          ;; return
//  612 }
//  613 
//  614 //*****************************************************************************
//  615 //
//  616 //! \brief Disables the processor interrupt.
//  617 //!
//  618 //! Prevents the processor from receiving interrupts.  This does not affect the
//  619 //! set of interrupts enabled in the interrupt controller; it just gates the
//  620 //! single interrupt from the controller to the processor.
//  621 //!
//  622 //! \return Returns \b true if interrupts were already disabled when the
//  623 //! function was called or \b false if they were initially enabled.
//  624 //
//  625 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  626 xtBoolean
//  627 xIntMasterDisable(void)
//  628 {
xIntMasterDisable:
        PUSH     {R7,LR}
//  629     //
//  630     // Disable processor interrupts.
//  631     //
//  632     return(xCPUcpsid());
        BL       xCPUcpsid
        UXTB     R0,R0
        POP      {R1,PC}          ;; return
//  633 }
//  634 
//  635 //*****************************************************************************
//  636 //
//  637 //! \brief Sets the priority of an interrupt.
//  638 //!
//  639 //! \param ulInterrupt specifies the interrupt in question.
//  640 //! \param ucPriority specifies the priority of the interrupt.
//  641 //!
//  642 //! This function is used to set the priority of an interrupt.  When multiple
//  643 //! interrupts are asserted simultaneously, the ones with the highest priority
//  644 //! are processed before the lower priority interrupts.  Smaller numbers
//  645 //! correspond to higher interrupt priorities; priority 0 is the highest
//  646 //! interrupt priority.
//  647 //!
//  648 //! The hardware priority mechanism will only look at the upper N bits of the
//  649 //! priority level (where N is 2 for the NUC1xx family), so any
//  650 //! prioritization must be performed in those bits.  The remaining bits can be
//  651 //! used to sub-prioritize the interrupt sources, and may be used by the
//  652 //! hardware priority mechanism on a future part.  This arrangement allows
//  653 //! priorities to migrate to different NVIC implementations without changing
//  654 //! the gross prioritization of the interrupts.
//  655 //!
//  656 //! \return None.
//  657 //
//  658 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  659 void
//  660 xIntPrioritySet(unsigned long ulInterrupt, unsigned char ucPriority)
//  661 {
xIntPrioritySet:
        PUSH     {R4,R5,LR}
//  662     unsigned long ulTemp;
//  663 
//  664     //
//  665     // Check the arguments.
//  666     //
//  667     xASSERT(((ulInterrupt >= 4) && (ulInterrupt < NUM_INTERRUPTS)) || 
//  668 	         (ulInterrupt == xINT_SYSCTL) || (ulInterrupt == xINT_RTC));
//  669 
//  670     //
//  671     // Set the interrupt priority.
//  672     //
//  673     if((ulInterrupt >= 4) && (ulInterrupt < NUM_INTERRUPTS))
        CMP      R0,#+4
        BCC      ??xIntPrioritySet_0
        CMP      R0,#+47
        BCS      ??xIntPrioritySet_0
//  674     {
//  675         ulTemp = xHWREG(g_pulRegs[ulInterrupt >> 2]);
        MOVS     R3,R0
        LSRS     R3,R3,#+2
        MOVS     R4,#+4
        MULS     R3,R4,R3
        LDR      R4,??DataTable4
        LDR      R3,[R4, R3]
        LDR      R3,[R3, #+0]
        MOVS     R2,R3
//  676         ulTemp &= ~(0xFF << (8 * (ulInterrupt & 3)));
        MOVS     R3,#+255
        MOVS     R4,R0
        LSLS     R4,R4,#+30       ;; ZeroExtS R4,R4,#+30,#+30
        LSRS     R4,R4,#+30
        MOVS     R5,#+8
        MULS     R4,R5,R4
        LSLS     R3,R3,R4
        BICS     R2,R2,R3
//  677         ulTemp |= ucPriority << (8 * (ulInterrupt & 3) + 6);
        MOVS     R4,R2
        UXTB     R1,R1
        LSLS     R3,R0,#+30       ;; ZeroExtS R3,R0,#+30,#+30
        LSRS     R3,R3,#+30
        MOVS     R2,#+8
        MULS     R3,R2,R3
        ADDS     R3,R3,#+6
        MOVS     R2,R1
        LSLS     R2,R2,R3
        ORRS     R2,R2,R4
//  678         xHWREG(g_pulRegs[ulInterrupt >> 2]) = ulTemp;
        MOVS     R3,R0
        LSRS     R3,R3,#+2
        MOVS     R4,#+4
        MULS     R3,R4,R3
        LDR      R4,??DataTable4
        LDR      R3,[R4, R3]
        STR      R2,[R3, #+0]
        B        ??xIntPrioritySet_1
//  679     }
//  680     else if(ulInterrupt == xINT_SYSCTL)
??xIntPrioritySet_0:
        LDR      R3,??DataTable4_1  ;; 0x1716
        CMP      R0,R3
        BNE      ??xIntPrioritySet_2
//  681     {
//  682         ulTemp = xHWREG(NVIC_PRI1);
        LDR      R3,??DataTable4_2  ;; 0xe000e404
        LDR      R3,[R3, #+0]
        MOVS     R2,R3
//  683 	ulTemp &= ~0xFFFF0000;
        UXTH     R2,R2
//  684 	ulTemp |= ((ucPriority << (16 + 6)) | (ucPriority << (24 + 6)));
        MOVS     R4,R2
        UXTB     R1,R1
        LSLS     R3,R1,#+22
        UXTB     R1,R1
        LSLS     R2,R1,#+30
        ORRS     R2,R2,R3
        ORRS     R2,R2,R4
//  685 	xHWREG(NVIC_PRI1) = ulTemp; 
        LDR      R3,??DataTable4_2  ;; 0xe000e404
        STR      R2,[R3, #+0]
        B        ??xIntPrioritySet_1
//  686     }
//  687     else if(ulInterrupt == xINT_RTC)
??xIntPrioritySet_2:
        LDR      R3,??DataTable5  ;; 0x2524
        CMP      R0,R3
        BNE      ??xIntPrioritySet_1
//  688     {
//  689 	ulTemp = xHWREG(NVIC_PRI5);
        LDR      R3,??DataTable12  ;; 0xe000e414
        LDR      R3,[R3, #+0]
        MOVS     R2,R3
//  690 	ulTemp &= ~0x0000FFFF;
        LSRS     R2,R2,#+16
        LSLS     R2,R2,#+16
//  691 	ulTemp |= (ucPriority <<  6) | (ucPriority << (8 + 6));
        MOVS     R4,R2
        UXTB     R1,R1
        LSLS     R3,R1,#+6
        UXTB     R1,R1
        LSLS     R2,R1,#+14
        ORRS     R2,R2,R3
        ORRS     R2,R2,R4
//  692 	xHWREG(NVIC_PRI5) = ulTemp; 
        LDR      R3,??DataTable12  ;; 0xe000e414
        STR      R2,[R3, #+0]
//  693      }
//  694 
//  695 }
??xIntPrioritySet_1:
        POP      {R4,R5,PC}       ;; return
//  696 
//  697 //*****************************************************************************
//  698 //
//  699 //! \brief Gets the priority of an interrupt.
//  700 //!
//  701 //! \param ulInterrupt specifies the interrupt in question.
//  702 //!
//  703 //! This function gets the priority of an interrupt.  See xIntPrioritySet() for
//  704 //! a definition of the priority value.
//  705 //!
//  706 //! \return Returns the interrupt priority, or -1 if an invalid interrupt was
//  707 //! specified.
//  708 //
//  709 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  710 long
//  711 xIntPriorityGet(unsigned long ulInterrupt)
//  712 {
xIntPriorityGet:
        PUSH     {LR}
        MOVS     R1,R0
//  713     //
//  714     // Check the arguments.
//  715     //
//  716     xASSERT(((ulInterrupt >= 4) && (ulInterrupt <= NUM_INTERRUPTS)) || 
//  717 	         (ulInterrupt == xINT_SYSCTL) || (ulInterrupt == xINT_RTC));
//  718 
//  719     //
//  720     // Return the interrupt priority.
//  721     //
//  722     if((ulInterrupt >= 4) && (ulInterrupt < NUM_INTERRUPTS))
        CMP      R1,#+4
        BCC      ??xIntPriorityGet_0
        CMP      R1,#+47
        BCS      ??xIntPriorityGet_0
//  723     {
//  724         return((xHWREG(g_pulRegs[ulInterrupt >> 2]) >> (8 * (ulInterrupt & 3) + 6)) &
//  725                0xFF);
        MOVS     R0,R1
        LSRS     R0,R0,#+2
        MOVS     R2,#+4
        MULS     R0,R2,R0
        LDR      R2,??DataTable4
        LDR      R0,[R2, R0]
        LDR      R0,[R0, #+0]
        LSLS     R1,R1,#+30       ;; ZeroExtS R1,R1,#+30,#+30
        LSRS     R1,R1,#+30
        MOVS     R2,#+8
        MULS     R1,R2,R1
        ADDS     R1,R1,#+6
        LSRS     R0,R0,R1
        UXTB     R0,R0
        B        ??xIntPriorityGet_1
//  726     }
//  727     else if(ulInterrupt == xINT_SYSCTL)
??xIntPriorityGet_0:
        LDR      R0,??DataTable4_1  ;; 0x1716
        CMP      R1,R0
        BNE      ??xIntPriorityGet_2
//  728     {
//  729         return ((xHWREG(NVIC_PRI1) >> (16 + 6)) & 0xff);
        LDR      R0,??DataTable4_2  ;; 0xe000e404
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+22
        UXTB     R0,R0
        B        ??xIntPriorityGet_1
//  730     }
//  731     else if(ulInterrupt == xINT_RTC)
??xIntPriorityGet_2:
        LDR      R0,??DataTable5  ;; 0x2524
        CMP      R1,R0
        BNE      ??xIntPriorityGet_3
//  732     {
//  733         return ((xHWREG(NVIC_PRI5) >> 6 )& 0xff);
        LDR      R0,??DataTable12  ;; 0xe000e414
        LDR      R0,[R0, #+0]
        LSRS     R0,R0,#+6
        UXTB     R0,R0
        B        ??xIntPriorityGet_1
//  734     }
//  735         
//  736     return 0;
??xIntPriorityGet_3:
        MOVS     R0,#+0
??xIntPriorityGet_1:
        POP      {PC}             ;; return
//  737 
//  738 }
//  739 
//  740 //*****************************************************************************
//  741 //
//  742 //! \brief Enables an interrupt.
//  743 //!
//  744 //! \param ulInterrupt specifies the interrupt to be enabled.
//  745 //!
//  746 //! The specified interrupt is enabled in the interrupt controller.  Other
//  747 //! enables for the interrupt (such as at the peripheral level) are unaffected
//  748 //! by this function.
//  749 //!
//  750 //! \return None.
//  751 //
//  752 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  753 void
//  754 xIntEnable(unsigned long ulInterrupt)
//  755 {
xIntEnable:
        PUSH     {R4-R7,LR}
        MOVS     R4,R0
//  756     //
//  757     // Check the arguments.
//  758     //
//  759     xASSERT(((ulInterrupt >= 4) && (ulInterrupt <= NUM_INTERRUPTS)) || 
//  760 	    (ulInterrupt == xINT_SYSCTL) || (ulInterrupt == xINT_RTC));
//  761  
//  762     if(ulInterrupt == FAULT_SVCALL)
        CMP      R4,#+11
        BNE      ??xIntEnable_0
//  763     {
//  764         //
//  765         //   SVC Call Active
//  766         //
//  767         xHWREG(NVIC_SYS_HND_CTRL) |= NVIC_SYS_HND_CTRL_SVCA;
        LDR      R0,??DataTable14  ;; 0xe000ed24
        LDR      R0,[R0, #+0]
        MOVS     R1,#+128
        ORRS     R1,R1,R0
        LDR      R0,??DataTable14  ;; 0xe000ed24
        STR      R1,[R0, #+0]
        B        ??xIntEnable_1
//  768     }
//  769     else if(ulInterrupt == FAULT_PENDSV)
??xIntEnable_0:
        CMP      R4,#+14
        BNE      ??xIntEnable_2
//  770     {
//  771         //
//  772         //  SVC Call Pending
//  773         //
//  774         xHWREG(NVIC_SYS_HND_CTRL) |= NVIC_SYS_HND_CTRL_SVC;
        LDR      R0,??DataTable14  ;; 0xe000ed24
        LDR      R0,[R0, #+0]
        MOVS     R1,#+128
        LSLS     R1,R1,#+8        ;; #+32768
        ORRS     R1,R1,R0
        LDR      R0,??DataTable14  ;; 0xe000ed24
        STR      R1,[R0, #+0]
        B        ??xIntEnable_1
//  775     }
//  776     else if(ulInterrupt == FAULT_SYSTICK)
??xIntEnable_2:
        CMP      R4,#+15
        BNE      ??xIntEnable_3
//  777     {
//  778         //
//  779         // Enable the System Tick interrupt.
//  780         //
//  781         xHWREG(NVIC_ST_CTRL) |= NVIC_ST_CTRL_INTEN;
        LDR      R0,??DataTable16  ;; 0xe000e010
        LDR      R0,[R0, #+0]
        MOVS     R1,#+2
        ORRS     R1,R1,R0
        LDR      R0,??DataTable16  ;; 0xe000e010
        STR      R1,[R0, #+0]
        B        ??xIntEnable_1
//  782     }
//  783     else if((ulInterrupt >= 16) && (ulInterrupt <= 47))
??xIntEnable_3:
        CMP      R4,#+16
        BCC      ??xIntEnable_4
        CMP      R4,#+48
        BCS      ??xIntEnable_4
//  784     {
//  785         //
//  786         // Enable the general interrupt.
//  787         //
//  788         xHWREG(NVIC_EN0 + (((ulInterrupt & 0xFF)-16)/32)*4) 
//  789         = 1 << (((ulInterrupt & 0xFF)-16)%32);
        UXTB     R0,R4
        SUBS     R0,R0,#+16
        MOVS     R5,R0
        LSRS     R5,R5,#+5
        MOVS     R0,#+4
        MULS     R5,R0,R5
        LDR      R6,??DataTable16_1  ;; 0xe000e100
        MOVS     R7,#+1
        UXTB     R0,R4
        SUBS     R0,R0,#+16
        MOVS     R1,#+32
        BL       __aeabi_uidivmod
        LSLS     R7,R7,R1
        STR      R7,[R5, R6]
        B        ??xIntEnable_1
//  790     }
//  791     else if(ulInterrupt == xINT_SYSCTL)
??xIntEnable_4:
        LDR      R0,??DataTable4_1  ;; 0x1716
        CMP      R4,R0
        BNE      ??xIntEnable_5
//  792     {
//  793         xHWREG(NVIC_EN0) = (1 << 6) | (1 << 7);
        LDR      R0,??DataTable16_1  ;; 0xe000e100
        MOVS     R1,#+192
        STR      R1,[R0, #+0]
        B        ??xIntEnable_1
//  794     }
//  795     else if(ulInterrupt == xINT_RTC)
??xIntEnable_5:
        LDR      R0,??DataTable5  ;; 0x2524
        CMP      R4,R0
        BNE      ??xIntEnable_1
//  796     {
//  797         xHWREG(NVIC_EN0) = (1 << 20) | (1 << 21);
        LDR      R0,??DataTable16_1  ;; 0xe000e100
        MOVS     R1,#+192
        LSLS     R1,R1,#+14       ;; #+3145728
        STR      R1,[R0, #+0]
//  798     }
//  799 }
??xIntEnable_1:
        POP      {R4-R7,PC}       ;; return
//  800 
//  801 //*****************************************************************************
//  802 //
//  803 //! \brief Disables an interrupt.
//  804 //!
//  805 //! \param ulInterrupt specifies the interrupt to be disabled.
//  806 //!
//  807 //! The specified interrupt is disabled in the interrupt controller.  Other
//  808 //! enables for the interrupt (such as at the peripheral level) are unaffected
//  809 //! by this function.
//  810 //!
//  811 //! \return None.
//  812 //
//  813 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  814 void
//  815 xIntDisable(unsigned long ulInterrupt)
//  816 {
xIntDisable:
        PUSH     {R4-R7,LR}
        MOVS     R4,R0
//  817     //
//  818     // Check the arguments.
//  819     //
//  820     xASSERT(((ulInterrupt >= 4) && (ulInterrupt <= NUM_INTERRUPTS)) || 
//  821 	    (ulInterrupt == xINT_SYSCTL) || (ulInterrupt == xINT_RTC));
//  822 
//  823     //
//  824     // Determine the interrupt to disable.
//  825     //
//  826     if(ulInterrupt == FAULT_SVCALL)
        CMP      R4,#+11
        BNE      ??xIntDisable_0
//  827     {
//  828         //
//  829         //   SVC Call Active
//  830         //
//  831         xHWREG(NVIC_SYS_HND_CTRL) &= ~NVIC_SYS_HND_CTRL_SVCA;
        LDR      R0,??DataTable14  ;; 0xe000ed24
        LDR      R0,[R0, #+0]
        MOVS     R1,#+128
        BICS     R0,R0,R1
        LDR      R1,??DataTable14  ;; 0xe000ed24
        STR      R0,[R1, #+0]
        B        ??xIntDisable_1
//  832     }
//  833     else if(ulInterrupt == FAULT_PENDSV)
??xIntDisable_0:
        CMP      R4,#+14
        BNE      ??xIntDisable_2
//  834     {
//  835         //
//  836         //  SVC Call Pending
//  837         //
//  838         xHWREG(NVIC_SYS_HND_CTRL) &= ~NVIC_SYS_HND_CTRL_SVC;
        LDR      R0,??DataTable14  ;; 0xe000ed24
        LDR      R0,[R0, #+0]
        LDR      R1,??DataTable16_2  ;; 0xffff7fff
        ANDS     R1,R1,R0
        LDR      R0,??DataTable14  ;; 0xe000ed24
        STR      R1,[R0, #+0]
        B        ??xIntDisable_1
//  839     }
//  840     else if(ulInterrupt == FAULT_SYSTICK)
??xIntDisable_2:
        CMP      R4,#+15
        BNE      ??xIntDisable_3
//  841     {
//  842         //
//  843         // Disable the System Tick interrupt.
//  844         //
//  845         xHWREG(NVIC_ST_CTRL) &= ~(NVIC_ST_CTRL_INTEN);
        LDR      R0,??DataTable16  ;; 0xe000e010
        LDR      R0,[R0, #+0]
        MOVS     R1,#+2
        BICS     R0,R0,R1
        LDR      R1,??DataTable16  ;; 0xe000e010
        STR      R0,[R1, #+0]
        B        ??xIntDisable_1
//  846     }
//  847     else if((ulInterrupt >= 16) && (ulInterrupt <= 47))
??xIntDisable_3:
        CMP      R4,#+16
        BCC      ??xIntDisable_4
        CMP      R4,#+48
        BCS      ??xIntDisable_4
//  848     {
//  849         //
//  850         // Enable the general interrupt.
//  851         //
//  852         xHWREG(NVIC_DIS0 + (((ulInterrupt & 0xFF)-16)/32)*4) 
//  853         = 1 << (((ulInterrupt - 16) & 0xFF)%32);
        UXTB     R0,R4
        SUBS     R0,R0,#+16
        MOVS     R5,R0
        LSRS     R5,R5,#+5
        MOVS     R0,#+4
        MULS     R5,R0,R5
        LDR      R6,??DataTable16_3  ;; 0xe000e180
        MOVS     R7,#+1
        MOVS     R0,R4
        SUBS     R0,R0,#+16
        UXTB     R0,R0
        MOVS     R1,#+32
        BL       __aeabi_uidivmod
        LSLS     R7,R7,R1
        STR      R7,[R5, R6]
        B        ??xIntDisable_1
//  854     }
//  855     else if(ulInterrupt == xINT_SYSCTL)
??xIntDisable_4:
        LDR      R0,??DataTable4_1  ;; 0x1716
        CMP      R4,R0
        BNE      ??xIntDisable_5
//  856     {
//  857         xHWREG(NVIC_DIS0) = (1 << 6) | (1 << 7);
        LDR      R0,??DataTable16_3  ;; 0xe000e180
        MOVS     R1,#+192
        STR      R1,[R0, #+0]
        B        ??xIntDisable_1
//  858     }
//  859     else if(ulInterrupt == xINT_RTC)
??xIntDisable_5:
        LDR      R0,??DataTable5  ;; 0x2524
        CMP      R4,R0
        BNE      ??xIntDisable_1
//  860     {
//  861         xHWREG(NVIC_DIS0) = (1 << 20) | (1 << 21);
        LDR      R0,??DataTable16_3  ;; 0xe000e180
        MOVS     R1,#+192
        LSLS     R1,R1,#+14       ;; #+3145728
        STR      R1,[R0, #+0]
//  862     }
//  863 
//  864 }
??xIntDisable_1:
        POP      {R4-R7,PC}       ;; return
//  865 
//  866 //*****************************************************************************
//  867 //
//  868 //! \brief Pends an interrupt.
//  869 //!
//  870 //! \param ulInterrupt specifies the interrupt to be pended.
//  871 //!
//  872 //! The specified interrupt is pended in the interrupt controller.  This will
//  873 //! cause the interrupt controller to execute the corresponding interrupt
//  874 //! handler at the next available time, based on the current interrupt state
//  875 //! priorities.  For example, if called by a higher priority interrupt handler,
//  876 //! the specified interrupt handler will not be called until after the current
//  877 //! interrupt handler has completed execution.  The interrupt must have been
//  878 //! enabled for it to be called.
//  879 //!
//  880 //! \return None.
//  881 //
//  882 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  883 void
//  884 xIntPendSet(unsigned long ulInterrupt)
//  885 {
xIntPendSet:
        PUSH     {R4,R5,LR}
        MOVS     R4,R0
//  886     //
//  887     // Check the arguments.
//  888     //
//  889     xASSERT(((ulInterrupt >= 4) && (ulInterrupt <= NUM_INTERRUPTS)) || 
//  890 	         (ulInterrupt == xINT_SYSCTL) || (ulInterrupt == xINT_RTC));
//  891 
//  892     //
//  893     // Determine the interrupt to pend.
//  894     //
//  895     if(ulInterrupt == FAULT_PENDSV)
        CMP      R4,#+14
        BNE      ??xIntPendSet_0
//  896     {
//  897         //
//  898         //  PendSV Set Pending
//  899         //
//  900         xHWREG(NVIC_INT_CTRL) |= NVIC_INT_CTRL_PEND_SV;
        LDR      R0,??DataTable16_4  ;; 0xe000ed04
        LDR      R0,[R0, #+0]
        MOVS     R1,#+128
        LSLS     R1,R1,#+21       ;; #+268435456
        ORRS     R1,R1,R0
        LDR      R0,??DataTable16_4  ;; 0xe000ed04
        STR      R1,[R0, #+0]
        B        ??xIntPendSet_1
//  901     }
//  902     else if(ulInterrupt == FAULT_SYSTICK)
??xIntPendSet_0:
        CMP      R4,#+15
        BNE      ??xIntPendSet_2
//  903     {
//  904         //
//  905         // Pend the SysTick interrupt.
//  906         //
//  907         xHWREG(NVIC_INT_CTRL) |= NVIC_INT_CTRL_PENDSTSET;
        LDR      R0,??DataTable16_4  ;; 0xe000ed04
        LDR      R0,[R0, #+0]
        MOVS     R1,#+128
        LSLS     R1,R1,#+19       ;; #+67108864
        ORRS     R1,R1,R0
        LDR      R0,??DataTable16_4  ;; 0xe000ed04
        STR      R1,[R0, #+0]
        B        ??xIntPendSet_1
//  908     }
//  909     else if((ulInterrupt >= 16) && (ulInterrupt <= 47))
??xIntPendSet_2:
        CMP      R4,#+16
        BCC      ??xIntPendSet_3
        CMP      R4,#+48
        BCS      ??xIntPendSet_3
//  910     {
//  911         //
//  912         // pend the general interrupt.
//  913         //
//  914         xHWREG(NVIC_PEND0 + ((ulInterrupt & 0xFF)/32)*4) = 1 << (((ulInterrupt & 0xFF) - 16)%32);
        MOVS     R5,#+1
        UXTB     R0,R4
        SUBS     R0,R0,#+16
        MOVS     R1,#+32
        BL       __aeabi_uidivmod
        LSLS     R5,R5,R1
        MOVS     R0,R4
        LSRS     R0,R0,#+5
        LSLS     R0,R0,#+29       ;; ZeroExtS R0,R0,#+29,#+29
        LSRS     R0,R0,#+29
        MOVS     R1,#+4
        MULS     R0,R1,R0
        LDR      R1,??DataTable16_5  ;; 0xe000e200
        STR      R5,[R0, R1]
        B        ??xIntPendSet_1
//  915         
//  916       //  xHWREG(NVIC_PEND0) = 1 << (((ulInterrupt & 0xFF) - 16)%32);
//  917     }
//  918 	else if(ulInterrupt == xINT_SYSCTL)
??xIntPendSet_3:
        LDR      R0,??DataTable4_1  ;; 0x1716
        CMP      R4,R0
        BNE      ??xIntPendSet_4
//  919 	{
//  920 	    xHWREG(NVIC_PEND0) = (1 << 6) | (1 << 7);
        LDR      R0,??DataTable16_5  ;; 0xe000e200
        MOVS     R1,#+192
        STR      R1,[R0, #+0]
        B        ??xIntPendSet_1
//  921 	}
//  922 	else if(ulInterrupt == xINT_RTC)
??xIntPendSet_4:
        LDR      R0,??DataTable5  ;; 0x2524
        CMP      R4,R0
        BNE      ??xIntPendSet_1
//  923 	{
//  924 	    xHWREG(NVIC_PEND0) = (1 << 20) | (1 << 21);
        LDR      R0,??DataTable16_5  ;; 0xe000e200
        MOVS     R1,#+192
        LSLS     R1,R1,#+14       ;; #+3145728
        STR      R1,[R0, #+0]
//  925 	}
//  926 
//  927 }
??xIntPendSet_1:
        POP      {R4,R5,PC}       ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4:
        DC32     g_pulRegs

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_1:
        DC32     0x1716

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable4_2:
        DC32     0xe000e404
//  928 
//  929 //*****************************************************************************
//  930 //
//  931 //! \brief Unpends an interrupt.
//  932 //!
//  933 //! \param ulInterrupt specifies the interrupt to be unpended.
//  934 //!
//  935 //! The specified interrupt is unpended in the interrupt controller.  This will
//  936 //! cause any previously generated interrupts that have not been handled yet
//  937 //! (due to higher priority interrupts or the interrupt no having been enabled
//  938 //! yet) to be discarded.
//  939 //!
//  940 //! \return None.
//  941 //
//  942 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  943 void
//  944 xIntPendClear(unsigned long ulInterrupt)
//  945 {
xIntPendClear:
        PUSH     {R4,R5,LR}
        MOVS     R4,R0
//  946     //
//  947     // Check the arguments.
//  948     //
//  949     xASSERT(((ulInterrupt >= 4) && (ulInterrupt <= NUM_INTERRUPTS)) || 
//  950 	         (ulInterrupt == xINT_SYSCTL) || (ulInterrupt == xINT_RTC));
//  951 
//  952     //
//  953     // Determine the interrupt to unpend.
//  954     //
//  955     if(ulInterrupt == FAULT_PENDSV)
        CMP      R4,#+14
        BNE      ??xIntPendClear_0
//  956     {
//  957         //
//  958         //  PendSV  Unpend
//  959         //
//  960         xHWREG(NVIC_INT_CTRL) |= NVIC_INT_CTRL_UNPEND_SV;
        LDR      R0,??DataTable16_4  ;; 0xe000ed04
        LDR      R0,[R0, #+0]
        MOVS     R1,#+128
        LSLS     R1,R1,#+20       ;; #+134217728
        ORRS     R1,R1,R0
        LDR      R0,??DataTable16_4  ;; 0xe000ed04
        STR      R1,[R0, #+0]
        B        ??xIntPendClear_1
//  961     }
//  962     else if(ulInterrupt == FAULT_SYSTICK)
??xIntPendClear_0:
        CMP      R4,#+15
        BNE      ??xIntPendClear_2
//  963     {
//  964         //
//  965         // Unpend the SysTick interrupt.
//  966         //
//  967         xHWREG(NVIC_INT_CTRL) |= NVIC_INT_CTRL_PENDSTCLR;
        LDR      R0,??DataTable16_4  ;; 0xe000ed04
        LDR      R0,[R0, #+0]
        MOVS     R1,#+128
        LSLS     R1,R1,#+18       ;; #+33554432
        ORRS     R1,R1,R0
        LDR      R0,??DataTable16_4  ;; 0xe000ed04
        STR      R1,[R0, #+0]
        B        ??xIntPendClear_1
//  968     }
//  969     else if((ulInterrupt >= 16) && (ulInterrupt <= 47))
??xIntPendClear_2:
        CMP      R4,#+16
        BCC      ??xIntPendClear_3
        CMP      R4,#+48
        BCS      ??xIntPendClear_3
//  970     {
//  971         //
//  972         // Unpend the general interrupt.
//  973         //
//  974 		xHWREG(NVIC_UNPEND0 + ((ulInterrupt & 0xFF)/32)*4) 
//  975                  = 1 << (((ulInterrupt & 0xFF) - 16)%32);
        MOVS     R5,#+1
        UXTB     R0,R4
        SUBS     R0,R0,#+16
        MOVS     R1,#+32
        BL       __aeabi_uidivmod
        LSLS     R5,R5,R1
        MOVS     R0,R4
        LSRS     R0,R0,#+5
        LSLS     R0,R0,#+29       ;; ZeroExtS R0,R0,#+29,#+29
        LSRS     R0,R0,#+29
        MOVS     R1,#+4
        MULS     R0,R1,R0
        LDR      R1,??DataTable16_6  ;; 0xe000e280
        STR      R5,[R0, R1]
        B        ??xIntPendClear_1
//  976     }
//  977 	else if(ulInterrupt == xINT_SYSCTL)
??xIntPendClear_3:
        LDR      R0,??DataTable16_7  ;; 0x1716
        CMP      R4,R0
        BNE      ??xIntPendClear_4
//  978 	{
//  979 	    xHWREG(NVIC_UNPEND0) = (1 << 6) | (1 << 7);
        LDR      R0,??DataTable16_6  ;; 0xe000e280
        MOVS     R1,#+192
        STR      R1,[R0, #+0]
        B        ??xIntPendClear_1
//  980 	}
//  981 	else if(ulInterrupt == xINT_RTC)
??xIntPendClear_4:
        LDR      R0,??DataTable5  ;; 0x2524
        CMP      R4,R0
        BNE      ??xIntPendClear_1
//  982 	{
//  983 	    xHWREG(NVIC_UNPEND0) = (1 << 20) | (1 << 21);
        LDR      R0,??DataTable16_6  ;; 0xe000e280
        MOVS     R1,#+192
        LSLS     R1,R1,#+14       ;; #+3145728
        STR      R1,[R0, #+0]
//  984 	}
//  985 }
??xIntPendClear_1:
        POP      {R4,R5,PC}       ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable5:
        DC32     0x2524
//  986 
//  987 //*****************************************************************************
//  988 //
//  989 //! \brief Sets the priority masking level
//  990 //!
//  991 //! \param ulPriorityMask is the priority level that will be masked.
//  992 //!
//  993 //! This function sets the interrupt priority masking level so that all
//  994 //! interrupts at the specified or lesser priority level is masked.  This
//  995 //! can be used to globally disable a set of interrupts with priority below
//  996 //! a predetermined threshold.  A value of 0 disables priority
//  997 //! masking.
//  998 //!
//  999 //! Smaller numbers correspond to higher interrupt priorities.  So for example
// 1000 //! a priority level mask of 4 will allow interrupts of priority level 0-3,
// 1001 //! and interrupts with a numerical priority of 4 and greater will be blocked.
// 1002 //!
// 1003 //! The hardware priority mechanism will only look at the upper N bits of the
// 1004 //! priority level (where N is 2 for the NUC1xx family), so any
// 1005 //! prioritization must be performed in those bits.
// 1006 //!
// 1007 //! \return None.
// 1008 //
// 1009 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1010 void
// 1011 xIntPriorityMaskSet(unsigned long ulPriorityMask)
// 1012 {
xIntPriorityMaskSet:
        PUSH     {R4,LR}
        MOVS     R4,R0
// 1013     xCPUbasepriSet(ulPriorityMask);
        MOVS     R0,R4
        BL       xCPUbasepriSet
// 1014 }
        POP      {R4,PC}          ;; return
// 1015 
// 1016 //*****************************************************************************
// 1017 //
// 1018 //! \brief Gets the priority masking level
// 1019 //!
// 1020 //! This function gets the current setting of the interrupt priority masking
// 1021 //! level.  The value returned is the priority level such that all interrupts
// 1022 //! of that and lesser priority are masked.  A value of 0 means that priority
// 1023 //! masking is disabled.
// 1024 //!
// 1025 //! Smaller numbers correspond to higher interrupt priorities.  So for example
// 1026 //! a priority level mask of 4 will allow interrupts of priority level 0-3,
// 1027 //! and interrupts with a numerical priority of 4 and greater will be blocked.
// 1028 //!
// 1029 //! The hardware priority mechanism will only look at the upper N bits of the
// 1030 //! priority level (where N is 2 for the NUC1xx family), so any
// 1031 //! prioritization must be performed in those bits.
// 1032 //!
// 1033 //! \return Returns the value of the interrupt priority level mask.
// 1034 //
// 1035 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1036 unsigned long
// 1037 xIntPriorityMaskGet(void)
// 1038 {
xIntPriorityMaskGet:
        PUSH     {R7,LR}
// 1039     return(xCPUbasepriGet());
        BL       xCPUbasepriGet
        POP      {R1,PC}          ;; return
// 1040 }
// 1041 
// 1042 //*****************************************************************************
// 1043 //
// 1044 //! \brief Enables the SysTick counter.
// 1045 //!
// 1046 //! This will start the SysTick counter.  If an interrupt handler has been
// 1047 //! registered, it will be called when the SysTick counter rolls over.
// 1048 //!
// 1049 //! \note Calling this function will cause the SysTick counter to (re)commence
// 1050 //! counting from its current value.  The counter is not automatically reloaded
// 1051 //! with the period as specified in a previous call to xSysTickPeriodSet().  If
// 1052 //! an immediate reload is required, the \b NVIC_ST_CURRENT register must be
// 1053 //! written to force this.  Any write to this register clears the SysTick
// 1054 //! counter to 0 and will cause a reload with the supplied period on the next
// 1055 //! clock.
// 1056 //!
// 1057 //! \return None.
// 1058 //
// 1059 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1060 void
// 1061 xSysTickEnable(void)
// 1062 {
// 1063     //
// 1064     // Enable SysTick.
// 1065     //
// 1066     xHWREG(NVIC_ST_CTRL) |= NVIC_ST_CTRL_CLK_SRC | NVIC_ST_CTRL_ENABLE;
xSysTickEnable:
        LDR      R0,??DataTable16  ;; 0xe000e010
        LDR      R0,[R0, #+0]
        MOVS     R1,#+5
        ORRS     R1,R1,R0
        LDR      R0,??DataTable16  ;; 0xe000e010
        STR      R1,[R0, #+0]
// 1067 }
        BX       LR               ;; return
// 1068 
// 1069 //*****************************************************************************
// 1070 //
// 1071 //! \brief Disables the SysTick counter.
// 1072 //!
// 1073 //! This will stop the SysTick counter.  If an interrupt handler has been
// 1074 //! registered, it will no longer be called until SysTick is restarted.
// 1075 //!
// 1076 //! \return None.
// 1077 //
// 1078 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1079 void
// 1080 xSysTickDisable(void)
// 1081 {
// 1082     //
// 1083     // Disable SysTick.
// 1084     //
// 1085     xHWREG(NVIC_ST_CTRL) &= ~(NVIC_ST_CTRL_ENABLE);
xSysTickDisable:
        LDR      R0,??DataTable16  ;; 0xe000e010
        LDR      R0,[R0, #+0]
        MOVS     R1,#+1
        BICS     R0,R0,R1
        LDR      R1,??DataTable16  ;; 0xe000e010
        STR      R0,[R1, #+0]
// 1086 }
        BX       LR               ;; return
// 1087 
// 1088 //*****************************************************************************
// 1089 //
// 1090 //! \brief Enables the SysTick interrupt.
// 1091 //!
// 1092 //! This function will enable the SysTick interrupt, allowing it to be
// 1093 //! reflected to the processor.
// 1094 //!
// 1095 //! \note The SysTick interrupt handler does not need to clear the SysTick
// 1096 //! interrupt source as this is done automatically by NVIC when the interrupt
// 1097 //! handler is called.
// 1098 //!
// 1099 //! \return None.
// 1100 //
// 1101 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1102 void
// 1103 xSysTickIntEnable(void)
// 1104 {
// 1105     //
// 1106     // Enable the SysTick interrupt.
// 1107     //
// 1108     xHWREG(NVIC_ST_CTRL) |= NVIC_ST_CTRL_INTEN;
xSysTickIntEnable:
        LDR      R0,??DataTable16  ;; 0xe000e010
        LDR      R0,[R0, #+0]
        MOVS     R1,#+2
        ORRS     R1,R1,R0
        LDR      R0,??DataTable16  ;; 0xe000e010
        STR      R1,[R0, #+0]
// 1109 }
        BX       LR               ;; return
// 1110 
// 1111 //*****************************************************************************
// 1112 //
// 1113 //! \brief Disables the SysTick interrupt.
// 1114 //!
// 1115 //! This function will disable the SysTick interrupt, preventing it from being
// 1116 //! reflected to the processor.
// 1117 //!
// 1118 //! \return None.
// 1119 //
// 1120 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1121 void
// 1122 xSysTickIntDisable(void)
// 1123 {
// 1124     //
// 1125     // Disable the SysTick interrupt.
// 1126     //
// 1127     xHWREG(NVIC_ST_CTRL) &= ~(NVIC_ST_CTRL_INTEN);
xSysTickIntDisable:
        LDR      R0,??DataTable16  ;; 0xe000e010
        LDR      R0,[R0, #+0]
        MOVS     R1,#+2
        BICS     R0,R0,R1
        LDR      R1,??DataTable16  ;; 0xe000e010
        STR      R0,[R1, #+0]
// 1128 }
        BX       LR               ;; return
// 1129 
// 1130 //*****************************************************************************
// 1131 //
// 1132 //! \brief Sets the period of the SysTick counter.
// 1133 //!
// 1134 //! \param ulPeriod is the number of clock ticks in each period of the SysTick
// 1135 //! counter; must be between 1 and 16,777,216, inclusive.
// 1136 //!
// 1137 //! This function sets the rate at which the SysTick counter wraps; this
// 1138 //! equates to the number of processor clocks between interrupts.
// 1139 //!
// 1140 //! \note Calling this function does not cause the SysTick counter to reload
// 1141 //! immediately.  If an immediate reload is required, the \b NVIC_ST_CURRENT
// 1142 //! register must be written.  Any write to this register clears the SysTick
// 1143 //! counter to 0 and will cause a reload with the \e ulPeriod supplied here on
// 1144 //! the next clock after the SysTick is enabled.
// 1145 //!
// 1146 //! \return None.
// 1147 //
// 1148 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1149 void
// 1150 xSysTickPeriodSet(unsigned long ulPeriod)
// 1151 {
// 1152     //
// 1153     // Check the arguments.
// 1154     //
// 1155     xASSERT((ulPeriod > 0) && (ulPeriod <= 16777216));
// 1156 
// 1157     //
// 1158     // Set the period of the SysTick counter.
// 1159     //
// 1160     xHWREG(NVIC_ST_RELOAD) = ulPeriod - 1;
xSysTickPeriodSet:
        SUBS     R1,R0,#+1
        LDR      R2,??DataTable16_8  ;; 0xe000e014
        STR      R1,[R2, #+0]
// 1161 }
        BX       LR               ;; return
// 1162 
// 1163 //*****************************************************************************
// 1164 //
// 1165 //! \brief Gets the period of the SysTick counter.
// 1166 //!
// 1167 //! This function returns the rate at which the SysTick counter wraps; this
// 1168 //! equates to the number of processor clocks between interrupts.
// 1169 //!
// 1170 //! \return Returns the period of the SysTick counter.
// 1171 //
// 1172 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1173 unsigned long
// 1174 xSysTickPeriodGet(void)
// 1175 {
// 1176     //
// 1177     // Return the period of the SysTick counter.
// 1178     //
// 1179     return(xHWREG(NVIC_ST_RELOAD) + 1);
xSysTickPeriodGet:
        LDR      R0,??DataTable16_8  ;; 0xe000e014
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+1
        BX       LR               ;; return
// 1180 }
// 1181 
// 1182 //*****************************************************************************
// 1183 //
// 1184 //! \brief Gets the current value of the SysTick counter.
// 1185 //!
// 1186 //! This function returns the current value of the SysTick counter; this will
// 1187 //! be a value between the period - 1 and zero, inclusive.
// 1188 //!
// 1189 //! \return Returns the current value of the SysTick counter.
// 1190 //
// 1191 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1192 unsigned long
// 1193 xSysTickValueGet(void)
// 1194 {
// 1195     //
// 1196     // Return the current value of the SysTick counter.
// 1197     //
// 1198     return(xHWREG(NVIC_ST_CURRENT));
xSysTickValueGet:
        LDR      R0,??DataTable16_9  ;; 0xe000e018
        LDR      R0,[R0, #+0]
        BX       LR               ;; return
// 1199 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable12:
        DC32     0xe000e414
// 1200 
// 1201 //*****************************************************************************
// 1202 //
// 1203 //! \brief Set the SysTick pending.
// 1204 //!
// 1205 //! This function will Set the SysTick pending.
// 1206 //!
// 1207 //! \return None.
// 1208 //
// 1209 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1210 void
// 1211 xSysTickPendSet(void)
// 1212 {
// 1213     //
// 1214     // Set the SysTick pending.
// 1215     //
// 1216     xHWREG(NVIC_INT_CTRL) |= NVIC_INT_CTRL_PENDSTSET;
xSysTickPendSet:
        LDR      R0,??DataTable16_4  ;; 0xe000ed04
        LDR      R0,[R0, #+0]
        MOVS     R1,#+128
        LSLS     R1,R1,#+19       ;; #+67108864
        ORRS     R1,R1,R0
        LDR      R0,??DataTable16_4  ;; 0xe000ed04
        STR      R1,[R0, #+0]
// 1217 }
        BX       LR               ;; return
// 1218 
// 1219 //*****************************************************************************
// 1220 //
// 1221 //! \brief Clear the SysTick pending.
// 1222 //!
// 1223 //! This function will Clear the SysTick pending.
// 1224 //!
// 1225 //! \return None.
// 1226 //
// 1227 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1228 void
// 1229 xSysTickPendClr(void)
// 1230 {
// 1231     //
// 1232     // Clear the SysTick pending.
// 1233     //
// 1234     xHWREG(NVIC_INT_CTRL) |= NVIC_INT_CTRL_PENDSTCLR;
xSysTickPendClr:
        LDR      R0,??DataTable16_4  ;; 0xe000ed04
        LDR      R0,[R0, #+0]
        MOVS     R1,#+128
        LSLS     R1,R1,#+18       ;; #+33554432
        ORRS     R1,R1,R0
        LDR      R0,??DataTable16_4  ;; 0xe000ed04
        STR      R1,[R0, #+0]
// 1235 }
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable14:
        DC32     0xe000ed24
// 1236 
// 1237 //*****************************************************************************
// 1238 //
// 1239 //! \brief Set the PendSV pending.
// 1240 //!
// 1241 //! This function will Set the PendSV pending.
// 1242 //!
// 1243 //! \return None.
// 1244 //
// 1245 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1246 void
// 1247 xPendSVPendSet(void)
// 1248 {
// 1249     //
// 1250     // Set the PendSV pending.
// 1251     //
// 1252     xHWREG(NVIC_INT_CTRL) |= NVIC_INT_CTRL_PEND_SV;
xPendSVPendSet:
        LDR      R0,??DataTable16_4  ;; 0xe000ed04
        LDR      R0,[R0, #+0]
        MOVS     R1,#+128
        LSLS     R1,R1,#+21       ;; #+268435456
        ORRS     R1,R1,R0
        LDR      R0,??DataTable16_4  ;; 0xe000ed04
        STR      R1,[R0, #+0]
// 1253 }
        BX       LR               ;; return
// 1254 
// 1255 //*****************************************************************************
// 1256 //
// 1257 //! \brief Clear the PendSV pending.
// 1258 //!
// 1259 //! This function will Clear the PendSV pending.
// 1260 //!
// 1261 //! \return None.
// 1262 //
// 1263 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
// 1264 void
// 1265 xPendSVPendClr(void)
// 1266 {
// 1267     //
// 1268     // Clear the PendSV pending.
// 1269     //
// 1270     xHWREG(NVIC_INT_CTRL) |= NVIC_INT_CTRL_UNPEND_SV;
xPendSVPendClr:
        LDR      R0,??DataTable16_4  ;; 0xe000ed04
        LDR      R0,[R0, #+0]
        MOVS     R1,#+128
        LSLS     R1,R1,#+20       ;; #+134217728
        ORRS     R1,R1,R0
        LDR      R0,??DataTable16_4  ;; 0xe000ed04
        STR      R1,[R0, #+0]
// 1271 }
        BX       LR               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable16:
        DC32     0xe000e010

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable16_1:
        DC32     0xe000e100

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable16_2:
        DC32     0xffff7fff

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable16_3:
        DC32     0xe000e180

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable16_4:
        DC32     0xe000ed04

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable16_5:
        DC32     0xe000e200

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable16_6:
        DC32     0xe000e280

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable16_7:
        DC32     0x1716

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable16_8:
        DC32     0xe000e014

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable16_9:
        DC32     0xe000e018

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        END
// 1272 
// 
//    64 bytes in section .rodata
// 1 016 bytes in section .text
// 
// 1 016 bytes of CODE  memory
//    64 bytes of CONST memory
//
//Errors: none
//Warnings: none
