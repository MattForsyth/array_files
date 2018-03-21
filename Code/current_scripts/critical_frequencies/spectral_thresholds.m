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
p_cell = {p0,p1,p2,p3};

%destinations of smoothing 
yy0 = zeros(500-49,size(p0,2));  %frequency limited to 50:500, where f(50) is 71 Hz and end is arbitrary 
yy1 = zeros(500-49,size(p1,2));  %changes in the 500-x term are to capture proper space of the curve, done visually
yy2 = zeros(500-39,size(p2,2));
yy3 = zeros(500-59,size(p3,2));

i0 = 50:500;
i1 = 50:500;
i2 = 40:500;
i3 = 60:500;

e = [49 49 39 59];

i_cell = {i0,i1,i2,i3};

y_cell = {yy0,yy1,yy2,yy3};

%Frequency threshold point for each snapshot, each channel
CFI = zeros(4,196);

for(q=1:4)
    
    yy = cell2mat(y_cell(q));
    p_mat = cell2mat(p_cell(q));
    i_mat = cell2mat(i_cell(q));
    
    for(t=1:length(time_min))
    yy(:,t) = smooth(p_mat(i_mat,t),30,'moving');
    
    
    %for(ff=i_mat)
      
        %data_slope(ff-i_mat(1)+1,t) = (p_mat(ff,t) - p_mat(ff+20,t))/log10(f(ff)/f(ff+20));   
        
        
        for(ff=i_mat)
           dataslope(ff-i_mat(1)+1,t) = (p_mat(ff,t) - p_mat(ff+20,t))/log10(f(ff)/f(ff+20));
        
    end
        
    CFI(q,t) = find(abs(dataslope(:,t)) < abs(slope(q,t)),1,'first');
    CFI(q,t) = CFI(q,t)+e(q);
    CFI(q,t) = f(CFI(q,t));
    thresh = CFI+20;
    y_cell(q) = {yy};
    end
end 

figure
plot(currentspeed,thresh(1,:),'rx')
title('Channel 0')
grid minor
lsline
xlabel('Current [m/s]')
ylabel('Critical Frequency [Hz]')

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


    
