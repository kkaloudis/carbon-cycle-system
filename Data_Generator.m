%% carbon cycle sysytem
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

%% functions 
f = @(x,y) -(f_0*x^beta*(y0 - y + mu*(nu - theta*(x^gama/(c_x^gama + x^gama) - 1) + (b*x^gama)/(c_p^gama + x^gama) - 1)))/(c_f^beta + x^beta);
g = @(x,y) y0 - y + mu*(nu - theta*(x^gama/(c_x^gama + x^gama) - 1) - (b*x^gama)/(c_p^gama + x^gama) + 1);
 
fx = @(x,y) (f_0*mu*x^beta*(theta*((gama*x^(gama - 1))/(c_x^gama + x^gama) - (gama*x^gama*x^(gama - 1))/(c_x^gama + x^gama)^2) - (b*gama*x^(gama - 1))/(c_p^gama + x^gama) + (b*gama*x^gama*x^(gama - 1))/(c_p^gama + x^gama)^2))/(c_f^beta + x^beta) - (beta*f_0*x^(beta - 1)*(y0 - y + mu*(nu - theta*(x^gama/(c_x^gama + x^gama) - 1) + (b*x^gama)/(c_p^gama + x^gama) - 1)))/(c_f^beta + x^beta) + (beta*f_0*x^beta*x^(beta - 1)*(y0 - y + mu*(nu - theta*(x^gama/(c_x^gama + x^gama) - 1) + (b*x^gama)/(c_p^gama + x^gama) - 1)))/(c_f^beta + x^beta)^2;
fxx = @(x,y)  (2*beta^2*f_0*x^(2*beta - 2)*(y0 - y + mu*(nu - theta*(x^gama/(c_x^gama + x^gama) - 1) + (b*x^gama)/(c_p^gama + x^gama) - 1)))/(c_f^beta + x^beta)^2 - (f_0*mu*x^beta*(theta*((2*gama^2*x^(2*gama - 2))/(c_x^gama + x^gama)^2 - (gama*x^(gama - 2)*(gama - 1))/(c_x^gama + x^gama) - (2*gama^2*x^gama*x^(2*gama - 2))/(c_x^gama + x^gama)^3 + (gama*x^gama*x^(gama - 2)*(gama - 1))/(c_x^gama + x^gama)^2) - (2*b*gama^2*x^(2*gama - 2))/(c_p^gama + x^gama)^2 + (b*gama*x^(gama - 2)*(gama - 1))/(c_p^gama + x^gama) + (2*b*gama^2*x^gama*x^(2*gama - 2))/(c_p^gama + x^gama)^3 - (b*gama*x^gama*x^(gama - 2)*(gama - 1))/(c_p^gama + x^gama)^2))/(c_f^beta + x^beta) - (beta*f_0*x^(beta - 2)*(beta - 1)*(y0 - y + mu*(nu - theta*(x^gama/(c_x^gama + x^gama) - 1) + (b*x^gama)/(c_p^gama + x^gama) - 1)))/(c_f^beta + x^beta) - (2*beta^2*f_0*x^beta*x^(2*beta - 2)*(y0 - y + mu*(nu - theta*(x^gama/(c_x^gama + x^gama) - 1) + (b*x^gama)/(c_p^gama + x^gama) - 1)))/(c_f^beta + x^beta)^3 + (2*beta*f_0*mu*x^(beta - 1)*(theta*((gama*x^(gama - 1))/(c_x^gama + x^gama) - (gama*x^gama*x^(gama - 1))/(c_x^gama + x^gama)^2) - (b*gama*x^(gama - 1))/(c_p^gama + x^gama) + (b*gama*x^gama*x^(gama - 1))/(c_p^gama + x^gama)^2))/(c_f^beta + x^beta) + (beta*f_0*x^beta*x^(beta - 2)*(beta - 1)*(y0 - y + mu*(nu - theta*(x^gama/(c_x^gama + x^gama) - 1) + (b*x^gama)/(c_p^gama + x^gama) - 1)))/(c_f^beta + x^beta)^2 - (2*beta*f_0*mu*x^beta*x^(beta - 1)*(theta*((gama*x^(gama - 1))/(c_x^gama + x^gama) - (gama*x^gama*x^(gama - 1))/(c_x^gama + x^gama)^2) - (b*gama*x^(gama - 1))/(c_p^gama + x^gama) + (b*gama*x^gama*x^(gama - 1))/(c_p^gama + x^gama)^2))/(c_f^beta + x^beta)^2;
fyx = @(x,y) (beta*f_0*x^(beta - 1))/(c_f^beta + x^beta) - (beta*f_0*x^beta*x^(beta - 1))/(c_f^beta + x^beta)^2;
fy=@(x,y) (f_0*x^beta)/(c_f^beta + x^beta);

