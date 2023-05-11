; Strlen
; Calculate the length of a string

            BITS 64                             ; 64−bit mode

            GLOBAL      strlen:function         ; (like include in c) strlen : global --> str_lp + str_ex = static

            SECTION     .text                   ; Code section -> the code is inside .text

strlen:
            ENTER       0, 0                    ; Setup stack : first 0 = no memory asked second 0 = no function inside function
            MOV         rax, 0                  ; Put 0 in return value
            CMP         rdi, 0x0                ; Compare the first argument to NULL
            JE          str_ex                  ; If the compare is true you go inside the exit otherwise you continue
            MOV         rcx, rdi                ; Copy rdi inside rcx

str_lp:
            MOV         dl, [rcx]               ; Copy *rcx (what's inside of it) inside dl (8 bit)
            ADD         rax, 1                  ; Add 1 ro rax
            ADD         rcx, 1                  ; Add 1 to rcx
            CMP         dl, 00                  ; Compare dl to 0
            JNE         str_lp                  ; If the compare is false you go inside the loop again otherwise you continue
            SUB         rax, 1                  ; Substract 1 to rax

str_ex:
            LEAVE                               ; unsetup stack (enter)
            RET                                 ; jump into call adress (call)
