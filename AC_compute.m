clear,clc

tic
%% initail parameters
mu = 250;
b = 4;
theta = 5;
c_x = 58;
c_p = 110;
nu = 0;
y0 = 2000;
gama = 4;
f_0 = 0.694;
c_f = 43.9;
beta = 2;
eps = 0.1;

%% Lagrangian
f = @(x,y) -(f_0*x^beta*(y0 - y + mu*(nu - theta*(x^gama/(c_x^gama + x^gama) - 1) + (b*x^gama)/(c_p^gama + x^gama) - 1)))/(c_f^beta + x^beta);
fx = @(x,y) (f_0*mu*x^beta*(theta*((gama*x^(gama - 1))/(c_x^gama + x^gama) - (gama*x^gama*x^(gama - 1))/(c_x^gama + x^gama)^2) - (b*gama*x^(gama - 1))/(c_p^gama + x^gama) + (b*gama*x^gama*x^(gama - 1))/(c_p^gama + x^gama)^2))/(c_f^beta + x^beta) - (beta*f_0*x^(beta - 1)*(y0 - y + mu*(nu - theta*(x^gama/(c_x^gama + x^gama) - 1) + (b*x^gama)/(c_p^gama + x^gama) - 1)))/(c_f^beta + x^beta) + (beta*f_0*x^beta*x^(beta - 1)*(y0 - y + mu*(nu - theta*(x^gama/(c_x^gama + x^gama) - 1) + (b*x^gama)/(c_p^gama + x^gama) - 1)))/(c_f^beta + x^beta)^2;
g = @(x,y) y0 - y + mu*(nu - theta*(x^gama/(c_x^gama + x^gama) - 1) - (b*x^gama)/(c_p^gama + x^gama) + 1);
s = @(x,y) -(f_0*mu*eps*x^beta)/(c_f^beta + x^beta);
gy = @(x,y) -1;
ga = @(x,y) mu*eps;

L = @(x,y,u,v) (u-f(x,y))^2/(s(x,y))^2 + fx(x,y) + (v-g(x,y))^2/(ga(x,y))^2 + gy(x,y);

%% Compute the action functional
T = 4;
uu = load('subdatau_opt.mat');
vv = load('subdatav_opt.mat');
u = uu.x1n;
v = vv.x3n;


[m n] = size(u);
for i = 1 : m
    Act(i) = ActionValue(u(i,:),v(i,:),L,T);
end

%% Find the minimizer of the action functional
ind = find(Act==min(min(Act)));
%ind = find(Act==max(max(Act)));

u_L = (b-1)^(-1/gama)*c_p;
v_L = y0+mu*(theta+nu-theta*c_p^gama/((b-1)*c_x^gama+c_p^gama));
for j = 1 : n
    u_opt(j) = u(ind,j);
    v_opt(j) = v(ind,j);
end

L = load('LimitCycle_nu=0.txt');


plot(u_opt,v_opt,'b'); hold on
plot(L(1,:),L(2,:),'r'); hold on 
plot(u_L,v_L,'*'); hold on
set(gca,'XTick',0:50:200);
plot(L(1,ind+150),L(2,ind+150),'o');hold on
% plot(L(1,j+1),L(2,j+1),'o');

toc