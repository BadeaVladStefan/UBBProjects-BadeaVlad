bits 32 
;Read unsigned numbers in base 10 from keyboard. Determine the maximum value of the string and write it in the file max.txt (it will be created) in 16  base.

global start        


extern exit,printf,scanf,fopen,fprintf,fclose,subprogram_maxi
import exit msvcrt.dll    
import printf msvcrt.dll
import scanf msvcrt.dll
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll
                          


segment data use32 class=data

    ;Things used to for the problem
    mesaj_citire db "How many numbers to you want to read?",0
    citire_numar db "%d",0
    mesaj_rezultat db "the max value is %d"
    n dd 0
    nrcurent dd 0
    maximum dd 0
    
    ;Thing related to file operations
    nume_fisier db "max.txt",0
    mod_acces db "w",0
    mesaj_afisare db "The maximum number is %x",0
    descrpitor_fis dd -1
    replicaecx dd 0
    
    
segment code use32 class=code
    start:
        push dword mesaj_citire
        call [printf]
        add esp,4
        
        push dword n
        push dword citire_numar
        call [scanf]
        add esp,4*2
        ;Now in n we have stored the number of numbers that we will read from the file
        
        mov ecx,[n]
        repeta:
        mov dword [replicaecx],ecx
        
       
            push dword nrcurent
            push dword citire_numar
            call [scanf]
            add esp,4*2
            ;Now nrcurent stores the current number
            
            mov eax,[nrcurent]
            mov ebx,[maximum]
            push eax
            push ebx 
            call subprogram_maxi
            add esp,4
            
            cmp eax,0
            je sari
            ;We have a new max
            mov dword [maximum],eax
            sari:
            
        nuemax:
        mov ecx,dword [replicaecx]
        loop repeta
        
            ;File Operations:
            ;The opening of the file:
            push dword mod_acces
            push dword nume_fisier
            call [fopen]
            add esp,4*2
            
            mov [descrpitor_fis],eax
            cmp eax,0 
            je final
            
            ;We write the result:
            push dword [maximum]
            push dword mesaj_afisare
            push dword [descrpitor_fis]
            call [fprintf]
            add esp,4*3
            
            ;We close the file:
            push dword [descrpitor_fis]
            call [fclose]
            add esp,4
            
            final:
        push    dword 0      
        call    [exit]       
