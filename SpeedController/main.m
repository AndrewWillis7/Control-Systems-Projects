clc
clear;
close all;

%% Load Parameters
p = params();

%% Modify

%% Simulink
model = 'sim_open';

simIn = Simulink.SimulationInput(model);
simIn = simIn.setVariable('params', p);
simIn = simIn.setModelParameter('StopTime', num2str(p.tstop));
simOut = sim(simIn);

t = simOut.wm.Time;
wm = simOut.wm.Data;

info = stepinfo(t, wm);
disp(info);

plot(t, wm);