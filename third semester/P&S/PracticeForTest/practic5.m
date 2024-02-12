%A manufacturer of gunpowder has developed a new powder which was tested in 12
%shells. the resulting muzzle velocities in m/s are (they are assumed to be
%approximately normally distributed)

X = [1001.7, 975.0, 978.3, 988.3, 978.7, 988.9, 1000.3, 979.2, 968.9, 983.5, 999.2, 985.6]

n = length(X);
m = mean(X);
v = var(X);
s = std(X);

%a)At the 5% significance level, does the data suggest that, on average, the
%muzzle are faster then 995 m/s?

fprintf("\nb)\n");
alpha = input("Please input the significance level (should be 0.05): ");
m0 = input("Please input the testing value (should be 995):");

[H, P, CI, STATS] = ttest(X, m0, 'alpha', alpha, 'tail', 'right');

if H == 0
    fprintf("The null hypothesis is not rejected!\n");
    fprintf("On average, the muzzle velocities are not faster than %.2f m/s!\n", m0);
else
    fprintf("The null hypothesis is rejected!\n");
    fprintf("On average, the muzzle velocities are faster than %.2f m/s!\n", m0);
end

t = tinv(1-alpha, n-1);
fprintf("The rejection region is (%.4f, %.4f)\n", t, inf);
fprintf("The test statistics value is: %.4f\n", STATS.tstat);
fprintf("The P-value of the test is: %.4f\n", P);
fprintf("The value of H is: %.4f\n", H);

%Find the 99% confidence interval for the standard deviation of the velocity of
%of shells of this type

alpha = 0.01
fprintf("\nb)\n");

% Degrees of freedom for chi-square distribution
df = n - 1;

% Chi-square values for the confidence interval
chi_square_lower = chi2inv(alpha/2, df);
chi_square_upper = chi2inv(1 - alpha/2, df);

% Confidence interval for standard deviation
ci_lower = sqrt((n-1) * v / chi_square_upper);
ci_upper = sqrt((n-1) * v / chi_square_lower);

fprintf("The 99%% confidence interval for the standard deviation is: (%.4f, %.4f)\n", ci_lower, ci_upper);
