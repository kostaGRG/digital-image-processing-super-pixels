function outputImage = superpixelDescriptor(imIn, labels)
    [M,N,n] = size(imIn);
    outputImage = zeros(M,N,3);
    max_superpixel = max(labels,[],'all');
    colors = zeros(max_superpixel+1,n);
    counts = zeros(max_superpixel+1,1);

    
    for i=1:M
        for j=1:N
            index = labels(i,j);
            counts(index) = counts(index) + 1;
            for l=1:n
                colors(index,l) = colors(index,l) + double(imIn(i,j,l));
            end
        end
    end
    colors = colors./counts;
    
    for i=1:M
        for j=1:N
            outputImage(i,j,:) = colors(labels(i,j),:);
        end
    end

end