bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 10
    b db 7
    c db 12
    d db 3

; our code starts here
segment code use32 class=code
    start:
        ; (a-b)+(c-b-d)+d=8
        mov AL, [a] ;AX<=a, 
        sub AL, [b] ;AX<=(a-b) 
        mov BL, [c] ;BX<=c, 
        sub BL, [b] ;BX<=c-b, 
        sub BL, [d] ;BX<=c-b-d 
        mov CL, [d] 
        add CL, AL ;CX=(a-b)+d 
        add CL, BL ;CX=(a-b)+(c-b-d)+d
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
