%% Portable EV Charging System
% Main script for running the Portable EV Charging System Test 2 model

clear;
clc;
close all;

% Open the Simulink model
open_system('Portable_Charging_System_Test_2');

% Run simulation
sim('Portable_Charging_System_Test_2');

disp('Simulation completed successfully.');
