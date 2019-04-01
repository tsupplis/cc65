;
; Chars used by chline () and cvline ()
;

	.ifdef  __BBCMASTER__
        .exportzp       chlinechar = $a6
        .exportzp       cvlinechar = $a9
        .else
        .exportzp       chlinechar = 45
        .exportzp       cvlinechar = 124
	.endif
