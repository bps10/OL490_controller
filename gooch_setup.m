function gooch = gooch_setup(LIGHT_REDUCTION, FPS, LOOPING, TRIGGER_MODE)
% gooch = gooch_setup(LIGHT_REDUCTION, FPS, LOOPING, TRIGGER_MODE)
% ------------------------
% This function imports OL490 DLLs, connects to the gooch, turns the mirrors
% on, loads the calibration file and sets some basic parameters. The function
% returns a handle to the gooch connection.
%
% Parameters:
% 1. LIGHT_REDUCTION: set linear light reduction (bool). Default = false.
% According to page 16 of the manual, 'The Light Reduction Control is used
% to attenuate the output intensity without the need to modify individual
% peak intensities ... This will reduce all mirror column hights by the
% same ratio'.
% 2. FPS: frames per second. Default = 256. Only useful in RAM mode. See
% TRIGGER_MODE.
% 3. LOOPING: set number of loops. Default = 0 (infinite).
% 4. TRIGGER_MODE: 0 for software control, 1 for hardware triggered
% advance, 2 for hardware triggering of sequence, 3 for hardware control, 4
% for software triggered advance. Default = 1. 2-4 have never been
% implemented in the Neitz lab. 0 is very typical.

    if nargin < 1
        LIGHT_REDUCTION = false;
    end
    if nargin < 2
        FPS = 256;
    end
    if nargin < 3
        LOOPING = 0; % 0 is for infinite
    end
    if nargin < 4
        TRIGGER_MODE = 1;
    end
    
    NET.addAssembly('c:\Program Files\GoochandHousego\OL 490 ALS\OL490Lib.dll');
    NET.addAssembly('c:\Program Files\GoochandHousego\OL 490 SDK\OL490_SDK_Dll.dll');
    
    % get a handle to the gooch SDK
    gooch = OL490_SDK_Dll.OL490SdkLibrary;
    
    % connect to the gooch
    OL490_err = gooch.ConnectToOL490(0);
    if OL490_err == OL490_SDK_Dll.eErrorCodes.Success

    else
        disp(OL490_err);
        error('ERROR: Gooch not connected properly.');
    end
    
    % make sure shutter is closed while we work
    gooch_shutter(gooch, 'close');

    % make sure mirrors are on
    mirrors = gooch.TurnMirrorsOn();
    if mirrors == true
        % Do nothing
    else
        error('ERROR: OL 490 not connected.');
    end
    
    % load calibartion file
    err = gooch.LoadAndUseStoredCalibration(0);
    if err == OL490_SDK_Dll.eErrorCodes.Success
        % Do nothing.
    else
        disp(err);
        error('ERROR: Calibration did not load.');
    end

    % enable linear light reduction if desired
    if LIGHT_REDUCTION
        err = gooch.EnableLinearLightReduction(1023);
        if err == OL490_SDK_Dll.eErrorCodes.Success
            % Do nothing
        else
            disp(err);
            error('ERROR: Linear light reduction unsuccessful.');
        end
    end
    
    % make sure sequence is reset
    gooch.ResetSequence();

    % set trigger mode
    err = gooch.SetTriggerMode(TRIGGER_MODE);
    if err == OL490_SDK_Dll.eErrorCodes.Success
        % Do nothing
    else
        disp(err);
        error('ERROR: Trigger mode not properly set.');
    end

    % set frames per second
    err = gooch.SetFramesPerSecond(FPS);
    if err == OL490_SDK_Dll.eErrorCodes.Success
        % Do nothing
    else
        disp(err);
        error('ERROR: Frames per second not set properly.');
    end

    % set RAM looping
    err = gooch.SetRamLooping(LOOPING);
    if err == OL490_SDK_Dll.eErrorCodes.Success
        % Do nothing
    else
        disp(err);
        error('ERROR: Ram looping not set properly.');
    end
    
end
