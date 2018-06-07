%===================================================
% FUCNTION TO COMPUTE 95% CONFIDENCE INTERVAL
%===================================================
function [bounds,rel] = ci(data)
SEM = std(data)/sqrt(length(data));               % Standard Error
ts = tinv([0.025  0.975],length(data)-1);      % T-Score
bounds = mean(data) + ts*SEM;                      % Confidence Intervals
rel = ts*SEM;
fprintf("%f \\pm %f\n",mean(data),rel(2));
end

