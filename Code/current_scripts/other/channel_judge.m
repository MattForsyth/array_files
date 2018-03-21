figure 
plot(f,p0(:,50),'b-')
hold on
plot(f,p1(:,50),'r-')
plot(f,p2(:,50),'m-')
plot(f,p3(:,50),'g-')
set(gca,'xscale','log')
grid minor
title('t = 55')

hold off


figure 
plot(f,p0(:,150),'b-')
hold on
plot(f,p1(:,150),'r-')
plot(f,p2(:,150),'m-')
plot(f,p3(:,150),'g-')
set(gca,'xscale','log')
grid minor
title('t = 186')

hold off

figure 
plot(f,p0(:,100),'b-')
hold on
plot(f,p1(:,100),'r-')
plot(f,p2(:,100),'m-')
plot(f,p3(:,100),'g-')
set(gca,'xscale','log')
grid minor
title('t = 131')

hold off