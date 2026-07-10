%% ========================================================================
%% Clear Workspace
%% Clear previous variables, command window, and figures
%% ========================================================================

clear;
clc;
close all;

%% ========================================================================
%% Setup - Find the file in the github workspace
%% ========================================================================

repoRoot = fileparts(fileparts(mfilename('fullpath')));
addpath(fullfile(repoRoot,'tests'));

modelName = 'Portable_Charging_System_Test_2_1_';

%% ========================================================================
%% Run Simulation - Open the Simulink model and run the simulation.
%% ========================================================================

open_system(modelName);
simOut = sim(modelName);

logs = simOut.logsout;

disp('Simulation completed successfully.');

%% ========================================================================
%% Retrieve Logged Signals - Simulink logs the simulation data to logsout.
%% MATLAB retrieves the logged voltage, current, SOC, thermal, and efficiency signals.
%% ========================================================================
% Portable Battery
portableSOC = logs.get('Portable Battery State of Charge (SOC)');

% EV Battery
evVoltage = logs.get('EV Battery Charging Voltage');
evCurrent = logs.get('EV Battery Charging Current');
evSOC = logs.get('EV Battery State of Charge (SOC)');
batteryTemp = logs.get('EV Battery Temperature During Charging');

% IGBT Temperatures
junctionTemp = logs.get('IGBT Junction Temperature During Charging');
caseTemp = logs.get('IGBT Case Temperature During Charging');
heatsinkTemp = logs.get('IGBT Heatsink Temperature During Charging');

% Efficiency
eff = logs.get('Efficiency');

%% ========================================================================
%% Plot Results - MATLAB uses the logged signals from Simulink to create
%% individual plots with titles, axis labels, and grids.
%% ========================================================================

%% ------------------------------------------------------------------------
%% EV Battery Charging Voltage
%% ------------------------------------------------------------------------

figure;
plot(evVoltage.Values.Time, evVoltage.Values.Data, 'LineWidth', 2);
title('EV Battery Charging Voltage');
xlabel('Time (s)');
ylabel('Voltage (V)');
grid on;

%% ------------------------------------------------------------------------
%% EV Battery Charging Current
%% ------------------------------------------------------------------------

figure;
plot(evCurrent.Values.Time, evCurrent.Values.Data, 'LineWidth', 2);
title('EV Battery Charging Current');
xlabel('Time (s)');
ylabel('Current (A)');
grid on;

%% ------------------------------------------------------------------------
%% EV Battery State of Charge (SOC)
%% ------------------------------------------------------------------------

figure;
plot(evSOC.Values.Time, evSOC.Values.Data, 'LineWidth', 2);
title('EV Battery State of Charge');
xlabel('Time (s)');
ylabel('State of Charge (%)');
grid on;

%% ------------------------------------------------------------------------
%% Portable Battery State of Charge (SOC)
%% ------------------------------------------------------------------------

figure;
plot(portableSOC.Values.Time, portableSOC.Values.Data, 'LineWidth', 2);
title('Portable Battery State of Charge');
xlabel('Time (s)');
ylabel('State of Charge (%)');
grid on;

%% ------------------------------------------------------------------------
%% EV Battery Temperature
%% ------------------------------------------------------------------------

figure;
plot(batteryTemp.Values.Time, batteryTemp.Values.Data, 'LineWidth', 2);
title('EV Battery Temperature');
xlabel('Time (s)');
ylabel('Temperature (°C)');
grid on;

%% ------------------------------------------------------------------------
%% IGBT Temperatures
%% ------------------------------------------------------------------------

figure;
plot(junctionTemp.Values.Time, junctionTemp.Values.Data, 'LineWidth', 2);
hold on;
plot(caseTemp.Values.Time, caseTemp.Values.Data, 'LineWidth', 2);
plot(heatsinkTemp.Values.Time, heatsinkTemp.Values.Data, 'LineWidth', 2);
hold off;

title('IGBT Temperatures');
xlabel('Time (s)');
ylabel('Temperature (°C)');
legend('Junction','Case','Heatsink','Location','best');
grid on;

%% ------------------------------------------------------------------------
%% Charging Efficiency
%% ------------------------------------------------------------------------

figure;
plot(eff.Values.Time, eff.Values.Data, 'LineWidth', 2);
title('Charging Efficiency');
xlabel('Time (s)');
ylabel('Efficiency (%)');
grid on;





...
