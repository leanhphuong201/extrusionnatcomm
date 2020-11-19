%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Protocols of running the code to plot data for Traction Force Analysis on Matlab environment %%%%%%
Software: Matlab 2020a, Matlab 2020b, Matlab 2016a, Matlab 2018a, Matlab 2018b. 
License number: 40707750

The codes below are run for each sample to generate the kymographs. 
Sample kymographs are shown in the sample images data.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Part 1: Output the traction force data to be used in Matlab environment for analysis


Input: Traction forces from plugin FTTC from imagej
Output: Traction forces from one event in Matlab data file: x_TFM, y_TFM, u_TFM, v_TFM

Open the function CompileTFM.m (must be in the same folder with the traction force data
Manually change the parameters for number of frames
Run CompileTFM.m
Save the variables as tfm.mat

Open tfm.mat in Matlab Workspace for further analysis

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Part 2: Generating kymographs for traction force as a function of time with respect to extrusion center.
Input: x_TFM, y_TFM, u_TFM, v_TFM
Output: AllAvgSpeed_test, AllAvgVFlux_test, AllAvgAngles_test

Create the Extrusion List parameter with the format
[Extrusion1_StartTime x_Extrusion1 y_Extrusion1;
Extrusion2_StartTime x_Extrusion2 y_Extrusion2;
.........]

With x and y are the position of extrusion site on the actual image (in pixel)

Run the following files for calculating the averaged forces. Remember to change the parameters in each file accordingly.
1) Traction Force Magnitude: CompileSEBGD.m
Output: AllAvgSpeed_test
2) Radial Traction Force: CompileVFEBGD.m
Output: AllAvgVFlux_test
3) Orthoradial Traction Force: CompileTangential.m 
Output: AllAvgOrthoradial_test

The plot scales can be adjusted using the matlab built-in function 

Save everything in the matlab data format tfm.mat. Change the name of the outputs to more specific format 
(experiment, date, month, year) for each sample data.

Save the variables as tfm.mat

Open tfm.mat in Matlab Workspace for further analysis

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Part 3: Generating averaged kymograph (as plot) from many extrusion events
Input: AllAvgAngles_Orthoradial_test, AllAvgSpeed_test, AllAvgVFlux_test
Output: Kymograph plots 

Run the following files for:
1) Average Traction Force Magnitude kymograph: CompileSEBGD_averaging.m
The averaged data will be generated into the variable AllAvgSpeed_p1

2) Average Radial Force Magnitude kymograph: CompileVFEBGD_averaging.m
The averaged data will be generated into the variable AllAvgVFlux_p1

3) Average Orthoradial Force Magnitude kymograph: CompileTangential_averaging.m
The averaged data will be generated into the variable AllAvgTangential

The sample output in raw data form is saved in averagedata.mat file in Output folder. 
The plots are saved in .fig files in Output folder and can be openned in Matlab to be saved into jpeg, tif, eps, ... formats 
Scales can be adjusted using the matlab built-in function xlim(), ylim, caxis(), colormap()


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Part 4: Some other useful functions to use with x_TFM, y_TFM, u_TFM, v_TFM

FindForceMagnitude.m to find the traction force magnitude and represents them in the form of a matrix, with value at each (x,y) in the matrix is the traction force scalar components.
FindRadialVector.m to find the radial force and represents them in the form of a matrix, with value at each (x,y) in the matrix is the radial component of the traction force.
ForceAnglewrtExtrusion.m to find the cosine of force angle w.r.t extrusion site and represents them in the form of a matrix, with value at each (x,y) in the matrix is the cosine of the radial of the traction force.