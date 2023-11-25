bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a db 4
    b db 10
    c db -1
; our code starts here
segment code use32 class=code
    start:
        ; (a-c)*3+b*b=15+100=115
        mov BL,[a];BL=a 
        sub BL,[c];BL=a-c 
        mov AL, 3;AL=3 
        mul BL; AX=AL*BL
        mov BX,AX; BX=AX=(a-c)*3
        mov CL,[b];CL=b 
        mov AL,[b];AL=b
        mul CL;AX=CL*AL =b*b
        add AX,BX; (a-c)*3+b*b=AX
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
