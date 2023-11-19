% ****Image2Graph****
% **Arguments**
% * imIn: image to be converted to graph
% **Outputs**
% * myAffinityMat: the final graph, produced by the image.

function myAffinityMat = Image2Graph(imIn)
     % Initialize variables
    [M,N,~] = size(imIn);
    d = zeros(M*N,M*N);
    total_pixels = size(d,1);

    % for every pixel, find its difference in rgb values with every other
    % pixel and store them to array d
    for i=1:total_pixels
        % get coordinates of the pixel in the image
        m1 = floor((i-1)/N) + 1;
        n1 = i - N* floor((i-1)/N);
        
        disp(i)
        
        for j=1:total_pixels
            m2 = floor((j-1)/N) + 1;
            n2 = j - N* floor((j-1)/N);
            d(i,j) = sqrt(sum((imIn(m1,n1,:) - imIn(m2,n2,:)).^2));
        end
    end
    
    % calculate the final matrix
    myAffinityMat = 1./exp(d);
end