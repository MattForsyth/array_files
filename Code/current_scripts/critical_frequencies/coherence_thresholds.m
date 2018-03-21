%TIME TO MINUTES%
time_min = (Tabs-Tabs(1))/60;
%DEFINING CELL%
%titles = {'Ch 0' 'Ch 1' 'Ch 2' 'Ch 3'};
%titles = cell2mat(titles)
c_cell = {c01,c02,c03,c12,c13,c23};

i_cell = {0.8 0.7 0.7 0.9 0.8 0.9};

%TIME TO CURRENT%
for(zz=1:length(time_min))
        tau = (round(time_min/5)*5);
        index = find(time == tau(zz));
        if any(abs(speed(index))) == 1
            currentspeed(zz) = abs(speed(index));
        elseif any(abs(speed(index))) == 0
            currentspeed(zz) = NaN;
        end
 end
 %FILLING NANS
currentspeed = inpaint_nans(currentspeed);

for(q=1:length(c_cell))
    c_mat = cell2mat(c_cell(q));
    i_mat = cell2mat(i_cell(q));
    for(t=1:length(time_min))
        
        if any(c_mat(100:342,t) >= i_mat)
        
        f_index = find(c_mat(100:342,t)> i_mat,1,'first');
        
        coh_thresh(q,t) = f(f_index);
        
        else 
            
        f_index = NaN;
        coh_thresh(q,t) = NaN;
        
        end 
    
        disp([num2str(t) '/' num2str(length(time_min))])
        
    end
    
  
    
    
    disp([num2str(q) '/' num2str(length(c_cell))])
    
end

coh_thresh = coh_thresh+f(100);
coh_thresh = inpaint_nans(coh_thresh,2);

figure 
plot(currentspeed,coh_thresh(1,:),'ks')
grid minor 
lsline 
title('Ch 0 - 1')
xlabel('Current [m/s]')
ylabel('Frequency [Hz]')

figure 
plot(currentspeed,coh_thresh(2,:),'ks')
grid minor 
lsline 
title('Ch 0 - 2')
xlabel('Current [m/s]')
ylabel('Frequency [Hz]')

figure 
plot(currentspeed,coh_thresh(3,:),'ks')
grid minor 
lsline 
title('Ch 0 - 3')
xlabel('Current [m/s]')
ylabel('Frequency [Hz]')

figure 
plot(currentspeed,coh_thresh(4,:),'ks')
grid minor 
lsline 
title('Ch 1 - 2')
xlabel('Current [m/s]')
ylabel('Frequency [Hz]')

figure 
plot(currentspeed,coh_thresh(5,:),'ks')
grid minor 
lsline 
title('Ch 1 - 3')
xlabel('Current [m/s]')
ylabel('Frequency [Hz]')

figure 
plot(currentspeed,coh_thresh(6,:),'ks')
grid minor 
lsline 
title('Ch 2 - 3')
xlabel('Current [m/s]')
ylabel('Frequency [Hz]')
