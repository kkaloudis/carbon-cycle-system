%% compute the stable point
clear,clc
load('Data_Eff_nu=0.0.mat');
u = load('LimitCycle_nu=0.txt');
%  plot(u(1,:),u(2,:),'r'); hold on
% plot(SED(3,:),SED(4,:),'*');

[m n] = size(SED);
k = 0;
l = 0;
for j = 1 : n
    if SED(4,j) < 2800;
        k = k + 1;
        SDE1(1,k) = SED(1,j);
        SDE1(2,k) = SED(2,j);
        SDE1(3,k) = SED(3,j);
        SDE1(4,k) = SED(4,j);
    else
        l = l + 1;
        SDE2(1,l) = SED(1,j);
        SDE2(2,l) = SED(2,j);
        SDE2(3,l) = SED(3,j);
        SDE2(4,l) = SED(4,j);        
    end
end
plot(SDE2(3,:),SDE2(4,:),'*');hold on
plot(SDE1(3,:),SDE1(4,:),'*');
% 
% save  SED_up.mat SDE1
% save  SED_down.mat SDE2

