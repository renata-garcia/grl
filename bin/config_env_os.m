function root = config_env_os(print)
    if ismac
        if print
            disp("NOT SUPPORTED: MAC");
        end
        exit;
    elseif isunix
        if print
            disp("config_env_os: isunix");
        end
        addpath("~/Dropbox/phd_grl_results/matlab");
        root = "/media/renata/renatargo/";
    elseif ispc
        if print
            disp("config_env_os: ispc");
        end
        addpath("../../../../../../Dropbox/phd_grl_results/matlab");
        root = "D:\";
    else
        if print
            disp('Platform not supported/recognized');
        end
        exit;
    end
end