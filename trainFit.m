function [net,mse,reg,trainingInfo] = trainFit(hiddenLayerSize,inputs,targets,show)
    net = fitnet(hiddenLayerSize);
    net.trainParam.showWindow=show;    
    net.divideParam.trainRatio = 75/100;
    net.divideParam.valRatio = 15/100;
    net.divideParam.testRatio = 15/100;
    [net,trainingInfo] = train(net,inputs,targets);
    trIndex = trainingInfo.trainInd;
    outputs = net(inputs(:,trIndex));
    mse = immse(outputs,targets(trIndex));
    reg = regression(targets(trIndex),outputs);
end

