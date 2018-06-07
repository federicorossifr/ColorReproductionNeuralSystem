load data.mat
ind = 120;
spec = spectra(:,ind)*100;
k_s = 5;
k_e = 20;
step = 5;
wlRange = 1:1:421;
f1=figure('visible','on');
plot(wlRange,spec,'-.'); hold on; grid on;
xlabel("wavelength (nm)");
ylabel("% reflection");
legendInfo = {(k_e-k_s)/step+1};
legendInfo{1} = "original";
legendCounter = 2;
markers = '+o*dx';
colors = 'kkkkk';
for i=k_s:step:k_e
    [extracted,range] = extractFeatures(spec,i);
    legendInfo{legendCounter} = sprintf("k=%d",i);
    scatter(range,extracted,20,[colors(legendCounter-1) markers(legendCounter-1)]);     
    legendCounter=legendCounter+1;
end
legend(legendInfo);
filename = sprintf("../Report/images/%d_%d_%d_%d_masterSub.png",ind,k_s,step,k_e);
saveas(f1,filename);


