;
; File generated by cc65 v 2.17 - Git 19925800
;
	.fopt		compiler,"cc65 v 2.17 - Git 19925800"
	.setcpu		"6502"
	.smart		on
	.autoimport	on
	.case		on
	.debuginfo	on
	.importzp	sp, sreg, regsave, regbank
	.importzp	tmp1, tmp2, tmp3, tmp4, ptr1, ptr2, ptr3, ptr4
	.macpack	longbranch
	.dbg		file, "overlaydemo.c", 3179, 1554126600
	.dbg		file, "/opt/cc-6502/share/cc65/include/stdio.h", 6189, 1554133537
	.dbg		file, "/opt/cc-6502/share/cc65/include/stddef.h", 3057, 1554133537
	.dbg		file, "/opt/cc-6502/share/cc65/include/stdarg.h", 2913, 1554133537
	.dbg		file, "/opt/cc-6502/share/cc65/include/cc65.h", 5139, 1554133537
	.dbg		file, "/opt/cc-6502/share/cc65/include/cbm.h", 11354, 1554133537
	.dbg		file, "/opt/cc-6502/share/cc65/include/c64.h", 6969, 1554133537
	.dbg		file, "/opt/cc-6502/share/cc65/include/_vic2.h", 10835, 1554133537
	.dbg		file, "/opt/cc-6502/share/cc65/include/_sid.h", 3626, 1554133537
	.dbg		file, "/opt/cc-6502/share/cc65/include/_6526.h", 3962, 1554133537
	.dbg		file, "/opt/cc-6502/share/cc65/include/cbm_filetype.h", 4949, 1554133537
	.dbg		file, "/opt/cc-6502/share/cc65/include/device.h", 3212, 1554133537
	.forceimport	__STARTUP__
	.dbg		sym, "getchar", "00", extern, "_getchar"
	.dbg		sym, "printf", "00", extern, "_printf"
	.dbg		sym, "doesclrscrafterexit", "00", extern, "_doesclrscrafterexit"
	.dbg		sym, "cbm_load", "00", extern, "_cbm_load"
	.dbg		sym, "getcurrentdevice", "00", extern, "_getcurrentdevice"
	.dbg		sym, "_OVERLAY1_LOAD__", "00", extern, "__OVERLAY1_LOAD__"
	.dbg		sym, "_OVERLAY1_SIZE__", "00", extern, "__OVERLAY1_SIZE__"
	.dbg		sym, "_OVERLAY2_LOAD__", "00", extern, "__OVERLAY2_LOAD__"
	.dbg		sym, "_OVERLAY2_SIZE__", "00", extern, "__OVERLAY2_SIZE__"
	.dbg		sym, "_OVERLAY3_LOAD__", "00", extern, "__OVERLAY3_LOAD__"
	.dbg		sym, "_OVERLAY3_SIZE__", "00", extern, "__OVERLAY3_SIZE__"
	.import		_getchar
	.import		_printf
	.import		_doesclrscrafterexit
	.import		_cbm_load
	.import		_getcurrentdevice
	.import		__OVERLAY1_LOAD__
	.import		__OVERLAY1_SIZE__
	.import		__OVERLAY2_LOAD__
	.import		__OVERLAY2_SIZE__
	.import		__OVERLAY3_LOAD__
	.import		__OVERLAY3_SIZE__
	.export		_log
	.export		_foo
	.export		_bar
	.export		_foobar
	.export		_loadfile
	.export		_main

.segment	"RODATA"

L0027:
	.byte	$CC,$4F,$41,$44,$49,$4E,$47,$20,$4F,$56,$45,$52,$4C,$41,$59,$20
	.byte	$46,$49,$4C,$45,$20,$46,$41,$49,$4C,$45,$44,$00
L0041:
	.byte	$C3,$41,$4C,$4C,$49,$4E,$47,$20,$4F,$56,$45,$52,$4C,$41,$59,$20
	.byte	$33,$20,$46,$52,$4F,$4D,$20,$4D,$41,$49,$4E,$00
L0037:
	.byte	$C3,$41,$4C,$4C,$49,$4E,$47,$20,$4F,$56,$45,$52,$4C,$41,$59,$20
	.byte	$32,$20,$46,$52,$4F,$4D,$20,$4D,$41,$49,$4E,$00
L000E:
	.byte	$C3,$41,$4C,$4C,$49,$4E,$47,$20,$4D,$41,$49,$4E,$20,$46,$52,$4F
	.byte	$4D,$20,$4F,$56,$45,$52,$4C,$41,$59,$20,$31,$00
