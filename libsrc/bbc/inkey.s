;
; int inkey (int delay);
;
	.export		_inkey
	.include	"bbc.inc"

.proc _inkey
	pha
	txa
	tay
	pla
	tax
	lda	#$81
	jsr	OSBYTE
	cpy	#$ff
	beq	l0
	cpy	#$1b
	beq	l1
	ldx	#0
	rts
l0:
	lda	#$ff
	tax	
	rts
l1:
	lda	#126
	ldx	#0
	ldy	#0
	jsr	OSBYTE
	lda	#$1b
	ldx	#0
	rts
.endproc

