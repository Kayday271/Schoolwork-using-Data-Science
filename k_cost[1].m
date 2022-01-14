function [J, means] = k_cost(X,k)
    
[N,d] = size(X);
p = randperm(k);
means = [];
for i = 1:k
    means = [means X(p(i),:)'];
end

for m = 1:5
    delta = zeros(N,k);
    J_mat = zeros(N,k);
    cells = cell(1,k);
    
    for i = 1:N
        x_i = X(i,:);
        c = 10^6;
        for j = 1:k
             mean_k = means(:,j)';
             dist_sq = norm(x_i - mean_k)^2;
            if dist_sq < c
                c = dist_sq;
                k_j = j;
            end
        end
        delta(i,k_j) = 1;
        J_mat(i,k_j) = c*delta(i,k_j);  
        cells{k_j} = [cells{k_j} x_i'];
    end
       
    for i = 1:k
        mat = cells{i}';
        [a,b] = size(mat);
        mu_i = sum(mat)/a;
        means(:,i) = mu_i';
    end
end

J = sum(J_mat,'all');

end

