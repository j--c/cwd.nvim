local M = {}


local init_cfg = function()
    return {
        prmpt_msg = 'Change directory to: ',
        dflt_prmpt_val = vim.fn.getcwd(),
        cncl_msg = 'Operation cancelled!',
        err_msg = '  Error - Invalid directory!',
        cmplt_msg = '  Success - Directory changed to: ',
    }
end


local upd_cfg = function(cfg)
    if type(cfg) == 'table' then
        for k,v in pairs(cfg) do
            if M.cfg[k] ~= nil then
                M.cfg[k] = v
            end
        end
    end
end


local dir_prompt = function(opts)
    return vim.fn.input( {
        prompt = opts.prmpt_msg,
        default = opts.dflt_prmpt_val,
        completion = 'dir' ,
        cancelreturn = opts.cncl_code
    })
end


------------------------ PUBLIC API ------------------------


-- setup
M.setup = function(cfg)
    M.cfg = init_cfg()
    upd_cfg(cfg)
end


-- cwd
M.cwd = function(new_wd_path, opts)
    local chgd = false
    upd_cfg(opts)
    if new_wd_path == nil then
        new_wd_path = M.get_dir_f_usr(M.cfg)
    end
    if new_wd_path ~= nil then
        local clean_wd_path = M.clean_dir_path(new_wd_path)
        if M.valid_dir_path(clean_wd_path) then
            vim.api.nvim_set_current_dir(clean_wd_path)
            print(M.cfg.cmplt_msg .. '"' .. clean_wd_path .. '"')
            chgd = true
        else
            print(M.cfg.err_msg)
        end
    end
    return chgd
end


-- swd
M.swd = function(swp_wd_path, opts)
    upd_cfg(opts)
    local new_wd_path = M.prv_wd_path or swp_wd_path
    if M.prv_wd_path == nil then
        M.prv_wd_path = vim.fn.getcwd()
    else
        new_wd_path = M.prv_wd_path
        M.prv_wd_path = nil
    end
    local chgd = M.cwd(new_wd_path, opts)
    if chgd == false then
        M.prv_wd_path = nil
    end
    return chgd
end


-- get_dir_f_usr
M.get_dir_f_usr = function(opts)
    opts.cncl_code = 'a;lskdjf;a'
    local dir = dir_prompt(opts)
    if dir == opts.cncl_code then
        dir = nil
        print(opts.cncl_msg)
    end
    return dir
end


-- clean_dir_path
M.clean_dir_path = function(dir_path)
    local trm_dir_path = dir_path:gsub('%s+', '')
    local clean_path = trm_dir_path:gsub('~', vim.env.HOME)
    return clean_path
end


-- valid_dir_path
M.valid_dir_path = function(dir_path)
    return (vim.fn.isdirectory(dir_path)) ~= 0
end


------------------------------------------------------------

return M
