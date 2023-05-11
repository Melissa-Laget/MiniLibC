; Strchr
; Returns a pointer to the first occurrence of the character c in the string s.

            BITS 64                             ; 64−bit mode

            GLOBAL      strchr:function         ; (like include in c) strchr : global --> strchr_lp + strchr_end : static

            SECTION     .text                   ; Code section -> the code is inside .text

strchr:
            ENTER       0, 0                    ; Setup stack : first 0 = no memory asked second 0 = no function inside function
            MOV         rax, rdi                ; Copy rdi inside rax
            CMP         rax, 0x0                ; Compare rax and NULL
            JE          strchr_ex               ; If the compare is true you go inside the exit otherwise you continue

strchr_lp:
            MOV         dl, [rax]               ; Copy *rax (what's inside of it) inside dl (8 bit)
            CMP         dl, sil                 ; Compare dl to sil (second argument)
            JE          strchr_ex               ; If equal : move to exit otherwise you continue
            CMP         dl, 00                  ; compare dl to 0
            JE          strchr_end              ; If equal : move to end otherwise you continue
            ADD         rax, 1                  ; Add 1 to rax
            JMP         strchr_lp               ; Jump inside the loop until exit or end

strchr_end:
            MOV         rax, 0x0                ; Copy NULL to rax

strchr_ex:
            LEAVE                               ; Unsetup stack (enter)
            RET                                 ; Jump into call adress (call)
