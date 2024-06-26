;
; Ullrich von Bassewitz, 16.11.2002
;
; int __fastcall__ close (int fd);
;

        .export         _close

        .import         CLOSE
        .import         readdiskerror, closecmdchannel

        .include        "zeropage.inc"
        .include        "errno.inc"
        .include        "atom.inc"
        .include        "filedes.inc"


;--------------------------------------------------------------------------
; _close

.proc   _close

; Check if we have a valid handle

        cpx     #$00
        bne     invalidfd
        cmp     #MAX_FDS        ; Is it valid?
        bcs     invalidfd       ; Jump if no
        sta     tmp2            ; Save the handle

; Check if the file is actually open

        tax
        lda     fdtab,x         ; Get flags for this handle
        and     #LFN_OPEN
        beq     notopen

; Valid lfn, close it. The close call is always error free, at least as far
; as the kernal is involved

        lda     #LFN_CLOSED
        sta     fdtab,x
	lda	fdhandle,x
	tay
	jsr	OSSHUT

	lda	#0

; Successful

        tax                     ; Return zero in a/x
        rts

; Error entry, file descriptor is invalid

invalidfd:
        lda     #EINVAL
        sta     ___errno
        lda     #0
        sta     ___errno+1
        beq     errout

; Error entry, file is not open

notopen:
        lda     #3              ; File not open
        bne     error

; Error entry, status not ok

error:  sta     ___oserror
errout: lda     #$FF
        tax                     ; Return -1
        rts

.endproc




