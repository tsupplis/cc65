;
; Ullrich von Bassewitz, 16.11.2002
;
; int open (const char* name, int flags, ...);	/* May take a mode argument */
;
; Be sure to keep the value priority of closeallfiles lower than that of
; closeallstreams (which is the high level C file I/O counterpart and must be
; called before closeallfiles).


	.export		_open
	.destructor		closeallfiles, 17

	.import		addysp, popax
	.import		fnparse, fnbuf, fdhandle
	.import		__oserror
	.import		fnunit
	.import		_close
	.importzp		sp, tmp2, tmp3

	.include		"errno.inc"
	.include		"fcntl.inc"
	.include		"filedes.inc"
	.include		"atom.inc"


;--------------------------------------------------------------------------
; closeallfiles: Close all open files.

.proc   closeallfiles

        ldx     #MAX_FDS
loop:   lda     fdtab-1,x
        beq     next            ; Skip unused entries

; Close this file

        txa
        pha                     ; Save current value of X
        ldx     #0
        jsr     _close
        pla
        tax

; Next file

next:   dex
        bne     loop

	ldy	#0
	jmp	OSSHUT

.endproc

;--------------------------------------------------------------------------
; _open

.proc   _open

	cpy	#4     	   		; correct # of arguments (bytes)?
	beq	parmok 	   		; parameter count ok
	tya					; parm count < 4 shouldn't be needed to be...
      sec    	       	      ; ...checked (it generates a c compiler warning)
	sbc	#4
	tay
	jsr	addysp	   		; fix stack, throw away unused parameters

; Parameters ok. Pop the flags and save them into tmp3

parmok:
	jsr     popax           	; Get flags
      sta     tmp3

; Get the filename from stack and parse it. Bail out if is not ok

      jsr     popax           	; Get name
      jsr     fnparse         	; Parse it
      cmp     #0
      bne     error 			; Bail out if problem with name

; Get a free file handle and remember it in tmp2

	jsr     freefd
	bcs     nofile
	stx     tmp2

; Check the flags. We cannot have both, read and write flags set, and we cannot
; open a file for writing without creating it.

	lda     tmp3
	and     #(O_RDWR | O_CREAT)
	cmp     #O_RDONLY       	; Open for reading?
	beq     doread          	; Yes: Branch
	cmp     #(O_WRONLY | O_CREAT) ; Open for writing?
	bne     invflags        	; No: Invalid open mode

; If O_TRUNC is set, scratch the file, but ignore any errors

	lda     tmp3
	and     #O_TRUNC
	beq     notrunc

; Complete the the file name. Check for append mode here.

notrunc:
	lda	tmp3				; Get the mode again
	ldx	#'a'
	and	#O_APPEND			; Append mode?
	bne	append			; Branch if yes

; Setup the real open flags

	lda	#LFN_WRITE
	clc
	bne	common

append:
	txa
	sta	$6000
	brk

; Setup the real open flags

	lda	#LFN_WRITE
	clc
	bne	common

; Read bit is set. Add an 'r' to the name

doread:
	lda	#LFN_READ
	sec

; Common read/write code. Flags in A, handle in tmp2

common:
	sta	tmp3

	lda	#<fnbuf
	sta	FILENAME
	lda	#>fnbuf
	sta	FILENAME+1

	ldx	#FILENAME
	jsr	OSFIND
	beq	notfound

; File is open. Mark it as open in the table

	ldx	tmp2
	sta	fdhandle,x
	lda	tmp3
	sta	fdtab,x
	lda	fnunit
	sta	unittab,x			; Remember

; Done. Return the handle in a/x

	txa					; Handle
	ldx	#0
	rts

; Error entry: File not found

notfound:
	lda	#4				; File not found
	bne	error

; Error entry: No more file handles

nofile:
	lda	#1				; Too many open files

; Error entry. Error code is in A.

error:
	sta	__oserror
errout:
	lda	#$FF
	tax					; Return -1
	rts

; Error entry: Invalid flag parameter

invflags:
	lda	#EINVAL
	sta	__errno
	lda	#0
	sta	__errno+1
	beq	errout

; Error entry: Close the file and exit

closeandexit:
	pha
	lda	tmp2
	jsr	_close
	pla
	bne	error				; Branch always

.endproc


