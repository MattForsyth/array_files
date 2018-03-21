%Calculating an imagesc of an entire folder of BRTP array .wav files
%duty cycled data reading for the BRTP array


%To make script work, navigatr to array data .wav files%
clear all
close all

c=1500;

%filelist=dir('./log 08-27-16 12-52-23-5990.wav');
filelist=dir('*.wav');
pp=1; Tabs=[];
for(kk=1:length(filelist))

info=audioinfo(filelist(kk).name)
if(info.Duration<595)
else
%assume first file is normal sized, if not the code will be slow
normsize=filelist(kk).bytes;

%files are 10 minutes
fs=info.SampleRate;
nfft=2^16; %fft length
M=50; %number of fft lengths to load
skip=1*60*fs; %number of samples to skip between record
N=floor(info.TotalSamples/skip);
T=[0:N-2]*skip/fs; %time vector in seconds from beginning of file
f=[0:nfft-1]*fs/(nfft-1);
dt = 1/fs;
df = 1/dt/length(f);

%element spacing
d01=0.17;
d02=0.17*2;
d03=0.17*3;
d12=d01;d23=d01;
d13=d02;

for(ii=1:N-1)
    st=(ii-1)*skip+1;
    et=(ii-1)*skip+M*nfft;

    [Y, fs]=audioread(filelist(kk).name,[st et]);

    ch0=Y(:,1);
    ch1=Y(:,2);
    ch2=Y(:,3);
    ch3=Y(:,4);
 
disp('Buffering input')

    ch0buff=buffer(ch0,nfft,nfft/2,'nodelay');
    ch1buff=buffer(ch1,nfft,nfft/2,'nodelay');
    ch2buff=buffer(ch2,nfft,nfft/2,'nodelay');
    ch3buff=buffer(ch3,nfft,nfft/2,'nodelay');
disp('Calculating FFTs')
     An=zeros(size(ch0buff.'));Bn=zeros(size(ch0buff.'));Cn=zeros(size(ch0buff.'));Dn=zeros(size(ch0buff.'));
     for(jj=1:(size(ch1buff,2)))
         An(jj,:)=fft(ch0buff(:,jj).*hann(nfft));
         Bn(jj,:)=fft(ch1buff(:,jj).*hann(nfft));
         Cn(jj,:)=fft(ch2buff(:,jj).*hann(nfft));
         Dn(jj,:)=fft(ch3buff(:,jj).*hann(nfft));
         Xn(jj,:) = An(jj,:) + Bn(jj,:) + Cn(jj,:) + Dn(jj,:);
         COMP3(jj,:) = An(jj,:) + Bn(jj,:) + Cn(jj,:);
         COMP2(jj,:) = An(jj,:) + Bn(jj,:);
         
         %for(ff=1:size(An,2))
         %    p=[An(jj,ff); Bn(jj,ff)];
         %    CSDM1(:,:,jj,ff)=p*p';
         %end
         clc
         disp([num2str(jj) '/' num2str(size(ch1buff,2))])
     end
           
            %Calculate running mean
