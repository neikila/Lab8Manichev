function res = odelin02i(t,X,XP)
A=getA();
B=getB();
res=XP-A*X-B;
