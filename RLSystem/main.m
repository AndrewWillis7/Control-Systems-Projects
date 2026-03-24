clc
clear;
close all;

%% RL Circuit tf
% G(s) = Vo(s) / Vi(s) = R / (Ls+R)
L = 1;
R = 2;

%% Design Specs
OS = 10; % Overshoot
Ts_req = 1; % Settling time must be under 1 second

%% Solve for damping ratio from overshoot
zeta = -log(OS/100) / sqrt(pi^2 + (log(OS/100))^2);

%% Choose wn to satisfy Ts < 1 sec
% Ts ~= 4/(zeta*wn)
wn_min = 4/(zeta*Ts_req);

% choose a value a bit larger than minimum for margin
wn = 8;

%% PI Controller Design
% Characteristic Equation:
% s^2 + (2 + 2*Kp)s + 2*Ki = 0
% Match with s^2 + 2*zeta*wn*s + wn^2 (Derived from hand-calcs)

Kp = zeta * wn - 1;
Ki = wn^2 / 2;

fprintf('Kp = %.4f\n', Kp);
fprintf('Ki = %.4f\n', Ki);

%% Send Variables to base workspace
assignin('base', 'Kp', Kp);
assignin('base', 'Ki', Ki);

%% Run Simulink
model = 'sim';
disp(['About to simulate model: ', model]);

load_system(model);

% Simulation Time
simIn = Simulink.SimulationInput(model);
simIn = simIn.setModelParameter('StopTime', '5');
simOut = sim(simIn);

%% Extract Data from Simulink
t = simOut.yout.time;
y = simOut.yout.signals.values;

%% Plot in Matlab
figure;
plot(t, y, 'LineWidth', 2);
grid on;
xlabel('Time (s)');
ylabel('Output');
title('Step Response (RL System)');

%% Performance Metrics
info = stepinfo(y, t);

disp('Performance from Simulink:');
disp(info);

