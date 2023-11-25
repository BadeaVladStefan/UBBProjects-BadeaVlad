#a)
M=input("Please input the M: M=");
Sigma=input("Please input the Sigma: Sigma=");

p1 = normcdf(0,M,Sigma);
printf("p(x<=0) is equal to %1.6f\n",p1);

p2 = 1 - normcdf(0,M,Sigma);
printf("p(x>=0) is equal to %1.6f\n",p2);

#b)
p3 = normcdf(1,M,Sigma) - normcdf(-1,M,Sigma);
printf("p(-1<=x<=1) is equal to %1.6f\n",p3);

p4 = 1 - p3;
printf("p(x<=-1 or x>=1) is equal to %1.6f\n",p4);

#c)+d)
Alpha = input("Please input Alpha: Alpha=");
Beta = input("Please input Beta: Beta=");

p5 = norminv(Alpha,M,Sigma);
printf("Alpha = %1.6f\n")

p6 = norminv(1-Beta,M,Sigma);
printf("Beta = %1.6f\n")


