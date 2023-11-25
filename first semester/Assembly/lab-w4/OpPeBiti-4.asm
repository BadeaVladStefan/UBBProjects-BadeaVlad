bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
                          
;Given the byte A, obtain the integer number n represented on the bits 2-4 of A. Then obtain the byte B by rotating A n positions to the right. Compute the doubleword C as follows:

;the bits 0-7 of C have the value 1
;the bits 8-15 of C have the value 0
;the bits 16-23 of C are the same as the bits of B
;the bits 24-31 of C are the same as the bits of A

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 10101010b;we need the integer value of the bits between 2-4 ;a=170d
    b db 0;b=170d
    c dd 0
    

; our code starts here
segment code use32 class=code
    start:
        ; 
        mov EAX,0
        mov AL,[a];we will compute the result in al
        and AL,0001_1100b;AL now holds the value of the integer in the 2-4 bits, so here n=8 which we will use to rotate the value of a so we can obtain b
        mov CL,AL;CL now holds the value of 8
        mov AL,[a];AL=1010 1010b ,and now we can rotate them to obtain the value of b
        ror AL,CL;AL now holds the value of b which is:10101010b
        mov [b],AL;now [b] holds the value 10101010b
        ;and now we have a=10101010b and b=10101010b so we can start computing the value of c
        mov EAX,[c];eax=00000000000000000000000000000000
        or EAX,0000_0000__0000_0000__0000_0000__1111_1111b;the bits 0-7 of the doubleword c are now 1 and the bits from 8-15 are 0 and because it is the first half of the number it is stored in AX => now AX:0000 0000 1111 1111 an the other half is full of 0
        push EAX
        pop AX;AX contains only the first 16 bits
        pop DX;we isolate DX,which is empty so we can work with it,DX is 0
        mov DL,[b];DL=>1010 1010b ->DL holds the value of b
        mov DH,[a];DH=>1010 1010b ->DH holds the value of a ; and my combining the 2 we get DX=1010 1010b-Value of A and 1010 1010b -value of B so DX=d
        push DX
        push AX
        pop EAX; so now EAX=10101010 10101010 00000000 11111111, which is the value of C (2,863,268,095d)
        mov [c],EAX; c=1010 1010 1010 1010 0000 0000 1111 1111
        ;                A    A    A    A    0    0    F    F =>AAAA00FF
        
        
        
        
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
