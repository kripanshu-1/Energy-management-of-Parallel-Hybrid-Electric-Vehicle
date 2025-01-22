Project: Energy Management of Parallel Hybrid Electric Vehicle using Predictive Control Strategy (Model predicitve control)


Project Description:
This project focuses on energy management strategies for parallel hybrid electric vehicles (HEVs) using Model Predictive Control (MPC). The primary objective is to minimize fuel consumption while ensuring battery charge sustainment and respecting system constraints. The control strategy balances the power distribution between the electric motor and the internal combustion engine (ICE) using MPC.
Simulink models and MATLAB scripts were used for the implementation and testing of the proposed strategy. The performance was validated using standard drive cycles (NEDC and FTP-75), emphasizing the trade-off between energy efficiency and computational complexity.


Toolbox Required to Run the Model:
DSP System Toolbox; MATLAB;Model Predictive Control Toolbox; Simulink;Stateflow


Files and Their Functionality:
File 1: QSS_Toolbox.zip
Contains all the subsystems, including Drive-cycle, Vehicle, Manual Gearbox, Electric Motor, and Combustion Engine.
File 2: Initial_Data.mat
Contains initial variables and parameters required for running the MPC controller.
File 3: MPC_Implementation.m
MATLAB script used to create the prediction model, MPC object, initial constraints, and tuning parameters.
File 4: QSS_HEV.slx
Simulink model of the hybrid electric vehicle implementing the MPC strategy.


Steps to Run the Simulink Model:
Open MATLAB and Add Toolbox:
Unzip QSS_Toolbox.zip and add it to the current MATLAB folder using the "Add to Path" option (Selected Folders and Subfolders).
Locate the Required Files:
Inside the unzipped QSS_Toolbox folder, navigate to the Model directory and locate the files:
Initial_Data.mat; MPC_Implementation.m; QSS_HEV.slx
Load the Initial Data and Setup MPC:
Load Initial_Data.mat and run the MPC_Implementation.m script to set up the MPC controller.
Run the Simulink Model:
Open the QSS_HEV.slx file in Simulink and simulate the model.


Results and Future Improvements:
The MPC controller was able to minimize fuel consumption while ensuring battery charge sustainment. Simulations demonstrated effective power distribution between the electric motor and the combustion engine.
In fututre, Adaptive MPC can be implemented,which can dynamically update system parameters like motor efficiency and fuel rates.



Author:
Kripanshu Yadav,
Dept. of Commercial Vehicle Technology, 
RPTU Kaiserslautern, Germany
