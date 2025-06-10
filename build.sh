nasm -f elf64 ./fetchasm.asm -o ./fetchasm.o 
ld ./fetchasm.o -o ./fetchasm
