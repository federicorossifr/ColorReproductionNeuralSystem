function [labOrig,labMod] = plotSpectrum(origPair,subsPair,numSubSamples,subSampledRange,index,wlRange,adjDiff)
    modifiedSig = subsPair(1:numSubSamples,index);
    modifiedNoisyS = subsPair(numSubSamples+1:2*numSubSamples,index);
    originalS = origPair(1:421,index);
    labOrig=roo2lab(originalS',[],wlRange);
    originalNoisyS = origPair(422:421*2,index);
    labMod=roo2lab(originalNoisyS',[],wlRange);
    originalRange = 1:1:421;
    filename1 = sprintf("../Report/images/A_%d_%d_masterSub.png",numSubSamples,index);
    filename2 = sprintf("../Report/images/C_%d_%d_masterCopy.png",numSubSamples,index); 
    filename3 = sprintf("../Report/images/B_%d_%d_copySub.png",numSubSamples,index);
    filename4 = sprintf("../Report/images/D_%d_%d_masterCopySub.png",numSubSamples,index); 
    filename5 = sprintf("../Report/images/E_%d_masterCopyView.png",index);     
    f1 = figure('visible','off');    
    plot(originalRange,originalS,'--'); hold on; grid on;
    scatter(subSampledRange,modifiedSig,10,'k*'); 
    legend('Master original','Master compressed'); 
    xlabel("wavelength (nm)"); ylabel("% reflection");    
    saveas(f1,filename1); hold off;
    
    f2 = figure('visible','off');        
    plot(originalRange,originalS,'k-'); hold on; grid on;
    xlabel("wavelength (nm)"); ylabel("% reflection");        
    plot(originalRange,originalNoisyS,'k-.'); 
    legend('Master original','Copy original'); 
    saveas(f2,filename2); hold off;
    f3 = figure('visible','off');        
    plot(originalRange,originalNoisyS); hold on; plot(subSampledRange,modifiedNoisyS); legend('Copy original','Copy compressed'); saveas(f3,filename3); hold off;
    f4 = figure('visible','off');        
    plot(subSampledRange,modifiedSig); hold on; plot(subSampledRange,modifiedNoisyS); legend('Master compressed','Noisy compressed'); saveas(f4,filename4); hold off;    
    rgbO = lab2rgb(labOrig); rgbM = lab2rgb(labMod);
    
    f5 = figure('visible','on');
    rectangle('Position',[0 0 0.5 1],'EdgeColor',rgbO,'FaceColor',rgbO);
    hold on;
    xlabel(sprintf("diff: %f\ncorrected:%f",de(labOrig,labMod),adjDiff));
    rectangle('Position',[0.5 0 0.5 1],'EdgeColor',rgbM,'FaceColor',rgbM);
    set(gca,'xticklabel',[]);
    set(gca,'yticklabel',[]);
    saveas(f5,filename5);
end

