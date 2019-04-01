/* bbc/vdu.h - Interface to BBC host VDU system.      */
/* Copyright (C) J.G.Harston, 1991.                   */
/* Version 0.72                                       */

#ifndef __bbc_h
#include <bbc/os.h>
#endif

#ifndef __vdu_h
#define __vdu_h

#define vdu(p) os_wrch(p)
#define draw(x,y) plot(4,x,y)
#define move(x,y) plot(0,x,y)

void plot(k,x,y)
int k,x,y;
{
os_wrch(k);
os_wrch(x); os_wrch(x >> 8);
os_wrch(y); os_wrch(y >> 8);
}

void mode(a)
int a;
{
if (os_byte(130,0) < 0 & os_byte(133,a)-os_byte(132,0) < 0) {
  printf("Restart in mode %d.\n",a);
  exit(25);	/* Bad mode - If not in tube, and no memory for mode change, stop */
  }
os_wrch(22); os_wrch(a);
}
