/*****************************************************************************/
/*                                                                           */
/*                                apple2enh.h                                */
/*                                                                           */
/*               enhanced Apple //e system specific definitions              */
/*                                                                           */
/*                                                                           */
/*                                                                           */
/* (C) 2004  Oliver Schmidt, <ol.sc@web.de>                                  */
/*                                                                           */
/*                                                                           */
/* This software is provided 'as-is', without any expressed or implied       */
/* warranty.  In no event will the authors be held liable for any damages    */
/* arising from the use of this software.                                    */
/*                                                                           */
/* Permission is granted to anyone to use this software for any purpose,     */
/* including commercial applications, and to alter it and redistribute it    */
/* freely, subject to the following restrictions:                            */
/*                                                                           */
/* 1. The origin of this software must not be misrepresented; you must not   */
/*    claim that you wrote the original software. If you use this software   */
/*    in a product, an acknowledgment in the product documentation would be  */
/*    appreciated but is not required.                                       */
/* 2. Altered source versions must be plainly marked as such, and must not   */
/*    be misrepresented as being the original software.                      */
/* 3. This notice may not be removed or altered from any source              */
/*    distribution.                                                          */
/*                                                                           */
/*****************************************************************************/



#ifndef _APPLE2ENH_H
#define _APPLE2ENH_H



/* Check for errors */
#if !defined(__APPLE2ENH__)
#  error This module may only be used when compiling for the enhanced Apple //e!
#endif



#include <apple2.h>



/*****************************************************************************/
/*                                   Data                                    */
/*****************************************************************************/



/* Characters codes */
#define CH_DEL          0x7F
#define CH_CURS_UP      0x0B
#define CH_CURS_DOWN    0x0A

/* These are defined to be OpenApple + NumberKey */
#define CH_F1   0xB1
#define CH_F2   0xB2
#define CH_F3   0xB3
#define CH_F4   0xB4
#define CH_F5   0xB5
#define CH_F6   0xB6
#define CH_F7   0xB7
#define CH_F8   0xB8
#define CH_F9   0xB9
#define CH_F10  0xB0



/*****************************************************************************/
/*                                 Variables                                 */
/*****************************************************************************/



/* The addresses of the static drivers */
extern void a2e_auxmem_emd[];
extern void a2e_stdjoy_joy[];     /* Referred to by joy_static_stddrv[]   */
extern void a2e_stdmou_mou[];     /* Referred to by mouse_static_stddrv[] */
extern void a2e_ssc_ser[];        /* Referred to by ser_static_stddrv[]   */
extern void a2e_gs_ser[];         /* IIgs serial driver                   */
extern void a2e_hi_tgi[];         /* Referred to by tgi_static_stddrv[]   */
extern void a2e_lo_tgi[];



/*****************************************************************************/
/*                                   Code                                    */
/*****************************************************************************/



void waitvsync (void);
/* Wait for start of next frame */



/* End of apple2enh.h */
#endif
