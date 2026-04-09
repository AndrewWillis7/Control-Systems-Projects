clc
clear;
close all;

%% Load Parameters
p = params();

%% Modify

% Part A input modification
p.Ea = 10; % 10 | 20

% Part B parameter modification
p.wm_ref = 0; % 0 | 140
p.Ka = 5; % 5 | 40

%% Simulink
model = 'sim_closed';

simIn = Simulink.SimulationInput(model);
simIn = simIn.setVariable('params', p);
simIn = simIn.setModelParameter('StopTime', num2str(p.tstop), ...
    'MaxStep', num2str(p.maxstep));
simOut = sim(simIn);

t = simOut.wm.Time;
wm = simOut.wm.Data;

info = stepinfo(wm, t);
disp(info);

plot(t, wm);