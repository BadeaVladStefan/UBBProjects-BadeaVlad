%The vector of white paper thrown per year by bank employees
X = [3.1, 2.9, 3.8, 3.3, 2.7, 3.0, 2.8, 2.5, 2.6, 2.0, 3.2, 2.4, 2.3, 3.1, 2.1, 3.4];
%The vector of white paper thrown per year by other employees
Y = [6.9, 6.4, 4.7, 4.3, 5.1, 6.3, 5.9, 5.4, 5.3, 5.2, 5.1, 5.9, 5.8, 4.9];

%The lengths of the vectors are described by n1 and n2
n1 = length(X);
n2 = length(Y);

%The mean of the 2 populations are described by m1 and m2
m1 = mean(X);
m2 = mean(Y);

%The variances of the 2 populations are described by v1 and v2
v1 = var(X);
v2 = var(Y);

printf("a)\n")
alpha = input("Please input the significance level(between 0 and 1) :");

printf("\nWe need to compare 2 population variances so we will use vartest2\n")
printf("H0-the null hypothesis : the variances are the same\n")
printf("H1-the alternative hypothesis : the variances differ\n")

[H, P, CI, TEST] = vartest2(X, Y, 'alpha', alpha);

%The fisher inverse cumulative distribution function to determine the rejection region
f1 = finv(alpha/2, n1 - 1, n2 - 1);
f2 = finv(1-alpha/2, n1-1, n2-1);

if H == 0
  printf("\nThe null hypothesis is not rejected!\n")
  printf("The variances of the 2 populations DO NOT differ!\n")
else
  printf("\nThe null hypothesis is rejected!\n")
  printf("The variances of the 2 populations seem to differ!\n")
endif

printf("The rejection region is : (%6.4f, %6.4f) U (%6.4f, %6.4f) \n", -Inf, f1, f2, Inf)
printf("The P-value of the test is: %6.4f\n", P)
printf("The confidence interval is (%6.4f, %6.4f)\n", CI)
printf("The test statistics value is : %6.4f\n", TEST.fstat)

printf("\nb)\n");
printf("95 percent confidence level is equivalent to 5% significance level, so alpha will remain 0.05 for our matter.\n")
printf("From the conf_int file, we must refer to the point 3 (difference of 2 population means)\n")
printf("Depending if we the variances seem to differ (point a), we see if sigmas are equal or not.\n")

%Case where the variances are equal
%we will refer to the Student-T distribution(cumulative distribution inverse function)
if H == 0
  n = n1 + n2 - 2;
  sp = ((n1 - 1) * v1 + (n2 - 1) * v2) / (n1 + n2 - 2);
  left = m1 - m2 - tinv(1-alpha/2, n) * sqrt(sp) * sqrt(1/n1 + 1/n2);
  right = m1 - m2 + tinv(1-alpha/2, n) * sqrt(sp) * sqrt(1/n1 + 1/n2);
else
  %Case where the variances are not equal
  %We will refer again to the Student-T distribution with the quantile's n value being computed differently
  c = (v1/n1) / ((v1 / n1) + (v2 / n2));
  n = c * c / (n1 - 1) + ((1-c) * (1-c) / (n2 - 1))
  n = 1 / n;
  left = m1 - m2 - tinv(1-alpha/2, n) * sqrt(1/n1 + 1/n2);
  right = m1 - m2 + tinv(1-alpha/2, n) * sqrt(1/n1 + 1/n2);
endif

printf("The 95 percent confidence interval is : (%6.4f, %6.4f)\n", left, right)



