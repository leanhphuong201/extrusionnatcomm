% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The function below is to pool all kymographs generated for each extrusion event.
% The function will generate the averaged kymographs for all data and plot into the 
% kymograph graph. Each pixel in the kymograph represents averaged traction force 
% between radius r with reMin < r < rMax from all extrusion events.
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Change parameters here

      %for the range of Vflux kymograph
       reMin=0; %20  %pix
       reMax=200; %pix
       Nre=21;%43; 
       fNbefaft=100;
        Widths=(reMax-reMin)/(Nre-1); %s.t. =5


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%pull all exps into one averaged graph of phase  1 and phase 2
        %phase1
           AllAvgTangential_p1_list=[AllAvgOrthoradial_test];
               
           dum=size(AllAvgTangential_p1_list);
           Nump1list=dum(1,1);
           AllAvgTangential=zeros(2*fNbefaft+1,Nre);
           countmatrix=zeros(2*fNbefaft+1,Nre);
           StdVFlux_p1=zeros(2*fNbefaft+1,Nre);
           SteVFlux_p1=zeros(2*fNbefaft+1,Nre);  %standard error=std/sqrt(n)
           for f=1:1:2*fNbefaft+1
              for r=1:Nre
                 templist=[];
                 for i=1:Nump1list
                     if isempty(AllAvgTangential_p1_list{i,1})==0
                       if isnan(AllAvgTangential_p1_list{i,1}(f,r))==0  
                          countmatrix(f,r)=countmatrix(f,r)+1;
                          AllAvgTangential(f,r)=AllAvgTangential(f,r)+real(AllAvgTangential_p1_list{i,1}(f,r));
                          templist=[templist;real(AllAvgTangential_p1_list{i,1}(f,r))];
                       end
                     end
                 end
                 StdVFlux_p1(f,r)=std(templist);
              end
           end
           for f=1:1:2*fNbefaft+1
               for  r=1:Nre
                  AllAvgTangential(f,r)=AllAvgTangential(f,r)/countmatrix(f,r);
                  SteVFlux_p1(f,r)=StdVFlux_p1(f,r)/sqrt(countmatrix(f,r)-1);
               end
           end
        

 %plot x-y inverted kymograph, and also in hours for paper %%
 figure
    h = surf([-fNbefaft:fNbefaft]*3,[reMin:(reMax-reMin)/(Nre-1):reMax]*0.1833,(AllAvgTangential)'); 
%     ylabel('radius (\mum)'); 
%     xlabel('min'); 
    colorbar
    az = 0;    %view from overhead
    el = 90;
    view(az, el);
    set(h, 'edgecolor','none');  %no black grid lines
    title(['Average Orthoradial Traction'])
 