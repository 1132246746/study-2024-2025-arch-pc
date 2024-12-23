%include 'in_out.asm'
SECTION .data
div: DB 'Результат: ',0
SECTION .text
GLOBAL _start
_start:
; ---- Вычисление выражения (3+2)*4+5
mov eax,3
add eax,2 ; eax = 3 + 2 = 5
mov ebx,4
mul ebx ; eax = 5 * 4 = 20
add eax,5 ; eax = 20 + 5 = 25
mov edi,eax
; ---- Вывод результата на экран
mov eax,div
call sprint
mov eax,edi
call iprintLF
call quit

