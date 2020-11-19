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
function [AverageVelocityFlux]=GetAverageAngles(Widths,Rext,Xext,Yext,PIVx,PIVy,PIVu,PIVv)
  
%   figure
%   plot(Xcircle,Ycircle,'o');  %circle centre
%   hold on
%   plot(Xext,Yext,'o');
%   hold on
  
  dummy=size(PIVx);
  heightPIV=dummy(1,1);
  lengthPIV=dummy(1,2);
  
  %initiate 
  sumFlux=0;  %convention: positive if flux points inwards
  Number=0; 
  AverageVelocityFlux=0;
  
  
  
  
       
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
                    
                    re_vect=[Xext-PIVx(i,j);Yext-PIVy(i,j)];   %normal vector convention to point inside, so inward flux is positive
                    v_vect=[PIVu(i,j);PIVv(i,j)];
                    Number=Number+1;
                    sumFlux=sumFlux+dot(re_vect,v_vect)/(norm(re_vect)*norm(v_vect));  
                    
                    PIVu(i,j)=NaN;  %to prevent reaccessing same point taken, increase total computing speed
                    PIVv(i,j)=NaN;
                 end
             end
          end
       end
       
       if Number>0
          AverageVelocityFlux=sumFlux/Number;
       end
   end
  
  
