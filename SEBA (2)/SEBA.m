function S=SEBA(V,Rinit)

%V is pxr matrix (r vectors of length p as columns, assumed orthonormal)
%S is pxr matrix with columns approximately spanning the column space of V
%Rinit is optional orthonormal rxr matrix

maxiter=5000;
[V,~]=qr(V,0); %Enforce orthonormality
[p,r]=size(V);
mu=0.99/sqrt(p);

S=zeros(size(V));
%Perturb near-constant vectors
for j=1:r
    if max(V(:,j))-min(V(:,j))<1e-14
        V(:,j)=V(:,j)+(rand(p,1)-1/2)*1e-12;
    end
end
%Initialise rotation
if nargin==1
    Rnew=speye(r);
else
    [P,~,Q]=svd(Rinit,0);
    Rinit=P*Q'; %Ensure orthonormality of Rinit
    Rnew=Rinit;
end
R=0;

iter=0;
while norm(Rnew-R)>1e-14 && iter<maxiter
    iter=iter+1;
    R=Rnew;
    Z=V*R';
    %Threshold to solve sparse approximation problem
    for i=1:r
        S(:,i)=sign(Z(:,i)).*max(abs(Z(:,i))-mu,0);
        S(:,i)=S(:,i)/norm(S(:,i));
    end
    %Polar decomposition to solve Procrustes problem
    [P,~,Q]=svd(S'*V,0);
    Rnew=P*Q';
end

%Choose correct parity of vectors and scale so largest value is 1
for i=1:r
    S(:,i)=S(:,i)*sign(sum(S(:,i)));
    S(:,i)=S(:,i)/max(S(:,i));
end

%Sort so that most reliable vectors appear first
[~, I] = sort(min(S), 'descend');
S = S(:, I);