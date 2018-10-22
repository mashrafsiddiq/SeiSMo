function [bsf,ind] = EA_ED_Search(x,y,bsf)

%x is the data, y is the query
m = length(y);
n = length(x);

y = zNorm(y);

%compute x stats -- O(n)
meanx = movmean(x,[m-1 0]);
sigmax = movstd(x,[m-1 0],1);

b2 = bsf^2;
ind = -1;
for i = 1:n-m+1
    
    S = 0;
    for j = 0:m-1
        S = S + ( (x(i+j) - meanx(i+m-1))/sigmax(i+m-1) - y(j+1) )^2;
        if S > b2
            break;
        end
    end
    if S < b2
        b2 = S;
        ind = i;
    end
end
bsf = sqrt(b2);