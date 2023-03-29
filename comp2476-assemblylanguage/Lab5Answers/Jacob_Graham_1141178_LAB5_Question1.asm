INCLUDE Irvine32.inc
.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD

.data
    array DWORD 10,20,30,40,50,60,70,80,90,100
    array_size DWORD 10

.code
;----------------------------------------------------------
; Procedure to compute sum of array elements within range j...k
; Parameters:
;   esi: pointer to array
;   ecx: size of array
;   edx: value of j
;   ebp: value of k
; Return value:
;   eax: sum of array elements within range j...k
;----------------------------------------------------------
compute_sum PROC
    push ebx                  ; preserve ebx
    xor eax, eax              ; set sum to zero
    mov ebx, esi              ; ebx = pointer to start of array
    lea ebx, DWORD PTR [esi+edx*4] ; Load the effective address located at this arithmetic operation location
    sum_loop:
        cmp edx, ebp          ; check if we've reached the end of the range
        jg sum_done           ; if so, jump to sum_done
        add eax, [ebx]        ; add current array element to sum
        add ebx, 4            ; increment pointer to next element
        inc edx               ; increment j
        jmp sum_loop          ; jump back to top of loop
    sum_done:
        pop ebx               ; restore ebx
        ret
compute_sum ENDP

main PROC
    mov esi, OFFSET array     ; load base address of array into ESI
    mov ecx, array_size       ; load array size into ECX
    
    ; call compute_sum to compute sum of elements within range j...k
    mov edx, 1                ; value of j
    mov ebp, 5                ; value of k
    push ecx                  ; save array size
    push ebp                  ; save k
    push edx                  ; save j
    push esi                  ; push pointer to array
    call compute_sum          ; compute sum of array elements within range j...k
    add esp, 16               ; clean up stack
    
    ; print result to console
    call WriteDec             ; write EAX to console
    call Crlf                 ; write a newline character to console
    
    ; call compute_sum again to compute sum of elements within range j...k
    mov edx, 2                ; value of j
    mov ebp, 7                ; value of k
    push ecx                  ; save array size
    push ebp                  ; save k
    push edx                  ; save j
    push esi                  ; push pointer to array
    call compute_sum          ; compute sum of array elements within range j...k
    add esp, 16               ; clean up stack
    
    ; print result to console
    call WriteDec             ; write EAX to console
    call Crlf                 ; write a newline character to console
    

    INVOKE ExitProcess, 0         
main ENDP
END main
