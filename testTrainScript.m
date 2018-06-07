clear net mse reg idest
reps = 10;
regBounds = zeros([5 2],'double');
regDeltas = zeros([5 2],'double');

for j=50
    regs = zeros([reps 1],'double');
    mses = zeros([reps 1],'double');
for i=1:reps
    fprintf("STARTED TRAINING %d - %d\n",i,reps);
    [net,mse,reg,info] = trainFit(j,selectedMasterCopyPairsMean,masterCopyExpectedDiff,0);
    in = selectedMasterCopyPairsMean(:,info.testInd);
    tr = masterCopyExpectedDiff(:,info.testInd);
    ou = net(in);
    regs(i)=regression(tr,ou);
    mses(i)=immse(tr,ou);
    clear net mse reg info
end
[regBounds(j,:),regDeltas(j,:)] = ci(regs');
ci(mses');
end
r = 1:1:5;
rb = mean(regBounds');
figure,e=errorbar(r,rb,regDeltas(:,1),regDeltas(:,2)); hold on;
grid on;
set(gca,'XTick',[1 2 3 4 5]);
xlabel("hidden layer size");
ylabel("R=regression coefficient");
ylim([0.95 1]);
e.LineStyle = 'none';
e.Marker = '.';
e.MarkerSize = 10;
clear hiddenLayerSize