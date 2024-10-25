# cwd.nvim

Change or swap your current Neovim working directory more easily.

### Purpose

I wrote cwd.nvim to learn how to write Neovim plugins.  It is an early effort... please be gentle! 

### Installation 

__Examples__

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

### Configuration

You MUST call the setup method before using; it is required!

__Examples__

Call setup with the default configuration.
```lua
    require 'cwd'.setup()
```

Call setup with the custom configuration.
```lua
    require 'cwd'.setup({
        prmpt_msg = 'prompt for ad-hoc swaps and changes',
        dflt_prmpt_val = 'default directory value at prompt',
        cncl_msg = 'message on cancel',
        err_msg = 'message on error',
        cmplt_msg = 'message on complete'
    })
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

Your can also use the CwdChange command for an Ad-hoc change. The command, however does not take parameters.
```vim
    :CwdChange
```

#### 2. - Swap Working Directory

__swd(swp_wd, {opts})__

Swap the current Neovim working directory with another directory. Call again to swap back to your prior Neovim working directory. Send directory as a parameter, or type directory at the prompt.

__Examples__

Known swap. Swap current working directory with your neovim config.
```lua
    require 'cwd'.swd('~/.config/nvim', {}) -- swap

    require 'cwd'.swd('~/.config/nvim', {}) -- call again to swap back
````

Ad-hoc swap. Type directory at prompt. 
```lua
    require 'cwd'.swd(nil, {}) -- swap

    require 'cwd'.swd(nil, {}) -- call again to swap back
````

Your can also use the CwdSwap command for an Ad-hoc swap. The command, however does not take parameters.
```vim
    :CwdSwap
```
