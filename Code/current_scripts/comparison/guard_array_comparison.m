%pass_by_number   time    elapsedtimegb   elapsedtimearray
%1 13:38 00:35 01:30
%2 13:54 00:51 01:47
%3 14:10 01:06 02:00

%guard_time(35) = 35 mins 
%guard_time(51) = 51 mins
%guard_time(65) = 66 mins

%array_time(72) = 90 mins 
%array_time(88) = 107 mins 
%array_time(90) = 120 mins 

figure 
A = semilogx(f,p0(:,72),'r');
hold on
%semilogx(f,p1(:,72),'k');
%semilogx(f,p2(:,72),'m');
%semilogx(f,p3(:,72),'g');

%

B = semilogx(f,g0(:,33),'b');
%semilogx(f,g0(:,51),'b');
%semilogx(f,g0(:,65),'b');

C = semilogx(f,A_t(:,72),'k');
D = semilogx(f,A_3(:,72),'m');
E = semilogx(f,A_2(:,72),'g');
%semilogx(f,A_t(:,88),'k--');
%semilogx(f,A_t(:,90),'k--');
hold off

grid minor 
grid on 
title('Power Spectra Comparison')
xlabel('Frequency [Hz]')
ylabel('Power [dB]')
set(gca,'xlim',[0 45000])
legend([A B C D E],'Hydrophone','Guard Buoy', 'Array', '3 Hydrophones','2 Hydrophones')