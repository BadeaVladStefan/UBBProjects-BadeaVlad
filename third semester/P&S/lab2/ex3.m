#we simulate 3 main tosses

N=input("Enter the number of simulations, N=");

U=rand(3,N);
Y=(U<0.5);

# if U < 0.5 => Y = 1 heads
# if U > 0.5 => Y = 0 tails
# is inverted because of the boolean (pot schimba semnul si se rezolva)

#we compute the number of heads
X=sum(Y);
clf; # curata consola
hist(X);

