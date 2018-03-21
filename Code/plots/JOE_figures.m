%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FIGURE STYLE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%currentspeed = new_currentspeed - min(new_currentspeed);
%currentspeed(1:161) = -currentspeed(1:161);

%currentspeed = new_currentspeed;
cd('F:\Matt_Auvinen_Files\Journal\current\IEEEtran_current\figures')


set(0,'DefaultTextFontName','Times',...
'DefaultTextFontSize',16,...
'DefaultAxesFontName','Times',...
'DefaultAxesFontSize',16,...
'DefaultLineLineWidth',1,...
'DefaultLineMarkerSize',7.75)


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FIGURE 1 - SPECTROGRAM & WEBTIDE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

g = figure%('units','normalized','position',[0 0 .4 3])
p = get(g,'position');
p(4) = p(4)*2.3; % Add 10 percent to height
set(g, 'position', p);

subplot(2,1,1)
hold on 
pcolor((Tabs-Tabs(1))/60,f,p0);shading flat;
set(gca,'ylim',[0 20000])
set(gca,'xlim',[0 235])
xlabel('Time after deployment [min]')
ylabel('Frequency [Hz]')
set(gca,'yscale','log')
c = colorbar
ylabel(c,'[dB re \muPa^2/Hz]')
grid on; 

text(3,4000,'E1','Color','white')
text(89,1000,'E2','Color','white')
text(118,6500,'E3','Color','white')
text(130,6500,'E4','Color','white')
text(173,6500,'E5','Color','white')
text(218,420,'E6','Color','white')

x_1_arrow = [0.393 0.393];
y_1_arrow = [0.8 0.76];

x_2_arrow = [0.15 0.15];
y_2_arrow = [0.85 0.81];

x_3_arrow = [0.475 0.475];
y_3_arrow = [0.87 0.83];

x_4_arrow = [0.502 0.502];
y_4_arrow = [0.87 0.83];

x_5_arrow = [0.625 0.625];
y_5_arrow = [0.87 0.83];

x_6_arrow = [0.75 0.75];
y_6_arrow = [0.77 0.73];


annotation('arrow',x_1_arrow,y_1_arrow,'Color','white')
annotation('arrow',x_2_arrow,y_2_arrow,'Color','white')
annotation('arrow',x_3_arrow,y_3_arrow,'Color','white')
annotation('arrow',x_4_arrow,y_4_arrow,'Color','white')
annotation('arrow',x_5_arrow,y_5_arrow,'Color','white')
annotation('arrow',x_6_arrow,y_6_arrow,'Color','white')


t = title('a)')
set(t, 'horizontalAlignment', 'right')
set(t, 'units', 'normalized')
h1 = get(t, 'position')
set(t, 'position', [0 h1(2)+0.05 h1(3)])
hold off
g2 = subplot(2,1,2)
p2=get(g2,'Position')
p2(3) = p2(3)*0.8505
set(g2,'Position',p2)

plot(time,speed1,'LineWidth',2);
xlabel('Time after deployment [min]');
ylabel('Current Speed [m/s]');
set(gca,'xlim',[0 235]);
set(gca,'ylim',[-speedamp speedamp]);
hline=refline(0,0);
hline.Color='k';
set(hline,'LineStyle','--')
grid on;

t = title('b)')
set(t, 'horizontalAlignment', 'right')
set(t, 'units', 'normalized')
h1 = get(t, 'position')
set(t, 'position', [0 h1(2)+0.05 h1(3)])

print('-depsc2','-r600','figure1.eps') % Print to file
close all


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FIGURE 2 - HISTOGRAM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

input1 = 30 %Input time in minutes
power0 = upsilon0; % Generating power matrices in correct dimensions
power1 = upsilon1;
power2 = upsilon2;
power3 = upsilon3;

zesty=((Tabs-Tabs(1))/60); %Finding index of input1
zesty=round(zesty,0);
t=find(zesty==input1);

t1=find(zesty==140); %Indexing other times 
t2=find(zesty==220);
t3=find(zesty==10);
freqline1 = -17*log10(f(2:8))+168; %Reference lines
freqline2 = -40*log10(f(28:70))+200;


