.model flat,stdcall
.stack 4096

ExitProcess PROTO,dwExitCode:DWORD

.data
fib DWORD 0, 1, 0, 0, 0, 0, 0 ; Initialize the first two values

.code
main PROC
    mov ecx, 7                ; Loop counter
    mov esi, 2                ; Array index

calculateFibValue:
    mov eax, [fib + esi - 1]  ; Get previous value
    add eax, [fib + esi - 2]  ; Add two previous values
    mov [fib + esi], eax      ; Store result
    inc esi                   ; Move to next array element
    loop calculateFibValue    
    mov ecx, 7                ; Display the result in registers
    mov esi, 0

reverseCharOrder:
    mov eax, [fib + esi]      ; Get current value
    inc esi
    loop reverseCharOrder
    
INVOKE ExitProcess, 0
main ENDP
END main