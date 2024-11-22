segment .text

global memoryBlockAddressCalculator

; Function: calculate the real memory address from the virtual address
memoryBlockAddressCalculator:
    enter 0, 0
    pusha
    mov eax,[ebp+8];get the block physical address pointer
    mov eax,[eax];get the block physical address

    mov ebx ,[ebp+12];get the virtual address pointer
    mov ebx,[ebx];get the virtual address

    add eax,ebx;add the virtual address to the block physical address

    mov ebx,[ebp+16];get the block size pointer
    mov [ebx],eax;store the result in the block size
    
    .exitWithoutOffset:
    popa
    leave
    ret
