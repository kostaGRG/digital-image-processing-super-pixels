mex slicmex.c
clear
close all
clc

rng(1);

%% SLIC
image = imread('bee.jpg');
[M,N,~] = size(image);
[labels, ~] = slicmex(image, 400, 20);
labels = labels+1;
max_superpixel = max(labels,[],'all');

%% SUPERPIXEL DESCRIPTOR AND AFFINITY MATRIX

% Matlab plot function can't offer 10 different colors, so i created my own
% list with 10 different colors to use on plotting.
color_codes=[
    [0 0.4470 0.7410]
    [0.8500 0.3250 0.0980]
    [0.9290 0.6940 0.1250]
    [0.4940 0.1840 0.5560]
    [0.4660 0.6740 0.1880]
    [0.3010 0.7450 0.9330]
    [0.6350 0.0780 0.1840]
    [0 1 0]
    [1 1 0]
    [0 0 0]];

superpixels = zeros(max_superpixel,2);
colors = zeros(max_superpixel,size(image,3));
outputImage = superpixelDescriptor(image,labels);

% We will find now a representive pixel for each superpixel
% We use the median to find a suitable pixel

for k=1:max_superpixel
    count = 0;
    diff_i = [];
    diff_j = [];
    for i=1:size(labels,1)
        for j=1:size(labels,2)
            if labels(i,j) == k
                count = count + 1;
                diff_i(count) = i;
                diff_j(count) = j;
            end
        end
    end

    superpixels(k,:) = [floor(median(diff_i)),floor(median(diff_j))];
    colors(k,:) = outputImage(superpixels(k,1),superpixels(k,2),:);
end

figure(1);
subplot(1,2,1);
imshow(image);
title('Official image');
subplot(1,2,2);
imshow(outputImage./255);
title('Image after SLIC');

affinityMat = Image2GraphUpdate(superpixels,colors);

%% K=6, NON RECURSIVE N-CUT
k = 6;
clusters = myGraphSpectralClustering(affinityMat,k);

figure(2);
subplot(1,2,1);
imshow(image);
title('Image non-recursive ncut, k=6');
hold on;

for l=min(clusters):max(clusters)
    index = find(clusters == l);
    if(~isempty(index))
        sec_index = zeros(M,N);
        for i=1:length(index)
            sec_index = sec_index + (labels == index(i));
        end
        [rows,cols] = find(sec_index > 0);
        scatter(cols,rows,'filled');
    end
end


%% K=6, RECURSIVE N-CUT
T1 = 5;
T2 = 0.1;

clusters = recursiveNcut(affinityMat,T1,T2);

subplot(1,2,2);
imshow(image);
title('Image recursive ncut, k=6');
hold on;
string_list = unique(clusters);
for l=1:length(string_list)
    index = find(clusters == string_list(l));
    if(~isempty(index))
        sec_index = zeros(M,N);
        for i=1:length(index)
            sec_index = sec_index + (labels == index(i));
        end
        [rows,cols] = find(sec_index > 0);
        scatter(cols,rows,'filled');
    end
end

fprintf("T1,T2,K=%d %f %d\n",T1,T2,length(string_list));

% This section of code were used to find out which parameters to use in
% order to get the number of clusters we wish.

% T2 = 0.1;
% for T1 = [2,3,4,5,6]
%     clusters = recursiveNcut(affinityMat,T1,T2);
%     string_list = unique(clusters);
%     fprintf("T1,T2,K=%d %f %d\n",T1,T2,length(string_list));
% %         if length(string_list) == 10 || length(string_list) == 6
% %             pause;
%     disp(T1);
%     disp(length(string_list));
% end

%% K=10, NON RECURSIVE N-CUT
k = 10;
clusters = myGraphSpectralClustering(affinityMat,k);

figure(3);
subplot(1,2,1);
imshow(image);
title('Image non-recursive ncut, k=10');
hold on;

for l=min(clusters):max(clusters)
    index = find(clusters == l);
    if(~isempty(index))
        sec_index = zeros(M,N);
        for i=1:length(index)
            sec_index = sec_index + (labels == index(i));
        end
        [rows,cols] = find(sec_index > 0);
        counter = l-min(clusters)+1;
        scatter(cols,rows,'MarkerEdgeColor',color_codes(counter,:),'MarkerFaceColor',color_codes(counter,:));
    end
end

%% K=10, RECURSIVE N-CUT
T1 = 3;
T2 = 0.1;

clusters = recursiveNcut(affinityMat,T1,T2);
string_list = unique(clusters);

subplot(1,2,2);
imshow(image);
title('Image recursive ncut, k=10');
hold on;

for l=1:length(string_list)
    superpixel = find(clusters == string_list(l));
    if(~isempty(superpixel))
        index = zeros(M,N);
        for i=1:length(superpixel)
            index = index + (labels == superpixel(i));
        end
        [rows,cols] = find(index > 0);

        scatter(cols,rows,'MarkerEdgeColor',color_codes(l,:),'MarkerFaceColor',color_codes(l,:));
    end
end

fprintf("T1,T2,K=%d %f %d\n",T1,T2,length(string_list));
