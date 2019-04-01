;
; Ullrich von Bassewitz, 07.08.1998
;  Adapted for Acorn Atom by Kees van Oss, 29.08.2003
;
; unsigned char revers (unsigned char onoff);
;  0 	 = no reverse video
;  <>0 = reverse video

	.export		_revers
	.export		revers

_revers:
	ldx	#$00		; Assume revers off
	tay			; Test onoff
	beq	L1		; Jump if off
	ldx	#$80		; Load on value
L1:	ldy	#$00		; Assume old value is zero
	lda  	revers     	; Load old value
	stx	revers	; Set new value
	beq	L2		; Jump if old value zero
	iny			; Make old value = 1
L2:	ldx	#$00		; Load high byte of result
	tya			; Load low byte, set CC
	rts

.bss

revers:	.res	1

