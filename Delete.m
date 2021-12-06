function [En,Ep] = DataClass(P)
% En : number of points in each effective block
% Ep : point coordinate in each effictive block
% P : target points

[m,n] = size(P); 
M = 100;
Ml = (3400-2000)/100;
N = 100;
Nl = (200-0)/100;
En = zeros(M*N,1);
for i = 1 : n
    for j = 1 : N
        for k = 1 :M
            if P(4,i)<3400-(k-1)*Ml && P(4,i)>3400-k*Ml && P(3,i)<j*Nl && P(3,i)>(j-1)*Nl 
                En(N*(k-1)+j) = En(N*(k-1)+j)+1;
                Ep(N*(k-1)+j,1,En(N*(k-1)+j)) = P(1,i);
                Ep(N*(k-1)+j,2,En(N*(k-1)+j)) = P(2,i);
                Ep(N*(k-1)+j,3,En(N*(k-1)+j)) = P(3,i);
                Ep(N*(k-1)+j,4,En(N*(k-1)+j)) = P(4,i);
                break;
            end
        end
    end
end

        


