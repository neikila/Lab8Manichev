% task(1);
% task(2);
% task(3);
% task(4);
task(5);

function [] = task(taskNum) 
lambda1=@(a, b, c, d) ode45(a, b, c, d);
lambda2=@(a, b, c, d) ode15s(a, b, c, d);
lambda3=@(a, b, c, d) ode23t(a, b, c, d);

ideal = idealFun(taskNum);

X0=getX0(taskNum);
tfs = timeLimits(taskNum);
tf = tfs(1)
ode45Result = testIt(tf, lambda1, X0, ideal, taskNum)
ode15sResult = testIt(tf, lambda2, X0, ideal, taskNum)
ode23tResult = testIt(tf, lambda3, X0, ideal, taskNum)
% tf = tfs(2)
% ode45Result = testIt(tf, lambda1, X0, ideal, taskNum)
% ode15sResult = testIt(tf, lambda2, X0, ideal, taskNum)
% ode23tResult = testIt(tf, lambda3, X0, ideal, taskNum)
end


function [res]=createTestResult(time, error, num)
res.time = time;
res.error = error;
res.num = num;
end

function [testResult]=testIt(tf, fun, X0, ideal, taskNum)
t0=0;
tspan=[t0 tf];

OPTS = odeset('RelTol',1e-07,'AbsTol',1e-10,'InitialStep', 1e-06,'MaxStep',tf/10);

systemToSolve = @(t,X) odelin02(getA(taskNum), getB(taskNum), t, X);

tic;
[T,X]=fun(systemToSolve,tspan,X0,OPTS);
% fun(@odelin02,tspan,X0,OPTS);
timeCalc = toc;
n=length(T);
tspan01=T;
e1=zeros(n,1);
x1an=ideal(tspan01);
x1ch=X(:,1);
for ii=2:n
    e1(ii)=abs(x1ch(ii)-x1an(ii));
    if abs(x1an(ii))>1-32
        e1(ii)=e1(ii)/abs(x1an(ii));
    end
end
  format long
table(tspan01,x1an,x1ch,e1);
e=norm(e1,Inf);
testResult = createTestResult(timeCalc, e, n);
end

