%PREPARATION
prompt = 'What time? [min] ';
input1 = input(prompt)

power0 = upsilon0;
power1 = upsilon1;
power2 = upsilon2;
power3 = upsilon3;

zesty=((Tabs-Tabs(1))/60);
zesty=round(zesty,0);
t=find(zesty==input1);

t1=find(zesty==140);
t2=find(zesty==220);
t3=find(zesty==10);
freqline1 = -17*log10(f(3:10))+170;
%%%%%%%%%%%%
figure
%CHANNEL 0
m = pcolor(f,yaxis0,test0);shading flat;
        set(gca,'xlim',[0 20000])
        set(gca,'ylim',[60 170])
        set(m,'facealpha',0.7)
        ylabel('Power [dB]')
        xlabel('Frequency [Hz]')
        set(gca,'xscale','log')
        grid minor
    
        hold on 

        plot(f,power0(t,:),'Color','k');
        set(gca,'xlim',[0 20000]);
        xlabel('Frequency [Hz]')
        ylabel('Power [dB]')
        set(gca,'xscale','log')
        
        plot(f,power0(t1,:),'Color','b');
        set(gca,'xlim',[0 20000]);
        xlabel('Frequency [Hz]')
        ylabel('Power [dB]')
        set(gca,'xscale','log')
        
        
        plot(f,power0(t2,:),'Color','g');
        set(gca,'xlim',[0 20000]);
        xlabel('Frequency [Hz]')
        ylabel('Power [dB]')
        set(gca,'xscale','log')
        
        
        plot(f,power0(t3,:),'Color','r');
        set(gca,'xlim',[0 20000]);
        xlabel('Frequency [Hz]')
        ylabel('Power [dB]')
        set(gca,'xscale','log')
        legend('Histogram','30 min','140 min','220 min','10 min')
 
        
plot(f(3:10),freqline1,'k--');
display = text(10,160,'$f^{-5/3}$','Interpreter','latex')
display.FontSize=14;
hold off

figure
%CHANNEL 1
m = pcolor(f,yaxis1,test1);shading flat;
        set(gca,'xlim',[0 20000])
        set(gca,'ylim',[60 170])
        set(m,'facealpha',0.7)
        ylabel('Power [dB]')
        xlabel('Frequency [Hz]')
        set(gca,'xscale','log')
        title('Channel 1')
        colorbar
        grid minor
    
        hold on 

        plot(f,power1(t,:),'Color','k');
        set(gca,'xlim',[0 20000]);
        xlabel('Frequency [Hz]')
        ylabel('Power [dB]')
        set(gca,'xscale','log')
        
        plot(f,power1(t1,:),'Color','b');
        set(gca,'xlim',[0 20000]);
        xlabel('Frequency [Hz]')
        ylabel('Power [dB]')
        set(gca,'xscale','log')
        
        
        plot(f,power1(t2,:),'Color','g');
        set(gca,'xlim',[0 20000]);
        xlabel('Frequency [Hz]')
        ylabel('Power [dB]')
        set(gca,'xscale','log')
        
        
        plot(f,power1(t3,:),'Color','r');
        set(gca,'xlim',[0 20000]);
        xlabel('Frequency [Hz]')
        ylabel('Power [dB]')
        set(gca,'xscale','log')
        legend('Histogram','t = 30','t=140','t=220','t=10')
 
        
plot(f(1:10),freqline1,'k--');
display = text(10,160,'$f^{-5/3}$','Interpreter','latex')
display.FontSize=14;
hold off

figure
%CHANNEL 2
m = pcolor(f,yaxis2,test2);shading flat;
        set(gca,'xlim',[0 20000])
        set(gca,'ylim',[60 170])
        set(m,'facealpha',0.7)
        ylabel('Power [dB]')
        xlabel('Frequency [Hz]')
        set(gca,'xscale','log')
        title('Channel 2')
        colorbar
        grid minor
    
        hold on 

        plot(f,power2(t,:),'Color','k');
        set(gca,'xlim',[0 20000]);
        xlabel('Frequency [Hz]')
        ylabel('Power [dB]')
        set(gca,'xscale','log')
        
        plot(f,power2(t1,:),'Color','b');
        set(gca,'xlim',[0 20000]);
        xlabel('Frequency [Hz]')
        ylabel('Power [dB]')
        set(gca,'xscale','log')
        
        
        plot(f,power2(t2,:),'Color','g');
        set(gca,'xlim',[0 20000]);
        xlabel('Frequency [Hz]')
        ylabel('Power [dB]')
        set(gca,'xscale','log')
        
        
        plot(f,power2(t3,:),'Color','r');
        set(gca,'xlim',[0 20000]);
        xlabel('Frequency [Hz]')
        ylabel('Power [dB]')
        set(gca,'xscale','log')
        legend('Histogram','t = 30','t=140','t=220','t=10')
 
        
plot(f(1:10),freqline1,'k--');
display = text(10,160,'$f^{-5/3}$','Interpreter','latex')
display.FontSize=14;
hold off

figure
%CHANNEL 3
m = pcolor(f,yaxis3,test3);shading flat;
        set(gca,'xlim',[0 20000])
        set(gca,'ylim',[60 170])
        set(m,'facealpha',0.7)
        ylabel('Power [dB]')
        xlabel('Frequency [Hz]')
        set(gca,'xscale','log')
        title('Channel 3')
        colorbar
        grid minor
    
        hold on 

        plot(f,power3(t,:),'Color','k');
        set(gca,'xlim',[0 20000]);
        xlabel('Frequency [Hz]')
        ylabel('Power [dB]')
        set(gca,'xscale','log')
        
        plot(f,power3(t1,:),'Color','b');
        set(gca,'xlim',[0 20000]);
        xlabel('Frequency [Hz]')
        ylabel('Power [dB]')
        set(gca,'xscale','log')
        
        
        plot(f,power3(t2,:),'Color','g');
        set(gca,'xlim',[0 20000]);
        xlabel('Frequency [Hz]')
        ylabel('Power [dB]')
        set(gca,'xscale','log')
        
        
        plot(f,power3(t3,:),'Color','r');
        set(gca,'xlim',[0 20000]);
        xlabel('Frequency [Hz]')
        ylabel('Power [dB]')
        set(gca,'xscale','log')
        legend('Histogram','t = 30','t=140','t=220','t=10')
 
        
plot(f(1:10),freqline1,'k--');
display = text(10,160,'$f^{-5/3}$','Interpreter','latex')
display.FontSize=15;
display.FontWeight='bold'
hold off

set(gca,'FontSize',15,'fontWeight','bold')

set(findall(gcf,'type','text'),'FontSize',15,'fontWeight','bold')