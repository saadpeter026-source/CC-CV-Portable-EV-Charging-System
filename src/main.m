%% Portable EV Charging System
% Main script for running the Portable EV Charging System model

clear;
clc;
close all;

% Open the Simulink model
open_system('Portable_Charging_System');

% Run simulation
sim('Portable_Charging_System');

disp('Simulation completed successfully.');
