% ****Image2GraphUpdate****
% **Arguments**
% * superpixels: image to be converted to graph
% **Outputs**
% * myAffinityMat: the final graph, produced by the image.

function myAffinityMat = Image2GraphUpdate(superpixels,colors)
    % Initialize variables
    N = size(superpixels,1);
    d = zeros(N,N);
    
    % Find difference between the colors of each pair of superpixels
    for i=1:N
        for j=1:N
            d(i,j) = sqrt(sum((colors(i,:) - colors(j,:)).^2));          
        end
    end
    
    % Calculate the final affinity matrix
    myAffinityMat = 1./exp(d);
end