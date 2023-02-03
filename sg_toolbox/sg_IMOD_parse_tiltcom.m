function tiltcom  = sg_IMOD_parse_tiltcom(tiltcom_name)
%% sg_IMOD_parse_tiltcom
% A function to take the path to an IMOD tilt.com file, and parse out the
% inputs in the tilt.com.
%
% v2 returns the parameters in a struct array.
%
% WW 01-2018

%% Read in tilt.com
fid = fopen(tiltcom_name);
tiltcom_text = textscan(fid, '%s', 'Delimiter', '\n');
fclose(fid);

% Initilize tiltcom struct
tiltcom = struct;

%% Parse parameters
parameters = {'InputProjections', 'str';...
              'OutputFile', 'str';...
              'IMAGEBINNED','num';...
              'TILTFILE','str';...
              'THICKNESS','num';...
              'RADIAL','num';...
              'XAXISTILT','num';...
              'LOG','num';...
              'SCALE','num';...
              'PERPENDICULAR','str';...
              'MODE','num';...
              'FULLIMAGE','num';...
              'SUBSETSTART','num';...
              'AdjustOrigin','str';...
              'ActionIfGPUFails','str';...
              'XTILTFILE','str';...
              'OFFSET','num';...
              'SHIFT','num';...
              };
          
n_param = size(parameters,1);      


for i = 1:n_param
    idx = find(~cellfun('isempty',regexpi(tiltcom_text{1},['^',parameters{i,1}])),1,'first');
    if isempty(idx)
        tiltcom.(parameters{i}) = [];
    else
        switch parameters{i,2}
            case 'str'
                tiltcom.(parameters{i,1}) = tiltcom_text{1}{idx}(numel(parameters{i,1})+1:end);
            case 'num'
                tiltcom.(parameters{i,1}) = str2num(tiltcom_text{1}{idx}(numel(parameters{i,1})+1:end)); %#ok<ST2NM>
        end
            
    end
end

          