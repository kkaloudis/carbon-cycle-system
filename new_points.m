clear,clc

load('process0.mat');
u = load('LimitCycle_nu=0.txt');

[m,n] = size(P);
dt = 4;
M = (3400-2000)/dt;
N = (100-10)/dt;

kk = 1;

for i = 1 : M
    for j = 1 : N
        for k = 1 : n
        if P(4,k)<3400-(i-1)*dt && P(4,k)>3400-i*dt && P(3,k)<10+j*dt && P(3,k)>10+(j-1)*dt
            ED(1,kk) = P(1,k);
            ED(2,kk) = P(2,k);
            ED(3,kk) = P(3,k);
            ED(4,kk) = P(4,k);
            kk = kk + 1;
            break;
        end
    end
    end
end
plot(ED(3,:),ED(4,:),'*'); hold on
plot(u(1,:),u(2,:),'r'); 

save sparse0.mat ED