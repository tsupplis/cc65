
	;; Keivn Ruland
	;;
	;; unsigned char wherex( void );
	;; unsigned char wherey( void );

	.export		_wherex, _wherey

	.include	"atom.inc"

_wherex:
	lda	CURS_X
	rts

_wherey:
	lda	CURS_Y
	rts
	