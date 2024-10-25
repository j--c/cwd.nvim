local M = {}

local init_cfg = function()
    return {
        prmpt_msg = 'Change directory to: ',
        dflt_prmpt_val = vim.fn.getcwd(),
        cncl_msg = 'Operation cancelled!',
        err_msg = '  Error - Invalid directory!',
        cmplt_msg = '  Success - Directory changed to: ',
        tilde = '~'
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

local wd_prompt = function(cncl_code)
    local opts = {
        prompt = M.cfg.prmpt_msg,
        default = M.cfg.dflt_prmpt_val,
        completion = 'dir' ,
        cancelreturn = cncl_code
    }
    return vim.fn.input(opts)
end

local get_wd = function()
    local cncl_code = 'a;lskdjf;a'
    local wd = wd_prompt(cncl_code)
    if wd == cncl_code then
        wd = nil
        print(M.cfg.cncl_msg)
    end
    return wd
end

local edit_wd = function(new_wd)
    local trm_wd = new_wd:gsub('%s+', '')
    local wd = trm_wd:gsub(M.cfg.tilde, vim.env.HOME)
    return wd
end

local is_dir = function(wd)
    return (vim.fn.isdirectory(wd)) ~= 0
end

------------------------ PUBLIC API ------------------------

M.setup = function(cfg)
    M.cfg = init_cfg()
    upd_cfg(cfg)
end

M.cwd = function(new_wd, opts)
    local chgd = false
    upd_cfg(opts)
    if new_wd == nil then
        new_wd = get_wd()
    end
    if new_wd ~= nil then
        local wd = edit_wd(new_wd)
        if is_dir(wd) then
            vim.api.nvim_set_current_dir(wd)
            print(M.cfg.cmplt_msg .. '"' .. wd .. '"')
            chgd = true
        else
            print(M.cfg.err_msg)
        end
    end
    return chgd
end

M.swd = function(swp_wd, opts)
   local new_wd = M.prv_wd or swp_wd
    upd_cfg(opts)
    if M.prv_wd == nil then
        M.prv_wd = vim.fn.getcwd()
    else
        new_wd = M.prv_wd
        M.prv_wd = nil
    end
    local chgd = M.cwd(new_wd, opts)
    if chgd == false then
        M.prv_wd = nil
    end
    return chgd
end

------------------------------------------------------------

return M
