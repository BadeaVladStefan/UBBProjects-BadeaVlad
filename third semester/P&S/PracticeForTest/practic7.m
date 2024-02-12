# a. At the 5% significance level, do the population variances seem to differ?

alpha = input('Enter the significance level, alpha: ') # alpha = 0.05

alpha = 0.05;

%h0: sigma1  = sigma2
%h1: sigma1 =! sigma2
# - H0 = null hypothesis (no effect) : The population variances do NOT differ
# - H1 = alternative hypothesis (significant effect): The population variances differ

# we have a two-tailed test

fprintf('\n\npoint a)\n');


X1 = [29.8 30.6 29.0 27.7 29.9 29.6 30.5 31.1 30.2 28.1 29.4 28.5]; %sample test 1

X2 = [31.5 30.2 31.2 29.0 31.4 31.1 32.5 33.0 31.3 30.9 30.7 29.9]; %sample test 2
%tail values: -1 for left tailed
%           : 0 for both, default
%           : 1 for rigth tailed

[h, p, ci, stats] = vartest2(X1,X2,'alpha',alpha, 'tail', 'both');
% h - the binary indicator
% p-P value; ci = confidence level
% ci = confidence interval
% stats contains fstat, df1 and df2 (the value of the test statistic)
% and the degrees of freedom
if h == 0
    fprintf('H0 is not rejected, population variances do NOT differ\n');
else
    fprintf('H0 is rejected, population variances differ \n');
end

q1 = finv(alpha/2, stats.df1, stats.df2);
q2 = finv(1-alpha/2, stats.df2, stats.df1);

# we compute the rejection region RR
# if the value of the test statistic is within the rejection region => it means
# that the H0 is rejected, else the H0 is not rejected
fprintf('Observed value is %1.4f\n', stats.fstat);
fprintf('Rejection region R is RR (-inf, %3.4f) U (%3.4f, inf)\n', q1, q2);
fprintf('P-value is %1.4f\n', p);

printf('\n\npoint b) \n\n')
# n. At the same significance level, does the brand A printer seem to be faster, on average?

# we have to perform a ttest2 to test the equality of means
# from point a) we know that the variances do not differ => 'vartype' is 'equal' (default)
# we have a right tailed test : mean(X1) > mean(X2)

[h, pval, ci, stats] = ttest2(X1, X2, 'vartype', 'unequal');

a = h
# - H0 = null hypothesis (no effect) : The mean of Brand A is NOT greater than the mean of Brand B
# - H1 = alternative hypothesis (significant effect): The mean of Brand A is greater than the mean of Brand B

# we have a right-tailed test : mean(X1) > mean(X2)

if h==0
  printf('The H0 is not rejected.\nThe mean of Brand A is greater than the mean of Brand B\n\n');
else
    printf('The H0 is rejected\nThe mean of Brand A is NOT greater than the mean of Brand B\n');
end

# we compute the rejection region
q = tinv(alpha, stats.df); # stats.df - degrees of freedom
printf('\nThe observed value is: %1.6f\n', stats.tstat);
printf('The rejection region R is (%1.6f, +inf)\n', q);
printf('The p-value from the test statistic is: %1.6f \n',pval);
