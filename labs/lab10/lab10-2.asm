;--------------------------------
; Программа для записи в файл строки, введенной с клавиатуры
;--------------------------------

%include 'in_out.asm'

SECTION .data
filename db 'name.txt', 0h ; Имя создаваемого файла
msg1 db 'Как Вас зовут? ', 0h ; Сообщение для ввода имени
msg2 db 'Меня зовут ', 0h ; Сообщение для записи в файл

SECTION .bss
contents resb 255 ; Буфер для ввода имени

SECTION .text
global _start
_start:

; --- Вывод сообщения "Как Вас зовут?"
mov eax, msg1       ; Адрес сообщения
call slen           ; Вычислить длину сообщения
mov edx, eax        ; Длина сообщения в edx
mov eax, msg1       ; Адрес сообщения
call sprint         ; Вывести сообщение

; --- Считывание имени пользователя
mov ecx, contents   ; Адрес буфера для ввода
mov edx, 255        ; Максимальная длина
call sread          ; Считать строку

; --- Удаление символа перевода строки
mov eax, contents   ; Адрес введённой строки
call slen           ; Вычислить длину строки
dec eax             ; Уменьшить длину, исключая \n
mov byte [contents + eax], 0 ; Установить конец строки

; --- Открытие файла name.txt для записи
mov ecx, 0101o      ; Флаг: O_CREAT | O_WRONLY
mov ebx, filename   ; Имя файла
mov eax, 5          ; Системный вызов sys_open
int 80h
mov esi, eax        ; Сохранить файловый дескриптор

; --- Запись строки "Меня зовут " в файл
mov eax, msg2       ; Адрес сообщения
call slen           ; Вычислить длину строки
mov edx, eax        ; Длина строки
mov ecx, msg2       ; Адрес строки
mov ebx, esi        ; Дескриптор файла
mov eax, 4          ; Системный вызов sys_write
int 80h

; --- Запись имени пользователя в файл
mov eax, contents   ; Адрес строки с именем
call slen           ; Вычислить длину строки
mov edx, eax        ; Длина строки
mov ecx, contents   ; Адрес строки
mov ebx, esi        ; Дескриптор файла
mov eax, 4          ; Системный вызов sys_write
int 80h

; --- Закрытие файла
mov ebx, esi        ; Дескриптор файла
mov eax, 6          ; Системный вызов sys_close
int 80h

; --- Завершение программы
call quit

