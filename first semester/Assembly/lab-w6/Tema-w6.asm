bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; A byte string s is given. Build the byte string d such that every byte d[i] is equal to the count of ones in the corresponding byte s[i] of s.
    ;s: 5, 25, 55, 127
    ;in binary:
    ;0000_0101, 0001_1001, 0011_0111, 0111_1111 ;
    ;d: 2, 3, 5, 7
    
    s db 5,25,55,127
    len equ $-s
    d times len db 0
    
    
; our code starts here
segment code use32 class=code
    start:
        mov ecx,len 
        mov esi,s
        cld; from left -> right
        mov edi,0;we will use this to help us store the elements in the "d" array
        
        repeta:
            lodsb; AL = elements of the array one at a time
            mov ebx,8
            mov dl,0; we will count the numbers of 1 using dl
            
            rotation:
            
                ror al,1
                
                jnc done;we verify for every bit if its a 1
                inc dl
                done:
                
                dec ebx
                cmp ebx,0
                
                jnz rotation
              
        mov [d+edi],dl
        inc edi   
        loop repeta
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
