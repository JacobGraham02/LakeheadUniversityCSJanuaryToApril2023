INCLUDE Irvine32.inc


.data
    char_to_print BYTE 'A', 0
    foreground_colors DWORD 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
    background_colors DWORD 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
    num_colors DWORD 16

.code
main PROC
    mov edx, OFFSET char_to_print
    mov ecx, num_colors 
    mov esi, OFFSET foreground_colors

    print_all_colours:
        mov ebx, OFFSET background_colors
        push ecx

        background_color:
            mov eax, [esi]   ; Set the foreground color
            shl eax, 4       ; Shift left to make room for the background color
            mov edx, [ebx]   ; Set background color
            or eax, edx      ; Combine the foreground and background colors
            mov ah, 0        ; Clear the high byte of eax
            call SetTextColor
            call WriteChar
            ; call Crlf
            add ebx, 4       ; Increment the background color array pointer
            loop background_color

        pop ecx          ; Restore the outer loop counter
        add esi, 4       ; Increment the foreground color array pointer
        loop print_all_colours

    invoke ExitProcess, 0
main ENDP
END main