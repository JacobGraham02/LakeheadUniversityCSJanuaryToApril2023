INCLUDE Irvine32.inc

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO,dwExitCode:DWORD

.data
    placeholder_data_block BYTE 51 DUP(?)
    prompt_message BYTE "Enter a string (up to 50 characters): ",0
    answer_message BYTE "The reversed string is: ",0
    line_terminator BYTE 0dh, 0ah, 0
    total_length DWORD ?

.code
main PROC
    ; Prompt the user for input on what string they want to reverse
    mov edx, OFFSET prompt_message
    call WriteString

    ; Read the string to reverse from the user
    mov edx, OFFSET placeholder_data_block
    mov ecx, SIZEOF placeholder_data_block
    call ReadString

    ; Calculate the total length of the string
    mov esi, OFFSET placeholder_data_block
    mov edi, esi
    xor eax, eax
    mov ecx, 0ffffffffh
    repne scasb
    not ecx
    dec ecx
    mov total_length, ecx

    mov ecx, total_length
    dec ecx
    mov ebx, 0

    ; Declare the starting label for the string reversal loop
    swapCharactersInsideString:
        cmp ebx, ecx
        jge printOutReversedString
        mov al, [esi+ebx]
        mov dl, [esi+ecx]
        mov [esi+ecx], al
        mov [esi+ebx], dl
        inc ebx
        dec ecx
        jmp swapCharactersInsideString

    ; Declare the starting label for the reversal string print loop
    printOutReversedString:
    mov edx, OFFSET answer_message
    call WriteString
    mov edx, OFFSET placeholder_data_block
    call WriteString
    mov edx, OFFSET line_terminator
    call WriteString

    invoke ExitProcess,0
main ENDP
END main
