%============================================
% FUNCTION USED BY SEQUENTIALFS TO SELECT
% BEST FEATURES BASED ON MSE RETURNED
%============================================
function [mse] = fitFs(inputs,targets)
    inputs = inputs';
    targets = targets';
    net = fitnet(4);
    net.trainParam.showWindow=0;    
    net.divideParam.trainRatio = 75/100;
    net.divideParam.valRatio = 15/100;
    net.divideParam.testRatio = 15/100;
    [net,trainingInfo] = train(net,inputs,targets);
    trIndex = trainingInfo.testInd;
    outputs = net(inputs(:,trIndex));
    mse = immse(outputs,targets(trIndex));
end

