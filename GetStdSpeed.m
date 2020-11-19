%Widths=Strip area around window edge which to take vector flux
%Rext=radius of extrusion window (assume a circle shape)
%Xext=X of extrusion window centre
%Yext=Y of extrusion window centre
%Rcircle= radius of stamp circle
%Xcircle= X of stamp centre
%Ycircle=Y of stamp centre
%PIVx=X of centres of PIV cells (2by2 matrix)have same width and height as other PIVy,u,v
%PIVy= Y of centres of PIV cells (2by2 matrix)
%PIVu=x component velocity in corresponding PIV cells (2by2matrix)
%PIVv=y component velocity in corresponding PIV cells (2by2matrix)


%Here we do not care if the extrusion window cuts the outwide of the stamp.
%just take the points that is within the extrusion window edge
function [StdSpeed]=GetStdSpeed(Widths,Rext,Xext,Yext,PIVx,PIVy,PIVu,PIVv)
  
%   figure
%   plot(Xcircle,Ycircle,'o');  %circle centre
%   hold on
%   plot(Xext,Yext,'o');
%   hold on
  
  dummy=size(PIVx);
  heightPIV=dummy(1,1);
  lengthPIV=dummy(1,2);
  
  %initiate 
  sumvarSpeed=0;  
  Number=0; 
  StdSpeed=0;
  AvgSpeed = GetAverageSpeed(Widths,Rext,Xext,Yext,PIVx,PIVy,PIVu,PIVv);
  
  
  
       
       %scan all cells given by PIV
       for i=1:heightPIV
          for j=1:lengthPIV
             if isnan(PIVu(i,j))==0 && isnan(PIVv(i,j))==0
                 dx=PIVx(i,j)-Xext;
                 dy=PIVy(i,j)-Yext;
                 %if points fall into ext window strip, take this flux
                 %contribution
                 if sqrt(dx^2+dy^2)<=Rext+Widths/2 && sqrt(dx^2+dy^2)>=Rext-Widths/2 
%                     quiver(PIVx(i,j),PIVy(i,j),PIVu(i,j),PIVv(i,j));
%                     hold on
                    
                    speed=sqrt((PIVu(i,j))^2+(PIVv(i,j))^2);
                    Number=Number+1;
                    sumvarSpeed=sumvarSpeed+(speed-AvgSpeed).^2;  
                    
                    PIVu(i,j)=NaN;  %to prevent reaccessing same point taken, increase total computing speed
                    PIVv(i,j)=NaN;
                 end
             end
          end
       end
       
       if Number>0
          StdSpeed=sqrt(sumvarSpeed/(Number));
       end
   end
  
  
