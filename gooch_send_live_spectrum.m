function gooch_send_live_spectrum(gooch)
% gooch_send_live_spectrum(gooch)
% --------------------------------
% Send already loaded live spectrum to the gooch for display. User should
% have already called gooch_add_live_peaks().
%
% For use with the Live Spectrum functionality of the OL490. TRIGGER_MODE 
% should be set to 0 (Software control).

    % We are assuming only 1 Spectrum in the sequence for this function.
    gooch.AddLiveSpectrumToSequence(0);
    
    err = gooch.SendLiveSequence();
    if err == OL490_SDK_Dll.eErrorCodes.Success
        % Do nothing
    else
        disp(err);
        error('ERROR: SendLiveSpectrum did not work properly.');
    end