;--------------------------------
; Программа вычисления выражения y = 5(x-1)^2
;--------------------------------
%include 'in_out.asm'

SECTION .data
msg1: DB 'Введите значение x: ', 0
msg2: DB 'Результат: y = 5(x-1)^2 = ', 0

SECTION .bss
x: RESB 80

SECTION .text
GLOBAL _start

_start:
    ; Вывод сообщения для ввода x
    mov eax, msg1
    call sprint

    ; Ввод значения x
    mov ecx, x
    mov edx, 80
    call sread

    ; Преобразование ASCII кода в число
    mov eax, x
    call atoi

    ; Вычисление выражения y = 5(x-1)^2
    sub eax, 1          ; x - 1
    imul eax, eax       ; (x - 1)^2
    imul eax, 5         ; 5 * (x - 1)^2

    ; Вывод результата
    mov ebx, eax        ; Сохранение результата в ebx
    mov eax, msg2
    call sprint
    mov eax, ebx
    call iprintLF

    ; Завершение программы
    call quit
