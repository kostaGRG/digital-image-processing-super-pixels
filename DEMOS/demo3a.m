clear
close all
clc

rng(1)
%% LOAD DATA
data = load('dip_hw_2.mat');
d2a = data.d2a;
d2b = data.d2b;
[m1,n1,~] = size(d2a);
[m2,n2,~] = size(d2b);

%% CREATE AFFINITY MATRICES AND CLUSTERS
rng(1);
aff_image1 = Image2Graph(d2a);
aff_image2 = Image2Graph(d2b);

k = 2;
im1_clusters = myGraphSpectralClustering(aff_image1, k);
im2_clusters = myGraphSpectralClustering(aff_image2, k);

%% CALCULATE N-CUT VALUES
nCutValue1 = calculateNcut(aff_image1,im1_clusters);
fprintf("For the first image, ncut= %f\n",nCutValue1);

nCutValue2 = calculateNcut(aff_image2,im2_clusters);
fprintf("For the second image, ncut= %f\n",nCutValue2);

%% FIRST EXPERIMENT: K=2 AND FIRST IMAGE
figure(1);
imshow(d2a);
title('Non-recursive N-cut for first image');
hold on;
for l=min(im1_clusters):max(im1_clusters)
    index = find(im1_clusters == l);
    if size(index,1) > 0
        scatter(index - n1* floor((index-1)/n1),floor((index-1)/n1) + 1,'filled');
    end
end

%% SECOND EXPERIMENT: K=2 AND SECOND IMAGE
figure(2);
imshow(d2b);
title('Non-recursive N-cut for second image');
hold on;
for l=min(im2_clusters):max(im2_clusters)
    index = find(im2_clusters == l);
    if size(index,1) > 0
        scatter(index - n2* floor((index-1)/n2),floor((index-1)/n2 ) + 1,'filled');
    end
end