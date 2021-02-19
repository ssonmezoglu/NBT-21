clear all; close all; clc;

d = daq.getDevices;
s = daq.createSession('ni'); % Create session
tpoll = 5;   % Second
s.DurationInSeconds = tpoll; % Sample length
s.Rate = 400; % Sample rate

% Output channels
out1=addAnalogOutputChannel(s,'myDAQ1',1,'Voltage'); % Nitrogen gas
out2=addAnalogOutputChannel(s,'myDAQ1',0,'Voltage'); % Oxygen gas

V1 = 0*[0 1];  % Oxygen
V2 = 0;        % Nitrogen
 
% Initialization
Vout1 = zeros(length(V1),s.Rate*tpoll);
Vout2 = zeros(length(V1),s.Rate*tpoll);

for i = 1:length(V1)
    t = (1:(tpoll*s.Rate))/s.Rate;
    data0 = V1(i).*ones(length(t),1);
    data1 = V2.*ones(length(t),1);
    [data0(i) data1(i)]
    queueOutputData(s,[data0 data1]);
    [data,time] = s.startForeground();
    s.wait()
end

