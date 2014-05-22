function gooch_set_RGB_sequence(params, gooch)
% gooch = gooch_set_RGB_sequence(params, gooch)
% ------------------------------------------------
% Create and RGB sequence for display with a DLP mirror and send the
% sequence to the Gooch's RAM.

    % add blank
    dark1 = gooch.AddSpectrum();
    gooch.AddPeak(dark1, 550, 1, 0);

    % load RED peaks
    red = gooch.AddSpectrum();
    add_peaks(red, params.red);

    % add blank
    dark2 = gooch.AddSpectrum();
    gooch.AddPeak(dark2, 550, 1, 0);

    % load GREEN peaks
    green = gooch.AddSpectrum();
    add_peaks(green, params.green);

    % add blank
    dark3 = gooch.AddSpectrum();
    gooch.AddPeak(dark3, 550, 1, 0);

    % load GREEN peaks
    blue = gooch.AddSpectrum();
    add_peaks(blue, params.blue);

    % Send sequence to RAM
    err = gooch.SendToRam();
    if err == OL490_SDK_Dll.eErrorCodes.Success
        % Do nothing
    else
        disp(err);
        error('ERROR: Spectrum not sent to RAM properly.');
    end
    
    % Function for adding a peak(s) to a spectrum.
    function add_peaks(index, data)
        dat = cell2mat(data);
        for i = 1:length(dat(:, 1))
            % index, peak (nm), bandwidth, intensity %
            e = gooch.AddPeak(index, dat(i, 1), dat(i, 2), dat(i, 3));
            if e == OL490_SDK_Dll.eErrorCodes.Success
                % Do nothing
            else
                disp(err);
                error('ERROR: Peak was not added properly.');
            end
        end
    end
end
