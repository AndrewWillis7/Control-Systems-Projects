%% Model Parameters

function p = params()
p = struct();

%% DC Motor Parameters
p.Kb = 0.0772;
p.Ki = 0.067;
p.Ra = 0.7454;
p.La = 4.8e-3;
p.Jm = 6.87e-5;
p.Bm = 0.0003;

%% Controller / Sensor
p.Ks = 1;
p.Ka = 5;

%% Disturbance
p.TL_step = 0.1;
p.Td = 2;

%% Inputs (default)
p.Ea = 10;
p.wm_ref = 140;

%% Simulation
p.tstop = 6;
p.maxstep = 0.001;

p.den = [p.Jm * p.La, ...
    p.Jm * p.Ra + p.Bm * p.La, ...
    p.Bm * p.Ra + p.Ki * p.Kb];

p.num_v = [p.Ki];
p.num_d = [-p.La, -p.Ra];