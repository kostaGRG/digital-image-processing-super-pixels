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
%% CREATE AFFINITY MATRICES

aff_image1 = Image2Graph(d2a);
aff_image2 = Image2Graph(d2b);

%% FIRST EXPERIMENT: FIRST IMAGE WITH NON RECURSIVE N-CUT, K=3
k = 3;
clusters = myGraphSpectralClustering(aff_image1, k);
nCutValue1 = calculateNcut(aff_image1,clusters);
fprintf("For the first image and k=3, ncut= %f\n",nCutValue1);

figure(1);
subplot(1,2,1);
imshow(d2a);
title('First image, k=3, non recursive N-Cut');
hold on;
for l=min(clusters):max(clusters)
    index = find(clusters == l);
    if numel(index) > 0
        scatter(index - n1* floor((index-1)/n1),floor((index-1)/n1) + 1,'d','filled');
    end
end

%% SECOND EXPERIMENT: FIRST IMAGE WITH RECURSIVE N-CUT
T1 = 5;
T2 = 0.6;
clusters = recursiveNcut(aff_image1,T1,T2);

subplot(1,2,2);
imshow(d2a);
title('First image, recursive N-Cut');
unique_list = unique(clusters);
hold on;
for l=1:length(unique_list)
    index = find(clusters == unique_list(l));
    if numel(index) > 0
        scatter(index - n1* floor((index-1)/n1),floor((index-1)/n1) + 1,'d','filled');
    end
end

%% THIRD EXPERIMENT: SECOND IMAGE WITH NON RECURSIVE N-CUT, K=3
k = 3;
clusters = myGraphSpectralClustering(aff_image2, k);
nCutValue2 = calculateNcut(aff_image2,clusters);
fprintf("For the second image and k=3, ncut= %f\n",nCutValue2);

figure(2);
subplot(1,2,1);
imshow(d2b);
title('Second image, k=3, non recursive N-Cut');
hold on;
for l=min(clusters):max(clusters)
    index = find(clusters == l);
    if numel(index) > 0
        scatter(index - n1* floor((index-1)/n1),floor((index-1)/n1) + 1,'d','filled');
    end
end

%% FOURTH EXPERIMENT: SECOND IMAGE WITH RECURSIVE N-CUT
T1 = 5;
T2 = 0.6;
clusters = recursiveNcut(aff_image2,T1,T2);

subplot(1,2,2);
imshow(d2b);
title('Second image, recursive N-Cut');
unique_list = unique(clusters);
hold on;
for l=1:length(unique_list)
    index = find(clusters == unique_list(l));
    if numel(index) > 0
        scatter(index - n2* floor((index-1)/n2),floor((index-1)/n2) + 1,'d','filled');
    end
end

