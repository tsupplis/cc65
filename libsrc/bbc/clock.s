;
; clock_t clock (void);
;

	.export		_clock
	.importzp	sreg
	.include	"bbc.inc"

.proc _clock
	lda	#1
	ldx	#<system_clock
	ldy	#>system_clock
	jsr	OSWORD
	lda	system_clock+3
	sta	sreg+1
	lda	system_clock+2
	sta	sreg
	ldx	system_clock+1
	lda	system_clock
	rts
.endproc

.bss
system_clock:	.res	5

