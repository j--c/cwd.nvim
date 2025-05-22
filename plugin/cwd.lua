vim.api.nvim_create_user_command(
    'CwdSwapNvim', function() require 'cwd'.swd(vim.fn.stdpath('config'),{}) end, {}
)

vim.api.nvim_create_user_command(
    'CwdSwap', function() require 'cwd'.swd(nil, {}) end, {}
)

vim.api.nvim_create_user_command(
    'CwdChange', function() require 'cwd'.cwd(nil, {}) end, {}
)
