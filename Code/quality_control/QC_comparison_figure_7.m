%ONLY TO BE RUN ONCE BOTH SPECTRAL_THRESHOLDS.M AND COHERENCE_THRESHOLDS.M
%HAVE BEEN RUN 

%THIS IS A COMPARITIVE SCRIPT, NOTHING SHOULD BE CALCULATED HERE 

%COH_THRESH FOR COHERENCE 
%THRESH FOR SPECTRAL 

x_1 = min(currentspeed);
x_2 = max(currentspeed);

fc_copied = thresh;
fcc_copied = coh_thresh;

for(n = 1:size(fc_copied,1))  %NaN's for spectral fc for each channel
fc_copied(n,1:22) = NaN;
fc_copied(n,70:85) = NaN;
fc_copied(n,180:196) = NaN;
end 


for(nn = 1:size(fcc_copied,1)) %NaN's for coherence fc for each channel combination

fcc_copied(nn,1:22) = NaN;
fcc_copied(nn,54) = NaN;
fcc_copied(nn,69:82) = NaN;
fcc_copied(nn,89:96) = NaN;
fcc_copied(nn,101) = NaN;
fcc_copied(nn,107) = NaN;
fcc_copied(nn,114) = NaN;
fcc_copied(nn,116) = NaN;
fcc_copied(nn,118) = NaN;
fcc_copied(nn,120:122) = NaN;

end



fc_copied_no_nan = zeros(4,141);  %Eliminating NaN's for both fc and fcc
fcc_copied_no_nan = zeros(6,143);

fc_current = zeros(1,141); %Matching current speed with the length of fc's
fcc_current = zeros(1,143); 

for(n = 1:size(fc_copied,1))
    
fc_nan = ~isnan(fc_copied(n,:));
fc_nan_index = find(fc_nan > 0);
fc_copied_no_nan(n,:) = fc_copied(n,fc_nan_index);
fc_current = currentspeed(fc_nan_index);    
end 

for(nn = 1:size(fcc_copied,1))
    
fcc_nan = ~isnan(fcc_copied(nn,:));
fcc_nan_index = find(fcc_nan > 0);
fcc_copied_no_nan(nn,:) = fcc_copied(nn,fcc_nan_index);
fcc_current = currentspeed(fcc_nan_index);
end 

fcc_copied = fcc_copied_no_nan; %copying over collapsed results back into OG matrix
fc_copied = fc_copied_no_nan;



for(x = 1:size(fc_copied,1))

[fc_slope(x,:) , fc_int(x,:)] = polyfit(fc_current,fc_copied(x,:),1);


end

for(x = 1:size(fcc_copied,1))
    
[fcc_slope(x,:) , fcc_int(x,:)] = polyfit(fcc_current,fcc_copied(x,:),1);
    
end 


fc_mean_slope = mean(fc_slope(1:4,:),1);
fcc_mean_slope = mean(fcc_slope(1:6,:),1);

fc_std = std(fc_slope(1:4,1),1);
fcc_std = std(fcc_slope(1:6,1),1);

fc_line = fc_mean_slope(1).*fc_current + fc_mean_slope(2);
fcc_line = fcc_mean_slope(1).*fcc_current + fcc_mean_slope(2);

fc2_top_std = max(fc_line) + fc_std;
fc2_bottom_std = max(fc_line) - fc_std;

fc1_top_std = min(fc_line) + fc_std;
fc1_bottom_std = min(fc_line) - fc_std;

fcc2_top_std = max(fcc_line) + fcc_std;
fcc2_bottom_std = max(fcc_line) - fcc_std;

fcc1_top_std = min(fcc_line) + fcc_std;
fcc1_bottom_std = min(fcc_line) - fcc_std;



figure
hold on
fill([x_1,x_1,x_2,x_2],[fcc1_top_std,fcc1_bottom_std,fcc2_bottom_std,fcc2_top_std],[0.9 0.9 0.9],'LineStyle','none')
fill([x_1,x_1,x_2,x_2],[fc1_top_std,fc1_bottom_std,fc2_bottom_std,fc2_top_std],[0.9 0.9 0.9],'LineStyle','none')
fill([x_1,x_1,x_2,x_2],[a1(1,1),a1(1,2),a2(1,2),a2(1,1)],[0.9 0.9 0.9],'LineStyle','none')

fcc = plot(fcc_current,fcc_line,'LineWidth',1.5,'LineStyle','-','Color','r');
fc = plot(fc_current,fc_line,'LineWidth',1.5);
a_p1 = plot(currentspeed,a_v(1,:),'LineWidth',1.5,'LineStyle','-','Color','b');
%a_p2 = plot(currentspeed,a_v(2,:),'LineWidth',1.5);
%a_p3 = plot(currentspeed,a_v(3,:),'LineWidth',1.5);
hold off

grid on
set(gca,'ylim',[50 350])
xlabel('Current Speed [m/s]')
ylabel('Frequency [Hz]') 
legend([fcc,fc,a_p1],{'$f^\prime_c$','$f_c$ Hydrophone','$f_c$ Array'},'Location','northwest','Interpreter','latex')

label1 = text(1.5,300,'I. Ambient noise','Interpreter','latex')
label1.FontSize=14;
label2 = text(1,150,'II. Mix of ambient and flow noise','Interpreter','latex')
label2.FontSize=14;
label4 = text(1.5,60,'III. Flow noise','Interpreter','latex')
label4.FontSize=14;