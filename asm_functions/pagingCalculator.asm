segment .data
    offset dd 0 ; this variable will store the offset
                ; in the last page to get the exact memory address
                ; this offset is the residue of the division in the 
                ; pageNumberCalculator function and then will be use
                ; in the memoryAddressCalculator function to return the
                ; exact memory address
segment .text

global memoryAddressCalculator
global pageNumberCalculator
global segmentationFault
; Function: calculate the real memory address from the virtual address
memoryAddressCalculator:
    enter 0, 0
    sub edx, edx ; it will store the residue of the division

    mov eax, [ebp + 8] ; get the frame number
    mul dword [ebp + 12] ; multiply the frame number by the page size

    cmp edx,0 ; check if the result is more than 32 bits
    je .exit ; if it is more than 32 bits, then exit the function
    mov eax,-1
    jmp .exitWithoutOffset ; if it is not more than 32 bits, then continue

    .exit:
    add eax, [offset] ; add the offset to the result
    .exitWithoutOffset:
    leave
    ret

; Function: calculate the page number from the virtual address
pageNumberCalculator:
        enter 0, 0
        mov eax, [ebp + 8] ; get the virtual address

        ; calculate the page number
        sub edx, edx ; it will store the residue of the division
        div dword [ebp + 12] ; divide the virtual address by the page size
        mov [offset], edx ; store the residue in the offset variable
    .exit:
        leave
        ret

;Function: detect segmentation fault
segmentationFault:
    enter 0, 0
    sub edx, edx
    mov eax,[ebp+8];page number
    mul dword [ebp+16];page size
    cmp edx,0;check if the result is more than 32 bits
    jne .exitError;if it is more than 32 bits, then exit the function

    add eax,[offset];add the offset to the result
    cmp eax,[ebp+12];if the result is more than the procces size
    jle .exit;then exit the function
    jmp .exitIncorrect;if it is not more than the procces size, then continue
   
    .exit:
    mov eax,1 ; correct
    leave
    ret
    .exitIncorrect:
    mov eax,0 ; incorrect
    leave
    ret
    .exitError:
    mov eax,-1 ; error
   