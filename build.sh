#!/bin/bash

# Rutas de los archivos
ASM_PATH="asm_functions"
OBJ_PATH="objects"
C_PATH="c_functions"

nasm -f elf32 $ASM_PATH/pagingCalculator.asm -o $OBJ_PATH/pagingCalculator.o

gcc -m32 $C_PATH/main.c $OBJ_PATH/pagingCalculator.o -o calculator.exe -z noexecstack

./calculator.exe