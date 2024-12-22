;-- Объявление переменных
SECTION .data ; Секция инициированных данных
msg1: DB 'Введите строку:', 10 ; сообщение плюс символ перевода строки
msgLen1: EQU $-msg1 ; Длина переменной 'msg1'
msg2: DB 'Вы ввели:', 10 ; сообщение плюс символ перевода строки
msgLen2: EQU $-msg2 ; Длина переменной 'msg2'

SECTION .bss ; Секция не инициированных данных
buf1: RESB 80 ; Буфер размером 80 байт

;--------------- Текст программы
SECTION .text ; Код программы
GLOBAL _start ; Начало программы
_start: ; Точка входа в программу

;----------- Системный вызов 'write' для вывода приглашения
mov eax, 4 ; Системный вызов для записи (sys_write)
mov ebx, 1 ; Дескриптор файла 1 - стандартный вывод
mov ecx, msg1 ; Адрес строки 'msg1' в 'ecx'
mov edx, msgLen1 ; Размер строки 'msg1' в 'edx'
int 80h ; Вызов ядра

;----------- Системный вызов 'read' для ввода строки
mov eax, 3 ; Системный вызов для чтения (sys_read)
mov ebx, 0 ; Дескриптор файла 0 - стандартный ввод
mov ecx, buf1 ; Адрес буфера под вводимую строку
mov edx, 80 ; Длина вводимой строки
int 80h ; Вызов ядра

;----------- Системный вызов 'write' для вывода введенной строки
mov eax, 4 ; Системный вызов для записи (sys_write)
mov ebx, 1 ; Дескриптор файла 1 - стандартный вывод
mov ecx, msg2 ; Адрес строки 'msg2' в 'ecx'
mov edx, msgLen2 ; Размер строки 'msg2' в 'edx'
int 80h ; Вызов ядра

mov eax, 4 ; Системный вызов для записи (sys_write)
mov ebx, 1 ; Дескриптор файла 1 - стандартный вывод
mov ecx, buf1 ; Адрес буфера с введенной строкой
mov edx, 80 ; Длина введенной строки
int 80h ; Вызов ядра

;----------- Системный вызов 'exit'
mov eax, 1 ; Системный вызов для выхода (sys_exit)
mov ebx, 0 ; Выход с кодом возврата 0 (без ошибок)
int 80h ; Вызов ядра

