;
; Startup code for cc65 (C64 version)
;
; This must be the *first* file on the linker command line
;

    .debuginfo     +
    .export        __STARTUP__ : absolute = 1      ; Mark as startup
    .export        _exit
    .export        initmainargs
    .import        initlib, donelib
    .import        zerobss, push0
    .import        _main
    .import        __STACKBASE__    ; Linker generated

    .include       "zeropage.inc"
    .include       "atom.inc"
    .include       "atom_zpdefs.inc"

; ------------------------------------------------------------------------
; Actual code
    .segment        "STARTUP"

    ldx   #zpspace-1
L1: lda    c_sp,x
    sta    zpsave,x    ; Save the zero page locations we need
    dex
    bpl    L1

; Clear the BSS data

    jsr    zerobss

; Save system settings and setup the stack

    tsx
    stx    spsave         ; Save the system stack ptr

    lda    #<(__STACKBASE__)
    sta    c_sp
    lda    #>(__STACKBASE__)
    sta    c_sp+1           ; Set argument stack ptr

; Call module constructors

    jsr    initlib

; Pass an empty command line

    jsr    push0          ; argc
    jsr    push0          ; argv

    ldy    #4             ; Argument size
    jsr    _main          ; call the users code

; Call module destructors. This is also the _exit entry.

_exit:    jsr    donelib  ; Run module destructors

; Restore system stuff

    ldx    spsave
    txs                   ; Restore stack pointer

; Copy back the zero page stuff

    ldx    #zpspace-1
L2: lda    zpsave,x
    sta    c_sp,x
    dex
    bpl    L2
; Reset changed vectors, back to basic
    rts
initmainargs:
    rts

; ------------------------------------------------------------------------
; Data

.data

zpsave:    .res    zpspace

.bss

spsave:    .res    1
