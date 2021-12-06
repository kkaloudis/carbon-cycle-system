function u = Select(v)
%% find the number of non-zero data

[m n l] = size(v);
u = 0;
for i = 1 : l
    if v(1,1,i) > 0
        u = u + 1;
    end
end