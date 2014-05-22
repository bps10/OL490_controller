function gooch_gui()
% gooch_gui()
% ------------
% Create a GUI to control the gooch with hardware triggering.
% TRIGGER_MODE = 1.
    
    % Setup the gooch and get a handle to the controller.
    gooch = gooch_setup();
    
    % Create an empty cell container for light parameters.
    params = {};
    params.red = {};
    params.green = {};
    params.blue = {};
    
    %  Construct the gui components
    % ---- Figure handle
    f = figure('Visible','on','Name','parameters',...
            'Position',[500, 500, 550, 385], 'Toolbar', 'none');
    
    % ---- Panel
    ph = uipanel('Parent',f, 'Title', 'Gooch parameters',...
            'Position',[.05 .05 .9 .9]);

    %%%%%%%%%%%%%    
    %%%  Red  %%%
    %%%%%%%%%%%%%
    uicontrol(ph,'Style','text',...
                'String','Red peak',...
                'Units','normalized',...
                'Position',[.05 .9 .25 .10]);
            
    red_peak = uicontrol(ph,'Style','edit',...
            'Units','normalized',...
            'String', '630',...
            'Position', [.05 .85 .25 .10]);

    uicontrol(ph,'Style','text',...
                'String','Red bandwidth',...
                'Units','normalized',...
                'Position', [.05 .75 .25 .10]);
            
    red_band = uicontrol(ph,'Style','edit',...
            'Units','normalized',...
            'String', '10',...
            'Position', [.05 .7 .25 .10]); 
        
    uicontrol(ph,'Style','text',...
                'String','Red % intensity',...
                'Units','normalized',...
                'Position',[.05 .6 .25 .10]);

    red_int = uicontrol(ph,'Style','edit',...
            'Units','normalized',...
            'String', '100',...
            'Position', [.05 .55 .25 .10]); 
        
    uicontrol(ph,'Style','pushbutton','String','add',...
            'Units','normalized',...
            'Position', [.1 .45 .15 .08], ...
            'Callback', @update_red);
        
    columnname =   {'peak', 'bandwidth', 'intensity'};
    columnformat = {'numeric', 'numeric', 'numeric'};
    columneditable =  [true true true]; 
    red = uitable('Units','normalized','Position',...
                [0.085 0.25 0.25 0.18], 'Data', params.blue,... 
                'ColumnName', columnname,...
                'ColumnFormat', columnformat,...
                'ColumnEditable', columneditable,...
                'RowName',[]);
    set(red,'ColumnWidth',{45});    
    
    %%%%%%%%%%%%%    
    %%% Green %%%
    %%%%%%%%%%%%%
           
    uicontrol(ph,'Style','text',...
                'String','Green peak)',...
                'Units','normalized',...
                'Position',[.35 .9 .25 .10]);
            
    green_peak = uicontrol(ph,'Style','edit',...
            'Units','normalized',...
            'String', '530',...
            'Position', [.35 .85 .25 .10]);

    uicontrol(ph,'Style','text',...
                'String','Green bandwidth',...
                'Units','normalized',...
                'Position',[.35 .75 .25 .10]);
            
    green_band = uicontrol(ph,'Style','edit',...
            'Units','normalized',...
            'String', '10',...
            'Position', [.35 .7 .25 .10]); 

    uicontrol(ph,'Style','text',...
                'String','Green % intensity',...
                'Units','normalized',...
                'Position',[.35 .6 .25 .10]);

    
    green_int = uicontrol(ph,'Style','edit',...
            'Units','normalized',...
            'String', '100',...
            'Position', [.35 .55 .25 .10]); 

    uicontrol(ph,'Style','pushbutton','String','add',...
            'Units','normalized',...
            'Position', [.4 .45 .15 .08], ...
            'Callback', @update_green);
        
    columnname =   {'peak', 'bandwidth', 'intensity'};
    columnformat = {'numeric', 'numeric', 'numeric'};
    columneditable =  [true true true]; 
    green = uitable('Units','normalized','Position',...
                [0.355 0.25 0.25 0.18], 'Data', params.blue,... 
                'ColumnName', columnname,...
                'ColumnFormat', columnformat,...
                'ColumnEditable', columneditable,...
                'RowName',[]);
    set(green,'ColumnWidth',{45})        
    
    %%%%%%%%%%%%%    
    %%% Blue  %%%
    %%%%%%%%%%%%%
    
    uicontrol(ph,'Style','text',...
                'String','Blue peak',...
                'Units','normalized',...
                'Position',[.65 .9 .25 .10]);    
            
    blue_peak = uicontrol(ph,'Style','edit',...
            'Units','normalized',...
            'String', '430',...
            'Position', [.65 .85 .25 .10]); 

    uicontrol(ph,'Style','text',...
                'String','Blue bandwidth',...
                'Units','normalized',...
                'Position',[.65 .75 .25 .10]);
            
    blue_band = uicontrol(ph,'Style','edit',...
            'Units','normalized',...
            'String', '10',...
            'Position', [.65 .7 .25 .10]); 
        
    uicontrol(ph,'Style','text',...
                'String','Blue % intensity',...
                'Units','normalized',...
                'Position',[.65 .6 .25 .10]);
            
    blue_int = uicontrol(ph,'Style','edit',...
            'Units','normalized',...
            'String', '100',...
            'Position', [.65 .55 .25 .10]);

    uicontrol(ph,'Style','pushbutton','String','add',...
            'Units','normalized',...
            'Position', [.7 .45 .15 .08], ...
            'Callback', @update_blue);

    columnname =   {'peak', 'bandwidth', 'intensity'};
    columnformat = {'numeric', 'numeric', 'numeric'};
    columneditable =  [true true true]; 
    blue = uitable('Units','normalized','Position',...
                [0.625 0.25 0.25 0.18], 'Data', params.blue,... 
                'ColumnName', columnname,...
                'ColumnFormat', columnformat,...
                'ColumnEditable', columneditable,...
                'RowName',[]);
    set(blue,'ColumnWidth',{45})
        
    % ---- Buttons
    uicontrol(ph,'Style','pushbutton','String','start',...
            'Units','normalized',...
            'Position', [.05 .05 .25 .15], ...
            'Callback', @start_gooch);

     uicontrol(ph,'Style','pushbutton','String','pause',...
            'Units','normalized',...
            'Position', [.35 .05 .25 .15], ...
            'Callback', @stop_gooch);
 
     uicontrol(ph,'Style','pushbutton','String','quit',...
            'Units','normalized',...
            'Position', [.65 .05 .25 .15], ...
            'Callback', @end_program);
        
       
    uiwait(f);
       
    function update_red(~, ~)
        params = get_current_params(params, 'red');
        set(red, 'Data', params.red);
    end

    function update_green(~, ~)
        params = get_current_params(params, 'green');
        set(green, 'Data', params.green);
    end

    function update_blue(~, ~)
        params = get_current_params(params, 'blue');
        set(blue, 'Data', params.blue);
    end

    function start_gooch(~, ~)        
        gooch_set_RGB_sequence(params, gooch);
        gooch_start_sequence(gooch);
    end

    function stop_gooch(~, ~)        
        gooch_pause_sequence(gooch);
    end

    function end_program(~, ~)        
        gooch_stop_sequence(gooch);
        gooch_clear_sequence(gooch);
        uiresume(f);
    end

    function params = get_current_params(params, color)
   
        if strcmp(color, 'red')
            peak = str2double(get(red_peak, 'String'));
            band = str2double(get(red_band, 'String'));
            int = str2double(get(red_int, 'String'));
            l = size(params.red);
            params.red(l(1) + 1, :) = {peak band int};
            
        elseif strcmp(color, 'green')
            peak = str2double(get(green_peak, 'String'));
            band = str2double(get(green_band, 'String'));
            int = str2double(get(green_int, 'String'));
            l = size(params.green);
            params.green(l(1) + 1, :) = {peak band int};
            
        elseif strcmp(color, 'blue')
            peak = str2double(get(blue_peak, 'String'));
            band = str2double(get(blue_band, 'String'));
            int = str2double(get(blue_int, 'String'));
            l = size(params.blue);
            params.blue(l(1) + 1, :) = {peak band int};
            
        end

    end

    close all;

end