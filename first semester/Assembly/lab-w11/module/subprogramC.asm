bits 32

global _subprogramC

segment data public data use32
rez dd 0
segment code public code use32

;We have only one parameter (int type)
;We will calculate: parameter/2 and we will return this value


_subprogramC:
    push ebp
    mov ebp,esp ;We create the "new stack";
    pushad ;we save the registers
    
    
    mov ecx,2
    mov eax,[ebp+8] ; EAX = parameter
    mov edx,0;
    div ecx;
    mov [rez],eax
    popad ;we restore the registers
    mov eax,[rez]
    mov esp,ebp
    pop ebp
    ret 4
    
    