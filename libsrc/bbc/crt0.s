;
; Startup code for cc65
;

	.export		_exit
	.export		__STARTUP__		; Mark as startup

	.import		initlib, donelib
	.import		zerobss, callmain
	.import		__MAIN_START__, __MAIN_SIZE__
	.import		__STACKSIZE__
	.importzp	ST

	.include	"zeropage.inc"
	.include	"bbc.inc"

; ------------------------------------------------------------------------
; Startup code

.segment	"STARTUP"

init:

; Clear the BSS data.

	jsr	zerobss

; Push the command line arguments and call main()
	jsr	callmain

; low level stdio program execution routines
; ==========================================
; On entry, y=>top of stacked parameters at (sp), left-to-right
;           x=top parameter
; On exit,  xy=return value
;

; exit()
; ------
; exit from user program
;
_exit:
	lda #1		; return value is in xy
	jsr OSBYTE	; set return value

	jsr	donelib

; Copy back the zero-page stuff.
	ldx	#zpspace-1
L2:	lda	zpsave,x
	sta	sp,x
	dex
	bpl	L2

	ldx	spsave	; get stored SP
	txs		; restore stack
	rts		; and return

; ------------------------------------------------------------------------
; Save space by putting some of the start-up code in the ONCE segment,
; which can be re-used by the BSS segment, the heap and the X stack.

.segment	"ONCE"

__STARTUP__:
	tsx
	stx	spsave		; Save the system stack pointer

; Save the zero-page locations that we need.
	ldx	#zpspace-1
L1:	lda	sp,x
	sta	zpsave,x
	dex
	bpl	L1

; Set up the stack.

	lda	#<(__MAIN_START__ + __MAIN_SIZE__)
	ldx	#>(__MAIN_START__ + __MAIN_SIZE__)
	sta	sp
	stx	sp+1

; Call the module constructors
	jsr	initlib

	jmp	init


; ------------------------------------------------------------------------
; Data

.segment        "INIT"

zpsave: .res    zpspace
spsave:	.res	1

