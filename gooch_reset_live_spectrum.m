function gooch_reset_live_spectrum(gooch)
% gooch_reset_live_spectrum(gooch)
% ---------------------------------
% Remove all the peaks within the LiveSpectrum, bringing count to 0. This
% function is for use with TRIGGER_MODE = 0 (Software control).

    gooch.ResetLiveSpectrum();
    gooch.ResetSequence();