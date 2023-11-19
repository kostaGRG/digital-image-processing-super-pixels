function final_cluster = recursiveNcut(aff_image,T1,T2)
    rng(1);
    clusters = myGraphSpectralClustering(aff_image, 2);
    index1 = find(clusters==1);
    index2 = find(clusters==2);
 
    k1 = size(index1,1);
    k2 = size(index2,1);
    fprintf("k1=%d, k2=%d\n",k1,k2);
    
    nCutValue = calculateNcut(aff_image,clusters);
    fprintf("nCut = %.3f\n\n",nCutValue);
    
    
    if k1 < T1 || k2 < T1
        final_cluster = string(clusters-1);
%         final_cluster = '';
        return;
    end
    
    if nCutValue > T2
        final_cluster = string(clusters-1);
%         final_cluster = '';
        return;
    else
        A = aff_image(clusters==1,clusters==1);
        B = aff_image(clusters==2,clusters==2);

        final_cluster(index1) = "0" + recursiveNcut(A,T1,T2);
        final_cluster(index2) = "1" + recursiveNcut(B,T1,T2);
    end
    
end