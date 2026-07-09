%% Portable EV Charging System
% Main script for running the Portable EV Charging System Test 2 model

clear;
clc;
close all;

% Add the tests folder to the MATLAB path
repoRoot = fileparts(fileparts(mfilename('fullpath')));
addpath(fullfile(repoRoot,'tests'));

% Model name
modelName = 'Portable_Charging_System_Test_2_1_';

% Open the Simulink model
open_system(modelName);

% Run simulation
simOut = sim(modelName);

% Get logged signals
logs = simOut.logsout;

disp('Simulation completed successfully.');

% Efficiency
eff = logs.get('Efficiency');

% Portable Battery SOC
portableSOC = logs.get('Portable Battery State of Charge (SOC)');

% EV Voltage
evVoltage = logs.get('EV Battery Charging Voltage');

% EV Current
evCurrent = logs.get('EV Battery Charging Current');

% EV SOC
evSOC = logs.get('EV Battery State of Charge (SOC)');

% Battery Temperature
batteryTemp = logs.get('EV Battery Temperature During Charging');

% IGBT Temperatures
junctionTemp = logs.get('IGBT Junction Temperature During Charging');
caseTemp = logs.get('IGBT Case Temperature During Charging');
heatsinkTemp = logs.get('IGBT Heatsink Temperature During Charging');
