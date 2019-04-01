;
; void gotoxy (unsigned char x, unsigned char y);
; void gotox (unsigned char x);
;

	.export		gotoxy, _gotoxy, _gotox
	.import		pusha, popa

	.include	"bbc.inc"

gotoxy:
	jsr	popa		; Get Y

_gotoxy:
	pha			; Save Y
	lda	#31
	jsr	OSWRCH
	jsr	popa		; Get X
	jsr	OSWRCH
	pla			; Restore Y
	jmp	OSWRCH

.proc _gotox
	jsr	pusha		; Save X
	lda	CURS_Y		; Get Y
	jmp	_gotoxy
.endproc

	
