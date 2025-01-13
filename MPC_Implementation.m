
%% MPC Implementation


%load('/Users/apple/Desktop/Energy Management/QSS_TB_Seminar/Examples/Seminar/Initial_Data.mat')


%% State-Space Prediction Model

% Defining parameters
etta_EM = 0.85;                                                 % Considering constant motor efficiency for Prediction Model
etta_CE = 0.35;                                                 % Considering constant engine efficiency for Prediction Model
Ts=1;                                                           % Sample Time
U_nominal = 47;                                                 % Considering nominal voltage (in Volts)
A_0 = [1 0;0 1];                                                % State Matrix
B_0 = [-Ts/(U_nominal*etta_EM) 0 0; 0 1/(etta_CE*H_u) 0];       % Input Matrix
C_0 = [1 0;0 1];                                                % Output Matrix
D_0 = [0 0 0;0 0 0];                                            % Feedthrough Matrix

Sys_Dynamics = ss(A_0,B_0,C_0,D_0,1);                           % Creating discrete state-space model

%% MPC Object Creation
Predict_Horizon=11;                                             % Prediction Horizon
Control_Horizon=2;                                              % Control Horizon
plant=setmpcsignals(Sys_Dynamics, 'MV', [1,2], 'MD', 3);        % Assigning the Control Inputs as manipulated variable or measured distrubances
mpc_object= mpc(plant,1,Predict_Horizon,Control_Horizon);       % Creating the MPC Object

setname(mpc_object,'input',1,'P_EM_mech'); 
setname(mpc_object,'input',2,'P_CE_mech');
setname(mpc_object,'input',3,'P_MGB');
setname(mpc_object,'output',1,'Q_BT');
setname(mpc_object,'output',2,'V_CE');

%% Constraints

% Initialization of Output Variables Constraints
mpc_object.OutputVariables(1).Min = 3600;                       % Minimum charge (in Coloumb)
mpc_object.OutputVariables(2).Min = 0;                          % Minimum Mass of fuel (in kg)
mpc_object.OutputVariables(1).Max = 32400;                      % Maximum charge (in Coloumb)
mpc_object.OutputVariables(2).Max = inf;                        % Maximum Mass of fuel (in kg)

% Initial Manipulated Variable/Control Variable Constraints
mpc_object.ManipulatedVariables(1).Min = -12000;                % Minimum mechanical power(P_EM_mech) by motor (in Watts)
mpc_object.ManipulatedVariables(2).Min = 0;                     % Minimum mechanical power(P_CE_mech) by combustion engine (in Watts)
mpc_object.ManipulatedVariables(1).Max = 12000;                 % Maximum mechanical power(P_EM_mech) by motor (in Watts)
mpc_object.ManipulatedVariables(2).Max = 53500;                 % Maximum mechanical power(P_CE_mech) by combustion engine (in Watts)

% Input-Output Constraint  (i.e P_MGB = P_CE_mech + P_EM_mech)
E=[-1 -1;1 1];
F=[0 0;0 0];
G=[0;0];
V=[0;0];
S=[1;-1];
setconstraint(mpc_object,E,F,G,V,S);

% Changing Soft Constraint to Hard Constraint
mpc_object.ManipulatedVariables(1).MinECR = 0;
mpc_object.ManipulatedVariables(2).MinECR = 0;
mpc_object.ManipulatedVariables(1).MaxECR = 0;
mpc_object.ManipulatedVariables(2).MaxECR = 0;

%% Defining the inital vaules of Output Variables/State Variables (same in our case)
state_object = mpcstate(mpc_object);
state_object.Plant = [18000;0];

%% Tuning Parameters 
mpc_object.Weights.ManipulatedVariables = [0.00001 10];         % Weights for Manipulated Variables Tracking
mpc_object.Weights.OutputVariables = [5 1];                     % Weights for Output Variables Tracking
mpc_object.Weights.ManipulatedVariablesRate = [0 0];            % Weights for Manipulated Variable Rate Tracking





controllabilityMatrix = ctrb(Sys_Dynamics);
controllabilityRank = rank(controllabilityMatrix);

if controllabilityRank < size(A_0, 1)
    disp('The system is not fully controllable.');
else
    disp('The system is fully controllable.');
end

observabilityMatrix = obsv(Sys_Dynamics);
observabilityRank = rank(observabilityMatrix);

if observabilityRank < size(A_0, 1)
    disp('The system is not fully observable.');
else
    disp('The system is fully observable.');
end

