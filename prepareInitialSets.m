function [masterCopyPairs,masterCopyExpectedDiff,copyLabs,masterLabs,fuzzyInputs,origlch] = prepareInitialSets(spectra,numcopies,wlRange,coordinates)
    rng(12); % SET THE SEED TO PRODUCE REPEATABLE NOISES
    optsetpref('cwf','D65/2'); % STANDARD ILLUMINANT
    cmax = 127; %ASSUMED MAX VALUE OF CHROMA AT L=50
    spectraSizes = size(spectra);
    numSamples=spectraSizes(2);
    numWL = spectraSizes(1);
    masterCopyPairs = zeros([numWL*2 numSamples*numcopies],'double'); 
    masterCopyExpectedDiff = zeros([1 numSamples*numcopies],'double');
    fuzzyInputs = zeros([4 numSamples*numcopies],'double');
    masterLabs = coordinates(4:6,:)';
    for i=1:numcopies
        low = (i-1)*numSamples+1; 
        upp = numSamples*i;
        noise = random('unif',1,1.13); 
        copySpectra = spectra*noise; %apply iteration noise to all spectra
        masterCopyPairs(:,low:upp) = [spectra; copySpectra]; %insert into input set
        copyLabs = roo2lab(copySpectra',[],wlRange); %convert spectra to labs
        diff = de(masterLabs,copyLabs); %compute differences using standard formula
        
        %ADJUST C TO PERCENTAGE BY CONSIDERING AN ELLIPSIS
        lchs = lab2lch(masterLabs); %convert master LAB to lch format
        origlch = lchs; %just for return
        maxcs = cmax*sqrt(1-((lchs(:,1)-50)/50).^2); % apply ellipsis rule shown in report to obatin maximum chroma at a certain L
        lchs(:,2) = 100*lchs(:,2)./maxcs; % scale the lchs accordingly
        
        fuzzyInputs(:,low:upp) = ([lchs diff])'; %insert lch and incorrect diff into set for fuzzy input
        masterCopyExpectedDiff(:,low:upp) = diff; % return the incorrect differences
        fprintf("COPY %d OF %d -- [%d,%d]\n",i,numcopies,low,upp);            
    end
end

