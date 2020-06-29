
%% Renaming variables:

num_of_electrodes = 8;
% w = width(Fist);
w = 1 + num_of_electrodes^2;

varnames = strings(8);
numnames = ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight"];

for i = 1:num_of_electrodes
    for j = 1:num_of_electrodes
        varnames(i,j) = numnames(i) + '_to_' + numnames(j);
    end
end

Tables = {Down Fist Left Right Up};
Labels = categorical({'Down', 'Fist', 'Left', 'Right', 'Up'});

for t = 1:5
    Tables{t}.Properties.VariableNames{1} = 'Time';
    Tables{t}.Label(:) = Labels(t);
    h(t) = height(Tables{t});
    for c = 1:(w-1)
        i = ceil(c/8);
        j = c - 8*(i-1);
        % Tables{t}.Properties.VariableNames{c} = char("Var_" + c);
        Tables{t}.Properties.VariableNames{c+1} = char(varnames(i,j));
    end
end

%% 

init_shift = 15;
h_min = min(h);

% Percentage of data to test the models
test_percentage = 20; % for 100 test samples, set test_percentage = 23.2 
test_bin_size = round(h_min * test_percentage / 100);

% test_bin_start = 274;
% % test_bin_start = ceil(300*rand()) + init_shift;
% test_index = test_bin_start + [1:test_bin_size];
% train_index = [(init_shift+1):(test_index(1)-1) (test_index(end)+1):(h_min-init_shift)];
test_index = randperm(h_min,test_bin_size);
test_index = sort(test_index);
train_index = 1:h_min;
train_index = setdiff(train_index, test_index);

test_data = cell2table(cell(0,width(Tables{t})));
test_data.Properties.VariableNames = Tables{t}.Properties.VariableNames;
train_data = test_data;
total_data = test_data;

for t = 1:5
    test_data = [test_data; Tables{t}(test_index,:)];
    train_data = [train_data; Tables{t}(train_index,:)];
    total_data = [total_data; Tables{t}];
end

%% Clear Temporary Variables:
vars = {'w','h','c','i','j','t','varnames','numnames','init_shift','test_percentage'};
clear(vars{:});
clear vars;
