% This function find the total traction force magnitude and output in the form of cell
% with each cell represents one time frame. 
% In each cell, the forces are represented as a matrix with each element (x,y) in the matrix 
% represents the traction fores measured at each position x_TFM,y_TFM. 

% Change parameters here for number of frames to be run
Nframes = 80; 
% End of change parameters

ForceMagnitude = cell(Nframes,1);

for numberframe = 1:Nframes

PIVx = x_TFM{numberframe,1};
PIVy = y_TFM{numberframe,1};
PIVu = u_TFM{numberframe,1};
PIVv = v_TFM{numberframe,1};


 dummy=size(PIVx);
 heightPIV=dummy(1,1);
 lengthPIV=dummy(1,2);
 

Force_matrix = ones(heightPIV,lengthPIV);

for i=1:heightPIV
          for j=1:lengthPIV


                    Force = sqrt(PIVu(i,j).^2 + PIVv(i,j).^2);
                    
                    Force_matrix(i,j) = Force;
          end
end

ForceMagnitude{numberframe,1} = Force_matrix;
end