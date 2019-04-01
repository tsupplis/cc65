;
; 
; ATOMMC header file generation
; Automatically calculates the file size and sets up a ATOMMC header
; The filename will default to CC65GEN
;

	.debuginfo		+
        .export         __MMCHEADER__ : absolute = 1; Mark as MMC header
        .export         MMC_HEADER
        .import         __MAIN_START__, __MAIN_LAST__   ; Linker generated


; ------------------------------------------------------------------------
; Actual code
        .segment        "MMCHEADER"
MMC_HEADER:
        .byte           "CC65GEN         "

        .addr           __MAIN_START__                  ; Load address
        .addr		__MAIN_START__			; Execution address
        .word           __MAIN_LAST__ - __MAIN_START__  ; Load length
        

