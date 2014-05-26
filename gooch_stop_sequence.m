function gooch_stop_sequence(gooch)
% gooch_end_sequence(gooch)
% ----------------------
% End a sequence playing in RAM and then close the shutter.
% This method is for TRIGGER_MODE = 1.

    % Stop the sequence
    err = gooch.Stop();
     if err == OL490_SDK_Dll.eErrorCodes.Success
         % Do nothing.
     elseif err == OL490_SDK_Dll.eErrorCodes.NoAction
         disp('Sequence already stopped');
     else
        disp(err);
        error('ERROR: Sequence was not successfully ended.');
     end
    
    % Close the shutter
    gooch_shutter(gooch, 'close');

