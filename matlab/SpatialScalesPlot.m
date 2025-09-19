function SpatialScalesPlot(V)
%V is pxR matrix (r vectors of length p as columns, assumed orthonormal)

R=size(V,2);
column_minima=nan(R-1,R);
for i=1:R-1
    S=SEBA(V(:,1:i+1));   % Column minima are in descending order
    column_minima(i,1:i+1)=-min(S);
end
minimum_sums=cumsum(column_minima,2);

[~,best_r]=min(minimum_sums);
cla reset;
plot(best_r(1:R)+1,(1:R),['o','-'],'Color','k','MarkerSize',4,...
    'MarkerFaceColor','k');% Plot best r for each k=1,..,r
