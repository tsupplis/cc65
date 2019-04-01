; sys/s  07-Apr-1988  A.J.Travis

;
; Operating system interface for tcc under Acorn/BBC MOS
;
; 20-Jun-1991  v0.71 - J.G.Harston
;   system/exit pass return value via OSBYTE 1
; 30-Jun-2005  v0.73
;   is*(), to*(), etc. moved to ctype/s
;
; NB: _* symbols *must* be no more than 8 chars as tccom truncates!

	.export		__cmdline
	.export		escape
	.export		_os_cli
	.export		_os_byte
	.export		_os_host
	.export		_os_fx
	.export		_os_word
	.export		_os_bget
	.export		_os_rdch
	.export		_os_bput
	.export		_os_wrch
	.export		_os_newl
	.export		_os_asci
	.export		_osfile, _os_file
	.export		_os_args, _os_gbpb
	.export		_os_find
	.export		_os_close
	.export		_os_report
	.export		_os_error
	.export		_os_escape
	.export		_os_onerror
	.export		_os_call

	.include	"bbc.inc"
	.include	"zeropage.inc"

asave := $da
param := $da

; low level stdio program execution routines
; ==========================================
; On entry, y=>top of stacked parameters at (sp), left-to-right
;           x=top parameter
; On exit,  xy=return value
;

; _cmdline()
; ----------
; export address of MOS command line to C environment
;
.proc __cmdline
	lda #1		;get address of MOS command line		
	ldx #param	;4 byte parameter block
	ldy #0		;no file descriptor involved
	jsr OSARGS
	ldx param	;return address of '\r' terminated line
	ldy param+1
	rts
.endproc

; Escape event - should use os_escape()
; =====================================

;
; escape trap
;
escape:
	cmp #6		;escape event?
	bne Lescape1
	lda #13		;disable escape event
	ldx #6		;event no.
	jsr OSBYTE
	lda #$7e	;acknowledge escape condition
	jsr OSBYTE
	lda #0		;close all open files
	ldy #0
	jsr OSFIND
	lda #$b2	;write keyboard semaphore
	ldy #$00	;and y
	ldx #$ff	;eor x (enable keyboard interrupts)
	jsr OSBYTE
	brk
	.byte $11	;escape 'error' code
	.byte $0a,$0d	;lf/cr
	.asciiz	 "escape"
Lescape1:
	rts

; BBC MOS functions
; =================

; os_cli(s)
; ---------
; pass string to MOS to execute
;
.proc _os_cli
	jsr Lgsconv	; convert to BBC format
;	ldx #<gsbuf
;	ldy #>gsbuf
	jmp OSCLI
.endproc

; os_byte(type, parameters)
; ------------------------
; MOS "osbyte" interface
; a is type of call
; x and y are parameters
;
.proc _os_byte
;_osbyte:
	stx asave	;;
	ldy #2
	lda (sp),y	;x parameter
	tax
	iny
	lda (sp),y	;y parameter
	tay		;;
;	sta asave	;save it
;	ldy #0
;	lda (sp),y	;type of call
;	ldy asave
	lda asave	;;
	jmp OSBYTE
;	jsr OSBYTE
;	rts		;return val in xy
.endproc

; os_host()
; ---------
_os_host:
	lda #0
	ldx #1
	bne Losfx

; os_fx(type, x, y)
; -----------------
_os_fx:
	stx asave	; A parameter
	ldy #2
	lda (sp),y	; X parameter
	tax
	iny
	iny
	lda (sp),y	; Y parameter
	tay
	lda asave
Losfx:
	jsr OSBYTE
	ldy #0
	rts

; os_word(type, address)
; ---------------------
; MOS "osword" interface
; a is type of call
; (x + y << 8) is address of parameter block
;
_os_word:
;_osword
	stx asave	;;
	ldy #2
	lda (sp),y	;address lo
	tax
	iny
	lda (sp),y	;address hi
	tay		;;
;	sta asave	;save it
;	ldy #0
;	lda (sp),y	;type of call
;	ldy asave
	lda asave	;;
	jsr OSWORD
	tya

Lcarry:
	tax		;return y in low byte
	php
	pla
	and #$01
	tay		;return carry in high byte
	rts		;return val in xy

; os_bget(handle)
; ---------------
.proc _os_bget
	txa
	beq _os_rdch
	tay
	jsr OSBGET
	jmp Lcarry
.endproc

; os_rdch()
; ---------
.proc _os_rdch
	jsr OSRDCH
	jmp Lcarry
.endproc

; os_bput(handle, byte)
; ---------------------
.proc _os_bput
	stx asave
	ldy #2
	lda (sp),y	; byte to write
	ldy asave
	beq Loswrch
	jmp OSBPUT
.endproc

; os_wrch(c)
; ----------
; output char to output stream without any transformation
;
_os_wrch:
;_vdu
;	ldy #0
;	lda (sp),y
	txa		; get char from xy
Loswrch:
	jmp OSWRCH
;	jsr oswrch
;	rts

; os_newl()
; ---------
_os_newl = OSNEWL
;_os_newl
;	jmp OSNEWL

; os_asci(c)
; ----------
.proc _os_asci
	txa
	jmp OSASCI
.endproc

; osfile(name, fcb, type)
; -----------------------
; MOS osfile interface
;
.proc _osfile
	jmp Lreterr
