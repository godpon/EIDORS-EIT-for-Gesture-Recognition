train_data_array = train_data{:,2:65};
test_data_array = test_data{:,2:65};
total_data_array = total_data{:,2:65};

train_data_targets = zeros(length(train_data_array),5);
test_data_targets = zeros(length(test_data_array),5);
total_data_targets = zeros(length(total_data_array),5);

for i = 1:length(train_data_array)
    for j = 1:length(Labels)
        if (train_data.Label(i) == Labels(j))
            train_data_targets(i,j) = 1;
        end
    end
end


for i = 1:length(test_data_array)
    for j = 1:length(Labels)
        if (test_data.Label(i) == Labels(j))
            test_data_targets(i,j) = 1;
        end
    end
end

for i = 1:length(total_data_array)
    for j = 1:length(Labels)
        if (total_data.Label(i) == Labels(j))
            total_data_targets(i,j) = 1;
        end
    end
end

%% Clear Temporary Variables:
vars = {'i','j'};
clear(vars{:});
clear vars;
