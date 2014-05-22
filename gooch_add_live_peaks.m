function gooch_add_live_peaks(gooch, data)
% gooch_add_live_peaks(gooch, index, data)
% -----------------------------------
% Adds live peaks to a spectrum. For use with the Live Spectrum
% functionality of the OL490. TRIGGER_MODE should be set to 0 (Software
% control).
% 
% Data must be in the format of either a cell with numeric values or a
% matrix. Either way they should be organized in an nx3 manner with the
% first column corresponding to the peak wavelength (nm), the second column
% corresponding to the bandwidth (nm) and the third column indicating %
% intensity. Each row should contain parameters for n different peaks.

    % convert from cell if need be.
    if iscell(data)
        dat = cell2mat(data);
    elseif ismatrix(data)
        dat = data;
    else
        error('ERROR: Data must be in either cell numeric or nx3 matrix form')
    end
    
    % make sure that data is in nx3 matrix, 
    if ~length(data(1, :)) == 3
        error('ERROR: Peak parameters must be in nx3 format [peak bandwidth intensity]');
    end

    gooch.AddSpectrum();
    
    % add each peak in nx3 matrix
    for n = 1:length(dat(:, 1))
        % peak (nm), bandwidth, intensity %
        gooch.AddLiveSpectrumPeak(dat(n, 1), dat(n, 2), dat(n, 3));
    end
end