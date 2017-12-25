taskNum = 5;

t0=0;
timeLimitsForTask = timeLimits(taskNum)
tf=timeLimitsForTask(1);
tspan=[t0 tf];

X0 = getX0(taskNum)';
XP0=[0 0]';


systemToSolve = @(t,X, XP) odelin02i(getA(taskNum), getB(taskNum), t, X, XP);
[X0,XP0]=decic(systemToSolve,t0,X0,[1 1],XP0,[]);

OPTS = odeset('RelTol',1e-09,'AbsTol',1e-12,'InitialStep',1e-06,'MaxStep',tf/10);

tic;
[T,X]=ode15i(systemToSolve,tspan,X0,XP0,OPTS);
% ode15i(systemToSolve,tspan,X0,XP0,OPTS);
result = toc;
n=length(T);
tspan01=T;
e1=zeros(n,1);

ideal = idealFun(taskNum);
x1an=ideal(tspan01);
x1ch=X(:,1);

for ii=1:n
    e1(ii)=abs(x1ch(ii)-x1an(ii));
    if abs(x1an(ii))>1e-32
        e1(ii)=e1(ii)/abs(x1an(ii));
    end
end
%format long
% table(tspan01,x1an,x1ch,e1)
e=norm(e1,Inf);

createTestResult(result, e, n)

function [res]=createTestResult(time, error, num)
res.time = time;
res.error = error;
res.num = num;
end