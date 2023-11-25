# X - bino(3,0.5)

x=0:1:n; #the values of x
px = binopdf(x,3,0.5);

xx=0:0.01:3;
cx = binocdf(xx,3,0.5);
plot(xx,cx,'g');
hold on;

p1 = binopdf(0,3,0.5);
printf("P(X=0) is: %1.6f\n",p1); #asta e printu!!!
#p(X=0) is just one element from bino

p2 = 1 - binopdf(1,3,0.5);
printf("P(X~=1) is: %1.6f\n",p2);

p3 = binocdf(2,3,0.5);
printf("P(X<=2) is %1.6f\n",p3); #probability of P(X<=2) is the cdf of that number

#P(X<2) = P(X<=1)
p4 = binocdf(1,3,0.5);
printf("P(X<2) is %1.6f\n", p4);

# P(X>=1)=1-P(X<1)=1-P(X<=0)
p5 = binocdf(0,3,0.5);
printf("P(X>=1) is %1.6f\n",p5);

#P(X>1)=1-P(X<=1)
#we have used the complement probability
p6 = 1-binocdf(1,3,0.5);
printf("P(X>1) is %1.6f\n",p6);



