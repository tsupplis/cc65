;
; Ullrich von Bassewitz, 06.08.1998
;
; void cputcxy (unsigned char x, unsigned char y, char c);
; void cputc (char c);
;
; Remarks:
;  $0A=\n is LF (without CR)
;  $0D=\r is CR
;  

    	.export	      _cputcxy, _cputc, cputdirect, putchar
	.export		newline, plot
	.import		popa, _gotoxy
	.import		xsize, revers

	.include		"atom.inc"

_cputcxy:
	pha	    			; Save C
	jsr	popa			; Get Y
	jsr	_gotoxy		; Set cursor, drop x
	pla				; Restore C

; Plot a character - also used as internal function

_cputc:
 	cmp	#$0D  		; CR
	bne	L1
    	lda	#0
    	sta	CURS_X
	rts

L1:
	cmp	#$0A  	  	; LF without CR!!!!
	beq	newline		; Recalculate pointers

; Printable char of some sort

	cmp	#' '
    	bcc	controlchar		; Other control char
	adc	#$1F
	bmi	cputdirect
	eor	#$60

cputdirect:
  	jsr	putchar		; Write the character to the screen

; Advance cursor position

advance:
   	iny
	cpy	xsize
   	bne	L3
	jsr	newline		; new line
   	ldy	#0    	  	; + cr
L3:	sty	CURS_X
	rts

controlchar:
	sta	$8000
	jmp	OSWRCH

newline:
	inc	CURS_Y
	jsr	plot
	rts

; Set cursor position, calculate RAM pointers

plot:	pha
	lda	CURS_Y
	asl	a
	asl	a
	asl	a
	asl	a
	asl	a
	sta	SCREEN_PTR
	lda	#$80
	adc	#0
	sta	SCREEN_PTR+1
	pla
	rts

; Write one character to the screen without doing anything else, return X
; position in Y

putchar:
    	ora	revers	  	; Set revers bit
	jsr	plot
	ldy  	CURS_X
	sta	(SCREEN_PTR),y	; Set char
	rts

