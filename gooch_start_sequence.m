function gooch_start_sequence(gooch)
% gooch_start_sequence(gooch)
% ---------------------------
% Start a sequence already loaded into RAM and then open the shutter.
% This method is for TRIGGER_MODE = 1.

    % use StartAdv in order to return control to matlab.
    err = gooch.StartAdv();
    if err == OL490_SDK_Dll.eErrorCodes.Success
    else
        disp(err);
        error('ERROR: StartAdv command did not work.');
    end
    
    err = gooch.OpenShutter();
    if err == OL490_SDK_Dll.eErrorCodes.Success
    else
        disp(err);
        error('ERROR: Shutter did not open.');
    end

end    
