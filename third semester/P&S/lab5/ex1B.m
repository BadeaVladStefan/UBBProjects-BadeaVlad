#EX 1 B SUBPUNCT A:
X=[7 7 4 5 9 9 ...
4 12 8 1 8 7 ...
3 13 2 1 17 7 ...
12 5 6 2 1 13 ...
14 10 2 4 9 11 ...
3 5 12 6 10 7];
oneMinusAlpha=input('Please insert the confidence level (should be like 0.95, 0.98..)=');
alpha=1-oneMinusAlpha;
n=length(X);
sigma=5;
M1=mean(X)-(sigma/sqrt(n))*norminv(1-alpha/2,0,1);
M2=mean(X)-(sigma/sqrt(n))*norminv(alpha/2,0,1);
printf('The confidence interval for the theorethical mean when sigma is known is (%4.3f,%4.3f)\n',M1,M2)

#EX 1 B SUBPUNCT B:
M1B=mean(X)-(std(X)/sqrt(n))*tinv(1-alpha/2,n-1);
M2B=mean(X)-(std(X)/sqrt(n))*tinv(alpha/2,n-1);
printf('The confidence interval for the theorethical mean when sigma is unknown is (%4.3f,%4.3f)\n',M1B,M2B)

#EX 1 B SUBPUNCT C:
V1=(n-1)*var(X)/chi2inv(1-alpha/2,n-1);
V2=(n-1)*var(X)/chi2inv(alpha/2,n-1);
printf('The confidence interval for the variance is (%4.3f,%4.3f)\n',V1,V2)

S1=sqrt(V1);
S2=sqrt(V2);
printf('The confidence interval for the standard deviation is (%4.3f,%4.3f)\n',S1,S2)

