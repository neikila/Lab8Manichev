function dXdt = odelin02(A, B, t,X)
dXdt=zeros(2,1);
dXdt=A*X+B;
