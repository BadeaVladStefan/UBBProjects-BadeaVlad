#SA SCOT LA IMPIRAMNTA TABELUL DIN LAB 4 SI SA IL COMPLETEZ!

#2.a)


N=input('Number of simulations, N=');
p=input('The probability, needs to be between 0 and 1, p=');
U=rand(1,N);
X=(U<p);
U_X=[0 1]
n_X=hist(X,length(U_X));
rel_freq= n_X/N



