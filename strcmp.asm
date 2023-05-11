; Strcmp
; Compare two strings

            BITS 64                             ; 64−bit mode

            GLOBAL      strcmp:function         ; (like include in c) strcmp : global --> strcmp_lp + strcmp_end : static

            SECTION     .text                   ; Code section -> the code is inside .text

strcmp_less:
            MOV         rax, -1                 ; Copy -1 into rax
            JMP         strcmp_ex               ; Go into exit

strcmp_more:
            MOV         rax, 1                  ; Copy 1 into rax
            JMP         strcmp_ex               ; Go into exit

strcmp:
            ENTER       0, 0                    ; Setup stack : first 0 = no memory asked second 0 = no function inside function
            MOV         rax, 0                  ; Copy 0 into rax
            CMP         rdi, 0x0                ; Check if first argument is NULL
            JE          strcmp_ex               ; If true, go into exit
            CMP         rsi, 0x0                ; Check if second argument is NULL
            JE          strcmp_ex               ; If true, go into exit
            JMP         strcmp_start_lp         ; Go into strcmp_start_lp

strcmp_lp:
            CMP         cl, 00                  ; Check if rcx is equal to 0
            JE          strcmp_ex               ; If true, you exit

strcmp_start_lp:
            MOV         cl, [rdi]               ; Copy first argument into rcx
            MOV         ch, [rsi]               ; Copy second argument into rcx but the other register
            ADD         rdi, 1                  ; Add 1 to first argument
            ADD         rsi, 1                  ; Add 1 to second argument
            CMP         cl, ch                  ; Compare the two rcx
            JE          strcmp_lp               ; If equal, go inside loop
            JL          strcmp_less             ; If less, go inside less loop
            JMP         strcmp_more             ; Jump inside more loop

strcmp_ex:
            LEAVE                               ; Unsetup stack (enter)
            RET                                 ; Jump into call adress (call)
