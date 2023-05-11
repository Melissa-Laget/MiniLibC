; Memset
; Fill memory with a constant byte
; mettre le nombre de fois données un charactère donnée à l'endroit donnée

            BITS 64                             ; 64−bit mode

            GLOBAL      memset:function         ;(like include in c) memset : global --> memset_lp + memset_end : static

            SECTION     .text                   ; Code section -> the code is inside .text

memset:
            ENTER       0, 0                    ; Setup stack : first 0 = no memory asked second 0 = no function inside function
            MOV         rax, rdi                ; Copy first argument into return value
            CMP         rdi, 0x0                ; Compare if first argument is NULL
            JE          memset_ex               ; If true, go into exit

memset_lp:
            CMP         rdx, 0                  ; Compare third argument and 0
            JE          memset_ex               ; If true go into exit
            MOV         [rdi], sil              ; Copy second argument into first argument
            ADD         rdi, 1                  ; Add 1 to first argument
            SUB         rdx, 1                  ; Sub 1 to third argument
            JMP         memset_lp               ; Go into loop again

memset_ex:
            LEAVE                               ; unsetup stack (enter)
            RET                                 ; jump into call adress (call)
