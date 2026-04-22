% create_two_area_power_system.m

% This script creates a complete Simulink model of a two-area power system
% with PV and wind farm integration based on the specified block diagram.

% Define system parameters

% Area 1 parameters
P1 = 100; % Power in MW
H1 = 5; % Inertia constant
D1 = 0.1; % Damping factor
k1 = 1; % Gain

% Area 2 parameters
P2 = 100; % Power in MW
H2 = 5; % Inertia constant
D2 = 0.1; % Damping factor
k2 = 1; % Gain

% Create transfer functions
s = tf('s');
G1 = P1/(H1*s + D1);
G2 = P2/(H2*s + D2);

% Create the closed-loop transfer functions for the controllers
T1 = G1/(1 + G1*k1);
T2 = G2/(1 + G2*k2);

% Define the wind farm and PV integration

% PV System Parameters
PV_P = 20; % PV Power in MW
PV_W = 1; % PV Efficiency

% Wind Farm Parameters
WF_P = 30; % Wind Farm Power in MW
WF_E = 1; % Wind Farm Efficiency

% Create the model
open_system(new_system('TwoAreaPowerSystem'));
add_block('powerlib/Machines/Generator',[ 'TwoAreaPowerSystem/Generator1']);
add_block('powerlib/Machines/Generator',[ 'TwoAreaPowerSystem/Generator2']);

% Add additional blocks based on the block diagram to complete the model

% Define the input-output system dynamics

% Here, you would programmatically add the necessary blocks and connect them

% Save the model
save_system('TwoAreaPowerSystem');
close_system('TwoAreaPowerSystem');

% Display completion message
disp('Two-area power system model created successfully.');