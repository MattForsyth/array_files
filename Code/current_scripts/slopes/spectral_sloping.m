%TIME TO MINUTES%
time_min = (Tabs-Tabs(1))/60;
%DEFINING CELL%
%titles = {'Ch 0' 'Ch 1' 'Ch 2' 'Ch 3'};
%titles = cell2mat(titles)
p_cell = {p0,p1,p2,p3};
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
 
slope = zeros(4,196);

for(q=1:length(p_cell))
   for(t=1:length(time_min))
       mat = cell2mat(p_cell(q)); %reading in power spectra
       slice = mat(:,t); %taking snapshots 
       num = slice(8)-slice(30);
       denom = log10(f(8)/f(30));
       slope(q,t) = num/denom; %slopes of snapshots 
   end
   figure %plotting 196 snapshots per channel
   plot(currentspeed,slope(q,:),'ks')
   xlabel('Current [m/s]')
   ylabel('Spectral Slope [dB/decade]')
   title(['Channel ' num2str(q-1)])
   lsline
   grid minor
end


%end
