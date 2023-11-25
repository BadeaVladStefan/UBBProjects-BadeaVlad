bits 32
global subprogram_maxi

;| return address |
;|----------------|
;|    max value   |
;|----------------|
;| current value  |
;|----------------|

;input Values , integers:
;edx holds the current number value
;ebx holds the current maximum value


;the edx,eax,ebx registers will modify
;returns the value in eax an integer
subprogram_maxi:
    mov edx,[esp+8]
    mov ebx,[esp+4]
    mov eax,0
    cmp edx,ebx
    jbe nuemax
    ;This number is a new max
    mov eax,edx
    nuemax:
    
    ret 4