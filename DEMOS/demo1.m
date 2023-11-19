clear
close all
clc

rng(1);
%% LOAD DATA
data = load('dip_hw_2.mat');
d1a = data.d1a;

%% GET LABELS FOR DIFFERENT NUMBER OF CLUSTERS
index = zeros(size(d1a,1),3);
for k=1:3
    index(:,k) = myGraphSpectralClustering(d1a,k+1);
end

%% PRINT RESULTS
fprintf('<strong>    k=%d   k=%d   k=%d</strong>\n\n',2,3,4);
for i=1:size(index,1)
    disp(index(i,:))
end
