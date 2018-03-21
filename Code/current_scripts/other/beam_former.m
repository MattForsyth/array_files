set(groot,'defaultAxesColorOrder',[1 0 0;1 0 1;0 0 0; 0 0 1],...
      'defaultAxesLineStyleOrder','-|--|-.')


lever = exist('K') ;
if lever ~=1 
for(jj=1:(size(ch1buff,2)))
             for(ff=1:size(An,2))
             d=[An(jj,ff); Bn(jj,ff); Cn(jj,ff); Dn(jj,ff)];
             CSDM(:,:,jj,ff)=d*d';
             end
             
             
             disp(['CSMD:' num2str(jj) '/' num2str(size(ch1buff,2))])
end
else 
end 
K=squeeze(mean(CSDM,3));
%K = 10*log10(K);
figure 
hold on 
%for(kk=1:nfft)

in = 1;

 for(kk=[20 30 40 50 60 100 500 1000 1500 3500])
     ba=-90:2:90;
     B = zeros(size(ba));
                    for(bb=1:length(ba))
                        
                        k=2*pi*f(kk)/1500;
                        
%w=[exp(-i*0*k*sind(ba(bb))) exp(-i*k*d01*sind(ba(bb))) exp(-i*k*d02*sind(ba(bb))) exp(-i*k*d03*sind(ba(bb)))].';
w=[exp(-i*0*k*sind(ba(bb))) exp(-i*k*d01*sind(ba(bb))) exp(-i*k*d02*sind(ba(bb))) exp(-i*k*d03*sind(ba(bb)))].';

                        B(bb)=w.'*K(:,:,kk)*conj(w); 
                        %B = 10*log10(abs(B));
                        %wt=inv(K(:,:,kk))*w./(w'*inv(K(:,:,kk))*w);
                        %Bmvdr(bb)=wt'*K(:,:,kk)*wt;
                    end
                    %Bbart = B/max(B);
                    %Bbart(kk,:)=B/max(B);
                    %Bmv1(kk,:)=Bmvdr/max(Bmvdr);
               B = 10*log10(B);
               B = B - calibration(kk);
                    %B = B-calibration(kk);
                    
                    plot(ba,B)
         leg(in) = f(kk);
                    in = in+1;
                    
 end
                hold off

legend('27 Hz','40 Hz','58 Hz','70 Hz','85 Hz','145 Hz','730 Hz','1.5 kHz', '2 kHz','5 kHz')
set(gca,'ylim',[150 200])
grid minor 
xlabel('Angle, deg') 
ylabel('Power [dB]')
title('Beamformed Signals, Angle Dependence')
 

figure
for(kk=1:nfft)
     ba=-90:2:90;
     B = zeros(size(ba));
                    for(bb=1:length(ba))
                        
                        k=2*pi*f(kk)/1500;
                        
%w=[exp(-i*0*k*sind(ba(bb))) exp(-i*k*d01*sind(ba(bb))) exp(-i*k*d02*sind(ba(bb))) exp(-i*k*d03*sind(ba(bb)))].';
w=[exp(-i*0*k*sind(ba(bb))) exp(-i*k*d01*sind(ba(bb))) exp(-i*k*d02*sind(ba(bb))) exp(-i*k*d03*sind(ba(bb)))].';

                        B(bb)=w.'*K(:,:,kk)*conj(w); 
                        %B = 10*log10(abs(B));
                        %wt=inv(K(:,:,kk))*w./(w'*inv(K(:,:,kk))*w);
                        %Bmvdr(bb)=wt'*K(:,:,kk)*wt;
                    end
                    %Bbart = B/max(B);
                    
                    %Bmv1(kk,:)=Bmvdr/max(Bmvdr);
               B = 10*log10(B);
               B = B - calibration(kk);
                    %B = B-calibration(kk);
                    Bbart_norm(kk,:)=B/max(B);
                    Bbart_collective(kk,:)=B;
                    %plot(ba,B)
         %leg(in) = f(kk);
                    %in = in+1;
                    
                    disp(['Frequency Step' num2str(kk) '/' num2str(nfft)])
                    
 end
 
 pcolor(ba,f,real(Bbart_collective));shading flat
 title('Beamformed Signal')
 xlabel('Angle, deg')
 ylabel('Frequency [Hz]')
 %set(gca,'ylim',[0 500])
 
 plot(ba,Bbart_collective(200,:))
 set(gca,'ylim',[150 200])
 
