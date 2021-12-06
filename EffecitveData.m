clear,clc

tic

%% Data blocks for Target data
X = load('Original0.mat');
P = X.P;
[En,Ep] = DataClass(P);
[m n l] = size(Ep);

%% Data blocks for limit Cycle
u = load('LimitCycle_nu=0.txt');
M = 7;
N = 4;
[m,n] = size(u);
En1 = zeros(M*N,1);
Ep1= zeros(M*N,1,0);
for i = 1 : n
    for j = 1 : N
        for k = 1 :M
            if u(2,i)<3400-(k-1)*200 && u(2,i)>3400-k*200 && u(1,i)<j*50 && u(1,i)>(j-1)*50 
                En1(N*(k-1)+j) = En1(N*(k-1)+j)+1;
                Ep1(N*(k-1)+j,1,En1(N*(k-1)+j)) = u(1,i);
                Ep1(N*(k-1)+j,2,En1(N*(k-1)+j)) = u(2,i);
                break;
            end
        end
    end
end

%% Select effective number
k = 0;
M = 28;
for j = 1 : M
    if j ~= 10 && j~=15 && j~=28
        k = k + 1;
        v = Ep(j,4,:);
        v1 = Ep1(j,2,:);
        Tip(k) = Select(v);
        Tip1(k) = Select(v1);
    end
end

%% genarate effective data
k = 0;
kk = 0;
M = 28;
dd = 10;
for j = 1 : M
    if j ~= 10 && j~=15 && j~=28
        k = k + 1;
        uu = zeros(2,Tip1(k));
        for m = 1 : Tip1(k)
            uu(1,m) = Ep1(j,1,m);
            uu(2,m) = Ep1(j,2,m);
        end
        vv = zeros(2,Tip(k));
        for m = 1 : Tip(k)
            vv(1,m) = Ep(j,3,m);
            vv(2,m) = Ep(j,4,m);
        end
        for m = 1 : Tip(k)
            d = Distance(vv(:,m),uu);
            if d < dd
                kk = kk+1;
                SED(1,kk) = Ep(j,1,m);
                SED(2,kk) = Ep(j,2,m);
                SED(3,kk) = Ep(j,3,m);
                SED(4,kk) = Ep(j,4,m);
            end
        end
    end
end
save process0.mat SED

plot(u(1,:),u(2,:),'b');hold on
plot(SED(3,:),SED(4,:),'*');
toc