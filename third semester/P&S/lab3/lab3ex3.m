n = input("Input N (greater or equal then 30): N=");
p = input("Input P (less or equal then 0.05): P=");

lambda = n*p;

p1 = poisspdf(lambda);
printf("Lambda = %1.6f\n",lambda);

#try to plot in the same graph the pdf of the binomial and the pdf of Poission
