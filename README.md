# cwd.nvim

Change or swap your current Neovim working directory more easily.

<br>

### Purpose

I wrote cwd.nvim to learn how to write Neovim plugins.  It is an early effort... please be gentle! 

<br>

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
<br>

### Usage

There are two main functions:

1. cwd(new_wd, {opts})
2. swd(swp_wd, {opts})

<br>

#### 1. cwd - Change Working Directory

cwd allows you to change the current Neovim working directory.  Send the new directory as a parameter, or wait for the prompt and type the directory of your choice.

<br>

#### 2. swd - Swap Working Directory

swd allows you to swap the current Neovim working directory with a new directory.  Send the new directory as a parameter, or wait for the prompt and type the directory of your choice.  swd saves your previous working directory so that it will be swapped back the next time it is called.

<br>

__Examples__

<br>


require 'cwd'.swd(nil, {})

        prompt = 'Change directory to: ',
        cncl_msg = 'Operation cancelled!',
        err_msg = '  Error - Invalid directory!',
        cmplt_msg = '  Success - Directory changed to: ',
        dflt_wd = vim.fn.getcwd(),
        tilde = '~'
