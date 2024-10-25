# cwd.nvim

ONLY PARTIALLY COMPLETE - under construction

Change or swap your current Neovim working directory more easily.

### Purpose

I wrote cwd.nvim to learn how to write Neovim plugins.  It is an early effort... please be gentle! 

### Installation 

Using packer.nvim:
```lua
    use ('j--c/cwd.nvim')
```
Using vim-plug:
```lua
    Plug 'j--c/cwd.nvim'
```
Using dein:
```lua
    call dein#add('j--c/cwd.nvim')
```

### Usage

There are two main functions:

#### 1. Change Working Directory

__cwd(new_wd, {opts})__

Change the current Neovim working directory to another directory. Send directory as a parameter, or type directory at the prompt.

__Examples__

Known change. Change working directory to your neovim config.
```lua
    require 'cwd'.cwd('~/.config/nvim', {})
````

Ad-hoc change. Type directory at prompt. 
```lua
    require 'cwd'.cwd(nil, {})
````

#### 2. - Swap Working Directory

__swd(swp_wd, {opts})__

Swap the current Neovim working directory with another directory. Call again to swap back to your prior Neovim working directory. Send directory as a parameter, or type directory at the prompt.

__Examples__

Ad-hoc swap. Type directory at prompt. 
```lua
    require 'cwd'.swd(nil, {}) -- swap

    require 'cwd'.swd(nil, {}) -- call again to swap back later
````

Known swap. Swap current working directory with your neovim config.
```lua
    require 'cwd'.swd('~/.config/nvim', {}) -- swap

    require 'cwd'.swd('~/.config/nvim', {}) -- call again to swap back later
````

        prompt = 'Change directory to: ',
        cncl_msg = 'Operation cancelled!',
        err_msg = '  Error - Invalid directory!',
        cmplt_msg = '  Success - Directory changed to: ',
        dflt_wd = vim.fn.getcwd(),
        tilde = '~'
