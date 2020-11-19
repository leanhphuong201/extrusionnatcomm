%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The function below is to plot the kymograph for traction force of individual 
% data with respected to the center of extrusion. x axis is the time and y-axis is
% the radius from the extrusion center. y axis is the average force for each ring
% of width = Widths starting of radius between 
% reMin < r < reMax from extrusion center. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Change parameters here

      %for the range of Vflux kymograph
       reMin=0;%20;  %pix
       reMax=200; %pix
       Nre=21;%43; 
       fNbefaft=100; %frame before and after extrusion
        Widths=(reMax-reMin)/(Nre-1); %s.t. =5


   AllAvgSpeed_test=GetAllAvgSpeed(reMin,reMax,Nre,Widths,fNbefaft,ExtList,x_TFM,y_TFM,u_TFM,v_TFM);
   
 
