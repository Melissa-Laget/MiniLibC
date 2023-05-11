; Strncmp
; Compare two strings

            BITS 64                             ; 64−bit mode

            GLOBAL      strncmp:function        ; (like strncmp_include in c) strncmp : global --> strncmp_lp + strncmp_end : static

            SECTION     .text                   ; Code section -> the code is inside .text

strncmp:
            ENTER       0, 0                    ; Setup stack : first 0 = no memory asked second 0 = no function inside function
            MOV         rax, 0                  ; Copy 0 inside rax
            CMP         rdi, 0x0                ; Check if first argument is NULL
            JE          strncmp_ex              ; If true, go into exit
            CMP         rsi, 0x0                ; Check if second argument is NULL
            JE          strncmp_ex              ; If true, go into exit
            MOV         rax, 0                  ; Copy 0 inside rax
            JMP         strncmp_st_lp           ; Go into strncmp_st_lp

strncmp_lp:
            CMP         cl, 00                  ; Compare 0 to rcx
            JE          strncmp_ex              ; If true, go into exit

strncmp_st_lp:
            SUB         edx, 1                  ; Sub 1 to edx (rdx) to increment the result
            CMP         edx, 0                  ; Compare edx to 0
            JE          strncmp_ex              ; If true, go to exit
            MOV         cl, [rdi]               ; Copy first argument inside rcx
            MOV         ch, [rsi]               ; Copy second argument inside rcx
            ADD         rdi, 1                  ; Add 1 to first argument
            ADD         rsi, 1                  ; Add 1 to second argument
            CMP         cl, ch                  ; Compare the two rcx
            JE          strncmp_lp              ; If equal, go inside the loop
            MOV         rax, 0                  ; Copy 0 inside rax
            MOV         al, cl                  ; Copy rcx inside rax
            MOV         rdx, 0                  ; Copy 0 inside rdx
            MOV         dl, ch                  ; Copy rcx inside rdx
            SUB         rax, rdx                ; Sub rdx to rax

strncmp_ex:
            LEAVE                               ; Unsetup stack (enter)
            RET                                 ; Jump into call adress (call)
