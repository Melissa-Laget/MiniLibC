##
## EPITECH PROJECT, 2023
## B-ASM-400-BDX-4-1-asmminilibc-melissa.laget
## File description:
## Makefile
##

LIBNAME                =            libasm.so

SRC                    =            strlen.asm	\
									strchr.asm	\
									strrchr.asm	\
									memset.asm	\
									memcpy.asm	\
									strcmp.asm	\
									strncmp.asm	\
									strcasecmp.asm

OBJ                    =            $(SRC:.asm=.o)

$(OBJCOMPILED)%.o:%.asm
					@nasm -f elf64 $<

all: $(LIBNAME)

$(LIBNAME): $(OBJ)
					@ld -Bshareable -o $(LIBNAME) $(OBJ)

testexec: all
					gcc main.c -L. -lasm -ffreestanding


teststart:
				LD_PRELOAD=./libasm.so ./a.out

testvalgrind:
				LD_PRELOAD=./libasm.so valgrind --track-origins=yes --leak-check=full -s ./a.out

clean:
				rm -f $(OBJ)

fclean: clean
				rm -f $(LIBNAME)

re: fclean all

.PHONY: all clean fclean re
