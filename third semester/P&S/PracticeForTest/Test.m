X = [3.26, 1.89, 2.42, 2.03, 3.07, 2.95, 1.39, 3.06, 2.46, 3.35, 1.56, 1.79, 1.76, 3.82, 2.42, 2.96];

n = length(X);
m = mean(X);
v = var(X);

% a) At the 5% significance level, on average, do these nickel particles
% seem to be smaller than 3?

% sigma unknown => ttest


% H0 : on average the nickel particles are equal to 3
% H1 : on average the nickel particles are smaller than 3
% we must do a left-tailed test
fprintf("\nb)\n");
alpha = input("Please input the significance level (should be 0.05): ");
m0 = input("Please input the testing value (should be 3):");

[H, P, CI, STATS] = ttest(X, m0, 'alpha', alpha, 'tail', 'left');

if H == 0
    fprintf("\nThe null hypothesis is not rejected!\n");
    fprintf("On average the nickel particles are equal to 3!\n");
else
    fprintf("\nThe null hypothesis is rejected!\n");
    fprintf("On average the nickel particles are smaller than 3!\n");
end

t = tinv(alpha, n-1);
fprintf("The rejection region is (%.4f, %.4f)\n", -inf, t);
fprintf("The test statistics value is: %.4f\n", STATS.tstat);
fprintf("The P-value of the test is: %.4f\n", P);
fprintf("The value of H is: %.4f\n", H);


% b) find a 99% confidence interval for the standard deviation of the size of
%nickel particles

confidence = input("Please input the confidence interval (should be 99%): ");
alpha2 = 1 - confidence;
fprintf("\nb)\n");

N = columns(X);
standardDeviationOfX = std(X);
averageOfX = mean(X);

fprintf("We need the standard deviation of x so we use the second case from the confidence interval file and compute using chi 2. This gives us the variance so we need to sqrt to convert to standard deviation\n")
o1 = (N-1)*standardDeviationOfX*standardDeviationOfX/chi2inv(1-alpha2/2, N-1);
o2 = (N-1)*standardDeviationOfX*standardDeviationOfX/chi2inv(alpha2/2, N-1);

s1 = sqrt(o1);
s2 = sqrt(o2);

fprintf("The interval is (%f, %f)\n", s1, s2)
