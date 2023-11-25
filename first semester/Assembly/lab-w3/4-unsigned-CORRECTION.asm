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
        
        mov EAX, dword [x+0]
        mov EDX, dword [x+4]
        
        mov CX,[a]
        mov BX,0
        push BX;
        push CX;
        pop ECX;ECX=a
        
        div ECX;EAX=x/a
        mov EBX,EAX;EBX=x/a=4
        
        mov AX,[a]
        mov CX,2
        mul CX;DX:AX=a*2=30
        
        mov DX,0
        push DX
        push AX
        pop EAX;EAX=a*2
        mov ECX,EAX;ECX=a*2
        
        mov AL,[b]
        mov AH,0;AX=b
        mov DL,2
        div DL;AL=b/2
        mov AH,0;AX=b/2
        
        mov DX,0
        push DX
        push AX
        pop EAX;EAX=b/2
        
        add ECX,EAX;ECX=a*2+b/2
        add ECX,[e];ECX=a*2+b/2+e
        mov EAX,ECX;EAX=a*2+b/2+e
        
        ;*CORRECTION :
        push EAX
        pop AX
        pop DX;EAX=>DX:AX=(a*2+b/2+e)
        ;*
        
        mov CL,[c]
        sub CL,[d];CL=c-d
        mov CH,0;CX=c-d
        
        
        div CX;AX=(a*2+b/2+e)/(c-d)
        
        mov DX,0
        push DX
        push AX
        pop EAX;EAX=(a*2+b/2+e)/(c-d)
        
        add EAX,EBX;EAX=(a*2+b/2+e)/(c-d)+x/a
       
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
