xtips = 1:5;
ytips = 1:5;
Label_letters = categorical({'Dn', 'Ft', 'Lt', 'Rt', 'Up'});
% figure(6)
% for k = 1:7
%     curr = confusion_mats(:,:,plot_order(k));
%     row_summary = round(diag(curr)./sum(curr,2) *100,1);
%     row_summary = [row_summary (100 - row_summary)];
%     colorset = 'gray';
%     remap_range = [206 50];
%     temp1 = remap(curr,[0 test_bin_size],remap_range);
%     temp2 = remap(row_summary,[0 100],remap_range);
%     blank = 0.79*remap_range(1)*ones(5,8);
% 
%     subplot(3,3,k)
%     x = [1 ; 7];
%     y = [1 ; 1];
%     image(x(1,:),y(1,:),blank);
%     hold on;
%     image(x(1,:),y(1,:),temp1');
%     image(x(2,:),y(2,:),temp2);
%     hold off;
%     colormap(colorset)
% %     colorbar;
%     set(gca,'XTick', [1:5 7.5]', 'XTickLabel', [Labels(1:5) "Percentage"]);
%     set(gca,'YTick', [1:5]', 'YTickLabel', Labels(1:5));
%     title(Titles(plot_order(k)));
%     xlabel('Predicted Class');
%     ylabel('True Class');
%     for i = 1:5
%         for j = 1:5
%             if temp1(j,i)>mean(remap_range); text_color = [0 0 0];
%             else text_color = [1 1 1]; end
%             text(i,j,string(curr(j,i)),'HorizontalAlignment','center','Color',text_color);
%         end
%         for j = 6:7
%             if temp2(i,j-5)>mean(remap_range); text_color = [0 0 0];
%             else text_color = [1 1 1]; end
%             text(j+1,i,string(row_summary(i,j-5)),'HorizontalAlignment','center','Color',text_color);
%         end
%     end
% end

figure(7)
for k = 1:7
    curr = confusion_mats(:,:,plot_order(k));
    row_summary = round(diag(curr)./sum(curr,2) *100,1);
    row_summary = [row_summary (100 - row_summary)];
    colorset = 'bone';
    remap_range = [256 1];
    temp1 = remap(curr,[0 test_bin_size],remap_range);
    temp2 = remap(row_summary,[0 100],remap_range);
    blank = 0.99*remap_range(1)*ones(5,8);

    h1 = subplot(3,9,[3*k - 2, 3*k - 1]);
    h1_pos = get(h1,'Position'); %get the position data for sublot1.
    image(temp1);
    colormap(colorset)
    set(gca,'XTick', [1:5]', 'XTickLabel', Label_letters(1:5));
    set(gca,'YTick', [1:5]', 'YTickLabel', Label_letters(1:5));
    title(Titles(plot_order(k)) + " (Acc: " + round(Avg_Accuracy(k),1) + "%)");
        
    xlabel("Predicted Class" +newline+"  ");
    ylabel("  "+newline+"True Class");
    for i = 1:5
        for j = 1:5
            if curr(j,i)~= 0
                if temp1(j,i)>mean(remap_range); text_color = [0 0 0];
                else text_color = [1 1 1]; end
                text(i,j,string(curr(j,i)),'HorizontalAlignment','center','Color',text_color);
            end
        end
    end
%     set(h1,'Position',[h1_pos(1) - 0.02 h1_pos(2:end)]);
    
    h2 = subplot(3,9,3*k);
    h2_pos = get(h2,'Position'); %get the position data for sublot2.
    image(temp2);
    colormap(colorset)
    xlabel('Percentage');
    set(gca,'YTick', [], 'YTickLabel', []);
    set(gca,'XTick', [1 2], 'XTickLabel', ["TP", "FP"]);
    for i = 1:5
        for j = 1:2
            if temp2(i,j)>mean(remap_range); text_color = [0 0 0];
            else text_color = [1 1 1]; end
            text(j,i,string(row_summary(i,j)),'HorizontalAlignment','center','Color',text_color);
        end
    end
    % Position is a four-element vector of the form [left bottom width height]
    set(h2,'Position',[h1_pos(1)+0.162 h1_pos(2) 0.75*h2_pos(3) h2_pos(end)]);
end
% colorbar;

h3 = subplot(3,9,3*k+1);
h3_pos = get(h3,'Position'); %get the position data for colormap subplot.
set(h3,'Position',[h3_pos(1)-0.03 h3_pos(2) 0.25*h3_pos(3) 0.99*h3_pos(end)]);
cStart = remap_range(1);
cStop = remap_range(2);
% steps = 50; % (cStop - cStart)/4;
% color_range = [min(remap_range):steps:max(remap_range) - 1];
% color_range = [color_range max(remap_range)];
color_rr = [min(remap_range),mean(remap_range),max(remap_range)];
color_range = [0.01 0.5 1]*range(remap_range);
color_ticks = string(round(remap(color_rr,remap_range,[0 test_bin_size])));

image([min(remap_range):max(remap_range)]');
set(gca,'XTick', [], 'XTickLabel', []);
set(gca,'YTick', color_range, 'YTickLabel', color_ticks);
h3.YAxisLocation = 'right';
if(remap_range(1)<remap_range(2))
    h3.YDir = 'normal';
else
    h3.YDir = 'reverse';
end