m = pcolor(f,yaxis0,test0);shading flat;
        set(gca,'xlim',[0 1000])
        set(gca,'ylim',[50 170])
        set(m,'facealpha',0.7)
        ylabel('[dB re \muPa^2/Hz]')
        xlabel('Frequency [Hz]')
        set(gca,'xscale','log')
        grid minor
    
    
        hold on 

 m1 =   plot(f,power0(t3,:),'Color','r','LineWidth',3);
        set(gca,'xlim',[0 1000]);
        xlabel('Frequency [Hz]')
        ylabel('Power [dB re \muPa^2/Hz]')
        set(gca,'xscale','log')
        
        
 m2 =   plot(f,power0(t,:),'Color','k','LineWidth',3);
        set(gca,'xlim',[0 1000]);
        xlabel('Frequency [Hz]')
        ylabel('Power [dB re \muPa^2/Hz]')
        set(gca,'xscale','log')
        
        
m3 =    plot(f,power0(t1,:),'Color','g','LineWidth',3);
        set(gca,'xlim',[0 1000]);
        xlabel('Frequency [Hz]')
        ylabel('Power [dB re \muPa^2/Hz]')
        set(gca,'xscale','log')
        
        
        
 m4 =   plot(f,power0(t2,:),'Color','m','LineWidth',3);
        set(gca,'xlim',[0 1000]);
        xlabel('Frequency [Hz]')
        ylabel('[dB re \muPa^2/Hz]')
        set(gca,'xscale','log')
        
        
        

        
 
        
plot(f(2:8),freqline1,'k--','LineWidth',2);
plot(f(28:70),freqline2,'k--','LineWidth',2);
display1 = text(5,163,'$f^{-5/3}$ turbulent flow noise','Interpreter','latex')
str = {'$f^{-m}$'}
display2 = text(65,135,str,'Interpreter','latex')
str = {'Ambient','noise','region'}
display3 = text(240,110,str,'Interpreter','latex')


legend([m,m1,m2,m3,m4],'Histogram','10 min','30 min','140 min','220 min','Location','southwest')
hold off


print('-depsc2','-r600','figure2.eps') % Print to file
close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FIGURE 3 - SPECTRAL SLOPES

slope_copy = slope(1,:); %copying slopes over
slope_copy(1:22) = NaN;
slope_copy(70:85) = NaN;
slope_copy(180:196)=NaN; %blanking/removing the noisy data


plot(currentspeed,slope_copy,'ko') %plotting the current and the slope data
xlabel('u, Current Speed [m/s]')
str={'Spectral Slope','(40-100 Hz) [dB/decade]'}
ylabel(str) %making y label 
h = lsline 
ph = polyfit(get(h,'xdata'),get(h,'ydata'),1)
grid on
set(gca,'xlim',[0 3.5])
str={'$-10m$ = 5.49u - 46.03'}
R1 = corrcoef(currentspeed,slope_copy,'rows','complete');
display1 = text(1,-50,str,'Interpreter','latex')
display2 = text(1,-52.5,'R = 0.90','Interpreter','latex')

print('figure3.eps','-depsc2','-r600') % Print to file
close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FIGURE 4 - SPECTRAL CRITICAL FREQUENCY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

thresh_copy = thresh(1,:); %copying it over

thresh_copy(1:22)=NaN; %blanking/removing the faulty data
thresh_copy(70:85) = NaN;
thresh_copy(180:196)=NaN; %blanking/removing the faulty data

plot(currentspeed,thresh_copy,'ko')%,'MarkerSize',20)
grid on
lsline
h = lsline
ph = polyfit(get(h,'xdata'),get(h,'ydata'),1)
R1 = corrcoef(currentspeed,thresh_copy,'rows','complete');
xlabel('u, Current Speed [m/s]')
ylabel('Spectral Critical Frequency [Hz]') 
set(gca,'xlim',[0 3.5])
set(gca,'ylim',[55 160])
str={'$f_c$ = 5.57u + 99.18'}
display1 = text(0.3,145,str,'Interpreter','latex')
display2 = text(0.3,155,'R = 0.54','Interpreter','latex')


