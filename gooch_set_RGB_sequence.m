function gooch_set_RGB_sequence(gooch, primaries)
% gooch = gooch_set_RGB_sequence(gooch, primaries)
% ------------------------------------------------
% Create an RGB sequence for display with a DLP mirror and send the
% sequence to the Gooch's RAM.

    dark_params = [550, 1, 0];
    % add blank
    dark1 = gooch.AddSpectrum();
    gooch_add_peaks(gooch, dark1, dark_params);

    % load RED peaks
    red = gooch.AddSpectrum();
    gooch_add_peaks(gooch, red, primaries.red);

    % add blank
    dark2 = gooch.AddSpectrum();
    gooch_add_peaks(gooch, dark2, dark_params);

    % load GREEN peaks
    green = gooch.AddSpectrum();
    gooch_add_peaks(gooch, green, primaries.green);

    % add blank
    dark3 = gooch.AddSpectrum();
    gooch_add_peaks(gooch, dark3, dark_params);

    % load GREEN peaks
    blue = gooch.AddSpectrum();
    gooch_add_peaks(gooch, blue, primaries.blue);

    % Send sequence to RAM
    err = gooch.SendToRam();
    if err == OL490_SDK_Dll.eErrorCodes.Success
        % Do nothing
    else
        disp(err);
        error('ERROR: Spectrum not sent to RAM properly.');
    end
    
end
