;
; Kevin Ruland
;
; void clrscr (void);
; Adapted for the Acorn Atom by K.v.Oss, 29.09.2003

	.export	_clrscr

	.include	"atom.inc"

_clrscr:
	lda	#FF
	jsr	OSWRCH

	lda	#00
	sta	CURS_X
	sta	CURS_Y
      rts
