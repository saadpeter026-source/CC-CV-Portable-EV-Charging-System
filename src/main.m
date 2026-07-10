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


%% Plot Results

% EV Battery Charging Voltage
figure;
plot(evVoltage.Values.Time, evVoltage.Values.Data, 'LineWidth', 2);
title('EV Battery Charging Voltage');
xlabel('Time (s)');
ylabel('Voltage (V)');
grid on;

% EV Battery Charging Current
figure;
plot(evCurrent.Values.Time, evCurrent.Values.Data, 'LineWidth', 2);
title('EV Battery Charging Current');
xlabel('Time (s)');
ylabel('Current (A)');
grid on;

% EV Battery State of Charge
figure;
plot(evSOC.Values.Time, evSOC.Values.Data, 'LineWidth', 2);
title('EV Battery State of Charge');
xlabel('Time (s)');
ylabel('State of Charge (%)');
grid on;

% Portable Battery State of Charge
figure;
plot(portableSOC.Values.Time, portableSOC.Values.Data, 'LineWidth', 2);
title('Portable Battery State of Charge');
xlabel('Time (s)');
ylabel('State of Charge (%)');
grid on;

% EV Battery Temperature
figure;
plot(batteryTemp.Values.Time, batteryTemp.Values.Data, 'LineWidth', 2);
title('EV Battery Temperature');
xlabel('Time (s)');
ylabel('Temperature (°C)');
grid on;

% IGBT Temperatures
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

% Efficiency
figure;
plot(eff.Values.Time, eff.Values.Data, 'LineWidth', 2);
title('Charging Efficiency');
xlabel('Time (s)');
ylabel('Efficiency (%)');
grid on;

disp('Simulation completed successfully.');





