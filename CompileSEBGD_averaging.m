% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The function below is to pool all kymographs generated for each extrusion event.
% The function will generate the averaged kymographs for all data and plot into the 
% kymograph graph. Each pixel in the kymograph represents averaged traction force 
% between radius r with reMin < r < rMax from all extrusion events.
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Change parameters here

      %for the range of the kymograph
       reMin=0; %lower limit for the smallest radius  %pix
       reMax=200; %the upper limit for the radius for plotting pix
       Nre=21;%43; 
       fNbefaft=100;
        Widths=(reMax-reMin)/(Nre-1); %s.t. =5

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%pool all exps 
           AllAvgSpeed_p1_list=[AllAvgSpeed_test];
           dum=size(AllAvgSpeed_p1_list);
           Nump1list=dum(1,1);
           AllAvgSpeed_p1=zeros(2*fNbefaft+1,Nre);
           countmatrix=zeros(2*fNbefaft+1,Nre);
           StdSpeed_p1=zeros(2*fNbefaft+1,Nre);
           SteSpeed_p1=zeros(2*fNbefaft+1,Nre);  %standard error=std/sqrt(n)
           for f=1:1:2*fNbefaft+1
              for r=1:Nre
                 templist=[];
                 for i=1:Nump1list
                     if isempty(AllAvgSpeed_p1_list{i,1})==0
                       if isnan(AllAvgSpeed_p1_list{i,1}(f,r))==0  
                          countmatrix(f,r)=countmatrix(f,r)+1;
                          AllAvgSpeed_p1(f,r)=AllAvgSpeed_p1(f,r)+real(AllAvgSpeed_p1_list{i,1}(f,r));
                          templist=[templist;real(AllAvgSpeed_p1_list{i,1}(f,r))];
                       end
                     end
                 end
                 StdSpeed_p1(f,r)=std(templist);
              end
           end
           for f=1:1:2*fNbefaft+1
               for  r=1:Nre
                  AllAvgSpeed_p1(f,r)=AllAvgSpeed_p1(f,r)/countmatrix(f,r);
                  SteSpeed_p1(f,r)=StdSpeed_p1(f,r)/sqrt(countmatrix(f,r)-1);
               end
           end
        

 %plot x-y inverted kymograph, and also in hours for paper %%
 figure
    h= surf([-fNbefaft:fNbefaft]*3,[reMin:(reMax-reMin)/(Nre-1):reMax]*0.1833,(AllAvgSpeed_p1)'); ylabel('radius (\mum)'); xlabel('min'); 
    colorbar
    az = 0;    %view from overhead
    el = 90;
    view(az, el);
    set(h, 'edgecolor','none');  %no black grid lines
    title(['Average Total Traction Force'])
    
