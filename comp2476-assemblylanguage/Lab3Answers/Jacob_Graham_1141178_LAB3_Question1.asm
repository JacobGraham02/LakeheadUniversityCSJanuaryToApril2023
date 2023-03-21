.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD

.data
wArray WORD 1, 2, 3, 4, 5
dArray DWORD 0, 0, 0, 0, 0
wArraySize equ ($ - wArray) / 2     ; Number of elements in wArray

.code
main PROC
    mov esi, 0                      ; Set up source index
    mov edi, 0                      ; Set up destination index
    mov ecx, wArraySize             ; Set up loop counter

iterateThroughArray:
    movzx eax, wArray[esi]          ; Load word into eax
    mov dword ptr dArray[edi], eax  ; Store word in doubleword array
    add esi, 2                      ; Increment source index by 2 bytes (1 word)
    add edi, 4                      ; Increment destination index by 4 bytes (1 dword)
    loop iterateThroughArray        ; Decrement counter and loop if not zero

INVOKE ExitProcess, 0
main ENDP
END main
