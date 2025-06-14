nasm -f elf64 ./fetchasm.asm -o ./fetchasm.o 
gcc -no-pie ./fetchasm.o -o fetchasm
