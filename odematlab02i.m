t0=0;
tf=12;
% tf=1000;
tspan=[t0 tf];
X0=[1 2]';
XP0=[0 0]';
[X0,XP0]=decic(@odelin02i,t0,X0,[1 1],XP0,[])

OPTS = odeset('RelTol',1e-09,'AbsTol',1e-12,'InitialStep',1e-06,'MaxStep',tf/10);

tic;
[T,X]=ode15i(@odelin02i,tspan,X0,XP0,OPTS);
ode15i(@odelin02i,tspan,X0,XP0,OPTS);
result = toc;
n=length(T);
tspan01=T;
x1an=zeros(n,1);
x1ch=zeros(n,1);
e1=zeros(n,1);
x1an=exp(-tspan01/5).*cos(tspan01)+exp(-tspan01/5).*sin(tspan01);
x1ch=X(:,1);
for ii=1:n
    e1(ii)=abs(x1ch(ii)-x1an(ii));
    if abs(x1an(ii))>1e-32
        e1(ii)=e1(ii)/abs(x1an(ii));
    end
end
  %format long
table(tspan01,x1an,x1ch,e1)
e=norm(e1,Inf)
n

result