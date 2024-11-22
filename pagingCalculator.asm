section .data
    offset dd 0 ; this variable will store the offset
                ; in the last page to get the exact memory address
                ; this offset is the residue of the division in the 
                ; pageNumberCalculator function and then will be use
                ; in the memoryAddressCalculator function to return the
                ; exact memory address
section .text


global memoryAddressCalculator
global pageNumberCalculator

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
