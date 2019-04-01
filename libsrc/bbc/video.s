
	.export		_os_get_pixel
	.export		_os_set_pixel
	.export		_os_draw_line

	.include	"bbc.inc"
	.include	"zeropage.inc"

x1 := ptr1
y1 := ptr2
x2 := ptr3
y2 := ptr4
radius := tmp1

.proc	_os_get_pixel
.bss
temp:	.res 5
.code
	lda	x1+0
	sta	temp+0
	lda	x1+1
	sta	temp+1
	lda	y1+0
	sta	temp+2
	lda	y1+1
	sta	temp+3
	lda	#9
	jsr	OSWORD
	lda	temp+4
	rts
.endproc

.proc	_os_set_pixel
.code
	lda	#25
	jsr	OSWRCH
	lda	#69
	jsr	OSWRCH
	lda	x1+0
	jsr	OSWRCH
	lda	x1+1
	jsr	OSWRCH
	lda	y1+0
	jsr	OSWRCH
	lda	y1+1
	jmp	OSWRCH
.endproc

.proc _os_draw_line
.code
	lda	#25
	jsr	OSWRCH
	lda	#4
	jsr	OSWRCH
	lda	x1+0
	jsr	OSWRCH
	lda	x1+1
	jsr	OSWRCH
	lda	y1+0
	jsr	OSWRCH
	lda	y1+1
	jsr	OSWRCH
	lda	#25
	jsr	OSWRCH
	lda	#5
	jsr	OSWRCH
	lda	x2+0
	jsr	OSWRCH
	lda	x2+1
	jsr	OSWRCH
	lda	y2+0
	jsr	OSWRCH
	lda	y2+1
	jmp	OSWRCH
.endproc

