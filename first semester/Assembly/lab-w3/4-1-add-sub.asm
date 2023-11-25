bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; a - byte, b - word, c - double word, d - qword - Interpretare cu semn
    a db 15
    b dw 5
    c dd 20
    d dq 10

; our code starts here
segment code use32 class=code
    start:
        ; (a-b)+(c-b-d)+d=(10-5)+(20-5-10)+10=5+5+10=20
        mov AL,[a]
        cbw;AX=a
        sub AX,[b];AX=a-b;
        cwde;EAX=(a-b)
        mov EDX,0;EDX:EAX=(a-b)
        mov EBX, dword [d+0]
        mov ECX, dword [d+4]; ECX:EBX=d
        clc
        add EBX,EAX
        add ECX,EDX;ECX:EBX=(a-b)+d
        mov AX,[b]
        neg AX;AX=-b
        cwde;EAX=-b
        add EAX,[c];EAX=c-b
        mov EDX,0;EDX:EAX=c-b
        add ECX,EDX
        add EBX,EAX;ECX:EBX=(a-b)+(c-b)+d
        mov EAX,dword [d+0]
        mov EDX,dword [d+4];EDX:EAX=d
        neg EAX,
        neg EDX;EDX:EAX=-d
        add EBX,EAX
        add ECX,EDX;(a-b)+(c-b-d)+d
        
        
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
