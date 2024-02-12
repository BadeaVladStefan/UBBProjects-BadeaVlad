#ex 1 a

#(null hypothesis)
# {Ho: niu = 8.5
# {H1: niu < 8.5

alpha = input('Input the significance level (should be between 0 and 1): ');
X = [7 7 4 5 9 9 4 12 8 1 8 7 3 13 2 1 17 7 12 5 6 2 1 13 14 10 2 4 9 11 3 5 12 6 10 7];

n = length(X);

# the null hypoteisis H0 : 2 points niu = 0.5 (goes together with niu > 8.5, standard is met)
# the alternative hypotesis H1: 2 points niu < 0.5 (standard is not met)
# this is a left tailed test for niu

printf('We are solving ex 1 a), left tailed test for the mean when sigma is known \n');
sigma = 5;
mzero = 8.5;

#help ztest => (name value) doesnt help
# "alpha" => after this is the number that is the significance level
# the same for tail where i give it the type after "tail" but i also put it in ""
[h, p, ci, zval] = ztest(X, mzero, sigma, "alpha", alpha, "tail", "left");

#am pus break point linia 23 am dat step in in linia 139 142 145 149 am inlocuit p cu pval

#ttalpha follows the same statistic as the first point
z =  norminv(alpha, 0 ,1);
RR = [-inf z];
printf("the value of H is %d \n", h);
if (h == 1)
  printf("the null hypoteisis is rejected \n");
  printf("the data suggets that the standard is not met \n");
else
  printf("the null hypoteisis is not rejected \n");
  printf("the data suggets that the standard is met \n");
endif

printf("the rejection region is: (%4.4f, %4.4f)\n", RR);
printf("the observerd value of the test statistic is: %4.4f \n", zval);
printf("the p value of the test is %4.4f \n", p);

# HINTS:
# 1 b) ttest      H0: niu=5.5, H1:niu>5.5, right tailed (o sa zic the observerd val of the test statistic is stats.tstat) folosesc tinv
# 2 a) vartest 2
# 2 b) ttest2



