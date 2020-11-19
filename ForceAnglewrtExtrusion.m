Nframes = 69; 

angular = cell(Nframes,1);

for numberframe = 1:Nframes

PIVx = x{numberframe,1};
PIVy = y{numberframe,1};
PIVu = u_filtered{numberframe,1};
PIVv = v_filtered{numberframe,1};


 dummy=size(PIVx);
 heightPIV=dummy(1,1);
 lengthPIV=dummy(1,2);
 

angularmatrix = ones(heightPIV,lengthPIV);

for i=1:heightPIV
          for j=1:lengthPIV
                    re_vect=[Xext-PIVx(i,j);Yext-PIVy(i,j)];   %normal vector convention to point inside, so inward flux is positive
                    v_vect=[PIVu(i,j);PIVv(i,j)];

                    angle = dot(re_vect,v_vect)/(norm(re_vect)*norm(v_vect));
                    
                    angularmatrix(i,j) = angle;
          end
end

angular{numberframe,1} = angularmatrix;
end