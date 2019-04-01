;
; Ullrich von Bassewitz, 08.08.1998
;
; void cclearxy (unsigned char x, unsigned char y, unsigned char length);
; void cclear (unsigned char length);
;
; Adapted for the Acorn Atom by K.v.Oss, 29.09.2003

    	.export	_cclearxy, _cclear
	.import	popa, _gotoxy, cputdirect
	.importzp	tmp1

	.include	"atom.inc"

_cclearxy:
	pha	    		; Save the length
	jsr	popa		; Get y
      jsr  	_gotoxy	; Call this one, will pop params
      pla			; Restore the length and run into _cclear

_cclear:
      cmp	#0		; Is the length zero?
      beq	L9  		; Jump if done
    	sta	tmp1				     
L1:   lda  	#SPACE	; Blank - screen code
   	jsr	cputdirect	; Direct output
   	dec	tmp1
	bne	L1
L9:	rts




