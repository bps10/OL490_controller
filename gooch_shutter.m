function gooch_shutter(gooch, direction)
    shutter_state = gooch.GetOL490ShutterState();
    if strcmp(direction, 'open')
        if shutter_state == 0
            err = gooch.OpenShutter();
            if err == OL490_SDK_Dll.eErrorCodes.Success || ...
                    err == OL490_SDK_Dll.eErrorCodes.NoAction
                % Do nothing.
            else
                disp(err);
                error('ERROR: Shutter failed to open.');
            end
        elseif gooch.GetOL490ShutterState() == 1
            % Already open, do nothing
        else
            error('ERROR: Shutter open failed, OL490 not connected.')
        end
        
    elseif strcmp(direction, 'close')
        if shutter_state == 1
            err = gooch.CloseShutter();
            if err == OL490_SDK_Dll.eErrorCodes.Success || ...
                    err == OL490_SDK_Dll.eErrorCodes.NoAction
                % Do nothing.
            else
                disp(err);
                error('ERROR: Shutter failed to shut, OL490 not connected.');
            end
        elseif gooch.GetOL490ShutterState() == 0
            % Already closed, do nothing
        else
            error('ERROR: Shutter open failed, OL490 not connected.')
        end 
        
    else
        error('ERROR: Direction not understood. Only "open" or "close" are accepted');
    end