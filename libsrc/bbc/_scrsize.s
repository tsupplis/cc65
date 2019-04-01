;
; Screen size variables
;

        .export         screensize

        .include        "bbc.inc"

.proc   screensize

	clc
	lda	TEXT_Y1
	sbc	TEXT_Y2
	tay
	iny
	clc
	lda	TEXT_X2
	sbc	TEXT_X1
	tax
	inx
	rts

.endproc