gx = @(x,y) -mu*(theta*((gama*x^(gama - 1))/(c_x^gama + x^gama) - (gama*x^gama*x^(gama - 1))/(c_x^gama + x^gama)^2) + (b*gama*x^(gama - 1))/(c_p^gama + x^gama) - (b*gama*x^gama*x^(gama - 1))/(c_p^gama + x^gama)^2);
gy = @(x,y) -1;
gxy = @(x,y) 0;
gyy = @(x,y) 0;

s = @(x,y) -(f_0*mu*eps*x^beta)/(c_f^beta + x^beta);
sx = @(x,y) -eps*((beta*f_0*mu*x^(beta - 1))/(c_f^beta + x^beta) - (beta*f_0*mu*x^beta*x^(beta - 1))/(c_f^beta + x^beta)^2);
ga = @(x,y) mu*eps;

%% main code
u_L = (b-1)^(-1/gama)*c_p;
v_L = y0+mu*(theta+nu-theta*c_p^gama/((b-1)*c_x^gama+c_p^gama));
%网格划分的大小
N = 60;
dud = 0 : 2*pi/N : 2*pi;
for j = 1 : N+1
    vec1(j) = cos(dud(j));
    vec2(j) = sin(dud(j));
end
%网格划分的大小
M = 60;
vel = 20;
rur = vel/M : vel/M : vel;
T = 5;
NN = 10^3;
dt = T/NN;
t = 0 : dt : T;
F = @(x,y,u,v)   -(y-f(x,u))^2*sx(x,u)/s(x,u)+y*2*sx(x,u)*(y-f(x,u))/s(x,u)+f(x,u)*fx(x,u)+s(x,u)^2*fxx(x,u)/2+(g(x,u)*gx(x,u)*s(x,u)^2)/ga(x,u)^2+gxy(x,u)*s(x,u)^2/2+v*(fy(x,u)-s(x,u)^2*gx(x,u)/ga(x,u)^2);
G = @(x,y,u,v)   y*(gx(x,u)-fy(x,u)*ga(x,u)^2/s(x,u)^2)+ f(x,u)*fy(x,u)*ga(x,u)^2/s(x,u)^2+fyx(x,u)*ga(x,u)^2/2+g(x,u)*gy(x,u)+gyy(x,u)*ga(x,u)^2/2;

for k = 1 : M
    out1 = rur(k)*vec1;
    out2 = rur(k)*vec2;
for i = 1 : N+1
    for j = 1 : N+1            
        x1(1) = u_L;
        x2(1) = out1(i);
        x3(1) = v_L;
        x4(1) = out2(j);
        for l = 1 : NN
            x1(l+1) = x1(l) + x2(l)*dt;
            x2(l+1) = x2(l) + F(x1(l),x2(l),x3(l),x4(l))*dt;
            x3(l+1) = x3(l) + x4(l)*dt;
            x4(l+1) = x4(l) + G(x1(l),x2(l),x3(l),x4(l))*dt;
        end
        P(1,(k-1)*(N+1)^2+(i-1)*(N+1)+j) = out1(i);
        P(2,(k-1)*(N+1)^2+(i-1)*(N+1)+j) = out2(j);
        P(3,(k-1)*(N+1)^2+(i-1)*(N+1)+j) = x1(end);
        P(4,(k-1)*(N+1)^2+(i-1)*(N+1)+j) = x3(end);
    end
end
end

save Original0 P

toc