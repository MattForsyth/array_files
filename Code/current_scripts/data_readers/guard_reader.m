%Calculating an imagesc of an entire folder of BRTP array .wav files
%duty cycled data reading for the BRTP array


%To make script work, navigatr to array data .wav files%
%clear all
%close all

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
%dt=nfft/fs/60/2;
dt = 1/fs;
df = 1/dt/length(f);
%element spacing


for(ii=1:N-1)
    st=(ii-1)*skip+1;
    et=(ii-1)*skip+M*nfft;

    [Y, fs]=audioread(filelist(kk).name,[st et]);

    ch0=Y(:,1)*2^31;

 
disp('Buffering input')

    ch0buff=buffer(ch0,nfft,nfft/2,'nodelay');

disp('Calculating FFTs')
     An=zeros(size(ch0buff.'));
     for(jj=1:(size(ch0buff,2)))
         An(jj,:)=fft(ch0buff(:,jj).*hann(nfft));

         %for(ff=1:size(An,2))
         %    p=[An(jj,ff); Bn(jj,ff)];
         %    CSDM1(:,:,jj,ff)=p*p';
         %end
         clc
         disp([num2str(jj) '/' num2str(size(ch0buff,2))])
     end
           
            %Calculate running mean
disp('Calculating degrees of freedom')
  
    Pwr0(pp,:)=mean(2*An.*conj(An)/df/length(f)^2,1);
    %Pwr0(pp,:)=mean(An.*conj(An),1);     
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
day=str2num(filename(15:16));
hh=str2num(filename(17:18));
mm=str2num(filename(19:20));
ss=str2num(filename(21:22));
     %define absolute time   
T0=day*24*60*60+hh*60*60+mm*60+ss;
Tabs=[Tabs T+T0];


end
end

cd('C:/Users/matth/Documents/University/4th Year/Honours')
calib = importdata('gb_calibration.dat');
xcalib = calib.data(:,1);
vcalib = calib.data(:,2);

calibration = interp1(xcalib,vcalib,f,'linear');
calibration(isnan(calibration))=0;

upsilon0 = 10*log10(Pwr0)-calibration;

g0 = upsilon0.';

guard_time = (Tabs-Tabs(1))/60;

%g0 = Pwr0.';
%loggedpower0 = 10*log10(g0);
figure
pcolor(guard_time,f,g0);shading flat;
set(gca,'ylim',[5 20000])
xlabel('Time after deployment [min]')
ylabel('Frequency [Hz]')
set(gca,'yscale','log')
title('Guard Buoy')
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

