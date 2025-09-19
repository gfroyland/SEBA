function MinValStackedPlot(V,kmax)
%V is pxR matrix (r vectors of length p as columns, assumed orthonormal)
%kmax is number of lines to output, assumed <= R

R=size(V,2);
column_minima=nan(R-1,R);
for i=1:R-1
    S=SEBA(V(:,1:i+1));   % Column minima are in descending order
    column_minima(i,1:i+1)=-min(S);
end
minimum_sums=cumsum(column_minima,2);

[best_sum,best_r]=min(minimum_sums);
cla reset; hold on
for j=1:kmax
    iStart=max(j-1,1);
    plot(iStart+1:R,minimum_sums(iStart:R-1,j),'o-',...
        'MarkerSize',2,'Linewidth',1.5);
end
plot(best_r(1:kmax)+1,best_sum(1:kmax),'kd','MarkerSize',4,...
    'MarkerFaceColor','k');% Plot best r for each k
plot([2,2:kmax],minimum_sums([1,R:R:R*(kmax-1)]),'k:',...
    'MarkerSize',2.5) % Plot upper envelope
hold off
