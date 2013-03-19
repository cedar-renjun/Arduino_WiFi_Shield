///////////////////////////////////////////////////////////////////////////////
//                                                                            /
// IAR ANSI C/C++ Compiler V6.40.1.53790/W32 for ARM    24/Feb/2013  09:52:13 /
// Copyright 1999-2012 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  C:\Users\renjun\Desktop\Cox\CoX_Peripheral\CoX_Peripher /
//                    al_KLx\testframe\test.c                                 /
//    Command line =  C:\Users\renjun\Desktop\Cox\CoX_Peripheral\CoX_Peripher /
//                    al_KLx\testframe\test.c -D ewarm -lCN                   /
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
//                    al_KLx\uart\test\suite1\ewarm\Debug\List\test.s         /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME test

        #define SHT_PROGBITS 0x1

        EXTERN SysCtlDelay
        EXTERN TestDisableIRQ
        EXTERN TestEnableIRQ
        EXTERN TestIOInit
        EXTERN TestIOPut
        EXTERN __aeabi_memclr4
        EXTERN __aeabi_memcpy4
        EXTERN __aeabi_memset
        EXTERN __aeabi_uidiv
        EXTERN __aeabi_uidivmod
        EXTERN g_psPatterns

        PUBLIC FILE_Print
        PUBLIC TestEmitToken
        PUBLIC TestMain
        PUBLIC UART_Print
        PUBLIC _TestAssert
        PUBLIC _TestAssertSequenceBreak
        PUBLIC memset

// C:\Users\renjun\Desktop\Cox\CoX_Peripheral\CoX_Peripheral_KLx\testframe\test.c
//    1 //*****************************************************************************
//    2 //
//    3 //! \file test.c
//    4 //! \brief Tests support code.
//    5 //! \version 1.0
//    6 //! \date 5/19/2011
//    7 //! \author CooCox
//    8 //! \copy
//    9 //!
//   10 //! Copyright (c) 2009-2011 CooCox.  All rights reserved.
//   11 //
//   12 //*****************************************************************************
//   13 
//   14 #include "test.h"

        SECTION `.text`:CODE:REORDER:NOROOT(1)
        SECTION_GROUP memset
        THUMB
// __intrinsic __nounwind __interwork __softfp void *memset(void *, int, size_t)
memset:
        PUSH     {R4-R6,LR}
        MOVS     R4,R0
        MOVS     R5,R1
        MOVS     R6,R2
        MOVS     R2,R5
        MOVS     R1,R6
        MOVS     R0,R4
        BL       __aeabi_memset
        MOVS     R0,R4
        POP      {R4-R6,PC}       ;; return
//   15 #include "testcase.h"
//   16 
//   17 
//   18 
//   19 #ifdef ENHANCE_MODE
//   20 
//   21 //
//   22 // the following const value only used in TestAssert function
//   23 //
//   24 #define FSM_BEGIN       0
//   25 #define FSM_END         1
//   26 #define FSM_CHAR        2
//   27 #define FSM_DISPATCH    3
//   28 #define NEW_LINE                                                               \ 
//   29 "------------------------------------------------------------------------------"
//   30 
//   31 typedef void (* VirtualIoPort)(char);
//   32 
//   33 
//   34 //
//   35 // private function
//   36 //
//   37 
//   38 static uint32 NumToStr (uint32 Num,
//   39                         uint32 Base,
//   40                         uint8  *Buffer,
//   41                         uint32 BufferSize);
//   42 
//   43 static uint32 PrintDec (VirtualIoPort pIOPutChar,
//   44                         void * pParam);
//   45 
//   46 static uint32 PrintHex (VirtualIoPort pIOPutChar,
//   47                         void * pParam);
//   48 
//   49 static uint32 PrintStr (VirtualIoPort pIOPutChar,
//   50                         void * pParam);
//   51 
//   52 static uint32 Print    (VirtualIoPort pIoPutchar,
//   53                         const char * pcMsg,
//   54                         va_list VarPara);
//   55 static void   BufWrite (char ch);
//   56 
//   57 //
//   58 // Public function
//   59 //
//   60 uint32 FILE_Print  (const char * pcMsg, ...);
//   61 uint32 UART_Print  (const char * pcMsg, ...);
//   62 void   _TestAssert (const char * pcMsg, ...);
//   63 
//   64 #else
//   65 
//   66 static void PrintN(unsigned long n);
//   67 static void Print(char* pcMsg);
//   68 static void PrintLine(char* pcMsg);
//   69 static void PrintNewLine(void);
//   70 static void PrintTokens(void);
//   71 #endif
//   72 
//   73 static void ClearTokens(void);
//   74 static void ExecuteTest(const tTestCase *psTest);
//   75 static xtBoolean _TestFail(void);
//   76 
//   77 

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
//   78 static xtBoolean g_bLocalFail, g_bGlobalFail;
g_bLocalFail:
        DS8 1

        SECTION `.bss`:DATA:REORDER:NOROOT(0)
g_bGlobalFail:
        DS8 1
//   79 
//   80 //
//   81 // tokens buffer
//   82 //

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   83 static char g_pcTokensBuffer[TEST_TOKENS_MAX_NUM];
g_pcTokensBuffer:
        DS8 12
//   84 
//   85 //
//   86 // error string buffer
//   87 //

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   88 static char g_pcErrorInfoBuffer[TEST_ERROR_BUF_SIZE];
g_pcErrorInfoBuffer:
        DS8 512
//   89 
//   90 //
//   91 // Error Info Buffer Index
//   92 //

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   93 static unsigned long ErrorBufIndex;
ErrorBufIndex:
        DS8 4
//   94 
//   95 //
//   96 // current point of the token buffer
//   97 //

        SECTION `.bss`:DATA:REORDER:NOROOT(2)
//   98 static char *g_pcTok;
g_pcTok:
        DS8 4
