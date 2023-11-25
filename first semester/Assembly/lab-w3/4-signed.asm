bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; a-word; b,c,d-byte; e-doubleword; x-qword - unsigned
    a dw 15
    b db 20
    c db 35
    d db 30
    e dd 5
    x dq 60

; our code starts here
segment code use32 class=code
    start:
        ;(a*2+b/2+e)/(c-d)+x/a=(30+10+5)/5+60/15
        ;9+4=13
       mov AX,[a]
       mov CX,2 
       imul CX;AX=a*2
       cwde;EAX=a*2
       
       add EAX,[e];EAX=a*2+e
       mov EBX,EAX;EAX=a*2+e
       
       mov AL,[b]
       cbw;AX=b
       mov CL,2
       idiv CL;AL=b/2
       
       cbw;AX=b/2
       cwde;EAX=b/2
       add EBX,EAX;EBX=(a*2+b/2+e)=45=>doubleword
       
       mov AL,[c]
       sub AL,[d];=>AL=c-d=>byte
       cbw;AX=(c-d)
       mov CX,AX;CX=(c-d)=5
       
       mov EAX,EBX;EAX=(a*2+b/2+e)
       push EAX
       pop AX
       pop DX
       idiv CX;AX=(a*2+b/2+e)/(c-d)
       cwde;EAX=(a*2+b/2+e)/(c-d)=9
       mov ECX,EAX;ECX=(a*2+b/2+e)/(c-d)=9
       
       mov AX,[a];AX=a
       cwde;EAX=a;
       mov EBX,EAX;EBX=a
       
       mov EAX, dword [x+0]
       mov EDX, dword [x+4]
       
       idiv EBX;EAX=x/a=4
       
       add EAX,ECX;(a*2+b/2+e)/(c-d)+x/a=13
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
