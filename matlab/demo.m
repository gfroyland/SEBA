% create a data array V with 4 vectors
grid = 0:0.1:2*pi
numvecs = 4
V=zeros(length(grid),numvecs)
for i=1:length(grid)
    for k=1:numvecs
        V(i,k)= cos(((k-1) / 2) * grid(i))
    end
end

% apply SEBA to obtain sparse array S with similar column space to V
S = SEBA(V)

% plot initial data and SEBA result
subplot(2,1,1)
plot(grid, V)
xlim([0 2*pi])
title("4 original vectors")
subplot(2,1,2)
plot(grid, S)
xlim([0 2*pi])
title("4 sparse SEBA vectors with similar span")


