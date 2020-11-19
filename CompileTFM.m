
%FUNCTION: 
%1) to read and load into cell format - like what we get from PIVlab output.
% output: x_TFM, y_TFM, u_TFM, v_TFM in Matlab workplace environment
% the cell format will have each cell at one time point
% the force vector information is stored inside x_TFM, y_TFM, u_TFM, v_TFM
% variables


%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %Change parameters here
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       Nframes=100;
       Nstd_TFM=5;    %get rid of outliers from the mean for forces (based on force magnitude)  
       

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %FINISH Change parameters here
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%


  x_TFM=cell(Nframes,1);
  y_TFM=cell(Nframes,1);
  u_TFM=cell(Nframes,1);   %force direction (x component)
  v_TFM=cell(Nframes,1);
   TF_MartielOutput_tutorial=cell(Nframes,1);%%**
  
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%IMPORT Traction data TXT FILE SEQUENCES%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     
      for i=1:Nframes
         fileName = strcat('Traction_PIV',num2str(i),'.txt');   %%**
         TF_MartielOutput_tutorial{i,1}=importdata(fileName);
      end
      
      %%make it into PIVlab-style output
    
          xlist=sort(unique(TF_MartielOutput_tutorial{1,1}(:,1)));
          ylist=sort(unique(TF_MartielOutput_tutorial{1,1}(:,2)));
          dum=size(xlist);
          Numxpt=dum(1,1);
          dum=size(ylist);
          Numypt=dum(1,1);
          x_TFM{1,1}=[];
          y_TFM{1,1}=[];
          for j=1:Numypt
            x_TFM{1,1} =[x_TFM{1,1};xlist'];
          end
          for j=1:Numxpt
            y_TFM{1,1} =[y_TFM{1,1},ylist];
          end
          
          for i=2:Nframes
             x_TFM{i,1}=x_TFM{1,1}; 
             y_TFM{i,1}=y_TFM{1,1};
          end
          
     for i=1:Nframes
        for j=1:Numypt
            for k=1:Numxpt
                temp=TF_MartielOutput_tutorial{i,1};
                temp=temp(temp(:,1)==x_TFM{i,1}(j,k),:);
                temp=temp(temp(:,2)==y_TFM{i,1}(j,k),:);
                
                u_TFM{i,1}(j,k)=temp(1,3);
                v_TFM{i,1}(j,k)=temp(1,4);
            end
        end
     end
    
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%FINISH import Traction data TXT FILE SEQUENCES%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 