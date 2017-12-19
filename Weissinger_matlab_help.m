 t0 = 1;
y0 = sqrt(3/2)
yp0 = 0
[y0,yp0] = decic(@weissinger,t0,y0,1,yp0,0)
[t,y] = ode15i(@weissinger,[1 10],y0,yp0);
ytrue = sqrt(t.^2 + 0.5);
plot(t,y,t,ytrue,'o')