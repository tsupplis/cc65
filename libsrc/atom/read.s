;
; Ullrich von Bassewitz, 16.11.2002
;
; int read (int fd, void* buf, unsigned count);
;

        .export         _read
        .constructor    initstdin

        .import         rwcommon
        .import         popax
        .import         __oserror
        .importzp       ptr1, ptr2, ptr3, tmp1, tmp2, tmp3

        .include        "fcntl.inc"
        .include        "atom.inc"
        .include        "filedes.inc"


;--------------------------------------------------------------------------
; initstdin: Open the stdin file descriptors for the keyboard

.proc   initstdin

	lda	#LFN_READ
	sta	fdtab+STDIN_FILENO
	ldx	#3
	stx	unittab+STDIN_FILENO

	ldy	#0
	jmp	OSSHUT

.endproc

;--------------------------------------------------------------------------
; _read


.proc   _read

        jsr     rwcommon        ; Pop params, check handle
        bcs     errout          ; Invalid handle, errno already set

; Check if the LFN is valid and the file is open for writing
	sta	tmp2
;        adc     #LFN_OFFS       ; Carry is already clear
	tax
;        lda     fdtab-LFN_OFFS,x; Get flags for this handle
	lda	fdtab,x			; Get flags for this handle
	and	#LFN_READ			; File open for writing?
	beq	notopen

; Check the EOF flag. If it is set, don't read anything

;        lda     fdtab-LFN_OFFS,x; Get flags for this handle
	lda	fdtab,x			; Get flags for this handle
	bmi	eof

; Valid lfn. Make it the input file
; Reset file pointer

	ldx	tmp2
	beq	@L2
	lda	fdhandle,x
	tay

	lda	#0
	sta	TMP_PTR
	sta	TMP_PTR+1
	sta	TMP_PTR+2
	ldx	#TMP_PTR
	jsr	OSSTAR

; Go looping...

	jmp	@L2				; Branch always

; Read the next byte

@L0:
	ldx	tmp2
	lda	fdhandle,x
	tay
	jsr	OSBGET
	sta	tmp1            ; Save the input byte

	lda	INFOBYTE,y
	and	#%00010000
	bne	eof
	
; Store the byte just read

        ldy     #0
        lda     tmp1
        sta     (ptr2),y
        inc     ptr2
        bne     @L1
        inc     ptr2+1          ; *buf++ = A;

; Increment the byte count

@L1:    inc     ptr3
        bne     @L2
        inc     ptr3+1

; Decrement the count

@L2:
	inc     ptr1
        bne     @L0
        inc     ptr1+1
        bne     @L0
        beq     done            ; Branch always

; Set the EOI flag and bail out

@L4:    ldx     tmp2            ; Get the handle
        lda     #LFN_EOF
        ora     fdtab,x
        sta     fdtab,x

; Read done, close the input channel

done:

; Return the number of chars read

eof:    lda     ptr3
        ldx     ptr3+1
        rts

; Error entry, file is not open

notopen:
        lda     #3              ; File not open
        bne     error

; Error entry, status not ok

error5: lda     #5              ; Device not present
error:  sta     __oserror
errout: lda     #$FF
        tax                     ; Return -1
        rts

.endproc



