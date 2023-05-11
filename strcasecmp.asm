; Strcasecmp
; Compare two strings ignoring case

            BITS 64                             ; 64−bit mode

            GLOBAL      strcasecmp:function     ; (like strcasecmp_include in c) strcasecmp : global --> strcasecmp_lp + strcasecmp_end : static

            SECTION     .text                   ; Code section -> the code is inside .text

strcasecmp_less:
            MOV         rax, -1                 ; Copy -1 into rax
            JMP         strcasecmp_ex           ; Go into exit

strcasecmp_more:
            MOV         rax, 1                  ; Copy 1 into rax
            JMP         strcasecmp_ex           ; Go into exit

strcasecmp:
            ENTER       0, 0                    ; Setup stack : first 0 = no memory asked second 0 = no function inside function
            MOV         rax, 0                  ; Copy 0 into rax
            CMP         rdi, 0x0                ; Check if first argument is NULL
            JE          strcasecmp_ex           ; If true, go to exit
            CMP         rsi, 0x0                ; Check is second argument is NULL
            JE          strcasecmp_ex           ; If true, go to exit
            MOV         rax, 0                  ; Copy 0 into rax
            JMP         strcasecmp_st_lp        ; Go to strcasecmp_st_lp

strcasecmp_lp:
            CMP         cl, 00                  ; Check if rcx is NULL
            JE          strcasecmp_ex           ; If true, go to exit

strcasecmp_st_lp:
            MOV         cl, [rdi]               ; Copy first argument inside rcx
            MOV         ch, [rsi]               ; Copy second argument inside rcx
            ADD         rdi, 1                  ; Add 1 to first argument
            ADD         rsi, 1                  ; Add 1 to second argument

strcasecmp_cl_lw:
            CMP         cl, 'A'                 ; Compare first argument to A
            JL          strcasecmp_ch_lw        ; If less than A (not a letter), go to strcasecmp_ch_lw
            CMP         cl, 'Z'                 ; Compare first argument to Z
            JG          strcasecmp_ch_lw        ; If greater than Z (not a letter), go to strcasecmp_ch_lw
            ADD         cl, 32                  ; Add to first argument 23 (From A -> a)

strcasecmp_ch_lw:
            CMP         ch, 'A'                 ; Compare second argument to A
            JL          strcasecmp_cmp_lp       ; If less than A (not a letter), go to strcasecmp_cmp_lp
            CMP         ch, 'Z'                 ; Compare second argument to Z
            JG          strcasecmp_cmp_lp       ; If greater than Z (not a letter), go to strcasecmp_cmp_lp
            ADD         ch, 32                  ; Add to second argument 23 (From A -> a)

strcasecmp_cmp_lp:
            CMP         cl, ch                  ; Compare the two argument
            JE          strcasecmp_lp           ; If equal, go to loop
            JL          strcasecmp_less         ; if less, go to loop less
            JMP         strcasecmp_more         ; jump into loop more

strcasecmp_ex:
            LEAVE                               ; Unsetup stack (enter)
            RET                                 ; Jump into call adress (call)
