%ONLY TO BE RUN ONCE BOTH SPECTRAL_THRESHOLDS.M AND COHERENCE_THRESHOLDS.M
%HAVE BEEN RUN 

%THIS IS A COMPARITIVE SCRIPT, NOTHING SHOULD BE CALCULATED HERE 

%COH_THRESH FOR COHERENCE 
%THRESH FOR SPECTRAL 

set(groot,'defaultAxesColorOrder',[1 0 0;1 0 1;0 0 0; 0 0 1],...
      'defaultAxesLineStyleOrder','-|--|-.')

thresh_group = {thresh coh_thresh}
poly_v = zeros(10,196);
pp = 1
for(q=1:length(thresh_group))
    t_mat = cell2mat(thresh_group(q))
    
    for(e=1:size(t_mat,1))
        poly_f= polyfit(currentspeed,t_mat(e,:),1);
        poly_v(pp,:) = polyval(poly_f,currentspeed);
        
        pp = pp+1;
    
    end 
    
    
end 



plot(currentspeed,poly_v,'LineWidth',1.5)
grid minor
set(gca,'ylim',[70 300])
legend('Ch0','Ch1','Ch2','Ch3','Ch01','Ch02','Ch03','Ch12','Ch13','Ch23')
title('Frequency Threshold Comparison')
xlabel('Current Speed [m/s]')
ylabel('Frequency [Hz]')

set(groot,'defaultAxesLineStyleOrder','remove')
set(groot,'defaultAxesColorOrder','remove')