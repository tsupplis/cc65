;
; void kbflush (void);
;
	.export		_kbflush
	.include	"bbc.inc"

.proc _kbflush
	lda	#15
	ldx	#1
	ldy	#0
	jmp	OSBYTE
.endproc