L0014:
	.byte	$C3,$41,$4C,$4C,$49,$4E,$47,$20,$4D,$41,$49,$4E,$20,$46,$52,$4F
	.byte	$4D,$20,$4F,$56,$45,$52,$4C,$41,$59,$20,$32,$00
L001A:
	.byte	$C3,$41,$4C,$4C,$49,$4E,$47,$20,$4D,$41,$49,$4E,$20,$46,$52,$4F
	.byte	$4D,$20,$4F,$56,$45,$52,$4C,$41,$59,$20,$33,$00
L002D:
	.byte	$C3,$41,$4C,$4C,$49,$4E,$47,$20,$4F,$56,$45,$52,$4C,$41,$59,$20
	.byte	$31,$20,$46,$52,$4F,$4D,$20,$4D,$41,$49,$4E,$00
L003B:
	.byte	$4F,$56,$52,$4C,$44,$45,$4D,$4F,$2E,$32,$00
L0045:
	.byte	$4F,$56,$52,$4C,$44,$45,$4D,$4F,$2E,$33,$00
L0031:
	.byte	$4F,$56,$52,$4C,$44,$45,$4D,$4F,$2E,$31,$00
L0008:
	.byte	$CC,$4F,$47,$3A,$20,$25,$53,$0D,$00

; ---------------------------------------------------------------
; void __near__ log (__near__ unsigned char *)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_log: near

	.dbg	func, "log", "00", extern, "_log"
	.dbg	sym, "msg", "00", auto, 0

.segment	"CODE"

;
; {
;
	.dbg	line, "overlaydemo.c", 33
	jsr     pushax
;
; printf ("Log: %s\n", msg);
;
	.dbg	line, "overlaydemo.c", 34
	lda     #<(L0008)
	ldx     #>(L0008)
	jsr     pushax
	ldy     #$05
	jsr     pushwysp
	ldy     #$04
	jsr     _printf
;
; }
;
	.dbg	line, "overlaydemo.c", 35
	jmp     incsp2
	.dbg	line

.endproc

; ---------------------------------------------------------------
; void __near__ foo (void)
; ---------------------------------------------------------------

.segment	"OVERLAY1"

.proc	_foo: near

	.dbg	func, "foo", "00", extern, "_foo"

.segment	"OVERLAY1"

;
; log ("Calling main from overlay 1");
;
	.dbg	line, "overlaydemo.c", 51
	lda     #<(L000E)
	ldx     #>(L000E)
	jmp     _log
	.dbg	line

.endproc

; ---------------------------------------------------------------
; void __near__ bar (void)
; ---------------------------------------------------------------

.segment	"OVERLAY2"

.proc	_bar: near

	.dbg	func, "bar", "00", extern, "_bar"

.segment	"OVERLAY2"

;
; log ("Calling main from overlay 2");
;
	.dbg	line, "overlaydemo.c", 61
	lda     #<(L0014)
	ldx     #>(L0014)
	jmp     _log
	.dbg	line

.endproc

; ---------------------------------------------------------------
; void __near__ foobar (void)
; ---------------------------------------------------------------

.segment	"OVERLAY3"

.proc	_foobar: near

	.dbg	func, "foobar", "00", extern, "_foobar"

.segment	"OVERLAY3"

;
; log ("Calling main from overlay 3");
;
	.dbg	line, "overlaydemo.c", 71
	lda     #<(L001A)
	ldx     #>(L001A)
	jmp     _log
	.dbg	line

.endproc

; ---------------------------------------------------------------
; unsigned char __near__ loadfile (__near__ unsigned char *, __near__ void *, __near__ void *)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_loadfile: near

	.dbg	func, "loadfile", "00", extern, "_loadfile"
	.dbg	sym, "name", "00", auto, 4
	.dbg	sym, "addr", "00", auto, 2
	.dbg	sym, "size", "00", auto, 0

.segment	"CODE"

