function [segmentation, centers] = kmeans_segm(image, K, L, seed)

    img = double(imresize(image,1)); 
    dim = ndims(img);

    if dim == 3
        [imgx, imgy, dummy] = size(img);
        im_new = reshape(img, imgx * imgy, 3);
    else
        [imgx, dummy] = size(img);
        imgy = 1;
        im_new = img;
    end

    % Randomly initialize the K cluster centers    
    cluster_centroid = zeros([K,3]);
    k_min = ones(imgx * imgy , 1);
    
    x = randi(imgx, [K,1]);
    y = randi(imgy, [K,1]);
    
    for i = 1:K
        cluster_centroid(i,1) = img(x(i),y(i),1); 
        cluster_centroid(i,2) = img(x(i),y(i),2);
        cluster_centroid(i,3) = img(x(i),y(i),3);
    end
    
    % Iterate L times
    for i = 1:L
        % Compute all distances between pixels and cluster centers    
        dist = pdist2(im_new , cluster_centroid);
        
        % Assign each pixel to the cluster center for which the distance is minimum
        Vtemp = double(zeros(K, 3));
        count = double(zeros(K, 1));
        
        for z = 1 : imgx * imgy
            min_dist = dist(z);
            for j = 2 : K
                if (dist(z,j) < min_dist)
                    min_dist = dist(z,j);
                    k_min(z) = j;
                    count(j) = count(j) + 1;
                    Vtemp(j,:) = Vtemp(j,:) + im_new(z,:);
                else
                    count(1) = count(1) + 1;                    
                    Vtemp(1,:) = Vtemp(1,:) + im_new(z,:);
                end
            end
        end
        
        % Recompute each cluster center by taking the mean of all pixels assigned to it
        cluster_centroid(:, 1) = Vtemp(:, 1) ./ count(:);
        cluster_centroid(:, 2) = Vtemp(:, 2) ./ count(:);
        cluster_centroid(:, 3) = Vtemp(:, 3) ./ count(:);
    end
    
    segmentation = uint8(reshape(k_min, imgx, imgy, 1));
    centers = cluster_centroid;
end
