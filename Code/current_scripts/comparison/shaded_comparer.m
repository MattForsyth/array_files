%ONLY TO BE RUN ONCE BOTH SPECTRAL_THRESHOLDS.M AND COHERENCE_THRESHOLDS.M
%HAVE BEEN RUN 

%THIS IS A COMPARITIVE SCRIPT, NOTHING SHOULD BE CALCULATED HERE 

%COH_THRESH FOR COHERENCE 
%THRESH FOR SPECTRAL 

x_1 = min(currentspeed);
x_2 = max(currentspeed);

thresh_group = {thresh coh_thresh};
poly_v = zeros(10,196);
pp = 1;

%set(groot,'defaultAxesColorOrder',[0 0 0;0 0 0;0 0 0;0 0 0],...
      %'defaultAxesLineStyleOrder','-')
  
for(q=1:length(thresh_group))
    t_mat = cell2mat(thresh_group(q));
    
    for(e=1:size(t_mat,1))
        [poly_f(pp,:), poly_s(pp,:)]= polyfit(currentspeed,t_mat(e,:),1);
        [poly_v(pp,:),poly_d(pp,:)] = polyval(poly_f(pp,:),currentspeed,poly_s(pp,:));
        
        pp = pp+1;
    
    end 
    
    
end 

p_f = mean(poly_f(1:4,:),1);
c_f = mean(poly_f(5:10,:),1);

p_s = std(poly_f(1:4,1),1);
c_s = std(poly_f(5:10,1),1);

p_y = p_f(1).*currentspeed + p_f(2);
c_y = c_f(1).* currentspeed + c_f(2); 

%top_a2 = max(a_y)+a_d(end);
%bottom_a2 = max(a_y)-a_d(end);

%top_a2 = min(a_y)+a_d(end);
%bottom_a2 = min(a_y)-a_d(end);

top_p2 = max(p_y) + p_s;
bottom_p2 = max(p_y) - p_s;

top_p1 = min(p_y) + p_s;
bottom_p1 = min(p_y) - p_s;

top_c2 = max(c_y) + c_s;
bottom_c2 = max(c_y) - c_s;

top_c1 = min(c_y) + c_s;
bottom_c1 = min(c_y) - c_s;


for(q=1:size(thresh_a,1))
    
    [a_f(q,:),a_s(q,:)] = polyfit(currentspeed, thresh_a(q,:),1);
    [a_v(q,:),a_d(q,:)] = polyval(a_f(q,:),currentspeed,a_s(q,:));
    
     a2(q,:) = [max(a_v(q,:)) + max(a_d(q,:)) , max(a_v(q,:)) - max(a_d(q,:))];
    a1(q,:) = [min(a_v(q,:)) + max(a_d(q,:)) , min(a_v(q,:)) - max(a_d(q,:))];
    
    
end 
if(0)
for(q=1:size(thresh_a,1))
    
    a_mat = thresh_a;
    
    for(e=1:size(a_mat,1))
    
    [a_f(pp,:), a_s(pp,:)] = polyfit(currentspeed,a_mat(e,:),1);
    [a_v(pp,:), a_d(pp,:)] = polyval(a_f(pp,:),currentspeed,a_s(pp,:));
    
    pp = pp+1;
    
    end 
    
    a2(q,:) = [max(a_v(q,:)) + max(a_d(q,:)) , max(a_v(q,:)) - max(a_d(q,:))]
    a1(q,:) = [min(a_v(q,:)) + max(a_d(q,:)) , min(a_v(q,:)) - max(a_d(q,:))]
    
    disp([num2str(q) '/' num2str(length(a_cell))])
    
end 

[a_f, a_s] = polyfit(currentspeed,thresh_a,1);
[a_y, a_d] = polyval(a_f,currentspeed,a_s);
end 

if(0)
ordered = [3 2 1];
color = [0.73 0.83 0.96; 0.93 0.84 0.84; 0.76 0.87 0.78];
ccc = 1;
figure 
hold on 
if(0)
for(B = ordered)
    
   fill([x_1,x_1,x_2,x_2],[a1(B,1),a1(B,2),a2(B,2),a2(B,1)],[color(ccc,:)],'LineStyle','none') 
    ccc = ccc+1;
end 
end
end


figure
hold on

fill([x_1,x_1,x_2,x_2],[top_c1,bottom_c1,bottom_c2,top_c2],[0.9 0.9 0.9],'LineStyle','none')
fill([x_1,x_1,x_2,x_2],[top_p1,bottom_p1,bottom_p2,top_p2],[0.9 0.9 0.9],'LineStyle','none')
fill([x_1,x_1,x_2,x_2],[a1(1,1),a1(1,2),a2(1,2),a2(1,1)],[0.9 0.9 0.9],'LineStyle','none')

c_p = plot(currentspeed,c_y,'LineWidth',1.5);
p_p = plot(currentspeed,p_y,'LineWidth',1.5);
a_p1 = plot(currentspeed,a_v(1,:),'LineWidth',1.5);
%a_p2 = plot(currentspeed,a_v(2,:),'LineWidth',1.5);
%a_p3 = plot(currentspeed,a_v(3,:),'LineWidth',1.5);
hold off

grid minor
xlabel('Current [m/s]')
ylabel('Critical Frequency [Hz]') 
title('Critical Frequency Performance and Comparison')
legend([c_p,p_p,a_p1],'Coherence Thresholds','Spectral Thresholds','Array')


if(0)
set(groot,'defaultAxesColorOrder',[1 0 0;1 0 1;0 0 0; 0 0 1],...
      'defaultAxesLineStyleOrder','-|-.')

c_s(1:196) = c_s
figure

hold on
c_p = plot(currentspeed,c_y);

p_p = plot(currentspeed,p_y);

a_p = plot(currentspeed,a_y);


hold off

grid minor
xlabel('Current Speed [m/s]')
ylabel('Critical Frequency [Hz]')
title('Critical Frequnecy Comparison')

set(groot,'defaultAxesColorOrder',[1 0 0;1 0 1;0 0 0; 0 0 1],...
      'defaultAxesLineStyleOrder','-|--|-.')
  
end 


if(0)
figure
plot(currentspeed,poly_v,'LineWidth',1.5)
grid minor
set(gca,'ylim',[70 300])
legend('Ch0','Ch1','Ch2','Ch3','Ch01','Ch02','Ch03','Ch12','Ch13','Ch23')
title('Critical Frequency Comparison')
xlabel('Current Speed [m/s]')
ylabel('Critical Frequency [Hz]')

set(groot,'defaultAxesLineStyleOrder','remove')
set(groot,'defaultAxesColorOrder','remove')

end 