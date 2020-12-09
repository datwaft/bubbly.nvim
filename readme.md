# bubbly.nvim

## Introduction

Hello, my username is _datwaft_ and this is a status line plugin that I created.

This status line is based on using bubbles for almost every part of the status line.

## Instalation

You can install this plugin with your favorite package manager. For example I use [`packer.nvim`](https://github.com/wbthomason/packer.nvim).

### Example of how to install using `packer.nvim`

**Filename:** `init.lua`

```lua
vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function()
  use {'wbthomason/packer.nvim', opt = true}
  use {'datwaft/bubbly.nvim', setup = function()
  end}
end)
```

## Configuration and utilization


