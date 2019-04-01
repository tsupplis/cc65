/*****************************************************************************/
/*                                                                           */
/*                                  bbc.h                                    */
/*                                                                           */
/*                  BBC Micro system specific definitions                    */
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



#ifndef _BBC_H
#define _BBC_H



/* Check for errors */
#if !defined(__BBC__)
#  error This module may only be used when compiling for the BBC!
#endif

/* We need NULL. */

#if !defined(_STDDEF_H)
#  include <stddef.h>
#endif

#define CLOCKS_PER_SEC 100


/*****************************************************************************/
/*                       Character-codes (BBC charset)                       */
/*****************************************************************************/


#if defined(__BBCMASTER__)
#define CH_HLINE        0xa6
#define CH_VLINE        0xa9
#define CH_ULCORNER     0xa3
#define CH_URCORNER     0xa5
#define CH_LLCORNER     0xaa
#define CH_LRCORNER     0xac

#define CH_CURS_UP      0x8b
#define CH_CURS_DOWN    0x8a
#define CH_CURS_LEFT    0x88
#define CH_CURS_RIGHT   0x89
#define CH_PI           0xd0
#else
#define CH_HLINE        45
#define CH_VLINE        124
#define CH_ULCORNER     43
#define CH_URCORNER     43
#define CH_LLCORNER     43
#define CH_LRCORNER     43
#endif

#define CH_ESC           27
#define CH_DEL          127


/* Additional key defines */

#define VK_ESCAPE               -113
#define VK_TAB                  -97
#define VK_SPACE                -99
#define VK_CAPSLOCK             -65
#define VK_CTRL                 -2
#define VK_SHIFTLOCK            -81
#define VK_SHIFT                -1
#define VK_DEL                  -90
#define VK_COPY                 -106
#define VK_ENTER                -74
#define VK_CURS_UP              -58
#define VK_CURS_DOWN            -42
#define VK_CURS_LEFT            -26
#define VK_CURS_RIGHT           -122

#define VK_F0                   -33
#define VK_F1                   -114
#define VK_F2                   -115
#define VK_F3                   -116
#define VK_F4                   -21
#define VK_F5                   -117
#define VK_F6                   -118
#define VK_F7                   -23
#define VK_F8                   -19
#define VK_F9                   -120

/* Color defines : MODE 2 */
#define COLOR_BLACK             0x00
#define COLOR_RED               0x01
#define COLOR_GREEN             0x02
#define COLOR_YELLOW            0x03
#define COLOR_BLUE              0x04
#define COLOR_MAGENTA           0x05
#define COLOR_CYAN              0x06
#define COLOR_WHITE             0x07
#define COLOR_FLASHING          0x08

/* TGI color defines */
#define TGI_COLOR_BLACK         COLOR_BLACK
#define TGI_COLOR_WHITE         COLOR_WHITE
#define TGI_COLOR_RED           COLOR_RED
#define TGI_COLOR_CYAN          COLOR_CYAN
#define TGI_COLOR_VIOLET        COLOR_MAGENTA
#define TGI_COLOR_GREEN         COLOR_GREEN
#define TGI_COLOR_BLUE          COLOR_BLUE
#define TGI_COLOR_YELLOW        COLOR_YELLOW
#define TGI_COLOR_ORANGE        COLOR_YELLOW
#define TGI_COLOR_BROWN         COLOR_RED
#define TGI_COLOR_LIGHTRED      COLOR_RED
#define TGI_COLOR_GRAY1         COLOR_WHITE
#define TGI_COLOR_GRAY2         COLOR_WHITE
#define TGI_COLOR_LIGHTGREEN    COLOR_GREEN
#define TGI_COLOR_LIGHTBLUE     COLOR_BLUE
#define TGI_COLOR_GRAY3         COLOR_WHITE

/* Define hardware */
#include <bbc/os.h>

/* The addresses of the static drivers */


void kbflush(void);
int inkey(int delay);

unsigned __fastcall__ videomode (unsigned mode);
/* Set the video mode, return the old mode. Call with one of the VIDEOMODE_xx
** constants.
*/

/* End of bbc.h */
#endif
