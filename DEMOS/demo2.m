clear
close all
clc

rng(1);
%% LOAD DATA
data = load('dip_hw_2.mat');
d2a = data.d2a;
[m1,n1,~] = size(d2a);
d2b = data.d2b;
[m2,n2,~] = size(d2b);

figure(5);
montage({d2a,d2b});

%% CREATE AFFINITY MATRICES
aff_image1 = Image2Graph(d2a);
aff_image2 = Image2Graph(d2b);

%% FIRST EXPERIMENT: K=3 AND FIRST IMAGE
k = 3;
im1_clusters = myGraphSpectralClustering(aff_image1, k);

figure(1);
imshow(d2a);
title('First image, k=3');
hold on;
for l=min(im1_clusters):max(im1_clusters)
    index = find(im1_clusters == l);
    if size(index,1) > 0
        scatter(index - n1* floor((index-1)/n1),floor((index-1)/n1) + 1,'d','filled');
    end
end
%% SECOND EXPERIMENT: K=3 AND SECOND IMAGE
k=3;
im2_clusters = myGraphSpectralClustering(aff_image2, k);

figure(2);
imshow(d2b);
title('Second image, k=3');
hold on;
for l=min(im2_clusters):max(im2_clusters)
    index = find(im2_clusters == l);
    if size(index,1) > 0
        scatter(index - n2* floor((index-1)/n2),floor((index-1)/n2) + 1,'d','filled');
    end
end

%% THIRD EXPERIMENT: K=4 AND FIRST IMAGE
k = 4;
im1_clusters = myGraphSpectralClustering(aff_image1, k);

figure(3);
imshow(d2a);
axis off;
title('First image, k=4');
hold on;
for l=min(im1_clusters):max(im1_clusters)
    index = find(im1_clusters == l);
    if size(index,1) > 0
        scatter(index - n1* floor((index-1)/n1),floor((index-1)/n1) + 1,'d','filled');
    end
end

%% FOURTH EXPERIMENT: K=4 AND SECOND IMAGE
k = 4;
im2_clusters = myGraphSpectralClustering(aff_image2, k);

figure(4);
imshow(d2b);
title('Second image, k=4');
hold on;
for l=min(im2_clusters):max(im2_clusters)
    index = find(im2_clusters == l);
    if size(index,1) > 0
        scatter(index - n2* floor((index-1)/n2),floor((index-1)/n2) + 1,'d','filled');
    end
end