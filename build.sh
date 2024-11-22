nasm -f elf32 pagingCalculator.asm 

gcc -m32 main.c pagingCalculator.o -o calculator.exe -z noexecstack

./calculator.exe