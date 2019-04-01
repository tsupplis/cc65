;
; int read (int fd, const void* buf, unsigned count);
; int write (int fd, const void* buf, unsigned count);
;
	.export		_read, _write
	.import		popax, newline, _cputc
	.importzp	sp, ptr1, ptr2, tmp2
	.include	"bbc.inc"
	.include	"param.inc"

.proc rwcommon
	sta	ptr1
	txa	
	sta	ptr1+1	; Remember count

	jsr	popax	; Get buf
	sta	ptr2
	stx	ptr2+1

	jsr	popax	; Get fd
	sta	tmp2
	rts
.endproc

.proc _write
	jsr	rwcommon
	cmp	#1
	beq	sput
	cmp	#2
	beq	sput
	lda	#2
	pha
	jmp	access
.endproc

.proc sput
	lda	ptr1+1
	tax
	ldy	#0
l1:
	lda	ptr1
	bne	l2
	cpx	#0
	beq	l3
	dex
l2:
	dec	ptr1
	lda	(ptr2),y
	jsr	aput
	iny
	bne	l1
	inc	ptr2+1
	jmp	l1
l3:
	rts
.endproc

.proc aput
	cmp	#10
	beq	l1
	jmp	_cputc
l1:	jmp	newline
.endproc

.proc _read
	jsr	rwcommon
	tax
	lda	#127
	jsr	OSBYTE
	txa
	bne	l1
	lda	#4
	pha
	jmp	access
l1:
	ldx	#0
	lda	#0
	rts
.endproc

.proc access
	lda	tmp2
	sta	param
	lda	ptr2
	sta	param+1
	lda	ptr2+1
	sta	param+2
	lda	#0
	sta	param+3
	sta	param+4
	lda	ptr1
	sta	param+5
	lda	ptr1+1
	sta	param+6
	lda	#0
	sta	param+7
	sta	param+8
	pla
	ldx	#<param
	ldy	#>param
	jsr	OSGBPB
	sec
	lda	ptr1
	sbc	param+5
	tay
	lda	ptr1+1
	sbc	param+6
	tax
	tya
	rts
.endproc

