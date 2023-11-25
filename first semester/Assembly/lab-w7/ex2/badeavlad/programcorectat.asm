; Codul de mai jos va deschide un fisier numit "input.txt" din directorul curent si va citi intregul text din acel fisier, in etape, cate 100 de caractere intr-o etapa.
; Deoarece un fisier text poate fi foarte lung, nu este intotdeauna posibil sa citim fisierul intr-o singura etapa pentru ca nu putem defini un sir de caractere suficient de lung pentru intregul text din fisier. De aceea, prelucrarea fisierelor text in etape este necesara.
; Programul va folosi functia fopen pentru deschiderea fisierului, functia fread pentru citirea din fisier si functia fclose pentru inchiderea fisierului creat.
; Deoarece in apelul functiei fopen programul foloseste modul de acces "r", daca un fisier numele dat nu exista in directorul curent,  apelul functiei fopen nu va reusi (eroare). Detalii despre modurile de acces sunt prezentate in sectiunea "Suport teoretic".

bits 32 

global start        



extern exit, fopen, fclose, fread, printf
import exit msvcrt.dll 
import fopen msvcrt.dll 
import fread msvcrt.dll 
import fclose msvcrt.dll 
import printf msvcrt.dll
 
 
segment data use32 class=data
    nume_fisier db "fisier.txt", 0  
    mod_acces db "r", 0              
    descriptor_fis dd -1          
    nr_car_citite dd 0              
    len equ 100                     
    text resb len                 
    format db "there are %d odd digits in the file",0
    

segment code use32 class=code
    start:
        
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp, 4*2
        
        cmp eax, 0                  
        je final
        mov [descriptor_fis], eax   
        
        mov ebx,0
        bucla:
            
            push dword [descriptor_fis]
            push dword len
            push dword 1
            push dword text
            call [fread]
            add esp, 4*4
            ; eax = numar de caractere 
            cmp eax, 0          ; daca numarul de caractere citite este 0, am terminat de parcurs fisierul
            je cleanup

            mov [nr_car_citite], eax        
            mov ecx,eax
            mov esi,0
            
            
            repeta:
            mov al,[text+esi]
            inc esi
           
            cmp al,"1"
            jne n1
            inc ebx
            n1:
           
            cmp al,"3"
            jne n3
            inc ebx
            n3:
           
            cmp al,"5"
            jne n5
            inc ebx
            n5:
           
            cmp al,"7"
            jne n7
            inc ebx 
            n7:
           
            cmp al,"9"
            jne n9
            inc ebx
            n9:
           
            dec ecx
            jnz repeta
            
            
            jmp bucla
        
        
        
       
       
      cleanup:
      ;here we print the result
        push ebx
        push format
        call [printf]
        add esp,4*2
      
      ; here we close the file 
        push dword [descriptor_fis]
        call [fclose]
        add esp, 4
        
      final:  
        ; exit(0)
        push    dword 0      
        call    [exit]       