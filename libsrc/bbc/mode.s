;
; unsigned videomode (unsigned mode);
;


	.constructor	initmode, 28
	.export 	_videomode
	.include	"bbc.inc"

.code
.proc _videomode
	pha
	lda	#$16
	jsr	OSWRCH
	pla
.ifdef __BBCMASTER
	ora	#$80
.endif
	jsr	OSWRCH
	lda	MODE
	ldx	#0
	rts
.endproc

.segment "ONCE"

.proc initmode
	lda	MODE
	cmp	#7
	beq	l0
	and	#$7f
	bne	l0
.ifdef __BBCMASTER__
	lda	MODE
	ora	#$80
	jmp	_videomode
.else
	brk
	.byte	25
	.asciiz "Bad MODE"
.endif
l0:	rts
.endproc

