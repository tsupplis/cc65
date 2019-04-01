;
; Ullrich von Bassewitz, 06.08.1998
;
; int kbhit (void);
;

	.export		_kbhit
	.import		return0, return1

	.include	"atom.inc"

_kbhit:
	jsr	KEYREAD
	cpy	#$FF
	bne	L1
	jmp	return0
L1:	jmp	return1


