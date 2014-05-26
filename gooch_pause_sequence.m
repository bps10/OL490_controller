function gooch_pause_sequence(gooch)
% gooch_end_sequence(gooch)
% ----------------------
% Pause a sequence playing in RAM and then close the shutter.
% This method is for TRIGGER_MODE = 1.

    % Pause the sequence
    err = gooch.Pause();
    if err == OL490_SDK_Dll.eErrorCodes.Success
         % Do nothing.
    elseif err == OL490_SDK_Dll.eErrorCodes.NoAction
         % Do nothing.
    else
        disp(err);
        error('ERROR: Sequence was not successfully ended.');
    end
    
    % Close the shutter
    gooch_shutter(gooch, 'close');
