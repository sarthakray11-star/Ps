% build_simulink_model.m
function build_simulink_model()
    % Create a new Simulink model
    modelName = 'TwoAreaPowerSystem';
    open_system(new_system(modelName));

    % Define parameters for PV and Wind farms
    pv_capacity = 1.5; % MW
    wind_capacity = 2.0; % MW
    
    % Add PV Generator Block
    add_block('powerlib/Elements/Photovoltaic', [modelName '/PV Generator'], ...
        'Position', [100, 100, 130, 130], 'PV_Generator', num2str(pv_capacity));

    % Add Wind Turbine Block
    add_block('powerlib/Elements/WindTurbine', [modelName '/Wind Turbine'], ...
        'Position', [100, 200, 130, 230], 'Wind_Turbine', num2str(wind_capacity));

    % Define transfer functions and control loops
    % Example: Area 1 Transfer Function
    add_block('simulink/Math Operations/Transfer Fcn', [modelName '/Area 1 TF1'], ...
        'Numerator', '[0 1]', 'Denominator', '[1 10]', ...
        'Position', [250, 100, 300, 130]);

    % Add more blocks as necessary...
    
    % Interconnect blocks (Example)
    add_line(modelName, 'PV Generator/1', 'Area 1 TF1/1');
    add_line(modelName, 'Wind Turbine/1', 'Area 1 TF1/2');

    % Finalize model
    save_system(modelName);
    fprintf('Simulink model "%s" created and saved successfully.\n', modelName);
end
