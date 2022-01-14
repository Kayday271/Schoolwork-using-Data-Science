function J = k_cost_test(X,means)
    
    [N,d] = size(X);

    delta = zeros(N,d);
    J_mat = zeros(N,d);
    [d,k] = size(means);
    
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
    end
       
J = sum(J_mat,'all');

end