;	ldy #4
;	lda (sp),y	;osfile type
;~osfile	
;	pha		;save type
;	jsr ~gsconv	;convert name to MOS format
;	ldy #2
;	lda (sp),y	;fcb address lo
;	sta tr
;	iny
;	lda (sp),y	;fcb address hi
;	sta tr+1
;	ldy #0
;	lda #<gsbuf	;update file control block
;	sta (tr),y	;fcb address lo
;	iny
;	lda #>gsbuf
;	sta (tr),y	;fcb address hi
;	pla		;osfile type
;	ldx tr		;addr of fcb
;	ldy tr+1
;	jsr osfile
;	cmp #0		;check MOS exit status, 0 = no file
;	bne ~osfile1
;	ldx #$ff	;return -1 if no file found
;	ldy #$ff
;	rts
;~osfile1
;	ldx #0		;return 0 otherwise
;	ldy #0
;	sta (tr),y	;leave MOS file type in fcb
;	rts
.endproc

;;
;; os_file(type, name, fcb)
;          0/1   2/3   4/5
;; -----------------------
;; MOS osfile interface
;;
_os_file:
	ldy #0
	lda (sp),y	; osfile type
	ldy #2          ; point to name
Losfile:
	pha		; save type
	tya
	pha		; save pointer to name
	jsr Lconv1	; convert name to MOS format
	pla
	tya		; retrieve pointer to name
	iny
	iny		; point to fcb
	lda (sp),y	;fcb address lo
	sta tmp1
	iny
	lda (sp),y	;fcb address hi
	sta tmp2
	ldy #0
	lda #<gsbuf	;update file control block
	sta (tmp1),y	;fcb address lo
	iny
	lda #>gsbuf
	sta (tmp1),y	;fcb address hi
	pla		;osfile type
	ldx tmp1	;addr of fcb
	ldy tmp2
	jsr OSFILE
	tax
	ldy #0		; return file type
	sta (tmp1),y	; also leave file type in fcb
	rts

; os_args(action, handle, data)
; -----------------------------
.proc _os_args
	rts
.endproc


; os_gbpb(action, handle, block)
; ------------------------------
.proc _os_gbpb
	rts
.endproc

; os_find(action, name)
; -----------------------
.proc _os_find
	stx asave	; action
	ldy #2
	jsr Lconv1	; convert filename string
	lda asave
	jsr OSFIND
.endproc

; os_close(handle)
; ---------------
.proc _os_close
	txa
	tay
	lda #0
	jmp OSFIND
.endproc

; os_report()
; -----------
.proc _os_report
	ldx $fd
	ldy $fe		; return pointer to error block
	rts
.endproc

; os_error(e, s)
; --------------
_os_error:
	stx $101	; store error number
	ldy #2
	lda (sp),y
	sta ptr1
	iny
	lda (sp),y
	sta ptr2	; pr=>string
	ldy #$ff
Loserrlp:
	iny
	lda (ptr1),y
	sta $102,y	; copy to error buffer
	bne Loserrlp
	sta $100	; store BRK
	jmp $100	; jump to execute error

; os_escape()
; -----------
_os_escape:
	bit $ff
	bmi Lescset
	jmp Lretok
Lescset:
	jmp Lreterr

; os_onerror(f)
; -------------
_os_onerror:
	iny
	txa
	ora (sp),y
	beq Lonerroff
	lda (sp),y
;	sta ...
	dey
	lda (sp),y
;	sta ...
	rts
Lonerroff:
	lda #<break
;	sta ...
	lda #>break
;	sta ...
	rts

; os_call(r)
; ----------
; r => A,X,Y,P,PClo,PChi
_os_call:
	jsr Loscall1
	pha
	php
	pla
	sta asave	; save P
	txa
	pha
	tya
	pha
	lda asave	; get P back
	pha
; assumes called code doesn't corrupt pr
	ldy #3
Loscall3:
	pla
	sta (ptr1),y	; copy returned registers to r
	dey
	bpl Loscall3
	iny		; y=0
	tax             ; returns value in A
	rts
Loscall1:
	lda (sp),y
	sta ptr1
	iny
	lda (sp),y
	sta ptr2
	ldy #5
Loscall2:
	lda (ptr1),y
	pha
	dey
	bmi Loscall2
	sta asave
	pla
	pla
	tax
	pla
	tay
	lda asave
	rti		; pop P and stacked address

; convert string from C to BBC format
; ===================================
; string is null terminated in c, $0d terminated in BBC
; use pr to copy filename from addr pointed to by
; top stack item into MOS general string input buffer
;
Lgsconv:
	ldy #0
Lconv1:
	lda (sp),y	;name lo
	sta ptr1
	iny
	lda (sp),y	;name hi
	sta ptr2
	ldy #0
Lconv:
	lda (ptr1),y
	sta gsbuf,y	;parameter block for call
	beq Lterm
	iny
	bne Lconv	;max length = 255 chars
Lterm:
	lda #13		;replaces C '\0'
	sta gsbuf,y
	ldx #<gsbuf	; return xy=>converted string
	ldy #>gsbuf
	rts

Lreterr:
        ldx #$ff        ; return -1 on error
        ldy #$ff
        rts

Lretok:
        ldx #0          ; return 0 for ok
        ldy #0
        rts

.bss

break:	.res	1
gsbuf:	.res	64
