;
; Ullrich von Bassewitz, 23.09.1998
;
; unsigned readjoy (unsigned char joy);
;

     	.export		_readjoy
	.importzp		tmp1
	.include		"atom.inc"


_readjoy:

	tax		; Joystick number into X
	bne   joy2

; Read joystick 1

joy1:	lda	#0
	tax
	sta	tmp1
	jsr	KEYREAD

	cpy	#$31	; Up
	bne	L1
	ldx	#1
	jmp	L5

L1:	cpy	#$1D	; Down
	bne	L2
	ldx	#2
	jmp	L5

L2:	cpy	#$27	; Left
	bne	L3
	ldx	#4
	jmp	L5

L3:	cpy	#$13	; Right
	bne	L5
	ldx	#8

L5:	txa
	ora	tmp1
	rts

; Read joystick 2

joy2:	jmp	joy1
