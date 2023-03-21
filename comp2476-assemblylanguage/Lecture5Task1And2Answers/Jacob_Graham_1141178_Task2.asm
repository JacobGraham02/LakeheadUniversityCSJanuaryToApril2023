INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO,dwExitCode:DWORD

.data
    integer_values_output BYTE "%d ",0

.code
main PROC
    ; Assign integer values to the registers
    mov eax, 1
    mov ebx, 2
    mov ecx, 3
    mov edx, 4
    mov esi, 5
    mov edi, 6

    ; Push all general-purpose registers onto the stack. The general purpose registers are the ones listed above
    ; (eax through edi).
    pushad

    mov eax, 6
    ; Pop each integer from the stack and display it on the screen
    popIntegersFromStack:
        pop ebx
        push ebx ;   save value for later use
        push OFFSET integer_values_output
        push ebx
        call WriteConsole
        add esp, 8 ; clear stack of 2 parameters
        pop ebx ;    restore original value
        loop popIntegersFromStack

    invoke ExitProcess,0
main ENDP
END main