print('-depsc2','-r600','figure4.eps') % Print to file
close all

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FIGURE 5 - COHERENCE PLOT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

time_min=(Tabs-Tabs(1))/60;

g = figure
p = get(g,'position');
p(4) = p(4)*2; % Add 10 percent to height
set(g, 'position', p);

subplot(2,1,1)
pcolor((Tabs-Tabs(1))/60,f,c01);shading flat;
set(gca,'ylim',[0 1000])
xlabel('Time after deployment [min]')
ylabel('Frequency [Hz]')
c = colorbar
ylabel(c,'Magnitude Coherence')


t = title('a)')
set(t, 'horizontalAlignment', 'right')
set(t, 'units', 'normalized')
h1 = get(t, 'position')
set(t, 'position', [0 h1(2)+0.05 h1(3)])


subplot(2,1,2)
pcolor((Tabs-Tabs(1))/60,f,c03);shading flat;
set(gca,'ylim',[0 1000])
xlabel('Time after deployment [min]')
ylabel('Frequency [Hz]')
c = colorbar
ylabel(c,'Magnitude Coherence')


t = title('b)')
set(t, 'horizontalAlignment', 'right')
set(t, 'units', 'normalized')
h1 = get(t, 'position')
set(t, 'position', [0 h1(2)+0.05 h1(3)])



print('-depsc2','-r600','figure5.eps') % Print to file
close all


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FIGURE 6 - COHERENCE CRITICAL FREQUENCY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


coh_thresh_copy = coh_thresh(1,:); %copying it over

coh_thresh_copy(1:22) = NaN;
coh_thresh_copy(54) = NaN;
coh_thresh_copy(69:82) = NaN;
coh_thresh_copy(89:96) = NaN;
coh_thresh_copy(101) = NaN;
coh_thresh_copy(107) = NaN;
coh_thresh_copy(114) = NaN;
coh_thresh_copy(116) = NaN;
coh_thresh_copy(118) = NaN;
coh_thresh_copy(120:122) = NaN;


thresh_nan = find(coh_thresh_copy>350);
coh_thresh_copy(thresh_nan) = NaN;

thresh_nan = find(coh_thresh_copy<149);
coh_thresh_copy(thresh_nan) = NaN;

thresh_nan = find(coh_thresh_copy<148);
coh_thresh_copy(thresh_nan) = NaN;

plot(currentspeed,coh_thresh_copy,'ko')
grid on 
lsline 
h = lsline
ph = polyfit(get(h,'xdata'),get(h,'ydata'),1)
R1 = corrcoef(currentspeed,coh_thresh_copy,'rows','complete');
xlabel('u, Current Speed [m/s]')
ylabel('Coherence Critical Frequency [Hz]')
set(gca,'xlim',[0 3.5])
set(gca,'ylim',[120 450])
str={'$f^\prime _c$ = 46.71u + 171.49'}
display1 = text(1.25,375,str,'Interpreter','latex')
display2 = text(1.25,400,'R = 0.75','Interpreter','latex')

print('-depsc2','-r600','figure6.eps') % Print to file
close all



%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FIGURE 7 - COMPARISON OF ALL CRITICAL FREQUENCIES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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

print('-depsc2','-r600','figure7.eps') % Print to file
close all
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FIGURE 8 - SIGNAL COMPARISONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



figure 
A = semilogx(f,p0(:,88),'r');
hold on
B = semilogx(f,g0(:,51),'b');
C = semilogx(f,A_t(:,88),'k');

x_1_arrow = [0.76 0.76];
y_1_arrow = [0.55 0.39];

x_2_arrow = [0.69 0.69];
y_2_arrow = [0.55 0.39];

text(210,95,'A','Color','black')
text(340,95,'B','Color','black')

annotation('arrow',x_1_arrow,y_1_arrow,'Color','black')
annotation('arrow',x_2_arrow,y_2_arrow,'Color','black')

hold off

grid on 

xlabel('Frequency [Hz]')
ylabel('[dB re \muPa^2/Hz]')
set(gca,'xlim',[5 1000])
legend([A C B],'Fixed single hydrophone','Coherent array', 'Free drifting hydrophone')

print('-depsc2','-r600','figure8.eps') % Print to file
close all