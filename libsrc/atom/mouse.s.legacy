;--------------------------------------------------------------------
; Atomic Kees van Oss mouse

	.export		_mouse_init, _mouse_done, _mouse_box
	.export 		_mouse_show, _mouse_hide, _mouse_move
	.export 		_mouse_buttons, _mouse_pos, _mouse_info

	.import	 	popax
	.importzp		ptr1

	.include 		"atom.inc"

; the default values force the mouse cursor inside the test screen (no access to border)

defxmin = 0			; default x minimum
defymin = 0			; default y minimum
defxmax = 255		; default x maximum
defymax = 191		; default y maximum

xinit	= defxmin		; init. x pos.
yinit	= defymin		; init. y pos.

;--------------------------------------------------------------------
; Initialize mouse routines
; void __fastcall__ mouse_init (unsigned char type);

_mouse_init:
	cmp	#4
	bne	init_fail

	lda	#0				; check if mouse interface  available
	sta	MOUSE_X
	lda	MOUSE_X
	bne	init_fail
	lda	#$FF
	sta	MOUSE_X
	lda	MOUSE_X
	cmp	#$FF
	bne	init_fail

	lda	#%10000000			; disable mouse
	sta	MOUSE_PTR			; set mousepointer

	lda	defxmin			; set x-position mouse
	sta	MOUSE_X

	lda	defymin			; set y-position mouse
	sta	MOUSE_Y

	lda	defxmin			; reset bounding box
	sta	xmin
	lda	defxmax
	sta	xmax
	lda	defymin
	sta	ymin
	lda	defymax
	sta	ymax

	ldx	#0				; mouse found
	lda	#1
	sta	mouse_off			; set counter
	rts

init_fail:
	ldx	#0				; mouse error
	txa
	rts

;--------------------------------------------------------------------
; Finish mouse routines
; void mouse_done(void)

_mouse_done:
	lda	MOUSE_PTR
	ora	#%10000000		; disable mouse
	sta	MOUSE_PTR

	ldx	#1
	stx	mouse_off
	rts

;--------------------------------------------------------------------
; Set mouse limits
; void __fastcall__ mouse_box(int xmin, int ymin, int xmax, int ymax)

_mouse_box:
	sta	ymax
	jsr	popax			; always ignore high byte
	sta	xmax
	jsr	popax
	sta	ymin
	jsr	popax
	sta	xmin
	rts

;--------------------------------------------------------------------
; Set mouse position
; void __fastcall__ mouse_move(int xpos, int ypos)

_mouse_move:
	sta	MOUSE_Y		; always ignore high byte
	jsr	popax
	sta	MOUSE_X
	rts

;--------------------------------------------------------------------
; Show mouse arrow
; void mouse_show(void)

_mouse_show:
	lda	mouse_off		; already on?
	beq	@L1
	dec	mouse_off
	bne	@L1
	lda	MOUSE_PTR
	and	#%01111111
	sta	MOUSE_PTR
@L1:	rts

;--------------------------------------------------------------------
; Hide mouse arrow
; void mouse_hide(void)

_mouse_hide:
	lda	mouse_off
	bne	@L2			; was on?
	lda	MOUSE_PTR
	ora	#%10000000
	sta	MOUSE_PTR
@L2:	inc	mouse_off
	rts

;--------------------------------------------------------------------
; Ask mouse button
; unsigned char mouse_buttons(void)

_mouse_buttons:
	lda	MOUSE_BUTTONS
	and	#%00000011
	tax
	lda	buttons,x
    	rts

;--------------------------------------------------------------------
; Get the mouse position
; void mouse_pos (struct mouse_pos* pos);

_mouse_pos:
	sta	ptr1
	stx	ptr1+1			; Store argument pointer
	ldy	#0
	lda	MOUSE_X			; X position
	sta	(ptr1),y
	lda	#0
	iny
	sta	(ptr1),y
	lda	MOUSE_Y			; Y position
	iny
	sta	(ptr1),y
	lda	#0
	iny
	sta	(ptr1),y
    	rts

;--------------------------------------------------------------------
; Get the mouse position and button information
; void mouse_info (struct mouse_info* info);

_mouse_info:

; We're cheating here to keep the code smaller: The first fields of the
; mouse_info struct are identical to the mouse_pos struct, so we will just
; call _mouse_pos to initialize the struct pointer and fill the position
; fields.

	jsr	_mouse_pos

; Fill in the button state

	jsr	_mouse_buttons		; Will not touch ptr1
	ldy	#4
	sta	(ptr1),y

     	rts

;--------------------------------------------------------------------
        .rodata
; default values

xmin:		.byte	defxmin
ymin:		.byte	defymin
xmax:		.byte	defxmax
ymax:		.byte	defymax

mouse_off:	.res 1

buttons:	.byte $11,$01,$10,$00
