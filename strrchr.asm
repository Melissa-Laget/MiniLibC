; Strrchr
; Returns a pointer to the last occurrence of the character c in the string s.

            BITS 64                             ; 64−bit mode

            GLOBAL      strrchr:function        ; (like include in c) strrchr : global --> strrchr_lp + strrchr_end : static

            SECTION     .text                   ; Code section -> the code is inside .text

strrchr:
            ENTER       0, 0                    ; Setup stack : first 0 = no memory asked second 0 = no function inside function
            MOV         rax, 0x0                ; Copy NULL inside rax
            CMP         rdi, 0x0                ; Compare rdi and NULL
            JE          strrchr_ex              ; If the compare is true you go inside the exit otherwise you continue
            JMP         strrchr_lp              ; Go into loop

strrchr_end:
            MOV         rax, rdi                ; Copy rdi into rax
            ADD         rdi, 1                  ; Add 1 to rdi

strrchr_lp:
            MOV         dl, [rdi]               ; Copy *rdi (what's inside of it) inside dl (8 bit)
            CMP         dl, 00                  ; Compare dl to 0
            JE          strrchr_ex              ; If equal : move to exit otherwise you continue
            CMP         dl, sil                 ; Compare dl to sil (second argument)
            JE          strrchr_end             ; If equal : move to end otherwise you continue
            ADD         rdi, 1                  ; Add 1 to rdi
            JMP         strrchr_lp              ; Jump inside the loop until exit or end

new_exit:
            CMP         sil, 00                 ; you put '\0' in rax
            JNE         strrchr_ex              ; if not true
            MOV         rax, rdi                ; copy rdi inside rax

strrchr_ex:
            LEAVE                               ; Unsetup stack (enter)
            RET                                 ; Jump into call adress (call)
