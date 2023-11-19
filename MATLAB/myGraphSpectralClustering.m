% ****myGraphSpectralClustering****
% **Arguments**
% *anAffinityMat: the graph we want to find clusters
% *k: Number of different clusters to split the graph
% **Outputs**
% * clusterIdx: list with the values of cluster for each vertex of the
% graph

function clusterIdx = myGraphSpectralClustering(anAffinityMat, k)
    warning off;

    D = diag(sum(anAffinityMat));
    L = D - anAffinityMat;

    % find eigenvectors that meet the equation L*v = λ*D*v
    [U,~] = eigs(D\L,k,'smallestreal');
    
    clusterIdx = kmeans(real(U),k);
end