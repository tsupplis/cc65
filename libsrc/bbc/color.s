;
; unsigned char __fastcall__ textcolor (unsigned char color);
; unsigned char __fastcall__ bgcolor (unsigned char color);
; unsigned char __fastcall__ bordercolor (unsigned char color);
;

        .export         _textcolor, _bgcolor, _bordercolor

        .include        "bbc.inc"


.proc _bgcolor
.bss
old:	.res	1
.code
	pha
	lda	$358
	sta	old
	pla
	adc	#128
	jsr	_textcolor
	lda	old
	rts
.endproc

.proc _textcolor
.bss
old:	.res	1
.code
	pha
	lda	$357
	sta	old
	lda	#17
	jsr	OSWRCH
	pla
	jsr	OSWRCH
	lda	old
	rts
.endproc

_bordercolor:
        rts

