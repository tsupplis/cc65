/* bbc/xos.h - Error-trapping Interface to BBC host OS.*/
/* Copyright (C) J.G.Harston, 1991.                    */
/* Version 0.73                                        */

#ifndef __xos_h
#define __xos_h

#define __bbc__
#define xos_error char
#define regs char

/* regs[0]=A, regs[1]=X, regs[2]=Y, regs[3]=P, updated on return
   status=xos_call(r);
   status=0  - no error
         =-1 - escape occured and acknowledged
         <>0 - error occured, ERR=status[0], REPORT=status=1
 */

extern xos_error *xos_cli(regs *r);
extern xos_error *xos_byte(regs *r);
extern xos_error *xos_file(regs *r);
extern xos_error *xos_word(regs *r);
extern xos_error *xos_wrch(regs *r);
extern xos_error *xos_rdch(regs *r);
extern xos_error *xos_file(regs *r);
extern xos_error *xos_args(regs *r);
extern xos_error *xos_bget(regs *r);
extern xos_error *xos_bput(regs *r);
extern xos_error *xos_gbpb(regs *r);
extern xos_error *xos_find(regs *r);
extern xos_error *xos_asci(regs *r);

/*
extern xos_error *xos_report(void);
extern xos_error *xos_error(int err, char *s);
extern xos_error *xos_escape(void);
extern xos_error *xos_onerror(void *f());
extern xos_error *xos_call(regs *r);
extern xos_error *xos_host(regs *r);
 */

#endif
/* end of bbc/xos.h */
