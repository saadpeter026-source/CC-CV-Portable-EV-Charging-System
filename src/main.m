%% Portable EV Charging System
% Main script for running the Portable EV Charging System Test 2 model

clear;
clc;
close all;

% Add the tests folder to the MATLAB path
repoRoot = fileparts(fileparts(mfilename('fullpath')));
addpath(fullfile(repoRoot, 'tests'));

% Open the Simulink model
open_system('Portable_Charging_System_Test_2');

% Run simulation
sim('Portable_Charging_System_Test_2');

disp('Simulation completed successfully.');