;
; {
;
	.dbg	line, "overlaydemo.c", 78
	jsr     pushax
;
; if (cbm_load (name, getcurrentdevice (), NULL) == 0) {
;
	.dbg	line, "overlaydemo.c", 93
	jsr     decsp3
	ldy     #$08
	lda     (sp),y
	tax
	dey
	lda     (sp),y
	ldy     #$01
	sta     (sp),y
	iny
	txa
	sta     (sp),y
	jsr     _getcurrentdevice
	ldy     #$00
	sta     (sp),y
	ldx     #$00
	txa
	jsr     _cbm_load
	cpx     #$00
	bne     L0020
	cmp     #$00
	bne     L004D
;
; log ("Loading overlay file failed");
;
	.dbg	line, "overlaydemo.c", 94
	lda     #<(L0027)
	ldx     #>(L0027)
	jsr     _log
;
; return 0;
;
	.dbg	line, "overlaydemo.c", 95
	ldx     #$00
	txa
	jmp     incsp6
;
; return 1;
;
	.dbg	line, "overlaydemo.c", 99
L0020:	ldx     #$00
L004D:	lda     #$01
;
; }
;
	.dbg	line, "overlaydemo.c", 100
	jmp     incsp6
	.dbg	line

.endproc

; ---------------------------------------------------------------
; void __near__ main (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_main: near

	.dbg	func, "main", "00", extern, "_main"

.segment	"CODE"

;
; log ("Calling overlay 1 from main");
;
	.dbg	line, "overlaydemo.c", 105
	lda     #<(L002D)
	ldx     #>(L002D)
	jsr     _log
;
; if (loadfile ("ovrldemo.1", _OVERLAY1_LOAD__, _OVERLAY1_SIZE__)) {
;
	.dbg	line, "overlaydemo.c", 111
	jsr     decsp4
	lda     #<(L0031)
	ldy     #$02
	sta     (sp),y
	iny
	lda     #>(L0031)
	sta     (sp),y
	lda     #<(__OVERLAY1_LOAD__)
	ldy     #$00
	sta     (sp),y
	iny
	lda     #>(__OVERLAY1_LOAD__)
	sta     (sp),y
	lda     #<(__OVERLAY1_SIZE__)
	ldx     #>(__OVERLAY1_SIZE__)
	jsr     _loadfile
	tax
	beq     L002F
;
; foo ();
;
	.dbg	line, "overlaydemo.c", 117
	jsr     _foo
;
; log ("Calling overlay 2 from main");
;
	.dbg	line, "overlaydemo.c", 120
L002F:	lda     #<(L0037)
	ldx     #>(L0037)
	jsr     _log
;
; if (loadfile ("ovrldemo.2", _OVERLAY2_LOAD__, _OVERLAY2_SIZE__)) {
;
	.dbg	line, "overlaydemo.c", 125
	jsr     decsp4
	lda     #<(L003B)
	ldy     #$02
	sta     (sp),y
	iny
	lda     #>(L003B)
	sta     (sp),y
	lda     #<(__OVERLAY2_LOAD__)
	ldy     #$00
	sta     (sp),y
	iny
	lda     #>(__OVERLAY2_LOAD__)
	sta     (sp),y
	lda     #<(__OVERLAY2_SIZE__)
	ldx     #>(__OVERLAY2_SIZE__)
	jsr     _loadfile
	tax
	beq     L0039
;
; bar ();
;
	.dbg	line, "overlaydemo.c", 126
	jsr     _bar
;
; log ("Calling overlay 3 from main");
;
	.dbg	line, "overlaydemo.c", 129
L0039:	lda     #<(L0041)
	ldx     #>(L0041)
	jsr     _log
;
; if (loadfile ("ovrldemo.3", _OVERLAY3_LOAD__, _OVERLAY3_SIZE__)) {
;
	.dbg	line, "overlaydemo.c", 130
	jsr     decsp4
	lda     #<(L0045)
	ldy     #$02
	sta     (sp),y
	iny
	lda     #>(L0045)
	sta     (sp),y
	lda     #<(__OVERLAY3_LOAD__)
	ldy     #$00
	sta     (sp),y
	iny
	lda     #>(__OVERLAY3_LOAD__)
	sta     (sp),y
	lda     #<(__OVERLAY3_SIZE__)
	ldx     #>(__OVERLAY3_SIZE__)
	jsr     _loadfile
	tax
	beq     L0043
;
; foobar ();
;
	.dbg	line, "overlaydemo.c", 131
	jsr     _foobar
;
; if (doesclrscrafterexit ()) {
;
	.dbg	line, "overlaydemo.c", 134
L0043:	jsr     _doesclrscrafterexit
	tax
;
; getchar ();
;
	.dbg	line, "overlaydemo.c", 135
	jne     _getchar
;
; }
;
	.dbg	line, "overlaydemo.c", 137
	rts
	.dbg	line

.endproc

