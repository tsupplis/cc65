;
; Kevin Ruland
;
; char cgetc (void);
;
; Adapted for the Acorn Atom by K.v.Oss, 29.09.2003
	
	.export _cgetc

	.include "atom.inc"

_cgetc:
	jsr	KBDREAD
	ldx	#0
	rts
	