; xos/s  20-Jun-2005  J.G.Harston

;
; Error-trapping MOS calls
;

	.export		_xos_cli
	.export		_xos_byte
	.export		_xos_word
	.export		_xos_wrch
	.export		_xos_asci
	.export		_xos_file
	.export		_xos_args
	.export		_xos_bget
	.export		_xos_bput
	.export		_xos_gbpb
	.export		_xos_find
	.include	"bbc.inc"
	.include	"zeropage.inc"

;
; r[0]=A; r[1]=X; r[2]=Y; r[3]=P
; status=xos_call(r);
; status==0  - no error returned, A=r[0]; X=r[1]; Y=r[2]; P=r[3];
; status<>0  - error occured, ERR=status[0]; REPORT=status+1;
; status==-1 - escape occured and acknowledged

_xos_cli:
	jsr Lxos
	.word OSCLI-1
_xos_byte:
	jsr Lxos
	.word OSBYTE-1
_xos_word:
	jsr Lxos
	.word OSWORD-1
_xos_wrch:
	jsr Lxos
	.word OSWRCH-1
_xos_asci:
	jsr Lxos
	.word OSASCI-1
_xos_file:
	jsr Lxos
	.word OSFILE-1
_xos_args:
	jsr Lxos
	.word OSARGS-1
_xos_bget:
	jsr Lxos
	.word OSBGET-1
_xos_bput:
	jsr Lxos
	.word OSBPUT-1
_xos_gbpb:
	jsr Lxos
	.word OSGBPB-1
_xos_find:
	jsr Lxos
	.word OSFIND-1

; xos(reg *r)
; -----------
Lxos:
	pla
	sta tmp1		; (tr)=address of data after JSR
	pla
	sta tmp2
	ldy #0
	lda (sp),y
	sta ptr1
	iny
	lda (sp),y		;
	sta ptr2		; (pr)=address of register block
	lda BRKV+1
	pha
	lda BRKV+0
	pha			; Save current BRKV
	lda #>Lxostrap
	sta BRKV+1
	lda #<Lxostrap
	sta BRKV+0
	lda regsave
	pha			; Save current return stack pointer
	tsx
	stx regsave		; Save stack pointer
	jsr Lxosjmp		; Call inline address
	sta tmp1		; Store returned values
	stx tmp2
	sty tmp3
	php
	pla
	sta tmp4
	dey
Lxos2:
	lda (tmp1),y		; Copy returned registers
	sta (ptr1),y
	iny
	cpy #4
	bne Lxos2
	ldx #0
	ldy #0			; Prepare to return zero
	bit $ff
	bpl Lxosexit		; No pending escape
	lda #126
	jsr OSBYTE		; Acknowledge escape state
	dex
	dey			; Return -1 to indicate escape
Lxosexit:
	pla
	sta regsave		; Restore return stack pointer
	pla
	sta BRKV+0
	pla
	sta BRKV+1		; Restore BRKV
	rts

Lxosjmp:
	ldy #1
	lda (tmp1),y		; Point to inline address
	pha
	iny
	lda (tmp1),y
	pha			; Push it onto the stack
	iny
	lda (ptr1),y		; Get P
	pha			; Push it for later
	ldy #0
	lda (ptr1),y		; Get A
	pha			; Push it for later
	iny
	lda (ptr1),y		; Get X
	tax
	iny
	lda (ptr1),y		; Get Y
	tay
	pla			; Get A back
	plp			; Get P back
	rts			; Jump to OS routine

Lxostrap:
	ldx regsave
	txs			; Restore stack pointer
	ldx $FD
	ldy $FE			; Get pointer to error in &XXAA
	jmp Lxosexit

