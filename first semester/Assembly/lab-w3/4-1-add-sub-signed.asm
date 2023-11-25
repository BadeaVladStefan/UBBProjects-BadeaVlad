bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; a - byte, b - word, c - double word, d - qword - Interpretare fara semn
    b dw 20
    c dd 10
    a db 5
    d dq 15

; our code starts here
segment code use32 class=code
    start:
        ; (b+b)-c-(a+d)=(20+20)-10-(5+15)=40-10-20=10
        mov AX,[b];AX=b
        add AX,[b];AX=b+b
        mov DX,0
        push DX
        push AX
        pop EAX;EAX=b+b
        sub EAX,[c];(b+b)-c
        mov EDX,0;EDX:EAX=(b+b)-c
        mov BL,[a]
        mov BH,0;BX=a
        mov CX,0
        push CX
        push BX
        pop EBX;EBX=a
        mov ECX,0;ECX:EBX=a
        add EBX, dword [d+0]
        add ECX, dword [d+4];ECX:EBX=a+d
        neg EBX
        neg ECX;ECX:EBX=-(a+d)
        clc
        add EAX,EBX
        add EDX,ECX;EDX:EAX=(b+b)-c-(a+d)
        
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
