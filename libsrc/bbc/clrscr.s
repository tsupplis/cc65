;
; void clrscr (void);
;

	.export		_clrscr
	.import		_videomode
	.include	"bbc.inc"

.proc	_clrscr
	lda	MODE
	jmp	_videomode
.endproc
