INCLUDE Irvine32.inc

.data
    char_to_print BYTE 'A', 0
    foreground_colours DWORD 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
    background_colours DWORD 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
    number_colours DWORD 16

.code
main PROC
    mov edx, OFFSET char_to_print
    mov esi, OFFSET foreground_colours
    mov ebx, OFFSET background_colours
    mov ecx, number_colours

    print_all_colours:
        push ecx
        mov ecx, number_colours
        mov eax, [esi]
        shl eax, 4

        background_colour_loop:
            mov edx, ebx
            or eax, edx
            mov ah, 0
            call SetTextColor
            call WriteChar
            ; call Crlf
            add ebx, 4
            loop background_colour_loop
        
        pop ecx
        add esi, 2
        mov ebx, OFFSET background_colours
        loop print_all_colours

    invoke ExitProcess,0
main ENDP
END main
