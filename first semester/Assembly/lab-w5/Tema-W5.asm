bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;Two byte strings S1 and S2 are given, having the same length. Obtain the string D in the following way: each element found on the even positions of D is the sum of the corresponding elements from S1 and S2, and each element found on the odd positions of D is the difference of the corresponding elements from S1 and S2.
    ;ex:
    ;S1: 1, 2, 3, 4
    ;S2: 5, 6, 7, 8
    ;D: 6, -4, 10, -4
    ;  06h FCh 0Ah FCh 
    
    s1 db 1,2,3,4
    s2 db 5,6,7,8
    lens equ $-s2 
    d times lens db 0 
    two dw 2
    
    
    
    
    
segment code use32 class=code
    start:
        mov ecx,lens
        mov esi,0
        jecxz stop ;check to not enter the loop if ecx = 0
        
            repeta:
            
            mov eax,esi
            push eax
            pop ax
            pop dx; DX:AX=ESI
            div word [two] ;DX=ESI%2
            mov ax,dx
            cmp ax,0
            jne isodd
                ;This is for the even numbers
                mov bl,[s1+esi]
                add bl,[s2+esi]
                mov [d+esi],bl
                jmp nextone ;this jump is used so the "isodd" loop is ignored for even numbers

            isodd:
                ;This is for the odd numbers
                mov bl,[s1+esi]
                sub bl,[s2+esi]
                mov [d+esi],bl
                
            nextone:
            
            inc esi
            loop repeta
        
        stop:
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
