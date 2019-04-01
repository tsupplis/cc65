



;-----------------------------------------------------------------------------
; Vectors
;-----------------------------------------------------------------------------

BS			:=  8
HT			:=  9		; (CTRL-I, 9)	Horizontal tab
LF			:= 10		; (CTRL-J, 10)	Linefeed
VT			:= 11		; (CTRL-K, 11)	Vertical tab
FF			:= 12		; (CTRL-L, 12)	Formfeed
CR			:= 13		; (CTRL-M, 13)	Return
HOME			:= 30
SPACE			:= 32		; ASCII space

;-----------------------------------------------------------------------------
; Zeropage vars
;-----------------------------------------------------------------------------

ERR_NUM			:= $00
BAS_CURLINE		:= $01
BAS_STATEMENT		:= $05

_BAS_TOP		:= $0D
_BAS_PAGE		:= $12

CURS_X			:= $60		; Cursor column
CURS_Y			:= $61		; Cursor row
TMP_PTR			:= $62		; 62, 63, 64 = temp PTR for writing
SCREEN_PTR		:= $DE		; DE DF VDU RAM address of start of line containing the cursor 
					; DE should be 00, 20, 40 ... E0, DF should be 80 or 81 
					; E0 is x-position 00 to 3F (or is that 1F?) 
CURSOR			:= $E1		; Cursor on/off (#80,0)
FILENAME		:= $D0		; D0,D1 = adres where filename is stored
DRIVECMD		:= $EC
LOADLEN			:= $ED
DRIVENR			:= $EE		; 0 <= Drivenr <=3
LOADADDR		:= $F6		; Loadadres in $F6 and $F7

STRING_BUF		:= $140

;-----------------------------------------------------------------------------
; Vectors
;-----------------------------------------------------------------------------

BRKVEC 			:= $202	; Breakvector
FNDVEC			:= $218	; Find and open file
SHTVEC			:= $21A	; Shut file

;-----------------------------------------------------------------------------
; System calls
;-----------------------------------------------------------------------------

RESTOR			:= $C2B2	; BACK TO BASIC
TOGGLE_CURSOR		:= $FD44	; Toggle cursor on/off
KEYREAD			:= $FE71
OSSHUT			:= $FFCB	; OSSHUT
OSFIND			:= $FFCE	; OSFIND
OSBPUT			:= $FFD1	; OSBPUT
OSRDAR			:= $FFDA	; OSRDAR
OSBGET			:= $FFD4	; OSBGET
OSSTAR			:= $FFD7	; OSSTAR
KBDREAD			:= $FFE3	; OSRDCH
OSWRCH			:= $FFF4	; OSWRCH
;	LFFF7_OSCLI:
;	LFFE6_OSECHO:
;	LFFE3_OSRDCH:
;	LFFF4_OSWRCH:
;	LFFED_OSCRLF:
;	LFFE0_OSLOAD:
;	LFFDD_OSSAVE:
;	LFFDA_OSRDAR:
;	LFFD7_OSSTAR:
;	LFFD4_OSBGET:
;	LFFD1_OSBPUT:
;	LFFCE_OSFIND:
;	LFFCB_OSSHUT:

;-----------------------------------------------------------------------------
; Hardware dependent settings
;	VIDEO 	= 0, STANDARD
;	  	  1, 80COL_ACN
;-----------------------------------------------------------------------------

VIDEO			:= 0
SCREEN			:= $8000

PTR			:= $2210
INFOBYTE		:= $2217

MOUSE_X			:= $BFE0
MOUSE_Y			:= $BFE1
MOUSE_PTR		:= $BFE2	; write
MOUSE_BUTTONS		:= $BFE2	; read
