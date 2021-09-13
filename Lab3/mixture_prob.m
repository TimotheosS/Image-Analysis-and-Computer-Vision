function [prob] = mixture_prob(image,K,L,mask)

[nrows,ncolumns,dummy] = size(image);

% Store all pixels for which mask = 1 in a Nx3 matrix
Pvec = im2double(reshape(image,[nrows * ncolumns,3]));
Gvec = reshape(mask,[nrows * ncolumns, 1]);

Pones= Pvec(find(Gvec == 1), :);
g = zeros(size(Pones, 1), K);
g1 = zeros(nrows * ncolumns, K);
w = zeros(1, K);

% Randomly initialize the K components using masked pixels
seed = 4000;
[segmentation, centers] = kmeans_mix(Pones, K, L, seed);

cov = cell(K, 1);
cov(:) = {rand * eye(3)};

for i = 1 : K
    w(i) = sum(segmentation == i) / size(segmentation, 1);
end
% Iterate L times
for i = 1:L
% Expectation: Compute probabilities P_ik using masked pixels
    for k = 1 : K
        mean_value = centers(k, :);
        cov_k = cov{k};
        diff = bsxfun(@minus, Pones, mean_value);
        g(:, k) = 1 / sqrt(det(cov_k) * (2 * pi)^3) * exp(-0.5 * sum((diff * inv(cov_k) .* diff), 2));
    end
    
    p = bsxfun(@times, g, w);
    norm = sum(p, 2);
    p = bsxfun(@rdivide, p, norm);
    
% Maximization: Update weights, means and covariances using masked pixels
    w = sum(p, 1) / size(p, 1);
    for k = 1 : K
        tot = sum(p(:, k), 1);
        centers(k, :) = p(:, k)' * Pones / tot;
        diff = bsxfun(@minus, Pones, centers(k, :));
        cov{k} = (diff' * bsxfun(@times, diff, p(:, k))) / tot;
    end
end

% Compute probabilities p(c_i) in Eq.(3) for all pixels I
for k = 1 : K
    mean_k = centers(k, :);
    cov_k = cov{k};
    diff = bsxfun(@minus, Pvec, mean_k);
    g1(:, k) = 1 / sqrt(det(cov_k) * (2 * pi)^3) * exp(-1/2 * sum((diff * inv(cov_k) .* diff), 2));
end

prob_pre = sum(bsxfun(@times, g1, w), 2);
prob = reshape(prob_pre, nrows, ncolumns, 1);

end