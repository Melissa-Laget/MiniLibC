; Memcpy
; Copy memory area

            BITS 64                             ; 64−bit mode

            GLOBAL      memcpy:function         ;(like include in c) memcpy : global --> memcpy_lp + memcpy_end : static

            SECTION     .text                   ; Code section -> the code is inside .text

memcpy:
            ENTER       0, 0                    ; Setup stack : first 0 = no memory asked second 0 = no function inside function
            MOV         rax, rdi                ; Copy rdi inside rax
            CMP         rdi, 0x0                ; Check if first argument is NULL
            JE          memcpy_ex               ; If true you exit
            CMP         rsi, 0x0                ; Check if second argument is NULL
            JE          memcpy_ex               ; If true, go into exit

memcpy_lp:
            CMP         rdx, 0                  ; Check if third argument is 0
            JE          memcpy_ex               ; If true, go into exit
            MOV         cl, [rsi]               ; Copy second argument inside rcx
            MOV         [rdi], cl               ; Copy rcx inside first argument
            ADD         rdi, 1                  ; Add 1 to first argument
            ADD         rsi, 1                  ; Add 1 to second argument
            SUB         rdx, 1                  ; Add 1 to  third argument
            JMP         memcpy_lp               ; Go back into the loop again

memcpy_ex:
            LEAVE                               ; unsetup stack (enter)
            RET                                 ; jump into call adress (call)
