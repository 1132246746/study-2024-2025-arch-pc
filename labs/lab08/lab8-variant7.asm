%include 'in_out.asm'
SECTION .data
msg db "Функция: f(x)=3(x+2)", 0
result_msg db "Результат: ", 0

SECTION .text
global _start
_start:
pop ecx ; Извлекаем из стека в `ecx` количество аргументов
pop edx ; Извлекаем из стека в `edx` имя программы
sub ecx, 1 ; Уменьшаем `ecx` на 1 (количество аргументов без названия программы)
mov esi, 0 ; Используем `esi` для хранения промежуточной суммы

; Вывод сообщения о функции
mov eax, msg
call sprintLF

next:
cmp ecx, 0h ; проверяем, есть ли еще аргументы
jz _end ; если аргументов нет выходим из цикла (переход на метку `_end`)
pop eax ; иначе извлекаем следующий аргумент из стека
call atoi ; преобразуем символ в число
add eax, 2 ; вычисляем x + 2
imul eax, eax, 3 ; вычисляем 3(x + 2)
add esi, eax ; добавляем к промежуточной сумме
loop next ; переход к обработке следующего аргумента

_end:
mov eax, result_msg ; вывод сообщения "Результат: "
call sprint
mov eax, esi ; записываем сумму в регистр `eax`
call iprintLF ; печать результата
call quit ; завершение программы
