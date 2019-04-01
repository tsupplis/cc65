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

	.export		_system
	.import		_os_cli

	.include	"bbc.inc"
	.include	"zeropage.inc"

; low level stdio program execution routines
; ==========================================
; On entry, y=>top of stacked parameters at (sp), left-to-right
;           x=top parameter
; On exit,  xy=return value
;

; system(string)
; --------------
; execute MOS command and return result
;
.proc	_system
;	jsr ~gsconv	; convert to BBC format
;	ldx #<gsbuf
;	ldy #>gsbuf
;	jsr oscli
	jsr _os_cli	; execute command line
	lda #1		; recover return value
	ldx #0		; clear it once read
	jsr OSBYTE	; read return value into x
	ldy #0		; clear y
	rts		; return return value in xy
.endproc

