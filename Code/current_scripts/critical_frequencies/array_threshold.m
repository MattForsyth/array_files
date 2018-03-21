%TIME TO MINUTES%
time_min = (Tabs-Tabs(1))/60;
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

%power cell
a_cell = {A_t,A_3,A_2};

%destinations of smoothing 
yy_a = zeros(500-29,size(A_t,2));  %frequency limited to 50:500, where f(50) is 71 Hz and end is arbitrary 
yy_3 = zeros(500-39,size(A_t,2));
yy_2 = zeros(500-39,size(A_t,2));

i_a = [30:500];
i_3 = [40:500];
i_2 = [40:500];

e = [29,39,39];

i_cell = {i_a, i_3, i_2};

y_cell = {yy_a,yy_3,yy_2};

%Frequency threshold point for each snapshot, each channel
CFI = zeros(1,196);

for(q=1:length(a_cell))
    
    yy = cell2mat(y_cell(q));
    p_mat = cell2mat(a_cell(q));
    i_mat = cell2mat(i_cell(q));
    
    for(t=1:length(time_min))
    yy(:,t) = smooth(p_mat(i_mat,t),30,'moving');
    
    
    %for(ff=i_mat)
      
        %data_slope(ff-i_mat(1)+1,t) = (p_mat(ff,t) - p_mat(ff+20,t))/log10(f(ff)/f(ff+20));   
        
        
        for(ff=i_mat)
           dataslope(ff-i_mat(1)+1,t) = (p_mat(ff,t) - p_mat(ff+20,t))/log10(f(ff)/f(ff+20));
        
    end
        
    CFI(q,t) = find(abs(dataslope(:,t)) < abs(array_slope(q,t)),1,'first');
    CFI(q,t) = CFI(q,t)+e(q);
    CFI(q,t) = f(CFI(q,t));
    thresh_a(q,:) = CFI(q,:)+20;
    y_cell(q) = {yy};
    end
end 

figure
plot(currentspeed,thresh_a(1,:),'rx')
title('Array 4 Channels')
grid minor
lsline
xlabel('Current [m/s]')
ylabel('Critical Frequency [Hz]')

figure
plot(currentspeed,thresh_a(2,:),'rx')
title('Array 3 Channels')
grid minor
lsline
xlabel('Current [m/s]')
ylabel('Critical Frequency [Hz]')

figure
plot(currentspeed,thresh_a(3,:),'rx')
title('Array 2 Channels')
grid minor
lsline
xlabel('Current [m/s]')
ylabel('Critical Frequency [Hz]')
if(0)
figure
plot(currentspeed,thresh(2,:),'bs')
title('Channel 1')
grid minor
lsline 
xlabel('Current [m/s]')
ylabel('Critical Frequency [Hz]')

figure
plot(currentspeed,thresh(3,:),'m.')
title('Channel 2')
grid minor
lsline
xlabel('Current [m/s]')
ylabel('Critical Frequency [Hz]')

figure
plot(currentspeed,thresh(4,:),'k+')
title('Channel 3')
grid minor
lsline
xlabel('Current [m/s]')
ylabel('Critical Frequency [Hz]')

end
    
