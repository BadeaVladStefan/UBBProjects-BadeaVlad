bits 32 
global start        

;Two natural numbers a and b (a, b: dword, defined in the data segment) are given. ;Calculate their product and display the result in the following format: "<a> * <b> = <result>". Example: "2 * 4 = 8"
;The values will be displayed in decimal format (base 10) with sign.

extern exit, printf, scanf               
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll    
                          


segment data use32 class=data
    a dd 2
    b dd 4
    mesaj db "%d*%d=%d",0
    res resq 1
    


segment code use32 class=code
    start:
        mov eax,[a]
        mov ebx,[b]
        
        imul ebx ;edx:eax=a*b
        mov [res+0],edx
        mov [res+4],eax
        
        
        mov ecx,0
        mov edx,0
        
        mov ecx,[a]
        mov edx,[b]
        
        ;we verify if the high doubleword of the result is zero. if its a zero we dont want to print it
        cmp [res+0],dword 0
        je sari
        
        push dword [res+0]
        push dword [res+4]
        push dword edx
        push dword ecx
        push dword mesaj
        call [printf]
        add esp, 4*5
        jmp gata
        
        sari:
        push dword [res+4]
        push dword edx
        push dword ecx
        push dword mesaj
        call [printf]
        add esp, 4*4
        
        gata:
        push    dword 0      
        call    [exit]       
