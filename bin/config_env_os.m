function root = config_env_os()
    if ismac
        disp("NOT SUPPORTED: MAC");
        exit;
    elseif isunix
        disp("config_env_os: isunix");
        addpath("~/Dropbox/phd_grl_results/matlab");
        root = "/media/renata/renatargo/";
    elseif ispc
        disp("config_env_os: ispc");
        addpath("../../../../../../Dropbox/phd_grl_results/matlab");
        root = "D:\";
    else
        disp('Platform not supported/recognized');
        exit;
    end
end