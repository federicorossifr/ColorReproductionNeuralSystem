%==========================================================
% FUNCTION TO EXTRACT FEATURES USING THE APPORACH SHOWN
% IN THE REPORT ON BOTH SPECTRA
% original      original master-copy spectra
% k             number of desired output features
% fun           statistical function to apply to wl ranges
%==========================================================
function [extracted,range] = extractFeatures(original,k,fun)
    length = floor(421/k);
    originalSizes=size(original);
    height = originalSizes(2);
    if(originalSizes(1) > 421)
        extracted = zeros([k*2 height],'double');
    else
        extracted = zeros([k height],'double');
    end
    upp = 421; low = 0;
    upp2 = 842; low2 = 422;
    for i=1:k-1
        low=(i-1)*length+1; low2=(i-1)*length+422;
        upp= min(i*length,421); upp2 = min(i*length,421)+421;
        fprintf("SUBSAMPLING [%d,%d] ; [%d,%d]\n",low,upp,low2,upp2);
        extracted(i,:) = fun(original(low:upp,:));
        
        if(originalSizes(1) > 421)
            extracted(i+k,:) = fun(original(low2:upp2,:));    
        end
    end
    fprintf("SUBSAMPLING [%d,%d] ; [%d,%d]\n",upp,421,upp2,2*421);
    extracted(k,:) = fun(original(upp:421,:));
    if(originalSizes(1) > 421)
        extracted(2*k,:) = fun(original(upp2:2*421,:));
    end
    range = [length/2:length:upp 421-length/2];
end

