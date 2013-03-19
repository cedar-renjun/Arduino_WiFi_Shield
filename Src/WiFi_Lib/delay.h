#ifndef _DELAY_H_
#define _DELAY_H_

#define F_CLK                   ((uint32_t)48000000)
#define TIME_K                  ((uint32_t)8       )
#define TICK_1MS                ((F_CLK/1000)/TIME_K)

static void DelayMs(volatile int32_t ms)
{
    volatile int i = 0;
    while(ms--)
    {
        for(i = 0; i < TICK_1MS; i++)
        {
            ;//void
        }
    }
}
#endif //_DELAY_H_

