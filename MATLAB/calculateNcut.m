function nCutValue = calculateNcut(anAffinityMat, clusterIdx)
    assocAV = sum(anAffinityMat(clusterIdx==1,:),'all');
    assocBV = sum(anAffinityMat(clusterIdx==2,:),'all');
%     fprintf('assocAV,assocBV: %f  %f\n',assocAV,assocBV);
    assocAA = sum(anAffinityMat(clusterIdx==1,clusterIdx==1),'all');
    assocBB = sum(anAffinityMat(clusterIdx==2,clusterIdx==2),'all');

%     fprintf('assocAA,assocBB: %f  %f\n',assocAA,assocBB);
    nAssocAB = assocAA/assocAV + assocBB/assocBV ; 
    nCutValue = 2 - nAssocAB;
end