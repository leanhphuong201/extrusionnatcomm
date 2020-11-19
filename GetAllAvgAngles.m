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

function AllAvgVFlux=GetAllAvgAngles(reMin,reMax,Nre,Widths,fNbefaft,AllExtrusion,x,y,u_filtered,v_filtered)
   dummy=size(AllExtrusion);
   lengthAE=dummy(1,1);
   dum=size(x);
   Totframes=dum(1,1);
   
   %initiate
   AllAvgVFlux=cell(1);
   
   %go through each extrusion site
   if lengthAE>0
     for i=1:lengthAE
        
    
               %initiate
                ExtFrame=AllExtrusion(i,1);
               AverageVelocityFlux=zeros(2*fNbefaft+1,Nre);
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

                          [AverageVelocityFlux(f,r)]=GetAverageAngles(Widths,Rext,Xext,Yext,PIVx,PIVy,PIVu,PIVv);
                       end

                       if ExtFrame-fNbefaft+f-1<1  &&  ExtFrame-fNbefaft+f-1>Totframes
                           AverageVelocityFlux(f,r)=NaN;
                       end

                   end
               end
               %AllAvgVFlux
               %AverageVelocityFlux
               AllAvgVFlux=[AllAvgVFlux;AverageVelocityFlux];
     
     end
   end
   
   
end