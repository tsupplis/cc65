;
; This module supplies the load address
;

	; The following symbol is used by the linker config to force the module
	; to get included into the output file
	.export		__LOADADDR__: absolute = 1
	.import		__MAIN_START__, __MAIN_SIZE__, __STARTUP__, __BSS_RUN__

load_addr	:= __MAIN_START__
load_size	:= __BSS_RUN__ - __MAIN_START__
exec_addr	:= __STARTUP__

.mac    hex1    h
	.lobytes        ((h) & $0F) + (((h) & $0F) > 9) * 7 + '0'
.endmac

.mac    hex2    h
	hex1    (h) >> 4
	hex1    (h) >> 0
.endmac

.mac    hex4    h
	hex2    >(h)
	hex2    <(h)
.endmac

.segment	"LOADADDR"
	hex4	load_addr
	.byte	" "
	hex4	exec_addr
	.byte	" "
	hex4	load_size


