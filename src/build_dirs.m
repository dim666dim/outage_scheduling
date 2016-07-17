function [job_dirname_prefix,full_localRun_dir,job_data_filename,job_output_filename...
    ,full_remoteRun_dir,config] = build_dirs(prefix_num,config,caseName)
% builds all directory structure for current run
% INPUT:
% prefix_num - integer used to distinguish different instances of the
% algorithms from the cluster's point of view
local_dir_root  = config.LOCAL_DIR_ROOT;

if(config.remote_cluster)
    remote_dir_root = config.REMOTE_DIR_ROOT;
else
    remote_dir_root  = config.LOCAL_DIR_ROOT;
end

if (strcmp(config.run_mode,'optimize'))
    relative_dir = config.RELATIVE_DIR_OPTIMIZE;
else relative_dir = config.RELATIVE_DIR_COMPARE;
end;

job_dirname_prefix = config.JOB_DIRNAME_PREFIX;
run_dir=[config.run_mode,'_run_',datestr(clock,'yyyy-mm-dd-HH-MM-SS'),'--',num2str(prefix_num),'--',caseName];

full_localRun_dir  = [local_dir_root,relative_dir,run_dir];
if(isempty(dir(full_localRun_dir)))
    mkdir(full_localRun_dir);
end

full_remoteRun_dir = [remote_dir_root,relative_dir,run_dir];

local_tempFiles_dir = '';
remote_tempFiles_dir = '';

if(config.remote_cluster && isempty(dir(full_remoteRun_dir)))
    mkdir(full_localRun_dir,config.CLUSTER_OUTPUT_DIRNAME);
    mkdir(full_localRun_dir,config.CLUSTER_ERROR_DIRNAME);
    local_tempFiles_dir = [full_localRun_dir,config.TEMPFILES_DIR];
    remote_tempFiles_dir = [full_remoteRun_dir,config.TEMPFILES_DIR];
    mkdir(local_tempFiles_dir);
end
    
config.full_localRun_dir = full_localRun_dir;
config.full_remoteRun_dir = full_remoteRun_dir;

config.local_tempFiles_dir = local_tempFiles_dir;
config.remote_tempFiles_dir = remote_tempFiles_dir;

job_data_filename = config.JOB_DATA_FILENAME;
job_output_filename = config.JOB_OUTPUT_FILENAME;