disp('Calculating degrees of freedom')
  
    Pwr0(pp,:)=mean(2*An.*conj(An)/df/length(f)^2,1);
    Pwr1(pp,:)=mean(2*Bn.*conj(Bn)/df/length(f)^2,1);
    Pwr2(pp,:)=mean(2*Cn.*conj(Cn)/df/length(f)^2,1);
    Pwr3(pp,:)=mean(2*Dn.*conj(Dn)/df/length(f)^2,1);
    Xt(pp,:) = mean(2*Xn.*conj(Xn)/df/length(f)^2,1);
    X3(pp,:) = mean(2*COMP3.*conj(COMP3)/df/length(f)^2,1);
    X2(pp,:) = mean(2*COMP2.*conj(COMP2)/df/length(f)^2,1);
   if(0) 
    Xnum=mean(An.*conj(Bn),1);
    Xdenom=sqrt(mean(abs(Bn).^2,1).*mean(abs(An).^2,1));
    Xcoh01(pp,:)=Xnum./Xdenom;
                
    Xnum=mean(An.*conj(Cn),1);
    Xdenom=sqrt(mean(abs(Cn).^2,1).*mean(abs(An).^2,1));
    Xcoh02(pp,:)=Xnum./Xdenom;

    Xnum=mean(An.*conj(Dn),1);
    Xdenom=sqrt(mean(abs(Dn).^2,1).*mean(abs(An).^2,1));
    Xcoh03(pp,:)=Xnum./Xdenom;

    Xnum=mean(Bn.*conj(Cn),1);
    Xdenom=sqrt(mean(abs(Bn).^2,1).*mean(abs(Cn).^2,1));
    Xcoh12(pp,:)=Xnum./Xdenom;

    Xnum=mean(Bn.*conj(Dn),1);
    Xdenom=sqrt(mean(abs(Bn).^2,1).*mean(abs(Dn).^2,1));
    Xcoh13(pp,:)=Xnum./Xdenom;

    Xnum=mean(Cn.*conj(Dn),1);
    Xdenom=sqrt(mean(abs(Cn).^2,1).*mean(abs(Dn).^2,1));
    Xcoh23(pp,:)=Xnum./Xdenom;
  end            
            %Beamform
            if(0)
                K=squeeze(mean(CSDM1,3));
                for(kk=1:nfft)
                    ba=-90:5:90;
                    for(bb=1:length(ba))
                        k=2*pi*f(kk)/1700;
                        w=[exp(-i*0*k*d*sind(ba(bb))) exp(-i*1*k*d*sind(ba(bb)))].';
                        B(bb)=w'*K(:,:,kk)*conj(w); 
                        wt=inv(K(:,:,kk))*w./(w'*inv(K(:,:,kk))*w);
                        Bmvdr(bb)=wt'*K(:,:,kk)*wt;
                    end
                    Bbart1(kk,:)=B/max(B);
                    Bmv1(kk,:)=Bmvdr/max(Bmvdr);
                end
            end
            
           disp(['Time Step Complete: ' num2str(ii) '/' num2str(N-1)])
           pp=pp+1;
end
    
filename=filelist(kk).name;
month=str2num(filename(13:14));
day=str2num(filename(8:9));
hh=str2num(filename(14:15));
mm=str2num(filename(17:18));
ss=str2num(filename(20:21));
     %define absolute time   
T0=day*24*60*60+hh*60*60+mm*60+ss;
Tabs=[Tabs T+T0];


end
end

cd('C:/Users/matth/Documents/University/4th Year/Honours')
calib = importdata('calibration.dat');
xcalib = calib.data(:,1);
vcalib = calib.data(:,2);

calibration = interp1(xcalib,vcalib,f,'linear');


upsilon0 = 10*log10(Pwr0)-calibration;
upsilon1 = 10*log10(Pwr1)-calibration;
upsilon2 = 10*log10(Pwr2)-calibration;
upsilon3 = 10*log10(Pwr3)-calibration;
upsilon4 = 10*log10(Xt) - calibration - 10*log10(4^2);
upsilon5 = 10*log10(X3) - calibration - 10*log10(3^2);
upsilon6 = 10*log10(X2) - calibration - 10*log10(2^2);

p0 = upsilon0.';
p1 = upsilon1.';
p2 = upsilon2.';
p3 = upsilon3.';
A_t = upsilon4.';
A_3 = upsilon5.';
A_2 = upsilon6.';

time_min = (Tabs-Tabs(1))/60;



cd('C:/Users/matth/Documents/University/4th Year/Honours/tide data')
TIDE = xlsread('tides.xlsx');
elevation = TIDE(:,1);
time = day*24*60*60+TIDE(:,6)*60*60+TIDE(:,7)*60+TIDE(:,8);
time = (time-time(1))/60;


CURRENT = xlsread('current.xlsx');
speed1 = CURRENT(:,1);
speed2 = CURRENT(:,2);
speed = sqrt(speed1.^2+speed2.^2);
time = day*24*60*60+CURRENT(:,7)*60*60+CURRENT(:,8)*60+CURRENT(:,9);
time = (time-time(1))/60;

tideamp = 1+max(abs(elevation));
speedamp = 1+max(abs(speed));





figure
pcolor((Tabs-Tabs(1))/60,f,p0);shading flat;
set(gca,'ylim',[0 20000])
xlabel('Time after deployment [min]')
ylabel('Frequency [Hz]')
set(gca,'yscale','log')
title('Channel 0')
colorbar

figure
pcolor((Tabs-Tabs(1))/60,f,p1);shading flat;
set(gca,'ylim',[0 20000])
xlabel('Time after deployment [min]')
ylabel('Frequency [Hz]')
set(gca,'yscale','log')
title('Channel 1')
colorbar

figure
pcolor((Tabs-Tabs(1))/60,f,p2);shading flat;
set(gca,'ylim',[0 20000])
xlabel('Time after deployment [min]')
ylabel('Frequency [Hz]')
set(gca,'yscale','log')
title('Channel 2')
colorbar

figure
pcolor((Tabs-Tabs(1))/60,f,p3);shading flat;
set(gca,'ylim',[0 20000])
xlabel('Time after deployment [min]')
ylabel('Frequency [Hz]')
set(gca,'yscale','log')
title('Channel 3')
colorbar


figure
pcolor((Tabs-Tabs(1))/60,f,A_t);shading flat;
set(gca,'ylim',[0 20000])
xlabel('Time after deployment [min]')
ylabel('Frequency [Hz]')
set(gca,'yscale','log')
title('Array')
colorbar

if(0)
figure
pcolor(f,(Tabs-Tabs(1))/60,real(Xcoh01));shading flat;
set(gca,'xlim',[0 20000])
ylabel('Time after deployment [min]')
xlabel('Frequency [Hz]')
title('Real Coherence, Ch 0 - 1')

figure
pcolor(f,(Tabs-Tabs(1))/60,real(Xcoh03));shading flat;
set(gca,'xlim',[0 20000])
ylabel('Time after deployment [min]')
xlabel('Frequency [Hz]')
title('Real Coherence, Ch 0 - 3')
end




if(0)
    
    uplim=1000;
    
figure
pcolor(f,(Tabs-Tabs(1))/60,real(Xcoh01)),shading flat
set(gca,'xlim',[0 uplim])
xlabel('Frequency [Hz]')
ylabel('Time [mins]')
colorbar
caxis([-1 1])
print('-dpng','-r300',['./Xcoh01.png'])
close all
ylabel('Minutes after deployment')

figure
pcolor(f,(Tabs-Tabs(1))/60,real(Xcoh02)),shading flat
set(gca,'xlim',[0 uplim])
xlabel('Frequency [Hz]')
ylabel('Time [mins]')
colorbar
caxis([-1 1])
print('-dpng','-r300',['./Xcoh02.png'])
close all
ylabel('Minutes after deployment')


figure
pcolor(f,(Tabs-Tabs(1))/60,real(Xcoh03)),shading flat
set(gca,'xlim',[0 uplim])
xlabel('Frequency [Hz]')
ylabel('Time [mins]')
colorbar
caxis([-1 1])
print('-dpng','-r300',['./Xcoh03.png'])
close all


figure
pcolor(f,(Tabs-Tabs(1))/60,real(Xcoh12)),shading flat
set(gca,'xlim',[0 uplim])
xlabel('Frequency [Hz]')
ylabel('Time [mins]')
colorbar
caxis([-1 1])
print('-dpng','-r300',['./Xcoh12.png'])
close all

figure
pcolor(f,(Tabs-Tabs(1))/60,real(Xcoh13)),shading flat
set(gca,'xlim',[0 uplim])
xlabel('Frequency [Hz]')
ylabel('Time [mins]')
colorbar
caxis([-1 1])
print('-dpng','-r300',['./Xcoh13.png'])
close all

figure
pcolor(f,(Tabs-Tabs(1))/60,real(Xcoh23)),shading flat
set(gca,'xlim',[0 uplim])
xlabel('Frequency [Hz]')
ylabel('Time [mins]')
colorbar
caxis([-1 1])
print('-dpng','-r300',['./Xcoh23.png'])
close all
end
if(0)
plot(2*pi*f*d01/c,mean(real(Xcoh01)),'b')
set(gca,'xlim',[0 20])
hold on
plot(2*pi*f*d02/c,mean(real(Xcoh02)),'k')
plot(2*pi*f*d03/c,mean(real(Xcoh03)),'r')
plot(2*pi*f*d12/c,mean(real(Xcoh12)),'b')
plot(2*pi*f*d13/c,mean(real(Xcoh13)),'k')
plot(2*pi*f*d23/c,mean(real(Xcoh23)),'b')
legend('d','2d','3d',4)
grid on
xlabel('Normalized Frequency [w*d/c]')
ylabel('Real Coherence')
end



if(0)
%     figure
%     semilogx(f,20*log10(Pwr0))
%     hold on
%     semilogx(f,20*log10(Pwr1),'r')
%     hold on
%     semilogx(f,20*log10(Pwr2),'g')
%     semilogx(f,20*log10(Pwr3),'k')
%     grid on
%     set(gca,'xlim',[10 96000])

    figure
    plot(2*pi*f*d01/c,real(Xcoh01))
    hold on
    plot(2*pi*f*d02/c,real(Xcoh02),'r')
    plot(2*pi*f*d03/c,real(Xcoh03),'k')
    set(gca,'xlim',[0 40])

    figure
    plot(f,real(Xcoh01))
    hold on
    plot(f,real(Xcoh02),'r')
    plot(f,real(Xcoh03),'k')
    set(gca,'xlim',[0 96000])
end

