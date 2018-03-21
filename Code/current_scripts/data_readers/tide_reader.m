%Importing tide data
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
%MAKE SURE YOU HAVE RUN BASE.M FOR NEXT PORTION TO WORK%%%%%%%%%


%%%ELEVATION
figure;
subplot(2,1,1);
pcolor((Tabs-Tabs(1))/60,f,p0);shading flat;
set(gca,'ylim',[0 20000]);
xlabel('Time after deployment [min]');
ylabel('Frequency [Hz]');
set(gca,'yscale','log');


subplot(2,1,2);
plot(time,elevation);
xlabel('Time after deployment [min]');
ylabel('Elevation [m]');
set(gca,'xlim',[0 235]);
set(gca,'ylim',[-tideamp tideamp]);
hline=refline(0,0);
hline.Color='k';
set(hline,'LineStyle','--')

%%%%CURRENT
figure;
subplot(3,1,1);
pcolor((Tabs-Tabs(1))/60,f,p0);shading flat;
set(gca,'ylim',[0 20000]);
xlabel('Time after deployment [min]');
ylabel('Frequency [Hz]');
set(gca,'yscale','log');


subplot(3,1,2);
plot(time,speed1);
xlabel('Time after deployment [min]');
ylabel('Current [m/s]');
set(gca,'xlim',[0 235]);
set(gca,'ylim',[-speedamp speedamp]);
hline=refline(0,0);
hline.Color='k';
set(hline,'LineStyle','--')

subplot(3,1,3);
plot(time,speed2);
xlabel('Time after deployment [min]');
ylabel('Current [m/s]');
set(gca,'xlim',[0 235]);
set(gca,'ylim',[-speedamp speedamp]);
hline=refline(0,0);
hline.Color='k';
set(hline,'LineStyle','--')

