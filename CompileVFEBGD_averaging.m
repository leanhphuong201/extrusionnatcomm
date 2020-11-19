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
        
       % put all individual Radial Traction Force for each event here
       % separated by semicolon.
       AllAvgVFlux_p1_list=[AllAvgVFlux_test]; 
        

% End of changing parameters
           
           dum=size(AllAvgVFlux_p1_list);
           Nump1list=dum(1,1);
           AllAvgVFlux_p1=zeros(2*fNbefaft+1,Nre);
           countmatrix=zeros(2*fNbefaft+1,Nre);
           StdVFlux_p1=zeros(2*fNbefaft+1,Nre);
           SteVFlux_p1=zeros(2*fNbefaft+1,Nre);  %standard error=std/sqrt(n)
           for f=1:1:2*fNbefaft+1
              for r=1:Nre
                 templist=[];
                 for i=1:Nump1list
                     if isempty(AllAvgVFlux_p1_list{i,1})==0
                       if isnan(AllAvgVFlux_p1_list{i,1}(f,r))==0  
                          countmatrix(f,r)=countmatrix(f,r)+1;
                          AllAvgVFlux_p1(f,r)=AllAvgVFlux_p1(f,r)+real(AllAvgVFlux_p1_list{i,1}(f,r));
                          templist=[templist;real(AllAvgVFlux_p1_list{i,1}(f,r))];
                       end
                     end
                 end
                 StdVFlux_p1(f,r)=nanstd(templist);
              end
           end
           for f=1:1:2*fNbefaft+1
               for  r=1:Nre
                  AllAvgVFlux_p1(f,r)=AllAvgVFlux_p1(f,r)/countmatrix(f,r);
                  SteVFlux_p1(f,r)=StdVFlux_p1(f,r)/sqrt(countmatrix(f,r)-1);
               end
           end
        

 %plot x-y inverted kymograph, and also in hours for paper %%
 figure
    h= surf([-fNbefaft:fNbefaft]*3,[reMin:(reMax-reMin)/(Nre-1):reMax]*0.1833,(AllAvgVFlux_p1)'); ylabel('radius (\mum)'); xlabel('min'); 
    colorbar
    az = 0;    %view from overhead
    el = 90;
    view(az, el);
    set(h, 'edgecolor','none');  %no black grid lines
    title(['Average Radial Traction'])
    
