#!/bin/bash


ASM_PATH="asm_functions"
OBJ_PATH="objects"
C_PATH="c_functions"

nasm -f elf32 $ASM_PATH/pagingCalculator.asm -o $OBJ_PATH/pagingCalculator.o
nasm -f elf32 $ASM_PATH/blockAllocationCalculator.asm -o $OBJ_PATH/blockAllocationCalculator.o

gcc -m32 $C_PATH/main.c $OBJ_PATH/pagingCalculator.o $OBJ_PATH/blockAllocationCalculator.o -o calculator.exe -z noexecstack

./calculator.exe