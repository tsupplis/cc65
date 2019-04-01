;
; void cputcxy (unsigned char x, unsigned char y, char x);
; void cputc (char c);
;

	.export		_cputcxy, _cputc
	.export		cputdirect, newline, putchar, putchardirect
	.import		gotoxy

	.include	"bbc.inc"

_cputc = OSASCI

newline = OSNEWL

.proc	putchar
	jsr	OSWRCH
	lda	#8
	jmp	OSWRCH
.endproc

cputdirect = OSWRCH

putchardirect = putchar

.proc	_cputcxy
	pha
	jsr	gotoxy
	pla
	jmp	_cputc
.endproc
