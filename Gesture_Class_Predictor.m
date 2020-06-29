init_vars = {'gPred','cPred','wPred','test_range'};
clear(init_vars{:});
clear init_vars;
%% List models & predict classes:

num_of_models = 7;
Model_names = {'Medium Tree', 'Linear Discriminant', 'Naive Bayes', 'Quadratic SVM',...
    'Medium Gaussian SVM', 'Cosine KNN', 'Subspace Discriminant Ensemble'};

gPred(:,1) = trainedModel1.predictFcn(test_data);
gPred(:,2) = trainedModel2.predictFcn(test_data);
gPred(:,3) = trainedModel3.predictFcn(test_data);
gPred(:,4) = trainedModel4.predictFcn(test_data);
gPred(:,5) = trainedModel5.predictFcn(test_data);
gPred(:,6) = trainedModel6.predictFcn(test_data);
gPred(:,7) = trainedModel7.predictFcn(test_data);
% gPred(:,8) = trainedModel8.predictFcn(test_data);
% gPred(:,9) = trainedModel9.predictFcn(test_data);
% gPred(:,10) = trainedModel10.predictFcn(test_data);
% gPred(:,11) = trainedModel11.predictFcn(test_data);
% gPred(:,12) = trainedModel12.predictFcn(test_data);
% gPred(:,13) = trainedModel13.predictFcn(test_data);
% gPred(:,14) = trainedModel14.predictFcn(test_data);
% gPred(:,15) = trainedModel15.predictFcn(test_data);
% gPred(:,16) = trainedModel16.predictFcn(test_data);
% gPred(:,17) = trainedModel17.predictFcn(test_data);
% gPred(:,18) = trainedModel18.predictFcn(test_data);
% gPred(:,19) = trainedModel19.predictFcn(test_data);
% gPred(:,20) = trainedModel20.predictFcn(test_data);

cPred = gPred;
wPred = gPred;

%% Estimate prediction accuracy:

for j = 1:num_of_models
    correctPredictions(:,j) = (gPred(:,j) == test_data.Label);
    for i = 1:length(gPred)
        if gPred(i,j) == test_data.Label(i)
            wPred(i,j) = '';
        else
            cPred(i,j) = '';
        end
    end
end

for j = 1:num_of_models
    for i = 1:5
        test_range = test_bin_size*(i-1) + (1:test_bin_size);
        Accuracy(i,j) = 100*sum(correctPredictions(test_range,j))./length(correctPredictions(test_range,j));
        xtips(i) = (test_range(1) + test_range(end))/2;
        label_levels(i,j) = " " + string(round(Accuracy(i,j),2)) + "% ";
    end
end
    
[Avg_Accuracy, plot_order] = sortrows(mean(Accuracy)', 'descend');

%% Plot Prediction Accuracy:
num_of_figs = ceil(num_of_models/4);
% a = 2; b = 2;
a = ceil(sqrt(num_of_models));
b = round(sqrt(num_of_models));

Titles = string(Model_names); %["with PCA", "without PCA"];
Labels = categorical({'Down', 'Fist', 'Left', 'Right', 'Up'});
yaxis_order = {'Up', 'Right', 'Left', 'Fist', 'Down'};

Labels = reordercats(Labels,yaxis_order);
test_data_Label = reordercats(test_data.Label,yaxis_order);
cPred = reordercats(cPred,yaxis_order);
wPred = reordercats(wPred,yaxis_order);

confusion_mats = zeros(5,5,num_of_models);

for k = 1:num_of_figs
    figure(k +1);
%     mtit('Confusion Matrices','fontsize',14,'color',[0 0 0],'xoff',0,'yoff',0.04);
    for j = (4*k - 3):4*k
        if j > num_of_models
            break;
        end
        jj = mod(j,4);
        if jj==0
            jj=4;
        end
        subplot(2,2,jj)
        confusion_mats(:,:,plot_order(j)) = confusionmat(test_data.Label,gPred(:,plot_order(j)));
        confusion_chart = confusionchart(test_data.Label,gPred(:,plot_order(j)));
        confusion_chart.Title = Titles(plot_order(j)) + " (Accuracy = " + round(Avg_Accuracy(j),2) + "%)";
        confusion_chart.RowSummary = 'row-normalized';
%         confusion_chart.ColumnSummary = 'column-normalized';        
    end
    sgtitle('Confusion Matrices','fontsize',14,'color',[0 0 0]);
end

% for k = 1:num_of_figs
%     figure(num_of_figs + k);
%     for j = (4*k - 3):4*k
%         if j > num_of_models
%             break;
%         end
%         jj = mod(j,4);
%         if jj==0
%             jj=4;
%         end
%         subplot(2,2,jj)
%         plot(test_data_Label,'k:');
%         hold on;
%         plot(cPred(:,j),'b.','MarkerSize',9);
%         plot(wPred(:,j),'rx','MarkerSize',6);
%         hold off
%         ytips = double(Labels) + 0.1;
%         text(xtips,ytips,label_levels(:,j),'HorizontalAlignment','center',...
%             'VerticalAlignment','bottom','color',[0 0 0]);
%         title(Titles(j));
%         xlabel('Samples');
%         ylabel('Labels','FontSize',10);
% %        legend({'Actual Class','Correct prediction','Wrong prediction'},'location','northeast','FontSize',8);
%     end
%     bigtitle{num_of_figs + k} = mtit('Prediction Accuracies','fontsize',14,'color',[0 0 0],'xoff',0,'yoff',0.04);
% end


%% Clear Temporary Variables:
vars = {'a','b','i','j','jj','k','correctPredictions','xtips'};
clear(vars{:});
clear vars;
