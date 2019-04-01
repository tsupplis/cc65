;
; BBC generic definitions
;

CLOCKS_PER_SEC = 100

; ---------------------------------------------------------------------------
; Zero page

VDU_STATUS     := $D0         ; VDU status as returned by OSBYTE &75
AUTO_REPEAT    := $E7         ; Auto repeat countdown timer 
KEY_PRESSED    := $EC         ; Pressed key code or 0 if none pressed

TEXT_X1        := $308        ; Text window, left hand column
TEXT_Y1        := $309        ; Text window, bottom row
TEXT_X2        := $30A        ; Text window, right hand column
TEXT_Y2        := $30B        ; Text window, top row
CURS_X         := $318        ; Current text cursor X co-ordinate
CURS_Y         := $319        ; Current text cursor Y co-ordinate
HIMEM          := $34E        ; High byte of bottom of screen memory
MODESIZE       := $354        ; High byte of size of screen memory
MODE           := $355        ; Current screen mode
MODEMEMMAP     := $356        ; Memory map type.
FTCOL          := $357        ; Foreground text colour
BTCOL          := $358        ; Backgrould text colour
FGCOL          := $359        ; Foreground graphics colour
BGCOL          := $35A        ; Background graphics colour
COLOURS        := $360        ; Number of logical colours minus one

; ---------------------------------------------------------------------------
; Vectors

USERV          := $200        ; User vector
BRKV           := $202        ; Break vector
IRQ1V          := $204        ; Primary interrupt vector
IRQ2V          := $206        ; Secondary interrupt vector
CLIV           := $208        ; Command line interpreter vector
BYTEV          := $20A        ; OSBYTE indirection vector
WORDV          := $20C        ; OSWORD indirection vector
WRCHV          := $20E        ; WRCHV indirection vector
RDCHV          := $210        ; RDCHV indirection vector
FILEV          := $212        ; Read/write a whole file vector
ARGSV          := $214        ; OSARGS indirection vector
BGETV          := $216        ; Read one byte from a file. (BGET/*EXEC)
BPUTV          := $218        ; Write one byte to a file. (BPUT/*SPOOL)
GBPBV          := $21A        ; Read/write block of bytes
FINDV          := $21C        ; Open/close a file
FSCV           := $21E        ; Various filing system control
EVENTV         := $220        ; Pointer to event handling routine
UPTV           := $222        ; Pointer to user print routine
NETV           := $224        ; Used by Econet
VDUV           := $226        ; Unrecognized VDU 23/PLOT routine
KEYV           := $228        ; Keyboard indirection vector
INSV           := $22A        ; Insert into buffer vector
REMV           := $22C        ; Remove from buffer vector
CNPV           := $22E        ; Count/purge buffer vector
IND1V          := $230        ; Spare
IND2V          := $232        ; Spare
IND3V          := $234        ; Spare

; ---------------------------------------------------------------------------
; Operating System calls

OSWRCH         := $FFEE
OSRDCH         := $FFE0
OSNEWL         := $FFE7
OSASCI         := $FFE3
GSINIT         := $FFC2
GSREAD         := $FFC5
OSRDRM         := $FFB9
OSEVEN         := $FFBF
OSCLI          := $FFF7
OSBYTE         := $FFF4
OSWORD         := $FFF1
OSFILE         := $FFDD
OSFIND         := $FFCE
OSARGS         := $FFDA
OSBGET         := $FFD7
OSBPUT         := $FFD4
OSGBPB         := $FFD1

;
; Hardware

FRED           := $FC00
JIM            := $FD00
SHEILA         := $FE00

SHEILA_CRTC    := $FE00
SHEILA_ACIA    := $FE08
SHEILA_SULA    := $FE10
SHEILA_VULA    := $FE20
SHEILA_ROMSEL  := $FE30
SHEILA_SYSVIA  := $FE40
SHEILA_USRVIA  := $FE60
SHEILA_FDC     := $FE80
SHEILA_ECONET  := $FEA0
SHEILA_ADC     := $FEC0
SHEILA_TUBE    := $FEE0

