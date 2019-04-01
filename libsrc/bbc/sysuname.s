;
; unsigend char __fastcall__ _sysuname (struct utsname* buf);
;

	.export		__sysuname, utsdata

	.import		utscopy

	__sysuname = utscopy

; Data

.rodata

utsdata:
	; sysname
	.asciiz		"cc65"

	; nodename
	.asciiz		""

	; release
	.byte           ((.VERSION >> 8) & $0F) + '0'
	.byte           '.'
	.byte           ((.VERSION >> 4) & $0F) + '0'
	.byte           $00

	; version
	.byte           (.VERSION & $0F) + '0'
	.byte           $00

	; machine
	.ifdef  __BBCMASTER__
	.asciiz         "BBC Master"
	.else
	.asciiz         "BBC Micro"
	.endif

