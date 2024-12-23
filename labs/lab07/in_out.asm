;---------------   slen  -------------------
; Ð¤ÑƒÐ½ÐºÑ†Ð¸Ñ Ð²Ñ‹Ñ‡Ð¸ÑÐ»ÐµÐ½Ð¸Ñ Ð´Ð»Ð¸Ð½Ñ‹ ÑÐ¾Ð¾Ð±Ñ‰ÐµÐ½Ð¸Ñ
slen:                     
    push    ebx             
    mov     ebx, eax        
    
nextchar:                   
    cmp     byte [eax], 0   
    jz      finished        
    inc     eax             
    jmp     nextchar        
    
finished:
    sub     eax, ebx
    pop     ebx             
    ret                     


;---------------  sprint  -------------------
; Ð¤ÑƒÐ½ÐºÑ†Ð¸Ñ Ð¿ÐµÑ‡Ð°Ñ‚Ð¸ ÑÐ¾Ð¾Ð±Ñ‰ÐµÐ½Ð¸Ñ
; Ð²Ñ…Ð¾Ð´Ð½Ñ‹Ðµ Ð´Ð°Ð½Ð½Ñ‹Ðµ: mov eax,<message>
sprint:
    push    edx
    push    ecx
    push    ebx
    push    eax
    call    slen
    
    mov     edx, eax
    pop     eax
    
    mov     ecx, eax
    mov     ebx, 1
    mov     eax, 4
    int     80h

    pop     ebx
    pop     ecx
    pop     edx
    ret


;----------------  sprintLF  ----------------
; Ð¤ÑƒÐ½ÐºÑ†Ð¸Ñ Ð¿ÐµÑ‡Ð°Ñ‚Ð¸ ÑÐ¾Ð¾Ð±Ñ‰ÐµÐ½Ð¸Ñ Ñ Ð¿ÐµÑ€ÐµÐ²Ð¾Ð´Ð¾Ð¼ ÑÑ‚Ñ€Ð¾ÐºÐ¸
; Ð²Ñ…Ð¾Ð´Ð½Ñ‹Ðµ Ð´Ð°Ð½Ð½Ñ‹Ðµ: mov eax,<message>
sprintLF:
    call    sprint

    push    eax
    mov     eax, 0AH
    push    eax
    mov     eax, esp
    call    sprint
    pop     eax
    pop     eax
    ret

;---------------  sread  ----------------------
; Ð¤ÑƒÐ½ÐºÑ†Ð¸Ñ ÑÑ‡Ð¸Ñ‚Ñ‹Ð²Ð°Ð½Ð¸Ñ ÑÐ¾Ð¾Ð±Ñ‰ÐµÐ½Ð¸Ñ
; Ð²Ñ…Ð¾Ð´Ð½Ñ‹Ðµ Ð´Ð°Ð½Ð½Ñ‹Ðµ: mov eax,<buffer>, mov ebx,<N>
sread:
    push    ebx
    push    eax
   
    mov     ebx, 0
    mov     eax, 3
    int     80h

    pop     ebx
    pop     ecx
    ret
    
;------------- iprint  ---------------------
; Ð¤ÑƒÐ½ÐºÑ†Ð¸Ñ Ð²Ñ‹Ð²Ð¾Ð´Ð° Ð½Ð° ÑÐºÑ€Ð°Ð½ Ñ‡Ð¸ÑÐµÐ» Ð² Ñ„Ð¾Ñ€Ð¼Ð°Ñ‚Ðµ ASCII
; Ð²Ñ…Ð¾Ð´Ð½Ñ‹Ðµ Ð´Ð°Ð½Ð½Ñ‹Ðµ: mov eax,<int>
iprint:
    push    eax             
    push    ecx             
    push    edx             
    push    esi             
    mov     ecx, 0          
    
divideLoop:
    inc     ecx             
    mov     edx, 0          
    mov     esi, 10  
    idiv    esi    
    add     edx, 48  
    push    edx   
    cmp     eax, 0   
    jnz     divideLoop  

printLoop:
    dec     ecx       
    mov     eax, esp  
    call    sprint   
    pop     eax    
    cmp     ecx, 0   
    jnz     printLoop  

    pop     esi   
    pop     edx    
    pop     ecx   
    pop     eax           
    ret


;--------------- iprintLF   --------------------
; Ð¤ÑƒÐ½ÐºÑ†Ð¸Ñ Ð²Ñ‹Ð²Ð¾Ð´Ð° Ð½Ð° ÑÐºÑ€Ð°Ð½ Ñ‡Ð¸ÑÐµÐ» Ð² Ñ„Ð¾Ñ€Ð¼Ð°Ñ‚Ðµ ASCII
; Ð²Ñ…Ð¾Ð´Ð½Ñ‹Ðµ Ð´Ð°Ð½Ð½Ñ‹Ðµ: mov eax,<int>
iprintLF:
    call    iprint          

    push    eax             
    mov     eax, 0Ah        
    push    eax             
    mov     eax, esp       
    call    sprint          
    pop     eax             
    pop     eax             
    ret

;----------------- atoi  ---------------------
; Ð¤ÑƒÐ½ÐºÑ†Ð¸Ñ Ð¿Ñ€ÐµÐ¾Ð±Ñ€Ð°Ð·Ð¾Ð²Ð°Ð½Ð¸Ñ ascii-ÐºÐ¾Ð´ ÑÐ¸Ð¼Ð²Ð¾Ð»Ð° Ð² Ñ†ÐµÐ»Ð¾Ðµ Ñ‡Ð¸ÑÐ»Ð¾
; Ð²Ñ…Ð¾Ð´Ð½Ñ‹Ðµ Ð´Ð°Ð½Ð½Ñ‹Ðµ: mov eax,<int>
atoi:
    push    ebx             
    push    ecx             
    push    edx             
    push    esi             
    mov     esi, eax        
    mov     eax, 0          
    mov     ecx, 0          
 
.multiplyLoop:
    xor     ebx, ebx        
    mov     bl, [esi+ecx]
    cmp     bl, 48 
    jl      .finished 
    cmp     bl, 57  
    jg      .finished 
 
    sub     bl, 48 
    add     eax, ebx
    mov     ebx, 10  
    mul     ebx  
    inc     ecx   
    jmp     .multiplyLoop  
 
.finished:
    cmp     ecx, 0  
    je      .restore   
    mov     ebx, 10  
    div     ebx     
 
.restore:
    pop     esi   
    pop     edx    
    pop     ecx  
    pop     ebx 
    ret


;------------- quit   ---------------------
; Ð¤ÑƒÐ½ÐºÑ†Ð¸Ñ Ð·Ð°Ð²ÐµÑ€ÑˆÐµÐ½Ð¸Ñ Ð¿Ñ€Ð¾Ð³Ñ€Ð°Ð¼Ð¼Ñ‹
quit:
    mov     ebx, 0      
    mov     eax, 1      
    int     80h
    ret
