%reMin=minimum radius of extrusion window to check
%reMax=Max radius of extrusion window to check
%Nre=number of radius of extrusion window to check
%Widths=Strip area around window edge which to take vector flux
%Rcircle= radius of stamp circle
%Xcircle= X of stamp centre
%Ycircle=Y of stamp centre
%fNbefaft=number of frames before and after the extrusion frame itself
%AllExtrusion= all extrusion details (frame |x |y| duration)
%x=X of cells from PIV
%y=Y of centre of cells from PIV
%u_filtered=x component velocity for each cell from PIV
%v_filtered=y component velocity for each cell from PIV

function AllStdSpeed=GetAllStdSpeed(reMin,reMax,Nre,Widths,fNbefaft,AllExtrusion,x,y,u_filtered,v_filtered)
   dummy=size(AllExtrusion);
   lengthAE=dummy(1,1);
   dum=size(x);
   Totframes=dum(1,1);
   
   %initiate
   AllStdSpeed=cell(1);
   
   %go through each extrusion site
   if lengthAE>0
     for i=1:lengthAE
        
    
               %initiate
                ExtFrame=AllExtrusion(i,1);
               StdVelocityFlux=zeros(2*fNbefaft+1,Nre);
               Xext=AllExtrusion(i,2);
               Yext=AllExtrusion(i,3);

               for f=1:2*fNbefaft+1
                   for r=1:Nre

                       if ExtFrame-fNbefaft+f-1>=1  &&  ExtFrame-fNbefaft+f-1<=Totframes
                          Rext=reMin+(r-1)*(reMax-reMin)/(Nre-1);
                          PIVx=x{ExtFrame-fNbefaft+f-1,1};
                          PIVy=y{ExtFrame-fNbefaft+f-1,1};
                          PIVu=u_filtered{ExtFrame-fNbefaft+f-1,1};
                          PIVv=v_filtered{ExtFrame-fNbefaft+f-1,1};

                          [StdVelocityFlux(f,r)]=GetStdSpeed(Widths,Rext,Xext,Yext,PIVx,PIVy,PIVu,PIVv);
                       end

                       if ExtFrame-fNbefaft+f-1<1  &&  ExtFrame-fNbefaft+f-1>Totframes
                           StdVelocityFlux(f,r)=NaN;
                       end

                   end
               end
               %AllAvgVFlux
               %AverageVelocityFlux
               AllStdSpeed=[AllStdSpeed;StdVelocityFlux];
     
     end
   end
   
   
   for j=1:lengthAE
       
       c=j+1;
       
       
%        %plot heat map
%       
%        subplot(3,3,j);
%        h= surf([reMin:(reMax-reMin)/(Nre-1):reMax],[-fNbefaft:fNbefaft],AllAvgVFlux{c,1}); xlabel('radius (pixel)'); ylabel('frame (10min)');title(['Extrusion frame ',num2str(AllExtrusion(j,1))]); 
%        if j==lengthAE
%            colorbar %remember 1st cell is useless cell   %only put color bar for last one since all have the same color bar scale
%        end
%        az = 0;    %view from overhead
%        el = 90;
%        view(az, el);
%        set(h, 'edgecolor','none');  %no black grid lines
%        
% %        %plot line graph
% %        plot([-10:10],AllAvgVFlux{c,1}(:,1),'y');  %r=20
% %        hold
% %        plot([-10:10],AllAvgVFlux{c,1}(:,2),'m');  %r=40
% %        
% %        plot([-10:10],AllAvgVFlux{c,1}(:,3),'c');  %r=60
% %        
% %        plot([-10:10],AllAvgVFlux{c,1}(:,4),'r');  %r=80
% %        
% %        plot([-10:10],AllAvgVFlux{c,1}(:,5),'g');  %r=100
% %        
% %        plot([-10:10],AllAvgVFlux{c,1}(:,6),'b');  %r=120
% %        
% %        plot([-10:10],AllAvgVFlux{c,1}(:,7),'k');  %r=140
% %       legend('r=20(pix)','r=40(pix)','r=60(pix)','r=80(pix)','r=100(pix)','r=120(pix)','r=140(pix)');
% %        title(['Extrusion frame ',num2str(AllExtrusion(j,1))]);
% %        xlabel('frame (10min)');
% %        ylabel('AvgVFlux');
% %        axis([-10 10 -2.5 2.5]); 
% 
%    end
%    
%      
% figure
%  sum3=AllAvgVFlux{2,1}+AllAvgVFlux{3,1}+AllAvgVFlux{4,1};
%  h= surf([reMin:(reMax-reMin)/(Nre-1):reMax],[-fNbefaft:fNbefaft],sum3); xlabel('radius (pixel)'); ylabel('frame (10min)');title(['Extrusion frame ',num2str(AllExtrusion(j,1))]); colorbar%caxis([-2 2.5]); 
%  az = 0;    %view from overhead
%        el = 90;
%        view(az, el);
%        set(h, 'edgecolor','none');  %no black grid lines
   
   
end