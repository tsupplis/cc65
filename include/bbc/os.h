/* bbc/os.h - Interface to BBC host OS.               */
/* Copyright (C) J.G.Harston, 1991.                   */
/* Version 0.72                                       */
/* 2005-06-15 Renamed to bbc.h to converge with cc65. */

#ifndef __bbc_h
#define __bbc_h

#define __bbc__
extern int os_cli(char *s);
extern int os_byte(int a, int xy);                  /*  Returns XY                     */
extern int os_word(int a, char *block);             /*  Returns Y                      */
extern void os_wrch(int ch);
extern void os_newl(void);
extern void os_asci(int ch);
extern int os_rdch(void);                           /* Returns char or <0              */
extern int os_file(int a, char *name, char *block); /* Returns type                    */
extern long os_args(int a, int handle, int arg);    /* Returns new arg                 */
extern int os_bget(int handle);                     /* Returns byte or <0              */
extern int os_bput(int ch, int handle);
extern int os_gbpb(int a, int handle, char *block); /* Returns A reg                   */
extern int os_find(int a, char *name);              /* Returns file handle             */
extern void os_close(int handle);

extern char *os_report(void);                       /* Returns pointer to ERR, REPORT$ */
extern void os_error(int A, char *str);             /* Generate an error               */
extern int os_escape(void);                         /* Returns escape state            */
/*extern void os_onerror(void *f());*/                  /* Sets up error handler           */
extern char *os_call(char *regs);
#define os_host (osbyte(0,0xFFFF) && 0xFF)

#define _kernel_HOST_UNDEFINED    -1
#define _kernel_BBC_MOS1_0         0
#define _kernel_BBC_MOS1_2         1
#define _kernel_BBC_ACW            2
#define _kernel_BBC_MASTER         3
#define _kernel_BBC_MASTER_ET      4
#define _kernel_BBC_MASTER_COMPACT 5
#define _kernel_ARTHUR             6
#define _kernel_SPRINGBOARD        7
#define _kernel_A_UNIX             8
#define _kernel_AMSTRAD           30
#define _kernel_SPECTRUM          31
#define _kernel_PC                32

/* The following have not yet been written   */
/* int   gs_read(int Y, int C)               */
/* long  gs_init(char *str)                  */
/* void  os_event(int Y)                     */
/* int   os_rdsc(char *F6, int Y)            */
/* void  os_wrsc(char *D6, int Y, int A)     */
/* #define os_rdrm os_rdsc                   */

#endif
/* end of bbc/os.h */
