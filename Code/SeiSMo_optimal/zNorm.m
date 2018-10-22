function x=zNorm(x)

x = (x-mean(x))./std(x,1);