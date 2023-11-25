#problema2:

p = input("Probability is equal to(it should be between 0.05 and 0.95): p=");

for n=1:3:100
  x=0:n;
  y=binopdf(x,n,p);
  plot(x,y);
  pause(0.5);
endfor