//   99 
//  100 #ifndef ENHANCE_MODE
//  101 //*****************************************************************************
//  102 //
//  103 //! \brief Prints a decimal unsigned number.
//  104 //!
//  105 //! \param n is the number to be printed
//  106 //!
//  107 //! \details Prints a decimal unsigned number.
//  108 //!
//  109 //! \return None.
//  110 //
//  111 //*****************************************************************************
//  112 static
//  113 void PrintN(unsigned long n)
//  114 {
//  115     char buf[16], *p;
//  116 
//  117     if (n == 0)
//  118     {
//  119         TestIOPut('0');
//  120     }
//  121     else
//  122     {
//  123         p = buf;
//  124         while (n != 0)
//  125         {
//  126             *p++ = (n % 10) + '0';
//  127             n /= 10;
//  128         }
//  129 
//  130         while (p > buf)
//  131             TestIOPut(*--p);
//  132     }
//  133 }
//  134 
//  135 //*****************************************************************************
//  136 //
//  137 //! \brief Prints a line without final end-of-line.
//  138 //!
//  139 //! \param pcMsg is the message to print
//  140 //!
//  141 //! \details Prints a line without final end-of-line.
//  142 //!
//  143 //! \return None.
//  144 //
//  145 //*****************************************************************************
//  146 static void
//  147 Print(char *pcMsg)
//  148 {
//  149     while (*pcMsg != '\0')
//  150     {
//  151         TestIOPut(*pcMsg++);
//  152     }
//  153 }
//  154 
//  155 //*****************************************************************************
//  156 //
//  157 //! \brief Prints a line.
//  158 //!
//  159 //! \param pcMsg is the message to print
//  160 //!
//  161 //! \details Prints a line.
//  162 //!
//  163 //! \return None.
//  164 //
//  165 //*****************************************************************************
//  166 static void
//  167 PrintLine(char *pcMsg)
//  168 {
//  169     Print(pcMsg);
//  170     TestIOPut('\r');
//  171     TestIOPut('\n');
//  172 }
//  173 
//  174 //*****************************************************************************
//  175 //
//  176 //! \brief Prints a line of "---".
//  177 //!
//  178 //! \param None
//  179 //!
//  180 //! \return None.
//  181 //
//  182 //*****************************************************************************
//  183 static void
//  184 PrintNewLine(void)
//  185 {
//  186     unsigned int i;
//  187     for (i = 0; i < 76; i++)
//  188     {
//  189         TestIOPut('-');
//  190     }
//  191     TestIOPut('\r');
//  192     TestIOPut('\n');
//  193 }
//  194 #endif
//  195 
//  196 //*****************************************************************************
//  197 //
//  198 //! \brief clear the token buffer
//  199 //!
//  200 //! \param None
//  201 //!
//  202 //! \return None.
//  203 //
//  204 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  205 static void
//  206 ClearTokens(void)
//  207 {
//  208     g_pcTok = g_pcTokensBuffer;
ClearTokens:
        LDR      R0,??DataTable6
        LDR      R1,??DataTable6_1
        STR      R1,[R0, #+0]
//  209 }
        BX       LR               ;; return
//  210 
//  211 #ifndef ENHANCE_MODE
//  212 //*****************************************************************************
//  213 //
//  214 //! \brief Print the tokens.
//  215 //!
//  216 //! \param None
//  217 //!
//  218 //!
//  219 //! \return None.
//  220 //
//  221 //*****************************************************************************
//  222 static void
//  223 PrintTokens(void)
//  224 {
//  225     char *pcToken = g_pcTokensBuffer;
//  226 
//  227     while (pcToken < g_pcTok)
//  228     {
//  229         TestIOPut(*pcToken++);
//  230     }
//  231 }
//  232 #endif
//  233 
//  234 //*****************************************************************************
//  235 //
//  236 //! \brief Emits a token into the tokens buffer.
//  237 //!
//  238 //! \param token is a char to be emit into the buffer
//  239 //!
//  240 //! \return None.
//  241 //
//  242 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  243 void TestEmitToken(char cToken)
//  244 {
TestEmitToken:
        PUSH     {R4,LR}
        MOVS     R4,R0
//  245     TestDisableIRQ();
        BL       TestDisableIRQ
//  246     if(g_pcTok < (g_pcTokensBuffer + TEST_TOKENS_MAX_NUM) )
        LDR      R0,??DataTable6
        LDR      R0,[R0, #+0]
        LDR      R1,??DataTable6_1
        ADDS     R1,R1,#+10
        CMP      R0,R1
        BCS      ??TestEmitToken_0
//  247     {
//  248         *g_pcTok++ = cToken;
        LDR      R0,??DataTable6
        LDR      R0,[R0, #+0]
        STRB     R4,[R0, #+0]
        LDR      R0,??DataTable6
        LDR      R0,[R0, #+0]
        ADDS     R0,R0,#+1
        LDR      R1,??DataTable6
        STR      R0,[R1, #+0]
//  249     }
//  250     TestEnableIRQ();
??TestEmitToken_0:
        BL       TestEnableIRQ
//  251 }
        POP      {R4,PC}          ;; return
//  252 
//  253 #ifndef ENHANCE_MODE
//  254 //*****************************************************************************
//  255 //
//  256 //! \brief Clear Error info buffer.
//  257 //!
//  258 //! \param None.
//  259 //!
//  260 //! \return None.
//  261 //
//  262 //*****************************************************************************
//  263 static void
//  264 TestErrorInfoClear(void)
//  265 {
//  266     int i = 0;
//  267 
//  268     while(i < TEST_ERROR_BUF_SIZE)
//  269     {
//  270         g_pcErrorInfoBuffer[i++] = '\0';
//  271     }
//  272 
//  273 }
//  274 
//  275 //*****************************************************************************
//  276 //
//  277 //! \brief store the error message.
//  278 //!
//  279 //! \param pcMessage is the point of the error message.
//  280 //!
//  281 //! \return None.
//  282 //
//  283 //*****************************************************************************
//  284 static void
//  285 TestErrorInfoStore(char *pcMessage)
//  286 {
//  287     int i = 0;
//  288 
//  289     while((i < TEST_ERROR_BUF_SIZE-1) && g_pcErrorInfoBuffer[i] != '\0')
//  290     {
//  291         i++;
//  292     }
//  293 
//  294     while ((*pcMessage != '\0') && (i < TEST_ERROR_BUF_SIZE-1))
//  295     {
//  296         g_pcErrorInfoBuffer[i++] = *pcMessage++;
//  297     }
//  298 
//  299     g_pcErrorInfoBuffer[i] = '\0';
//  300 }
//  301 
//  302 //*****************************************************************************
//  303 //
//  304 //! \brief store the error message.
//  305 //!
//  306 //! \param n is a number.
//  307 //!
//  308 //! \return None.
//  309 //
//  310 //*****************************************************************************
//  311 static void
//  312 TestErrorInfoStoreNumber(unsigned long n)
//  313 {
//  314     char buf[16], *p;
//  315 
//  316     int i = 0;
//  317 
//  318     while((i < TEST_ERROR_BUF_SIZE-1) && g_pcErrorInfoBuffer[i] != '\0')
//  319     {
//  320         i++;
//  321     }
//  322 
//  323 
//  324     if (n == 0 && (i < TEST_ERROR_BUF_SIZE-1))
//  325     {
//  326         g_pcErrorInfoBuffer[i++] = '0';
//  327     }
//  328     else
//  329     {
//  330         p = buf;
//  331         while (n != 0)
//  332         {
//  333             *p++ = (n % 10) + '0';
//  334             n /= 10;
//  335         }
//  336 
//  337 
//  338         while (p > buf)
//  339         {
//  340             g_pcErrorInfoBuffer[i++] = *--p;
//  341         }
//  342     }
//  343 
//  344     g_pcErrorInfoBuffer[i] = '\0';
//  345 
//  346 }
//  347 #endif
//  348 
//  349 //*****************************************************************************
//  350 //
//  351 //! \brief set the global value of error flag.
//  352 //!
//  353 //! \return None.
//  354 //
//  355 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  356 static xtBoolean
//  357 _TestFail(void)
//  358 {
//  359     g_bLocalFail = xtrue;
_TestFail:
        LDR      R0,??DataTable6_2
        MOVS     R1,#+1
        STRB     R1,[R0, #+0]
//  360     g_bGlobalFail = xtrue;
        LDR      R0,??DataTable6_3
        MOVS     R1,#+1
        STRB     R1,[R0, #+0]
//  361     return xtrue;
        MOVS     R0,#+1
        BX       LR               ;; return
//  362 }
//  363 
//  364 #ifndef ENHANCE_MODE
//  365 //*****************************************************************************
//  366 //
//  367 //! \brief Test assertion.
//  368 //!
//  369 //! \param pcFile is the current file name. usually is \b __FILE__
//  370 //! \param ulLine is the current line number. usually is \b __LINE__
//  371 //! \param bCondition is the checking expr. \b xtrue, \bxfalse
//  372 //! \param pcMsg failure message
//  373 //!
//  374 //! \details The TestAssert macro, which does the actual assertion checking.
//  375 //!
//  376 //! \return None.
//  377 //
//  378 //*****************************************************************************
//  379 xtBoolean
//  380 _TestAssert(char* pcFile, unsigned long ulLine,
//  381               xtBoolean bCondition,
//  382               char * pcMsg)
//  383 {
//  384     if (bCondition == xfalse)
//  385     {
//  386         TestErrorInfoClear();
//  387         TestErrorInfoStore("\r\nFile:\t");
//  388         TestErrorInfoStore(pcFile);
//  389         TestErrorInfoStore("\r\nLine:\t");
//  390         TestErrorInfoStoreNumber(ulLine);
//  391         TestErrorInfoStore("\r\nError:\t");
//  392         TestErrorInfoStore(pcMsg);
//  393         return _TestFail();
//  394     }
//  395 
//  396     return xfalse;
//  397 }
//  398 #endif
//  399 
//  400 //*****************************************************************************
//  401 //
//  402 //! \brief Test sequence assertion.
//  403 //!
//  404 //! \param pcExpected is the expect token seq.
//  405 //! \param ulDelay wait delay time
//  406 
//  407 //!
//  408 //! \details Test sequence assertion.
//  409 //! \note If ulDelay is -1,then this will not break until sequence token is
//  410 //! finished! if ulDelay is not -1,then it will be wait delay time.ulDelay
//  411 //! is 0,show that there will be no delay!
//  412 //!
//  413 //! \return None.
//  414 //
//  415 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  416 xtBoolean
//  417 _TestAssertSequenceBreak(char *pcExpected, unsigned long ulDelay)
//  418 {
_TestAssertSequenceBreak:
        PUSH     {R3-R7,LR}
        MOVS     R4,R0
        MOVS     R7,R1
//  419     char *cp = g_pcTokensBuffer;
        LDR      R5,??DataTable6_1
//  420     unsigned long ulTemp = ulDelay;
        MOVS     R6,R7
//  421     do
//  422     {
//  423         while (cp < g_pcTok)
??_TestAssertSequenceBreak_0:
        LDR      R0,??DataTable6
        LDR      R0,[R0, #+0]
        CMP      R5,R0
        BCS      ??_TestAssertSequenceBreak_1
//  424         {
//  425             if (*cp++ != *pcExpected++)
        MOVS     R0,R5
        MOVS     R5,R0
        ADDS     R5,R5,#+1
        MOVS     R1,R4
        MOVS     R4,R1
        ADDS     R4,R4,#+1
        LDRB     R0,[R0, #+0]
        LDRB     R1,[R1, #+0]
        CMP      R0,R1
        BEQ      ??_TestAssertSequenceBreak_0
//  426             {
//  427                 return _TestFail();
        BL       _TestFail
        B        ??_TestAssertSequenceBreak_2
//  428             }
//  429         }
//  430         SysCtlDelay(1);
??_TestAssertSequenceBreak_1:
        MOVS     R0,#+1
        BL       SysCtlDelay
//  431         if (*pcExpected == '\0')
        LDRB     R0,[R4, #+0]
        CMP      R0,#+0
        BNE      ??_TestAssertSequenceBreak_3
//  432         {
//  433             ClearTokens();
        BL       ClearTokens
//  434             return xfalse;
        MOVS     R0,#+0
        B        ??_TestAssertSequenceBreak_2
//  435         }
//  436         if (ulDelay == 0xFFFFFFFF)
??_TestAssertSequenceBreak_3:
        MOVS     R0,#+0
        MVNS     R0,R0            ;; #-1
        CMP      R7,R0
        BNE      ??_TestAssertSequenceBreak_4
//  437         {
//  438             ulTemp = 1;
        MOVS     R0,#+1
        MOVS     R6,R0
        B        ??_TestAssertSequenceBreak_5
//  439         }
//  440         else if(ulDelay != 0)
??_TestAssertSequenceBreak_4:
        CMP      R7,#+0
        BEQ      ??_TestAssertSequenceBreak_5
//  441         {
//  442             ulTemp--;
        SUBS     R6,R6,#+1
//  443         }
//  444     } while(ulTemp);
??_TestAssertSequenceBreak_5:
        CMP      R6,#+0
        BNE      ??_TestAssertSequenceBreak_0
//  445     return _TestFail();
        BL       _TestFail
??_TestAssertSequenceBreak_2:
        POP      {R1,R4-R7,PC}    ;; return
//  446 }
//  447 
//  448 //*****************************************************************************
//  449 //
//  450 //! \brief Execute the test.
//  451 //!
//  452 //! \param psTest is the point of the test case.
//  453 //!
//  454 //! \details Test suite execution.
//  455 //!
//  456 //! \return None.
//  457 //
//  458 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  459 static void
//  460 ExecuteTest(const tTestCase *psTest)
//  461 {
ExecuteTest:
        PUSH     {R4,LR}
        MOVS     R4,R0
//  462     //
//  463     // Initialization
//  464     //
//  465     ClearTokens();
        BL       ClearTokens
//  466     g_bLocalFail = xfalse;
        LDR      R0,??DataTable6_2
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  467 
//  468     if (psTest->Setup != 0)
        LDR      R0,[R4, #+4]
        CMP      R0,#+0
        BEQ      ??ExecuteTest_0
//  469     {
//  470         psTest->Setup();
        LDR      R0,[R4, #+4]
        BLX      R0
//  471     }
//  472 
//  473     psTest->Execute();
??ExecuteTest_0:
        LDR      R0,[R4, #+12]
        BLX      R0
//  474 
//  475     if (psTest->TearDown != 0)
        LDR      R0,[R4, #+8]
        CMP      R0,#+0
        BEQ      ??ExecuteTest_1
//  476     {
//  477         psTest->TearDown();
        LDR      R0,[R4, #+8]
        BLX      R0
//  478     }
//  479 }
??ExecuteTest_1:
        POP      {R4,PC}          ;; return
//  480 
//  481 
//  482 #ifndef ENHANCE_MODE
//  483 //*****************************************************************************
//  484 //
//  485 //! \brief Test execution thread function.
//  486 //!
//  487 //! \param None
//  488 //!
//  489 //! \details Test execution thread function.
//  490 //!
//  491 //! \return The test result xtrue or xfalse.
//  492 //
//  493 //*****************************************************************************
//  494 xtBoolean
//  495 TestMain(void)
//  496 {
//  497     int i, j;
//  498 
//  499     TestIOInit();
//  500 
//  501     PrintLine("");
//  502     PrintLine("*** CooCox CoIDE components test suites");
//  503     PrintLine("***");
//  504 #ifdef TEST_COMPONENTS_NAME
//  505     Print("*** Components: ");
//  506     PrintLine(TEST_COMPONENTS_NAME);
//  507 #endif
//  508 #ifdef TEST_COMPONENTS_VERSION
//  509     Print("*** Version:       ");
//  510     PrintLine(TEST_COMPONENTS_VERSION);
//  511 #endif
//  512 #ifdef TEST_BOARD_NAME
//  513     Print("*** Test Board:   ");
//  514     PrintLine(TEST_BOARD_NAME);
//  515 #endif
//  516     PrintLine("");
//  517 
//  518     g_bGlobalFail = xfalse;
//  519     i = 0;
//  520     while (g_psPatterns[i])
//  521     {
//  522         j = 0;
//  523         while (g_psPatterns[i][j])
//  524         {
//  525             PrintNewLine();
//  526             Print("--- Test Case ");
//  527             PrintN(i + 1);
//  528             Print(".");
//  529             PrintN(j + 1);
//  530             Print(" (");
//  531             Print(g_psPatterns[i][j]->GetTest());
//  532             PrintLine(")");
//  533 
//  534             ExecuteTest(g_psPatterns[i][j]);
//  535             if (g_bLocalFail == xtrue)
//  536             {
//  537                 Print("--- Result: FAILURE ");
//  538                 PrintLine("");
//  539                 //
//  540                 //printf error information
//  541                 //
//  542                 Print(g_pcErrorInfoBuffer);
//  543                 PrintLine("");
//  544                 if (g_pcTokensBuffer < g_pcTok)
//  545                 {
//  546                     Print(" The tokens in buffer is: ");
//  547                     PrintTokens();
//  548                     PrintLine("");
//  549                 }
//  550             }
//  551             else
//  552             {
//  553                 PrintLine("--- Result: SUCCESS ");
//  554             }
//  555             j++;
//  556         }
//  557         i++;
//  558     }
//  559 
//  560     PrintNewLine();
//  561     PrintLine("");
//  562     Print("Final result: ");
//  563 
//  564     if (g_bGlobalFail == xtrue)
//  565     PrintLine("FAILURE");
//  566     else
//  567     PrintLine("SUCCESS");
//  568 
//  569     return g_bGlobalFail;
//  570 }
//  571 #endif
//  572 
//  573 //
//  574 // Enhance Mode
//  575 //
//  576 #ifdef ENHANCE_MODE

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  577 static uint32 NumToStr(uint32 Num,
//  578                        uint32  Base,
//  579                        uint8  *Buffer,
//  580                        uint32 BufferSize)
//  581 {
NumToStr:
        PUSH     {R0,R1,R3-R7,LR}
        SUB      SP,SP,#+4
        MOVS     R4,R2
//  582     uint32        tmpNum = Num;
        LDR      R5,[SP, #+4]
//  583     uint32        index  = 0;
        MOVS     R6,#+0
//  584     uint32        Strlen = 0;
        MOVS     R7,#+0
//  585     const uint8 * NumStr = (uint8 *)"0123456789ABCDEF";
        LDR      R0,??DataTable10
        STR      R0,[SP, #+0]
//  586 
//  587     if((Buffer == NULL) || (BufferSize == 0))
        CMP      R4,#+0
        BEQ      ??NumToStr_0
        LDR      R0,[SP, #+12]
        CMP      R0,#+0
        BNE      ??NumToStr_1
//  588     {
//  589         Strlen = 0;
??NumToStr_0:
        MOVS     R0,#+0
        MOVS     R7,R0
//  590         return (Strlen);
        MOVS     R0,R7
        B        ??NumToStr_2
//  591     }
//  592 
//  593     if(tmpNum == 0)
??NumToStr_1:
        CMP      R5,#+0
        BNE      ??NumToStr_3
//  594     {
//  595         *Buffer = '0';
        MOVS     R0,#+48
        STRB     R0,[R4, #+0]
//  596         *(Buffer+1) = '\0';
        MOVS     R0,#+0
        STRB     R0,[R4, #+1]
//  597 
//  598         Strlen = 1;
        MOVS     R0,#+1
        MOVS     R7,R0
//  599         return (Strlen);
        MOVS     R0,R7
        B        ??NumToStr_2
//  600     }
//  601 
//  602     while(tmpNum)
??NumToStr_3:
        CMP      R5,#+0
        BEQ      ??NumToStr_4
//  603     {
//  604         tmpNum /= Base;
        MOVS     R0,R5
        LDR      R1,[SP, #+8]
        BL       __aeabi_uidiv
        MOVS     R5,R0
//  605         index++;
        ADDS     R6,R6,#+1
        B        ??NumToStr_3
//  606     }
//  607 
//  608     Strlen = index;
??NumToStr_4:
        MOVS     R7,R6
//  609     if(Strlen > (BufferSize-1))
        LDR      R0,[SP, #+12]
        SUBS     R0,R0,#+1
        CMP      R0,R7
        BCS      ??NumToStr_5
//  610     {
//  611         Strlen = 0;
        MOVS     R0,#+0
        MOVS     R7,R0
//  612         return (Strlen);
        MOVS     R0,R7
        B        ??NumToStr_2
//  613     }
//  614 
//  615     *(Buffer + index) = '\0';
??NumToStr_5:
        MOVS     R0,#+0
        STRB     R0,[R4, R6]
//  616     tmpNum = Num;
        LDR      R0,[SP, #+4]
        MOVS     R5,R0
//  617 
//  618     while(tmpNum)
??NumToStr_6:
        CMP      R5,#+0
        BEQ      ??NumToStr_7
//  619     {
//  620         --index;
        SUBS     R6,R6,#+1
//  621         *(Buffer + index) = (uint8)*(tmpNum%Base + NumStr);
        MOVS     R0,R5
        LDR      R1,[SP, #+8]
        BL       __aeabi_uidivmod
        LDR      R0,[SP, #+0]
        LDRB     R0,[R0, R1]
        STRB     R0,[R4, R6]
//  622         tmpNum /= Base;
        MOVS     R0,R5
        LDR      R1,[SP, #+8]
        BL       __aeabi_uidiv
        MOVS     R5,R0
        B        ??NumToStr_6
//  623     }
//  624 
//  625     return (Strlen);
??NumToStr_7:
        MOVS     R0,R7
??NumToStr_2:
        ADD      SP,SP,#+16
        POP      {R4-R7,PC}       ;; return
//  626 }
//  627 
//  628 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  629 static uint32 PrintDec(VirtualIoPort pIOPutChar, void * pParam)
//  630 {
PrintDec:
        PUSH     {R1,R4-R7,LR}
        SUB      SP,SP,#+16
        MOVS     R6,R0
//  631 #define BUF_SIZE 16
//  632     uint32 i             = 0;
        MOVS     R4,#+0
//  633     uint32 NumOfChar     = 0;
        MOVS     R5,#+0
//  634     uint32 DecValue      = 0;
        MOVS     R7,#+0
//  635     uint8  Buf[BUF_SIZE] = {0};
        MOV      R0,SP
        MOVS     R1,#+16
        BL       __aeabi_memclr4
//  636 
//  637     //
//  638     // check the argument
//  639     //
//  640     if(NULL == pParam)
        LDR      R0,[SP, #+16]
        CMP      R0,#+0
        BNE      ??PrintDec_0
//  641     {
//  642         return NumOfChar;
        MOVS     R0,R5
        B        ??PrintDec_1
//  643     }
//  644 
//  645     DecValue = (uint32)pParam;
??PrintDec_0:
        LDR      R0,[SP, #+16]
        MOVS     R7,R0
//  646 
//  647     //
//  648     // Clear the memory
//  649     //
//  650     for(i = 0; i < BUF_SIZE; i++)
        MOVS     R0,#+0
        MOVS     R4,R0
??PrintDec_2:
        CMP      R4,#+16
        BCS      ??PrintDec_3
//  651     {
//  652         Buf[i] = '\0';
        MOV      R0,SP
        MOVS     R1,#+0
        STRB     R1,[R0, R4]
//  653     }
        ADDS     R4,R4,#+1
        B        ??PrintDec_2
//  654 
//  655     //
//  656     // Convert num to dec format
//  657     //
//  658     NumToStr(DecValue, 10, &Buf[0], BUF_SIZE);
??PrintDec_3:
        MOVS     R3,#+16
        MOV      R2,SP
        MOVS     R1,#+10
        MOVS     R0,R7
        BL       NumToStr
//  659 
//  660     //
//  661     // Output String to IO port,and count the num of chars
//  662     //
//  663     for(i = 0; (i < BUF_SIZE) && ('\0' != Buf[i]); i++)
        MOVS     R0,#+0
        MOVS     R4,R0
??PrintDec_4:
        CMP      R4,#+16
        BCS      ??PrintDec_5
        MOV      R0,SP
        LDRB     R0,[R0, R4]
        CMP      R0,#+0
        BEQ      ??PrintDec_5
//  664     {
//  665         (*pIOPutChar)(Buf[i]);
        MOV      R0,SP
        LDRB     R0,[R0, R4]
        BLX      R6
//  666         NumOfChar++;
        ADDS     R5,R5,#+1
//  667     }
        ADDS     R4,R4,#+1
        B        ??PrintDec_4
//  668 
//  669     return NumOfChar;
??PrintDec_5:
        MOVS     R0,R5
??PrintDec_1:
        ADD      SP,SP,#+20
        POP      {R4-R7,PC}       ;; return
//  670 #undef BUF_SIZE
//  671 }
//  672 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  673 static uint32 PrintStr(VirtualIoPort pIOPutChar, void * pParam)
//  674 {
PrintStr:
        PUSH     {R3-R7,LR}
        MOVS     R4,R0
        MOVS     R7,R1
//  675     uint32 NumOfChar = 0;
        MOVS     R5,#+0
//  676     uint8  *pStr     = 0;
        MOVS     R6,#+0
//  677 
//  678     //
//  679     // Check the argument
//  680     //
//  681     if(NULL == pParam)
        CMP      R7,#+0
        BNE      ??PrintStr_0
//  682     {
//  683         return NumOfChar;
        MOVS     R0,R5
        B        ??PrintStr_1
//  684     }
//  685 
//  686     pStr = (uint8 *) pParam;
??PrintStr_0:
        MOVS     R6,R7
//  687 
//  688     //
//  689     // Output the string and count the number of char
//  690     //
//  691     while(*pStr)
??PrintStr_2:
        LDRB     R0,[R6, #+0]
        CMP      R0,#+0
        BEQ      ??PrintStr_3
//  692     {
//  693         NumOfChar++;
        ADDS     R5,R5,#+1
//  694         (*pIOPutChar)(*pStr++);
        LDRB     R0,[R6, #+0]
        BLX      R4
        ADDS     R6,R6,#+1
        B        ??PrintStr_2
//  695     }
//  696 
//  697     return NumOfChar;
??PrintStr_3:
        MOVS     R0,R5
??PrintStr_1:
        POP      {R1,R4-R7,PC}    ;; return
//  698 }
//  699 
//  700 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  701 static uint32 PrintHex(VirtualIoPort pIOPutChar, void * pParam)
//  702 {
PrintHex:
        PUSH     {R1,R4-R7,LR}
        SUB      SP,SP,#+16
        MOVS     R6,R0
//  703 #define BUF_SIZE 16
//  704     uint32 i             = 0;
        MOVS     R4,#+0
//  705     uint32 NumOfChar     = 0;
        MOVS     R5,#+0
//  706     uint32 HexValue      = 0;
        MOVS     R7,#+0
//  707     uint8  Buf[BUF_SIZE] = {'0','X'};
        MOV      R0,SP
        LDR      R1,??DataTable11
        MOVS     R2,#+16
        BL       __aeabi_memcpy4
//  708 
//  709     //
//  710     // check the argument
//  711     //
//  712     if(NULL == pParam)
        LDR      R0,[SP, #+16]
        CMP      R0,#+0
        BNE      ??PrintHex_0
//  713     {
//  714         return NumOfChar;
        MOVS     R0,R5
        B        ??PrintHex_1
//  715     }
//  716 
//  717     HexValue = (uint32)pParam;
??PrintHex_0:
        LDR      R0,[SP, #+16]
        MOVS     R7,R0
//  718 
//  719     //
//  720     // Clear the memory, expect the first two value('0','X')
//  721     //
//  722     for(i = 2; i < BUF_SIZE; i++)
        MOVS     R0,#+2
        MOVS     R4,R0
??PrintHex_2:
        CMP      R4,#+16
        BCS      ??PrintHex_3
//  723     {
//  724         Buf[i] = '\0';
        MOV      R0,SP
        MOVS     R1,#+0
        STRB     R1,[R0, R4]
//  725     }
        ADDS     R4,R4,#+1
        B        ??PrintHex_2
//  726 
//  727     //
//  728     // Convert num to hex format
//  729     //
//  730     NumToStr(HexValue, 16, &Buf[2], (BUF_SIZE-2));
??PrintHex_3:
        MOVS     R3,#+14
        MOV      R2,SP
        ADDS     R2,R2,#+2
        MOVS     R1,#+16
        MOVS     R0,R7
        BL       NumToStr
//  731 
//  732     //
//  733     // Output String to IO port,and count the num of chars
//  734     //
//  735     for(i = 0; (i < BUF_SIZE) && ('\0' != Buf[i]); i++)
        MOVS     R0,#+0
        MOVS     R4,R0
??PrintHex_4:
        CMP      R4,#+16
        BCS      ??PrintHex_5
        MOV      R0,SP
        LDRB     R0,[R0, R4]
        CMP      R0,#+0
        BEQ      ??PrintHex_5
//  736     {
//  737         (*pIOPutChar)(Buf[i]);
        MOV      R0,SP
        LDRB     R0,[R0, R4]
        BLX      R6
//  738         NumOfChar++;
        ADDS     R5,R5,#+1
//  739     }
        ADDS     R4,R4,#+1
        B        ??PrintHex_4
//  740 
//  741     return NumOfChar;
??PrintHex_5:
        MOVS     R0,R5
??PrintHex_1:
        ADD      SP,SP,#+20
        POP      {R4-R7,PC}       ;; return
//  742 #undef BUF_SIZE
//  743 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6:
        DC32     g_pcTok

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_1:
        DC32     g_pcTokensBuffer

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_2:
        DC32     g_bLocalFail

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable6_3:
        DC32     g_bGlobalFail
//  744 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  745 uint32 Print(VirtualIoPort pIoPutchar, const char * pcMsg, va_list VarPara)
//  746 {
Print:
        PUSH     {R0,R1,R4-R7,LR}
        SUB      SP,SP,#+12
        MOVS     R6,R2
//  747     uint8   Token     = 0;
        MOV      R0,SP
        MOVS     R1,#+0
        STRB     R1,[R0, #+4]
//  748     uint32  NumOfChar = 0;
        MOVS     R4,#+0
//  749     const char * pStr = pcMsg;
        LDR      R5,[SP, #+16]
//  750 
//  751     uint32 FSM_Status = FSM_BEGIN;
        MOVS     R7,#+0
//  752 
//  753     //
//  754     //vaild pointer, return 0
//  755     //
//  756     if(NULL == pStr)
        CMP      R5,#+0
        BNE      ??Print_0
//  757     {
//  758         return 0;
        MOVS     R0,#+0
        B        ??Print_1
//  759     }
//  760 
//  761     //
//  762     // use FSM(Fimit state Machine) to deal string
//  763     //
//  764     while(1)
//  765     {
//  766         switch(FSM_Status)
??Print_0:
        CMP      R7,#+0
        BEQ      ??Print_2
        CMP      R7,#+2
        BEQ      ??Print_3
        BCC      ??Print_4
        CMP      R7,#+3
        BEQ      ??Print_5
        B        ??Print_0
//  767         {
//  768             case FSM_BEGIN:
//  769                 {
//  770                     Token = *pStr;
??Print_2:
        MOV      R0,SP
        LDRB     R1,[R5, #+0]
        STRB     R1,[R0, #+4]
//  771 
//  772                     if('\0' == Token)
        MOV      R0,SP
        LDRB     R0,[R0, #+4]
        CMP      R0,#+0
        BNE      ??Print_6
//  773                     {
//  774                         FSM_Status = FSM_END;
        MOVS     R0,#+1
        MOVS     R7,R0
        B        ??Print_7
//  775                     }
//  776                     else if('%' == Token)
??Print_6:
        MOV      R0,SP
        LDRB     R0,[R0, #+4]
        CMP      R0,#+37
        BNE      ??Print_8
//  777                     {
//  778                         pStr += 1;
        ADDS     R5,R5,#+1
//  779                         FSM_Status = FSM_DISPATCH;
        MOVS     R0,#+3
        MOVS     R7,R0
        B        ??Print_7
//  780                     }
//  781                     else
//  782                     {
//  783                         FSM_Status = FSM_CHAR;
??Print_8:
        MOVS     R0,#+2
        MOVS     R7,R0
//  784                     }
//  785 
//  786                     break;
??Print_7:
        B        ??Print_0
//  787                 }
//  788             case FSM_CHAR:
//  789                 {
//  790                    (*pIoPutchar)(*pStr++);
??Print_3:
        LDRB     R0,[R5, #+0]
        LDR      R1,[SP, #+12]
        BLX      R1
        ADDS     R5,R5,#+1
//  791                     NumOfChar++;
        ADDS     R4,R4,#+1
//  792                     FSM_Status = FSM_BEGIN;
        MOVS     R0,#+0
        MOVS     R7,R0
//  793                     break;
        B        ??Print_0
//  794                 }
//  795             case FSM_DISPATCH:
//  796                 {
//  797                     Token = *pStr++;
??Print_5:
        MOV      R0,SP
        LDRB     R1,[R5, #+0]
        STRB     R1,[R0, #+4]
        ADDS     R5,R5,#+1
//  798                     FSM_Status = FSM_BEGIN;
        MOVS     R0,#+0
        MOVS     R7,R0
//  799                     switch(Token)
        MOV      R0,SP
        LDRB     R0,[R0, #+4]
        CMP      R0,#+88
        BEQ      ??Print_9
        CMP      R0,#+100
        BEQ      ??Print_10
        CMP      R0,#+115
        BEQ      ??Print_11
        CMP      R0,#+120
        BNE      ??Print_12
//  800                     {
//  801                         case 'x':
//  802                         case 'X':
//  803                             {
//  804                                 uint32 InputPara = 0;
??Print_9:
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
//  805                                 InputPara = va_arg(VarPara, uint32);
        LDR      R0,[R6, #+0]
        STR      R0,[SP, #+0]
        ADDS     R6,R6,#+4
//  806                                 NumOfChar += PrintHex(pIoPutchar, (void *)InputPara);
        LDR      R1,[SP, #+0]
        LDR      R0,[SP, #+12]
        BL       PrintHex
        ADDS     R0,R4,R0
        MOVS     R4,R0
//  807                                 break;
        B        ??Print_13
//  808                             }
//  809                        case 'd':
//  810                             {
//  811                                 uint32 InputPara = 0;
??Print_10:
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
//  812                                 InputPara = va_arg(VarPara, uint32);
        LDR      R0,[R6, #+0]
        STR      R0,[SP, #+0]
        ADDS     R6,R6,#+4
//  813                                 NumOfChar += PrintDec(pIoPutchar, (void *)InputPara);
        LDR      R1,[SP, #+0]
        LDR      R0,[SP, #+12]
        BL       PrintDec
        ADDS     R0,R4,R0
        MOVS     R4,R0
//  814                                 break;
        B        ??Print_13
//  815                             }
//  816                        case 's':
//  817                             {
//  818                                 uint8  *InputPara = 0;
??Print_11:
        MOVS     R0,#+0
        STR      R0,[SP, #+0]
//  819                                 InputPara = va_arg(VarPara, uint8 *);
        LDR      R0,[R6, #+0]
        STR      R0,[SP, #+0]
        ADDS     R6,R6,#+4
//  820                                 NumOfChar += PrintStr(pIoPutchar, (void *)InputPara);
        LDR      R1,[SP, #+0]
        LDR      R0,[SP, #+12]
        BL       PrintStr
        ADDS     R0,R4,R0
        MOVS     R4,R0
//  821                                 break;
        B        ??Print_13
//  822                             }
//  823 
//  824                        //
//  825                        // If you want to add new function, add your code here
//  826                        // for example: you can add %p feature in ErrorPrint
//  827                        // for you can print the address of varilable
//  828                        //
//  829                        // case 'p':
//  830                        // {
//  831                        //     //your code is here
//  832                        //
//  833                        //     uint8  *InputPara = 0;
//  834                        //     InputPara = va_arg(pVar, uint8 *);
//  835                        //     NumOfChar += PrintPointer(pIoPutchar, (void *)InputPara);
//  836                        //     break;
//  837                        // }
//  838                        //
//  839 
//  840                        default:
//  841                             {
//  842                                 (*pIoPutchar)(Token);
??Print_12:
        MOV      R0,SP
        LDRB     R0,[R0, #+4]
        LDR      R1,[SP, #+12]
        BLX      R1
//  843                                 NumOfChar++;
        ADDS     R4,R4,#+1
//  844                                 break;
//  845                             }
//  846                     }
//  847                     break;
??Print_13:
        B        ??Print_0
//  848                 }
//  849             case FSM_END:
//  850                 {
//  851                     va_end(pVar);
//  852                     return NumOfChar;
??Print_4:
        MOVS     R0,R4
??Print_1:
        ADD      SP,SP,#+20
        POP      {R4-R7,PC}       ;; return
//  853                 }
//  854         }
//  855 
//  856     }
//  857 }
//  858 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  859 static void BufWrite(char ch)
//  860 {
BufWrite:
        PUSH     {LR}
//  861     if(ErrorBufIndex < TEST_ERROR_BUF_SIZE)
        LDR      R1,??DataTable11_1
        LDR      R1,[R1, #+0]
        MOVS     R2,#+128
        LSLS     R2,R2,#+2        ;; #+512
        CMP      R1,R2
        BCS      ??BufWrite_0
//  862     {
//  863         g_pcErrorInfoBuffer[ErrorBufIndex++] = ch;
        LDR      R1,??DataTable11_1
        LDR      R1,[R1, #+0]
        LDR      R2,??DataTable11_2
        STRB     R0,[R2, R1]
        LDR      R1,??DataTable11_1
        LDR      R1,[R1, #+0]
        ADDS     R1,R1,#+1
        LDR      R2,??DataTable11_1
        STR      R1,[R2, #+0]
//  864     }
//  865 }
??BufWrite_0:
        POP      {PC}             ;; return
//  866 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  867 uint32 FILE_Print(const char * pcMsg, ...)
//  868 {
FILE_Print:
        PUSH     {R1-R3}
        PUSH     {R3-R6,LR}
        MOVS     R5,R0
//  869     uint32 count = 0;
        MOVS     R4,#+0
//  870     va_list InputVar;
//  871     va_start(InputVar, pcMsg);
        ADD      R0,SP,#+20
        MOVS     R6,R0
//  872     count = Print(BufWrite, pcMsg, InputVar);
        MOVS     R2,R6
        MOVS     R1,R5
        LDR      R0,??DataTable11_3
        BL       Print
        MOVS     R4,R0
//  873     va_end(InputVar);
//  874     return count;
        MOVS     R0,R4
        ADD      SP,SP,#+4
        LDR      R1,[SP, #+12]
        POP      {R4-R6}
        ADD      SP,SP,#+16
        BX       R1               ;; return
//  875 }
//  876 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  877 uint32 UART_Print(const char * pcMsg, ...)
//  878 {
UART_Print:
        PUSH     {R1-R3}
        PUSH     {R3-R6,LR}
        MOVS     R5,R0
//  879     uint32 count = 0;
        MOVS     R4,#+0
//  880     va_list InputVar;
//  881     va_start(InputVar, pcMsg);
        ADD      R0,SP,#+20
        MOVS     R6,R0
//  882     count = Print(TestIOPut, pcMsg, InputVar);
        MOVS     R2,R6
        MOVS     R1,R5
        LDR      R0,??DataTable11_4
        BL       Print
        MOVS     R4,R0
//  883     va_end(InputVar);
//  884     return count;
        MOVS     R0,R4
        ADD      SP,SP,#+4
        LDR      R1,[SP, #+12]
        POP      {R4-R6}
        ADD      SP,SP,#+16
        BX       R1               ;; return
//  885 }
//  886 

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  887 void _TestAssert(const char * pcMsg, ...)
//  888 {
_TestAssert:
        PUSH     {R1-R3}
        PUSH     {R4,R5,LR}
        MOVS     R4,R0
//  889     va_list InputVar;
//  890 
//  891     ErrorBufIndex = 0;
        LDR      R0,??DataTable11_1
        MOVS     R1,#+0
        STR      R1,[R0, #+0]
//  892     memset(g_pcErrorInfoBuffer, '\0', TEST_ERROR_BUF_SIZE);
        MOVS     R2,#+128
        LSLS     R2,R2,#+2        ;; #+512
        MOVS     R1,#+0
        LDR      R0,??DataTable11_2
        BL       memset
//  893     va_start(InputVar, pcMsg);
        ADD      R0,SP,#+12
        MOVS     R5,R0
//  894     Print(BufWrite, pcMsg, InputVar);
        MOVS     R2,R5
        MOVS     R1,R4
        LDR      R0,??DataTable11_3
        BL       Print
//  895     va_end(InputVar);
//  896     _TestFail();
        BL       _TestFail
//  897 }
        LDR      R0,[SP, #+8]
        POP      {R4,R5}
        ADD      SP,SP,#+16
        BX       R0               ;; return

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable10:
        DC32     `?<Constant "0123456789ABCDEF">`
//  898 
//  899 //*****************************************************************************
//  900 //
//  901 //! \brief Test execution thread function.
//  902 //!
//  903 //! \param None
//  904 //!
//  905 //! \details Test execution thread function.
//  906 //!
//  907 //! \return The test result xtrue or xfalse.
//  908 //
//  909 //*****************************************************************************

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  910 xtBoolean TestMain(void)
//  911 {
TestMain:
        PUSH     {R3-R5,LR}
//  912     uint32 i = 0;
        MOVS     R5,#+0
//  913     uint32 j = 0;
        MOVS     R4,#+0
//  914 
//  915     TestIOInit();
        BL       TestIOInit
//  916 
//  917     UART_Print("\r\n*** CooCox CoIDE components test suites\r\n");
        LDR      R0,??DataTable11_5
        BL       UART_Print
//  918 #ifdef TEST_COMPONENTS_NAME
//  919     UART_Print("*** Components: %s\r\n", TEST_COMPONENTS_NAME);
        LDR      R1,??DataTable11_6
        LDR      R0,??DataTable11_7
        BL       UART_Print
//  920 #endif
//  921 #ifdef TEST_COMPONENTS_VERSION
//  922     UART_Print("*** Version   : %s\r\n", TEST_COMPONENTS_VERSION);
        LDR      R1,??DataTable11_8
        LDR      R0,??DataTable11_9
        BL       UART_Print
//  923 #endif
//  924 #ifdef TEST_BOARD_NAME
//  925     UART_Print("*** Test Board: %s\r\n", TEST_BOARD_NAME);
        LDR      R1,??DataTable11_10
        LDR      R0,??DataTable11_11
        BL       UART_Print
//  926 #endif
//  927     g_bGlobalFail = xfalse;
        LDR      R0,??DataTable11_12
        MOVS     R1,#+0
        STRB     R1,[R0, #+0]
//  928 
//  929     i = 0;
        MOVS     R0,#+0
        MOVS     R5,R0
//  930     while (g_psPatterns[i])
??TestMain_0:
        MOVS     R0,#+4
        MULS     R0,R5,R0
        LDR      R1,??DataTable11_13
        LDR      R0,[R1, R0]
        CMP      R0,#+0
        BEQ      ??TestMain_1
//  931     {
//  932         j = 0;
        MOVS     R0,#+0
        MOVS     R4,R0
//  933         while (g_psPatterns[i][j])
??TestMain_2:
        MOVS     R0,#+4
        MULS     R0,R4,R0
        MOVS     R1,#+4
        MULS     R1,R5,R1
        LDR      R2,??DataTable11_13
        LDR      R1,[R2, R1]
        LDR      R0,[R1, R0]
        CMP      R0,#+0
        BEQ      ??TestMain_3
//  934         {
//  935             UART_Print("%s\r\n--- Test Case %d.%d", NEW_LINE, i+1, j+1);
        MOVS     R3,R4
        ADDS     R3,R3,#+1
        MOVS     R2,R5
        ADDS     R2,R2,#+1
        LDR      R1,??DataTable11_14
        LDR      R0,??DataTable11_15
        BL       UART_Print
//  936             UART_Print("(%s)\r\n", g_psPatterns[i][j]->GetTest());
        MOVS     R0,#+4
        MULS     R0,R4,R0
        MOVS     R1,#+4
        MULS     R1,R5,R1
        LDR      R2,??DataTable11_13
        LDR      R1,[R2, R1]
        LDR      R0,[R1, R0]
        LDR      R0,[R0, #+0]
        BLX      R0
        MOVS     R1,R0
        LDR      R0,??DataTable11_16
        BL       UART_Print
//  937 
//  938             ExecuteTest(g_psPatterns[i][j]);
        MOVS     R0,#+4
        MULS     R0,R4,R0
        MOVS     R1,#+4
        MULS     R1,R5,R1
        LDR      R2,??DataTable11_13
        LDR      R1,[R2, R1]
        LDR      R0,[R1, R0]
        BL       ExecuteTest
//  939             if (g_bLocalFail == xtrue)
        LDR      R0,??DataTable11_17
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE      ??TestMain_4
//  940             {
//  941 
//  942                 UART_Print("--- Result: FAILURE \r\n%s\r\n", g_pcErrorInfoBuffer);
        LDR      R1,??DataTable11_2
        LDR      R0,??DataTable11_18
        BL       UART_Print
//  943 
//  944                 if (g_pcTokensBuffer < g_pcTok)
        LDR      R0,??DataTable11_19
        LDR      R1,??DataTable11_20
        LDR      R1,[R1, #+0]
        CMP      R0,R1
        BCS      ??TestMain_5
//  945                 {
//  946                     UART_Print(" The tokens in buffer is: %s\r\n", g_pcTokensBuffer);
        LDR      R1,??DataTable11_19
        LDR      R0,??DataTable11_21
        BL       UART_Print
        B        ??TestMain_5
//  947                 }
//  948             }
//  949             else
//  950             {
//  951                 UART_Print("--- Result: SUCCESS \r\n");
??TestMain_4:
        LDR      R0,??DataTable11_22
        BL       UART_Print
//  952             }
//  953             j++;
??TestMain_5:
        ADDS     R4,R4,#+1
        B        ??TestMain_2
//  954         }
//  955         i++;
??TestMain_3:
        ADDS     R5,R5,#+1
        B        ??TestMain_0
//  956     }
//  957 
//  958     if (g_bGlobalFail == xtrue)
??TestMain_1:
        LDR      R0,??DataTable11_12
        LDRB     R0,[R0, #+0]
        CMP      R0,#+1
        BNE      ??TestMain_6
//  959     {
//  960         UART_Print("%s\r\nFinal result: FAILURE\r\n", NEW_LINE);
        LDR      R1,??DataTable11_14
        LDR      R0,??DataTable11_23
        BL       UART_Print
        B        ??TestMain_7
//  961     }
//  962     else
//  963     {
//  964         UART_Print("%s\r\nFinal result: SUCCESS\r\n", NEW_LINE);
??TestMain_6:
        LDR      R1,??DataTable11_14
        LDR      R0,??DataTable11_24
        BL       UART_Print
//  965     }
//  966 
//  967     return g_bGlobalFail;
??TestMain_7:
        LDR      R0,??DataTable11_12
        LDRB     R0,[R0, #+0]
        POP      {R1,R4,R5,PC}    ;; return
//  968 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11:
        DC32     `?<Constant {48, 88}>`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_1:
        DC32     ErrorBufIndex

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_2:
        DC32     g_pcErrorInfoBuffer

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_3:
        DC32     BufWrite

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_4:
        DC32     TestIOPut

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_5:
        DC32     `?<Constant "\\r\\n*** CooCox CoIDE co...">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_6:
        DC32     `?<Constant "KLxx COX Packet">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_7:
        DC32     `?<Constant "*** Components: %s\\r\\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_8:
        DC32     `?<Constant "V1.0.0">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_9:
        DC32     `?<Constant "*** Version   : %s\\r\\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_10:
        DC32     `?<Constant "KLxx board">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_11:
        DC32     `?<Constant "*** Test Board: %s\\r\\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_12:
        DC32     g_bGlobalFail

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_13:
        DC32     g_psPatterns

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_14:
        DC32     `?<Constant "---------------------...">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_15:
        DC32     `?<Constant "%s\\r\\n--- Test Case %d.%d">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_16:
        DC32     `?<Constant "(%s)\\r\\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_17:
        DC32     g_bLocalFail

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_18:
        DC32     `?<Constant "--- Result: FAILURE \\r...">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_19:
        DC32     g_pcTokensBuffer

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_20:
        DC32     g_pcTok

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_21:
        DC32     `?<Constant " The tokens in buffer...">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_22:
        DC32     `?<Constant "--- Result: SUCCESS \\r\\n">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_23:
        DC32     `?<Constant "%s\\r\\nFinal result: FAI...">`

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable11_24:
        DC32     `?<Constant "%s\\r\\nFinal result: SUC...">`

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "0123456789ABCDEF">`:
        DATA
        DC8 "0123456789ABCDEF"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
        DATA
        DC8 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant {48, 88}>`:
        DATA
        DC8 48, 88, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "\\r\\n*** CooCox CoIDE co...">`:
        DATA
        DC8 "\015\012*** CooCox CoIDE components test suites\015\012"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "*** Components: %s\\r\\n">`:
        DATA
        DC8 "*** Components: %s\015\012"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "KLxx COX Packet">`:
        DATA
        DC8 "KLxx COX Packet"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "*** Version   : %s\\r\\n">`:
        DATA
        DC8 "*** Version   : %s\015\012"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "V1.0.0">`:
        DATA
        DC8 "V1.0.0"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "*** Test Board: %s\\r\\n">`:
        DATA
        DC8 "*** Test Board: %s\015\012"
        DC8 0, 0, 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "KLxx board">`:
        DATA
        DC8 "KLxx board"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "%s\\r\\n--- Test Case %d.%d">`:
        DATA
        DC8 "%s\015\012--- Test Case %d.%d"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "---------------------...">`:
        DATA
        DC8 2DH, 2DH, 2DH, 2DH, 2DH, 2DH, 2DH, 2DH
        DC8 2DH, 2DH, 2DH, 2DH, 2DH, 2DH, 2DH, 2DH
        DC8 2DH, 2DH, 2DH, 2DH, 2DH, 2DH, 2DH, 2DH
        DC8 2DH, 2DH, 2DH, 2DH, 2DH, 2DH, 2DH, 2DH
        DC8 2DH, 2DH, 2DH, 2DH, 2DH, 2DH, 2DH, 2DH
        DC8 2DH, 2DH, 2DH, 2DH, 2DH, 2DH, 2DH, 2DH
        DC8 2DH, 2DH, 2DH, 2DH, 2DH, 2DH, 2DH, 2DH
        DC8 2DH, 2DH, 2DH, 2DH, 2DH, 2DH, 2DH, 2DH
        DC8 2DH, 2DH, 2DH, 2DH, 2DH, 2DH, 2DH, 2DH
        DC8 2DH, 2DH, 2DH, 2DH, 2DH, 2DH, 0
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "(%s)\\r\\n">`:
        DATA
        DC8 "(%s)\015\012"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "--- Result: FAILURE \\r...">`:
        DATA
        DC8 "--- Result: FAILURE \015\012%s\015\012"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant " The tokens in buffer...">`:
        DATA
        DC8 " The tokens in buffer is: %s\015\012"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "--- Result: SUCCESS \\r\\n">`:
        DATA
        DC8 "--- Result: SUCCESS \015\012"
        DC8 0

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "%s\\r\\nFinal result: FAI...">`:
        DATA
        DC8 "%s\015\012Final result: FAILURE\015\012"

        SECTION `.rodata`:CONST:REORDER:NOROOT(2)
`?<Constant "%s\\r\\nFinal result: SUC...">`:
        DATA
        DC8 "%s\015\012Final result: SUCCESS\015\012"

        END
//  969 
//  970 #endif
//  971 
//  972 
//  973 
//  974 
// 
//   534 bytes in section .bss
//   456 bytes in section .rodata
// 1 322 bytes in section .text
// 
// 1 300 bytes of CODE  memory (+ 22 bytes shared)
//   456 bytes of CONST memory
//   534 bytes of DATA  memory
//
//Errors: none
//Warnings: none
