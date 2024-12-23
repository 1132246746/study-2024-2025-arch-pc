%include 'in_out.asm'

section .data
msg1 db 'Введите x: ',0h
msg2 db 'Введите a: ',0h
msg3 db 'Результат: ',0h

section .bss
x resb 10
a resb 10
result resb 10

section .text
global _start

_start:
; ---------- Вывод сообщения 'Введите x: '
mov eax, msg1
call sprint

; ---------- Ввод 'x'
mov ecx, x
mov edx, 10
call sread

; ---------- Преобразование 'x' из символа в число
mov eax, x
call atoi ; Вызов подпрограммы перевода символа в число
mov [x], eax ; запись преобразованного числа в 'x'

; ---------- Вывод сообщения 'Введите a: '
mov eax, msg2
call sprint

; ---------- Ввод 'a'
mov ecx, a
mov edx, 10
call sread

; ---------- Преобразование 'a' из символа в число
mov eax, a
call atoi ; Вызов подпрограммы перевода символа в число
mov [a], eax ; запись преобразованного числа в 'a'

; ---------- Вычисление значения функции f(x)
mov eax, [x]
mov ebx, [a]

cmp eax, ebx ; Сравниваем 'x' и 'a'
je equal ; если 'x == a', то переход на метку 'equal'

; ---------- Вычисление f(x) = a + x
add eax, ebx
jmp store_result

; ---------- Вычисление f(x) = 6a
equal:
mov eax, ebx
imul eax, eax, 6

; ---------- Сохранение результата
store_result:
mov [result], eax

; ---------- Вывод результата
mov eax, msg3
call sprint ; Вывод сообщения 'Результат: '
mov eax, [result]
call iprintLF ; Вывод результата
call quit ; Выход

