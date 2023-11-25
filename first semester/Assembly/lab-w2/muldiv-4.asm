bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 2
    b db -3
    d dw 5

; our code starts here
segment code use32 class=code
    start:
        ; -a*a + 2*(b-1) – d = -4-8-55=-17
       mov AL,[a]
       neg AL,;AL=-a
       mov BL,[a];BL=a 
       imul BL;AX=AX*BL =-a*a
       mov CX,AX;CX=-a*a 
       mov BL,[b];BL=b 
       dec BL;BL=BL-1=b-1 
       mov AL,2; AX=2
       imul BL;AX=AL*BL=2*(b-1)
       mov DX,AX;DX=2*(b-1)
       add CX,DX;CX=CX+DX=-a*a+2*(b-1)
       sub CX,[d];CX=CX-d=a*a+2*(b-1)-d
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
