clear; clc;
load data.mat;
addpath(genpath('optprop')); %Load the library into the Matlab path
spectra=spectra*100; %Scale the reflectance spectrum to match roo2lab desired format
wlRange = 380:1:800; %Wavelength range to use in roo2lab function
numcopies = 10; % Number of copies to realise for each master patch
optfis = evalfisOptions("NoRuleFiredMessage","none"); %DEBUG MESSAGES
%Prepare sets to use into fuzzy system and neural network
[masterCopyPairs,biasedDiffs,copyLabs,masterLabs,fuzzyInputs,origlch] = prepareInitialSets(spectra,numcopies,wlRange,coordinates);
%Load the fuzzy inference system from file
mamdaniFuzzyCorrector = readfis('fuzzysystem.fis');
%Correct the differences using the fuzzy inference system
masterCopyExpectedDiff = evalfis(fuzzyInputs,mamdaniFuzzyCorrector,optfis)';
%plotMfs(mamdaniFuzzyCorrector); %PLOT THE MEMBERSHIP FUNCTIONS
%See the corrections done to the initial differences
adjstmnts = abs(biasedDiffs-masterCopyExpectedDiff);
clear numCopies;
%===================================================
%FEATURE EXTRACTION
%===================================================
k=5;
[masterCopyPairsMean,mR] = extractFeatures(masterCopyPairs,k,@mean);
%===================================================
%FEATURE SELECTION
%===================================================
disp("STARTED FEATURE SELECTION");
opt = statset('display','off');
[fs,hst]=sequentialfs(@fitFs,masterCopyPairsMean',masterCopyExpectedDiff','cv','none','opt',opt,'nfeatures',4);
selectedMasterCopyPairsMean = masterCopyPairsMean(fs,:);

%===================================================
%MAKE SOME PLOTS ON THE i-th MASTER,COPY PAIR
%===================================================
%i=900; k=5;
%[labO,labM]=plotSpectrum(masterCopyPairs,masterCopyPairsMean,k,mR,i,wlRange,masterCopyExpectedDiff(i));
%ss = masterCopyPairsMean(1:k,i);   
%sss(1:k) = ss;
%sss(k+1:2*k) = ss;
clear i mr;
