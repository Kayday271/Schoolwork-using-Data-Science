A = readtable('Customers_clustering.csv', 'PreserveVariableNames',true);
A = A(:,2:5);
[N,d] = size(A);
  
G_vec = [];
for i = 1:N
    c = A(i,1);
    if strcmp(c{1,1}{1},'Male')
        G_vec = [G_vec 0];
    else
        G_vec = [G_vec 1];
    end
end
G_vec = G_vec';
A = A(:,2:4);
A = table2array(A);
A = [G_vec A];

A_norm = A;

for i = 1:4
    mean_i = mean(A_norm(:,i));
    s_i = std(A_norm(:,i));
    for j = 1:N
        A_norm(j,i) = (A_norm(j,i) - mean_i)/s_i;
    end
end


train_ind = randperm(160);

A_norm_train = [];
A_norm_test = [];
for i = 1:200
    if any(train_ind(:) == i)
        A_norm_train = [A_norm_train; A_norm(i,:)];
    else
        A_norm_test = [A_norm_test; A_norm(i,:)];
    end
end

cost_train = [];
ind_train = [];
for i = 1:40
    stats = [];
    for j = 1:20
        [J, mu_s] = k_cost(A_norm_train,i);
        stats = [stats; J];
    end
    cost_train = [cost_train min(stats)];
    ind_train = [ind_train i];
end

figure(1)
plot(A(:,3), A(:,4), 'b+')
xlabel('Annual Income')
ylabel('Spending Score')
grid


figure(2)
plot(ind,cost_train)
xlabel('k')
ylabel('Cost (train)')
grid


[J_final_train, mu_final] = k_cost(A_norm, 5);
disp('Final training cost:');
disp(J_final_train);

J_test = k_cost_test(A_norm_test, mu_final);
disp('Final test cost:');
disp(J_test);

for i = 1:5
    for j = 1:4
        mu_final(j,i)= mu_final(j,i)*std(A(:,j))+ mean(A(:,j));
    end
end

disp('Centroids:');
disp(mu_final);



        

