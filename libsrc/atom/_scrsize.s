;
; Ullrich von Bassewitz, 26.10.2000
;
; Screen size variables
;
; Adapted from C64 for the Acorn Atom by K.v.Oss, 29.09.2003

	.export		xsize, ysize
	.constructor	initscrsize 
	.include	"atom.inc"

.code

initscrsize:
	ldx	#VIDEO
	lda	VIDEO_X_SIZE,x
	sta	xsize
	lda	VIDEO_Y_SIZE,x
	sta	ysize
	rts	

VIDEO_X_SIZE:
	.byte	32,80

VIDEO_Y_SIZE:
	.byte	16,24

.bss

xsize:	.res	1
ysize:	.res	1

