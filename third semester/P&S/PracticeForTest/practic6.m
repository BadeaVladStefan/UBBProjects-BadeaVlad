# To reach the maximum efficiency in performing an assembling operation
# in a manufacturing plant, new employees are required to take a 1-month training course.
# A new method was sugested, and the manager wants to compare the new method to the
# standard one, by looking at the lengths of time required for employeees to assemble a certain device.
# They are given below

# Standard 46 37 39 48 47 44 35 31 44 37
# New      35 33 31 35 34 30 27 32 31 31


# a) At 5% significance level, do the population variances seem to differ?

X = [46 37 39 48 47 44 35 31 44 37];
Y = [35 33 31 35 34 30 27 32 31 31];
n1 = length(X);
n2 = length(Y);

alpha = input('Enter the significance level: ');
# H0: The population variances do NOT differ.
# H1: The population variances differ.
# H0: sigma1 = sigma2
# H1: sigma1 != sigma2

# it is a two-tailed test
[h, pval, ci, stats] = vartest2(X, Y, 'alpha', alpha, 'tail', 'both');

if h==0
  printf('The population variances do NOT differ.\n');
else
  printf('The population variances differ.\n');
end

#we compute the rejection region
q1 = finv(alpha/2, stats.df1, stats.df2);
q2 = finv(1-alpha/2, stats.df1, stats.df2);
printf('The rejection region is (-inf, %1.6f) U (%1.6f, +inf)\n', q1, q2);
printf('The observed value is: %1.6f\n', stats.fstat);
printf('The p-value from the test statistical is: %1.6f\n', pval);

# b) Find a 95% confidence interval for the difference of the average assembling
# times

one_minus_alpha = input('Enter the confidence level: '); # we use 0.95
alpha = 1- one_minus_alpha;

# the variances differ
#sp = sqrt((n1-1)* var(X) + (n2-1)* var(Y))/ (n1+n2-2);
m1 = mean(X) - mean(Y) - tinv((1-alpha/2), n1+n2-2)* sqrt(var(X)/n1 + var(Y)/n2);
m2 = mean(X) - mean(Y) + tinv((1-alpha/2), n1+n2-2)* sqrt(var(X)/n1 + var(Y)/n2);

printf('The confidence interval for the difference of the average assembling times is: \n');
printf('(%1.6f, %1.6f) \n',m1,m2);
