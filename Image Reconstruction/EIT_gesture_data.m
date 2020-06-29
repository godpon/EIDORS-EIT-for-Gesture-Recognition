

%% EIT Image reconstruction:
% Uncomment the following line and run the EIDORS setup if not initiated previously
% run C:\Users\godpo\Downloads\Software\eidors-v3.10\eidors\startup.m
% run C:\Users\e0408045\Downloads\Software\eidors-v3.10\eidors\startup.m

image_index = 0:5:h_min;
image_index(1) = 1;
span = 500;

n_rings = 12;
n_electrodes = 8;
elec_pairs = 2:65;
three_d_layers = []; % no 3D
fmdl = mk_circ_tank( n_rings , three_d_layers, n_electrodes);
% then assign the fields in fmdl to imdl.fwd_model
options = {'no_meas_current','no_rotate_meas'};
[stim, meas_select] = mk_stim_patterns(8,1,'{ad}','{ad}',options,1);
imdl= mk_common_model('b2c2',n_electrodes);
imdl.fwd_model.stimulation = stim;
imdl.fwd_model.meas_select = meas_select;
data_objs = zeros(length(image_index),length(elec_pairs),5);
data_homg = ones(length(elec_pairs),5);

for i = 1:5
    data_homg(:,i) = mean(Tables{i}{1:311,elec_pairs});
    for j = 1:length(image_index)
        start_index = round(image_index(j) - span/2);
        stop_index = round(image_index(j) + span/2);
        if start_index < 1
            start_index = 1;
        end
        if stop_index > h_min
            stop_index = h_min;
        end
        
        local_index =  start_index : stop_index;
        data_objs(j,:,i) = mean(Tables{i}{local_index,elec_pairs});
        %     data_homg(:,i) = mean(data_objs(:,:,i));
        img(i,j) = inv_solve(imdl, data_homg(:,i), data_objs(j,:,i)');
    end
end

% data_homg =Up_h; % from your file
% data_objs =Up;   % from your file
% img = inv_solve(imdl, data_homg, data_objs);
%%

plot_order = [8, 5, 4, 6, 2];
figure(1)
% hold on;
for j = 1:length(image_index)
    for i = 1:5
        subplot(3,3,plot_order(i))
        show_slices(img(i,j));
        title(Tables{i}.Label(10),'FontSize',14);
        colormap('jet');
%         colorbar
    end
    timedisplay = Tables{i}.Time(image_index(j)) + "s";
    text(120,203,"Time:",...
        'HorizontalAlignment','center','FontSize',14);
    text(120,215,string(timedisplay),...
        'HorizontalAlignment','center','FontSize',14);
    pause(0.000005);
end
% hold off;
    
