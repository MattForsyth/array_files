
%TIME TO MINUTES%
time_min = (Tabs-Tabs(1))/60;
titles = {'Array','3 Hydrophones','2 Hydrophones'}
%DEFINING CELL%
%titles = {'Ch 0' 'Ch 1' 'Ch 2' 'Ch 3'};
%titles = cell2mat(titles)
a_cell = {A_t,A_3,A_2}
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
 
array_slope = zeros(length(a_cell),196);

for(q=1:length(a_cell))
   for(t=1:length(time_min))
       mat = cell2mat(a_cell(q)); %reading in power spectra
       slice = mat(:,t); %taking snapshots 
       num = slice(8)-slice(30);
       denom = log10(f(8)/f(30));
       array_slope(q,t) = num/denom; %slopes of snapshots 
   end
   figure %plotting 196 snapshots per channel
   plot(currentspeed,array_slope(q,:),'ks')
   xlabel('Current [m/s]')
   ylabel('Spectral Slope [dB/decade]')
   title(titles(q))
   lsline
   grid minor
end


%end
