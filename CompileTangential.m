%IDEA:
%Yusuke commented that since we separate phase 1 and phase2 by time in each
%experiment, that means there is significant overlap between the overall
%(after accumulation from all samples) phase 1 and phase 2 densities during extrusion. The question is whether
%this will give artefacts, and lower the significance in the difference
%between the VFlux kymographs of the two phases determined this way.
%To probe this question, here we separate phases by a fixed lower and
%higher density limit, and not purely by time in each experiment. So there
%can be cases where one sample with high starting density will have only
%phase2.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Change parameters here

      %for the range of Vflux kymograph
       reMin=0; %20  %pix
       reMax=200; %pix
       Nre=21;%43; 
       fNbefaft=100;
        Widths=(reMax-reMin)/(Nre-1); %s.t. =5

AllAvgOrthoradial_test = GetAllAvgVParallel(reMin,reMax,Nre,Widths,fNbefaft,ExtList,x_TFM,y_TFM,u_TFM,v_TFM);
