clear net mse reg idest
%===================================================
% CREATE AND TRAIN THE FITTING NEURAL NETWORK
%===================================================
hiddenLayerSize = 50;
diffThreshold = 8;
useIndexes = masterCopyExpectedDiff < diffThreshold;
newIn = selectedMasterCopyPairsMean(:,useIndexes);
newTr = masterCopyExpectedDiff(:,useIndexes);
[net,mse,reg,info] = trainFit(hiddenLayerSize,newIn,newTr,0);

%COMPUTE REGRESSION ON TEST INDEXES (NOT USED IN TRAINING - PROOF FOR
%GENERALIZATION OF THE NETWORK
in = newIn(:,info.testInd);
tr = newTr(:,info.testInd);
out = net(in);
plotregression(tr,out);
filename = sprintf("../Report/images/adj_net_%d_reg.png",hiddenLayerSize);
saveas(gca,filename);
clear hiddenLayerSize