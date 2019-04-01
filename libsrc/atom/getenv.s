;
; Ullrich von Bassewitz, 17.06.1998
;
; char* getenv (const char* name);
;
; Adapted for the Acorn Atom by K.v.Oss, 29.09.2003

	.export	_getenv
	.import	return0

_getenv	= return0		; "not found"

