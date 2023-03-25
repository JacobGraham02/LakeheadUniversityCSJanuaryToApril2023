INCLUDE Irvine32.inc

.data
    string_multiple_colours BYTE "I am a string that changes colours",0
    number_of_colours DWORD 4
    colours_array WORD yellow, green, blue, red

.code
main PROC
    mov edx, OFFSET string_multiple_colours
    mov ecx, number_of_colours
    mov esi, OFFSET colours_array

    display_colour_strings:
        mov ebx, 0
        mov eax, [esi] + (black * 16)
        call SetTextColor
        call WriteString
        call Crlf
        add esi, 2
        loop display_colour_strings

    invoke ExitProcess,0
main ENDP
END main
