;
; Character specification table.
;

; The following 256-byte-wide table specifies attributes for the isxxx type
; of functions.  Doing it by a table means some overhead in space, but it
; has major advantages:
;
;   * It is fast.  If it weren't for the slow parameter-passing of cc65,
;     one even could define C-language macroes for the isxxx functions
;     (as it usually is done, on other platforms).
;
;   * It is highly portable.  The only unportable part is the table itself;
;     all real code goes into the common library.
;
;   * We save some code in the isxxx functions.

        .include        "ctype.inc"

; The table is read-only, put it into the RODATA segment.

        .rodata

__ctype:
        .byte   CT_CTRL                                 ;   0/00 _NUL/rvs_@_
        .byte   CT_CTRL                                 ;   1/01 ___rvs_a___
        .byte   CT_CTRL                                 ;   2/02 ___rvs_b___
        .byte   CT_CTRL                                 ;   3/03 ___rvs_c___
        .byte   CT_CTRL                                 ;   4/04 ___rvs_d___
        .byte   CT_CTRL                                 ;   5/05 ___rvs_e___
        .byte   CT_CTRL                                 ;   6/06 ___rvs_f___
        .byte   CT_CTRL                                 ;   7/07 _BEL/rvs_g_
        .byte   CT_CTRL                                 ;   8/08 ___rvs_h___
        .byte   CT_CTRL | CT_OTHER_WS | CT_SPACE_TAB    ;   9/09 _TAB/rvs_i_
        .byte   CT_CTRL | CT_OTHER_WS                   ;  10/0a _BOL/rvs_j_
        .byte   CT_CTRL                                 ;  11/0b ___rvs_k___
        .byte   CT_CTRL                                 ;  12/0c ___rvs_l___
        .byte   CT_CTRL | CT_OTHER_WS                   ;  13/0d _CR_/rvs_m_
        .byte   CT_CTRL                                 ;  14/0e ___rvs_n___
        .byte   CT_CTRL                                 ;  15/0f ___rvs_o___
        .byte   CT_CTRL                                 ;  16/10 ___rvs_p___
        .byte   CT_CTRL                                 ;  17/11 _DC1/rvs_q_
        .byte   CT_CTRL                                 ;  18/12 _DC2/rvs_r_
        .byte   CT_CTRL                                 ;  19/13 _DC3/rvs_s_
        .byte   CT_CTRL                                 ;  20/14 _DC4/rvs_t_
        .byte   CT_CTRL                                 ;  21/15 ___rvs_u___
        .byte   CT_CTRL                                 ;  22/16 ___rvs_v___
        .byte   CT_CTRL                                 ;  23/17 ___rvs_w___
        .byte   CT_CTRL                                 ;  24/18 ___rvs_x___
        .byte   CT_CTRL                                 ;  25/19 ___rvs_y___
        .byte   CT_CTRL                                 ;  26/1a ___rvs_z___
        .byte   CT_CTRL                                 ;  27/1b ___rvs_[___
        .byte   CT_CTRL                                 ;  28/1c ___rvs_\___
        .byte   CT_CTRL                                 ;  29/1d _GS_/rvs_]_
        .byte   CT_CTRL                                 ;  30/1e ___rvs_^___
        .byte   CT_CTRL                                 ;  31/1f _rvs_under_
        .byte   CT_SPACE | CT_SPACE_TAB                 ;  32/20 ___SPACE___
        .byte   $00                                     ;  33/21 _____!_____
        .byte   $00                                     ;  34/22 _____"_____
        .byte   $00                                     ;  35/23 _____#_____
        .byte   $00                                     ;  36/24 _____$_____
        .byte   $00                                     ;  37/25 _____%_____
        .byte   $00                                     ;  38/26 _____&_____
        .byte   $00                                     ;  39/27 _____'_____
        .byte   $00                                     ;  40/28 _____(_____
        .byte   $00                                     ;  41/29 _____)_____
        .byte   $00                                     ;  42/2a _____*_____
        .byte   $00                                     ;  43/2b _____+_____
        .byte   $00                                     ;  44/2c _____,_____
        .byte   $00                                     ;  45/2d _____-_____
        .byte   $00                                     ;  46/2e _____._____
        .byte   $00                                     ;  47/2f _____/_____
        .byte   CT_DIGIT | CT_XDIGIT                    ;  48/30 _____0_____
        .byte   CT_DIGIT | CT_XDIGIT                    ;  49/31 _____1_____
        .byte   CT_DIGIT | CT_XDIGIT                    ;  50/32 _____2_____
        .byte   CT_DIGIT | CT_XDIGIT                    ;  51/33 _____3_____
        .byte   CT_DIGIT | CT_XDIGIT                    ;  52/34 _____4_____
        .byte   CT_DIGIT | CT_XDIGIT                    ;  53/35 _____5_____
        .byte   CT_DIGIT | CT_XDIGIT                    ;  54/36 _____6_____
        .byte   CT_DIGIT | CT_XDIGIT                    ;  55/37 _____7_____
        .byte   CT_DIGIT | CT_XDIGIT                    ;  56/38 _____8_____
        .byte   CT_DIGIT | CT_XDIGIT                    ;  57/39 _____9_____
        .byte   $00                                     ;  58/3a _____:_____
        .byte   $00                                     ;  59/3b _____;_____
        .byte   $00                                     ;  60/3c _____<_____
        .byte   $00                                     ;  61/3d _____=_____
        .byte   $00                                     ;  62/3e _____>_____
        .byte   $00                                     ;  63/3f _____?_____

        .byte   $00                                     ;  64/40 _____@_____
        .byte   CT_UPPER | CT_XDIGIT                    ;  65/41 _____a_____
        .byte   CT_UPPER | CT_XDIGIT                    ;  66/42 _____b_____
        .byte   CT_UPPER | CT_XDIGIT                    ;  67/43 _____c_____
        .byte   CT_UPPER | CT_XDIGIT                    ;  68/44 _____d_____
        .byte   CT_UPPER | CT_XDIGIT                    ;  69/45 _____e_____
        .byte   CT_UPPER | CT_XDIGIT                    ;  70/46 _____f_____
        .byte   CT_UPPER                                ;  71/47 _____g_____
        .byte   CT_UPPER                                ;  72/48 _____h_____
        .byte   CT_UPPER                                ;  73/49 _____i_____
        .byte   CT_UPPER                                ;  74/4a _____j_____
        .byte   CT_UPPER                                ;  75/4b _____k_____
        .byte   CT_UPPER                                ;  76/4c _____l_____
        .byte   CT_UPPER                                ;  77/4d _____m_____
        .byte   CT_UPPER                                ;  78/4e _____n_____
        .byte   CT_UPPER                                ;  79/4f _____o_____
        .byte   CT_UPPER                                ;  80/50 _____p_____
        .byte   CT_UPPER                                ;  81/51 _____q_____
        .byte   CT_UPPER                                ;  82/52 _____r_____
        .byte   CT_UPPER                                ;  83/53 _____s_____
        .byte   CT_UPPER                                ;  84/54 _____t_____
        .byte   CT_UPPER                                ;  85/55 _____u_____
        .byte   CT_UPPER                                ;  86/56 _____v_____
        .byte   CT_UPPER                                ;  87/57 _____w_____
        .byte   CT_UPPER                                ;  88/58 _____x_____
        .byte   CT_UPPER                                ;  89/59 _____y_____
        .byte   CT_UPPER                                ;  90/5a _____z_____
        .byte   $00                                     ;  91/5b _____[_____
        .byte   $00                                     ;  92/5c _____\_____
        .byte   $00                                     ;  93/5d _____]_____
        .byte   $00                                     ;  94/5e _____^_____
        .byte   $00                                     ;  95/5f _UNDERLINE_
        .byte   $00                                     ;  96/60 ___POUND___
        .byte   CT_LOWER | CT_XDIGIT                    ;  97/61 _____a_____
        .byte   CT_LOWER | CT_XDIGIT                    ;  98/62 _____b_____
        .byte   CT_LOWER | CT_XDIGIT                    ;  99/63 _____c_____
        .byte   CT_LOWER | CT_XDIGIT                    ; 100/64 _____d_____
        .byte   CT_LOWER | CT_XDIGIT                    ; 101/65 _____e_____
        .byte   CT_LOWER | CT_XDIGIT                    ; 102/66 _____f_____
        .byte   CT_LOWER                                ; 103/67 _____g_____
        .byte   CT_LOWER                                ; 104/68 _____h_____
        .byte   CT_LOWER                                ; 105/69 _____i_____
        .byte   CT_LOWER                                ; 106/6a _____j_____
        .byte   CT_LOWER                                ; 107/6b _____k_____
        .byte   CT_LOWER                                ; 108/6c _____l_____
        .byte   CT_LOWER                                ; 109/6d _____m_____
        .byte   CT_LOWER                                ; 110/6e _____n_____
        .byte   CT_LOWER                                ; 111/6f _____o_____
        .byte   CT_LOWER                                ; 112/70 _____p_____
        .byte   CT_LOWER                                ; 113/71 _____q_____
        .byte   CT_LOWER                                ; 114/72 _____r_____
        .byte   CT_LOWER                                ; 115/73 _____s_____
        .byte   CT_LOWER                                ; 116/74 _____t_____
        .byte   CT_LOWER                                ; 117/75 _____u_____
        .byte   CT_LOWER                                ; 118/76 _____v_____
        .byte   CT_LOWER                                ; 119/77 _____w_____
        .byte   CT_LOWER                                ; 120/78 _____x_____
        .byte   CT_LOWER                                ; 121/79 _____y_____
        .byte   CT_LOWER                                ; 122/7a _____z_____
        .byte   $00                                     ; 123/7b _____{_____
        .byte   $00                                     ; 124/7c _____|_____
        .byte   $00                                     ; 125/7d _____}_____
        .byte   $00                                     ; 126/7e _____~_____
        .byte   CT_CTRL                                 ; 127/7f ____del____

        .byte   $00                                     ; 128/80 _alt_user__
        .byte   $00                                     ; 129/81 _alt_user__
        .byte   $00                                     ; 130/82 _alt_user__
        .byte   $00                                     ; 131/83 _alt_user__
        .byte   $00                                     ; 132/84 _alt_user__
        .byte   $00                                     ; 133/85 _alt_user__
        .byte   $00                                     ; 134/86 _alt_user__
        .byte   $00                                     ; 135/87 _alt_user__
        .byte   $00                                     ; 136/88 _alt_user__
        .byte   $00                                     ; 137/89 _alt_user__
        .byte   $00                                     ; 138/8a _alt_user__
        .byte   $00                                     ; 139/8b _alt_user__
        .byte   $00                                     ; 140/8c _alt_user__
        .byte   $00                                     ; 141/8d _alt_user__
        .byte   $00                                     ; 142/8e _alt_user__
        .byte   $00                                     ; 143/8f _alt_user__
        .byte   $00                                     ; 144/90 _alt_user__
        .byte   $00                                     ; 145/91 _alt_user__
        .byte   $00                                     ; 146/92 _alt_user__
        .byte   $00                                     ; 147/93 _alt_user__
        .byte   $00                                     ; 148/94 _alt_user__
        .byte   $00                                     ; 149/95 _alt_user__
        .byte   $00                                     ; 150/96 _alt_user__
        .byte   $00                                     ; 151/97 _alt_user__
        .byte   $00                                     ; 152/98 _alt_user__
        .byte   $00                                     ; 153/99 _alt_user__
        .byte   $00                                     ; 154/9a _alt_user__
        .byte   $00                                     ; 155/9b _alt_user__
        .byte   $00                                     ; 156/9c _alt_user__
        .byte   $00                                     ; 157/9d _alt_user__
        .byte   $00                                     ; 158/9e _alt_user__
        .byte   $00                                     ; 159/9f _alt_user__
        .byte   CT_CTRL                                 ; 160/a0 ___________
        .byte   CT_CTRL                                 ; 161/a1 ___________
        .byte   CT_CTRL                                 ; 162/a2 ___________
        .byte   CT_CTRL                                 ; 163/a3 ___________
        .byte   CT_CTRL                                 ; 164/a4 ___________
        .byte   CT_CTRL                                 ; 165/a5 ___________
        .byte   CT_CTRL                                 ; 166/a6 ___________
        .byte   CT_CTRL                                 ; 167/a7 ___________
        .byte   CT_CTRL                                 ; 168/a8 ___________
        .byte   CT_CTRL                                 ; 169/a9 ___________
        .byte   CT_CTRL                                 ; 170/aa ___________
        .byte   CT_CTRL                                 ; 171/ab ___________
        .byte   CT_CTRL                                 ; 172/ac ___________
        .byte   CT_CTRL                                 ; 173/ad ___________
        .byte   CT_CTRL                                 ; 174/ae ___________
        .byte   CT_CTRL                                 ; 175/af ___________
        .byte   CT_CTRL                                 ; 176/b0 ___________
        .byte   CT_CTRL                                 ; 177/b1 ___________
        .byte   CT_CTRL                                 ; 178/b2 ___________
        .byte   CT_CTRL                                 ; 179/b3 ___________
        .byte   CT_CTRL                                 ; 180/b4 ___________
        .byte   CT_CTRL                                 ; 181/b5 ___________
        .byte   CT_CTRL                                 ; 182/b6 ___________
        .byte   CT_CTRL                                 ; 183/b7 ___________
        .byte   CT_CTRL                                 ; 184/b8 ___________
        .byte   CT_CTRL                                 ; 185/b9 ___________
        .byte   CT_CTRL                                 ; 186/ba ___________
        .byte   CT_CTRL                                 ; 187/bb ___________
        .byte   CT_CTRL                                 ; 188/bc ___________
        .byte   CT_CTRL                                 ; 189/bd ___________
        .byte   CT_CTRL                                 ; 190/be ___________
        .byte   CT_CTRL                                 ; 191/bf ___________
        .byte   CT_CTRL                                 ; 192/c0 ___________
        .byte   CT_CTRL                                 ; 193/c1 ___________
        .byte   CT_CTRL                                 ; 194/c2 ___________
        .byte   CT_CTRL                                 ; 195/c3 ___________
        .byte   CT_CTRL                                 ; 196/c4 ___________
        .byte   CT_CTRL                                 ; 197/c5 ___________
        .byte   CT_CTRL                                 ; 198/c6 ___________
        .byte   CT_CTRL                                 ; 199/c7 ___________
        .byte   CT_CTRL                                 ; 200/c8 ___________
        .byte   CT_CTRL                                 ; 201/c9 ___________
        .byte   CT_CTRL                                 ; 202/ca ___________
        .byte   CT_CTRL                                 ; 203/cb ___________
        .byte   CT_CTRL                                 ; 204/cc ___________
        .byte   CT_CTRL                                 ; 205/cd ___________
        .byte   CT_CTRL                                 ; 206/ce ___________
        .byte   CT_CTRL                                 ; 207/cf ___________
        .byte   CT_CTRL                                 ; 208/d0 ___________
        .byte   CT_CTRL                                 ; 209/d1 ___________
        .byte   CT_CTRL                                 ; 210/d2 ___________
        .byte   CT_CTRL                                 ; 211/d3 ___________
        .byte   CT_CTRL                                 ; 212/d4 ___________
        .byte   CT_CTRL                                 ; 213/d5 ___________
        .byte   CT_CTRL                                 ; 214/d6 ___________
        .byte   CT_CTRL                                 ; 215/d7 ___________
        .byte   CT_CTRL                                 ; 216/d8 ___________
        .byte   CT_CTRL                                 ; 217/d9 ___________
        .byte   CT_CTRL                                 ; 218/da ___________
        .byte   CT_CTRL                                 ; 219/db ___________
        .byte   CT_CTRL                                 ; 220/dc ___________
        .byte   CT_CTRL                                 ; 221/dd ___________
        .byte   CT_CTRL                                 ; 222/de ___________
        .byte   CT_CTRL                                 ; 223/df ___________
        .byte   $00                                     ; 224/e0 _user_defn_
        .byte   $00                                     ; 225/e1 _user_defn_
        .byte   $00                                     ; 226/e2 _user_defn_
        .byte   $00                                     ; 227/e3 _user_defn_
        .byte   $00                                     ; 228/e4 _user_defn_
        .byte   $00                                     ; 229/e5 _user_defn_
        .byte   $00                                     ; 230/e6 _user_defn_
        .byte   $00                                     ; 231/e7 _user_defn_
        .byte   $00                                     ; 232/e8 _user_defn_
        .byte   $00                                     ; 233/e9 _user_defn_
        .byte   $00                                     ; 234/ea _user_defn_
        .byte   $00                                     ; 235/eb _user_defn_
        .byte   $00                                     ; 236/ec _user_defn_
        .byte   $00                                     ; 237/ed _user_defn_
        .byte   $00                                     ; 238/ee _user_defn_
        .byte   $00                                     ; 239/ef _user_defn_
        .byte   $00                                     ; 240/f0 _user_defn_
        .byte   $00                                     ; 241/f1 _user_defn_
        .byte   $00                                     ; 242/f2 _user_defn_
        .byte   $00                                     ; 243/f3 _user_defn_
        .byte   $00                                     ; 244/f4 _user_defn_
        .byte   $00                                     ; 245/f5 _user_defn_
        .byte   $00                                     ; 246/f6 _user_defn_
        .byte   $00                                     ; 247/f7 _user_defn_
        .byte   $00                                     ; 248/f8 _user_defn_
        .byte   $00                                     ; 249/f9 _user_defn_
        .byte   $00                                     ; 250/fa _user_defn_
        .byte   $00                                     ; 251/fb _user_defn_
        .byte   $00                                     ; 252/fc _user_defn_
        .byte   $00                                     ; 253/fd _user_defn_
        .byte   $00                                     ; 254/fe _user_defn_
        .byte   $00                                     ; 255/ff _user_defn_

