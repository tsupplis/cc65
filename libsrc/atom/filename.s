;
; Ullrich von Bassewitz, 16.11.2002
;
; File name handling for CBM file I/O
;

        .export         fnparse
        .export         fnunit, fnlen, fnbuf

        .import         SETNAM
        .import         __curunit, __filetype
        .importzp       ptr1

        .include        "ctype.inc"


;--------------------------------------------------------------------------
; fnparse: Parse a filename passed in in a/x. Will set the following
; variables:
;
;       fnlen   -> length of filename
;       fnbuf   -> filename
;       fnunit  -> driveunit from filename or default unit


.proc   fnparse

        sta     ptr1
        stx     ptr1+1          ; Save pointer to name

; For now we're always using the default unit

        lda     __curunit
        sta     fnunit

; Check the name for a drive spec

        ldy     #0
        lda     (ptr1),y
        sta     fnbuf+0
        cmp     #'0'
        beq     digit
        cmp     #'1'
        beq     digit
        cmp     #'2'
        beq     digit
        cmp     #'3'
        beq     digit
	jmp	nodrive

digit:
	iny
	lda	(ptr1),y
	cmp	#':'
	bne	nodrive

; We found a drive spec, copy it to the buffer

	lda	fnbuf+0
	sec
	sbc	#'0'
	sta	fnunit
	iny						; Skip colon
	bne	drivedone				; Branch always

; We did not find a drive spec, always use drive zero

nodrive:
	lda	#0
	sta	fnunit
	ldy	#0					; Reposition to start of name

; Drive spec done. Copy the name into the file name buffer. Check that all
; file name characters are valid and that the maximum length is not exceeded.

drivedone:
	lda	#0					; Length of drive spec
	sta	fnlen

nameloop:
	lda	(ptr1),y				; Get next char from filename
	beq	fncomplete				; Jump if end of name reached

; Check the maximum length, store the character

	ldx	fnlen
	cpx	#7					; Maximum length reached?
	bcs	invalidname
	lda	(ptr1),y				; Reload char
	jsr	fnadd
	iny						; Next char from name
	bne	nameloop				; Branch always

; Invalid file name

invalidname:
	lda	#33					; Invalid file name

; Done, we've successfully parsed the name.

namedone:
	rts

fncomplete:
	lda	#13
	jsr	fnadd
	dec	fnlen
	lda	#0
	beq	namedone

fnadd:
	ldx	fnlen
      inc	fnlen
      sta	fnbuf,x
	rts

.endproc

;--------------------------------------------------------------------------
; Data

.bss

fnunit: .res    1
fnlen:  .res    1

.data
fnbuf:  .res    8      ; 0123456+#0D
