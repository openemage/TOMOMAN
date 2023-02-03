function tm_tiltctf_run_ctffind_stack(tomolist,ps_name,ctffind4,diag_name,dep)% (tomolist,ps_name,ctffind,diag_name,dep)
%% tm_tiltctf_run_ctffind_stack
% Wrapper to run CTFFIND4 on a tiltctf power spectrum.
%
% WW 06-2022


%% CTFFIND4 input parameters

% Ordered list of CTFFIND4 inputs
param = {'pixelsize';...
         'voltage';...
         'cs';...
         'famp';...
         'ps_size';...
         'min_res';...
         'max_res';...
         'min_def';...
         'max_def';...
         'def_step';...
         'known_astig';...
         'slower';...
         'astig';...
         'astig_angle';...
         'rest_astig';...
         'exp_astig';...
         'det_pshift';...
         'pshift_min';...
         'pshift_max';...
         'pshift_step';...
         'expert';...
         'resample';...
         'known_defocus';...
         'known_defocus_1';...
         'known_defocus_2';...
         'known_defocus_astig';...
         'known_defocus_pshift';...
         'nthreads'};
n_param = size(param,1);


% Parse fields from input struct
input_fields = fieldnames(ctffind4);

%% Write run script and run

% Open file
ctffind4_filename = [tomolist.stack_dir,'/tiltctf/run_ctffind4.sh'];
fid = fopen(ctffind4_filename,'w');

% Print first few lines
fprintf(fid,'%s\n',[dep.ctffind4,' --amplitude-spectrum-input << fin']);
fprintf(fid,'%s\n',ps_name);
fprintf(fid,'%s\n','no');
fprintf(fid,'%s\n',diag_name);

% Print parameters
for i = 1:n_param
    
    % Parse index of field in input struct
    idx = strcmp(input_fields,param{i});
    
    % Write if field is present
    if any(idx)
        if isnumeric(ctffind4.(param{i}))
            fprintf(fid,'%s\n',num2str(ctffind4.(param{i})));
        else
            fprintf(fid,'%s\n',ctffind4.(param{i}));
        end
    end
end

% Close file
fprintf(fid,'%s\n','fin');
fclose(fid);

% Run CTFFIND
system(['chmod +x ',ctffind4_filename]);
system(ctffind4_filename);

end


        


