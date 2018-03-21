%% FIGURES FOR JOE %% 

%   1. Power Spectrum - Channel 0 
%   2. PSPD - Channel 0 
%   3. Spectral slope - Channel 0 
%   4. f_c - Channel 0
%
%   5. Coherence - 6 
%   6. f'_c - 6
%
%   7. Comparative plot 
%   8. Performance assessment 
%
% GO 

%cd('F:\University\4th Year\Journal\current\IEEEtran_current\Thesis')
%Preamble styling 
set(0,'DefaultTextFontName','Times',...
'DefaultTextFontSize',18,...
'DefaultAxesFontName','Times',...
'DefaultAxesFontSize',18,...
'DefaultLineLineWidth',1,...
'DefaultLineMarkerSize',7.75)

cd('F:\Matt_Auvinen_Files')
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%SPECTRAL SLOPE CONTROL
%WE SEE OUTLIERS AT 180:196
%SLOPE_COPY IS USED TO COPY SLOPE FROM THE MASTER WORKSPACE
%PLEASE DO NOT ALTER THE ORIGIN OF SLOPE
%EDITS ARE TO BE MADE HERE

%These slope indexes correspond to a time where the tide was turning 
%Perhaps some issues arose around slack 
%There is also the possibility that ship noise was interferring, but this
%is at the VERY end of the recording 
%maybe we are dealing with noise from reeling in the instrument? 

slope_copy = slope(1,:); %copying it over
slope_copy(1:22) = NaN;
slope_copy(70:85) = NaN;
slope_copy(180:196)=NaN; %blanking/removing the faulty data


plot(currentspeed,slope_copy,'ko') %plotting the current and the slope data
xlabel('u, Current Speed [m/s]')
str={'Spectral Slope','(40-100 Hz) [dB/decade]'}
ylabel(str) %making y label 
h = lsline 
ph = polyfit(get(h,'xdata'),get(h,'ydata'),1)
grid on
set(gca,'xlim',[0 2.4])
str={'$-m$ = 5.49u - 46.03'}
R1 = corrcoef(currentspeed,slope_copy,'rows','complete');
display1 = text(1.4,-50,str,'Interpreter','latex')
display2 = text(1.4,-52.5,'R = 0.90','Interpreter','latex')

%print('figure3.eps','-depsc2','-r600') % Print to file
%close all
%%
%HISTOGRAM TWEAKING - CHANGING THE f-m LINE


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       2                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
        ylabel('Power [dB re \muPa^2/Hz]')
        xlabel('Frequency [Hz]')
        set(gca,'xscale','log')
        grid minor
    
    
        hold on 

        plot(f,power0(t3,:),'Color','r','LineWidth',3);
        set(gca,'xlim',[0 1000]);
        xlabel('Frequency [Hz]')
        ylabel('Power [dB re \muPa^2/Hz]')
        set(gca,'xscale','log')
        
        
        plot(f,power0(t,:),'Color','k','LineWidth',3);
        set(gca,'xlim',[0 1000]);
        xlabel('Frequency [Hz]')
        ylabel('Power [dB re \muPa^2/Hz]')
        set(gca,'xscale','log')
        
        
        plot(f,power0(t1,:),'Color','g','LineWidth',3);
        set(gca,'xlim',[0 1000]);
        xlabel('Frequency [Hz]')
        ylabel('Power [dB re \muPa^2/Hz]')
        set(gca,'xscale','log')
        
        
        
        plot(f,power0(t2,:),'Color','m','LineWidth',3);
        set(gca,'xlim',[0 1000]);
        xlabel('Frequency [Hz]')
        ylabel('Power [dB re \muPa^2/Hz]')
        set(gca,'xscale','log')
        
        
        

        legend('Histogram','10 min','30 min','140 min','220 min','Location','southwest')
 
        
plot(f(2:8),freqline1,'k--','LineWidth',2);
plot(f(28:70),freqline2,'k--','LineWidth',2);
display1 = text(5,163,'$f^{-5/3}$ turbulent flow noise','Interpreter','latex')
str = {'$f^{-m}$'}
display2 = text(65,135,str,'Interpreter','latex')
str = {'Ambient','noise','region'}
display3 = text(240,110,str,'Interpreter','latex')

hold off


%print('-depsc2','-r600','figure2.eps') % Print to file
%close all


%%
%lets try cleaning this up with the same method
%180:196 is bad, so lets just plot without that data and see how we do
%I don't think we'll need to do the exact same quality control for the
%coherence and spectral methods, though it be nice if we could keep it
%consistent. Also, I think we should be consistent across spectral methods
%but we shall see. It's likely that the slopes were not affected in the
%same way that the critical frequency (spectral) would be affected.
%Regardless, going to try eliminating end of the signal first. We will do
%it the same way, we will make a copy of thresh. Do not alter. 


%Going to try something new. Lets go from the spectrogram and cut out time
%segments. This way we get rid of any noise that's throwing us off. 


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
set(gca,'xlim',[0 2.4])
set(gca,'ylim',[55 160])
str={'$f_c$ = 5.57u + 99.18'}
display1 = text(0.3,145,str,'Interpreter','latex')
display2 = text(0.3,155,'R = 0.54','Interpreter','latex')


%print('-depsc2','-r600','figure4.eps') % Print to file
%close all


%%
%Going to try cleaning up coherence using the same time trims as before. I
%don't think it will be enough. We will see. Need to make new copes of the
%coh_thresh
figure
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

thresh_nan = find(coh_thresh_copy<148);
coh_thresh_copy(thresh_nan) = NaN;

%coh_thresh_copy(69) = NaN;
%coh_thresh_copy(89) = NaN;
%coh_thresh_copy(101) = NaN;
%coh_thresh_copy(107) = NaN;
%coh_thresh_copy(114) = NaN;
%coh_thresh_copy(118:122) = NaN;
%coh_thresh_copy(130:150) = NaN;
%coh_thresh_copy(158) = NaN;
%coh_thresh_copy(160:175) = NaN;
%coh_thresh_copy(180:196) = NaN;


%coh_thresh_copy(1:22)=NaN; %blanking/removing the faulty data
%coh_thresh_copy(70:85) = NaN;
%coh_thresh_copy(90:100) = NaN;
%coh_thresh_copy(115:125) = NaN;
%coh_thresh_copy(130:140) = NaN;
%coh_thresh_copy(180:196)=NaN; %blanking/removing the faulty data

plot(currentspeed,coh_thresh_copy,'ko')%,'MarkerSize',20)
grid on 
lsline 
h = lsline
ph = polyfit(get(h,'xdata'),get(h,'ydata'),1)
R1 = corrcoef(currentspeed,coh_thresh_copy,'rows','complete');
xlabel('u, Current Speed [m/s]')
ylabel('Coherence Critical Frequency [Hz]')
set(gca,'xlim',[0 2.4])
set(gca,'ylim',[120 450])
str={'$f^\prime _c$ = 46.71u + 171.49'}
display1 = text(1.25,375,str,'Interpreter','latex')
display2 = text(1.25,400,'R = 0.75','Interpreter','latex')

%print('-depsc2','-r600','figure6.eps') % Print to file
%close all
