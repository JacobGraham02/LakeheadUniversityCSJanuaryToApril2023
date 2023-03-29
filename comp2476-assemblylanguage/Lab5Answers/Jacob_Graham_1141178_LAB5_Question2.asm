INCLUDE Irvine32.inc
.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD

.data
    grade_list DWORD 85, 73, 92, 60, 41, 89, 97, 11, 82, 91
    grade_count DWORD 10

.code
;----------------------------------------------------------
; Procedure to calculate letter grade based on integer input
; Parameters:
;   eax: integer value between 0 and 100
; Return value:
;   al: single capital letter grade
;----------------------------------------------------------
CalcGrade PROC grade:DWORD
    push ebx              ; Preserve ebx
    mov ebx, grade        ; Move grade value to ebx
    cmp ebx, 90           ; Compare the grade to 90
    jge grade_a           ; If greater than or equal to 90, jump to grade_a
    cmp ebx, 80           ; Compare the grade to 80
    jge grade_b           ; If greater than or equal to 80, jump to grade_b
    cmp ebx, 70           ; Compare the grade to 70
    jge grade_c           ; If greater than or equal to 70, jump to grade_c
    cmp ebx, 60           ; Compare the grade to 60
    jge grade_d           ; If greater than or equal to 60, jump to grade_d
    mov al, 'F'           ; If no procedure is executed, set the grade to F
    jmp grade_finished        ; Jump to end of procedure

    grade_a:
        mov al, 'A'           ; Set the grade to A
        jmp grade_finished        ; Jump to end of procedure

    grade_b:
        mov al, 'B'           ; Set the grade to B
        jmp grade_finished        ; Jump to end of procedure

    grade_c:
        mov al, 'C'           ; Set the grade to C
        jmp grade_finished        ; Jump to end of procedure

    grade_d:
        mov al, 'D'           ; Set the grade to D

    grade_finished:
        pop ebx               ; Restore ebx
        ret

CalcGrade ENDP

main PROC
    mov ecx, grade_count        ; Load grade_count into ecx
    mov esi, OFFSET grade_list  ; Load address of grade_list into esi
    
    display_grade_loop:
        mov eax, [esi]          ; Load the current grade into eax
        push eax                ; Push the current grade onto the stack
        call CalcGrade          ; Call CalcGrade with current grade to display a character value
        call WriteChar          ; Write the letter grade to the console
        call Crlf               ; Write a newline character to console
        add esi, 4              ; Increment pointer to next grade
        loop display_grade_loop ; Continue loop until ecx is zero   
    
    INVOKE ExitProcess, 0         
main ENDP
END main
