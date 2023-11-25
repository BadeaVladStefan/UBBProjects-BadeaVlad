##A=[1 2 3;4 5 6;7 8 9]; #matrice
##x=1:2:10;  #vector de la 1 la 10 cu pas 2
##A(1:2,2:3); #submatrice capat sus stanga jos dr
##A(1,1); #elem matricei
##x+2; # aduna 2 la fiecare numar din vectoru din linia 2
##functiecool(10);
###help plot in command window ca sa vad cum se face plotu!
###x^2 nu o sa mearga ca sa ridic la patrat trebuie:
##x.^2; #. inseamna pointwise
##B=[9 8 7;6 5 4;3 2 1];
##A*B; #inmultirea normala
##A.*B; #inmultire element cu element de pe pozitia aceasi

#help input & help printf - date de intrare si iesire
#help plot - graficul functiilor

#clear sterge variabilele
#clc - sterge tot recomandat sa incep scriptu cu asta!

A=[1 0 -2;2 1 3;0 1 0];
B=[2 1 1;1 0 -1;1 1 0];
printf("Matricea C=A-B: \n")
C=A-B
printf("Matricea D=A*B: \n")
D=A*B
printf("Matricea E: \n")
E=A.*B
x=linspace(0,3);
plot(x,f1(x),"-dk;x^5/10;",x,f2(x),"--;x*sin(x);",x,f3(x),"-b;cos(x);")
title('Plot of f1(x), f2(x), and f3(x)')

