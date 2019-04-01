;
; Ullrich von Bassewitz, 06.08.1998
;
; unsigned char __fastcall__ textcolor (unsigned char color);
; unsigned char __fastcall__ bgcolor (unsigned char color);
; unsigned char __fastcall__ bordercolor (unsigned char color);
;
; Adapted for the Acorn Atom by K.v.Oss, 29.09.2003

 	.export	_textcolor, _bgcolor, _bordercolor
	.import	return0, return1

_textcolor		= return1

_bgcolor		= return0

_bordercolor	= return0


