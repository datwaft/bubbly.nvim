# bubbly.nvim

## Introduction

Hello, my username is _datwaft_ and this is a status line plugin that I created.

This status line is based on using bubbles for almost every part of the status line.

This plugin has support for [`coc.nvim`](https://github.com/neoclide/coc.nvim) and [`signify`](https://github.com/mhinz/vim-signify).

Feel free to open an _issue_ if have some idea about how to make this plugin better or if you find some bug or functionality you don't like.

Also, feel free to copy/steal the code of this plugin.

Here are some screenshots:

<details>
<summary><b>Screenshots</b></summary>

![image](https://user-images.githubusercontent.com/37723586/101704640-ce6a5c80-3a4a-11eb-8020-5da1869b1600.png)

---

![image](https://user-images.githubusercontent.com/37723586/101704746-01145500-3a4b-11eb-98a1-1e41a3dbf7cf.png)

---

![image](https://user-images.githubusercontent.com/37723586/101704807-25703180-3a4b-11eb-83fb-864cd66bf30b.png)

</details>

## Current bubbles

Here is the list of the bubbles that are available right now:

- Mode bubble
- Current file bubble
- Signify bubble
- Coc.nvim bubble
- Filetype bubble
- Progress bubble

## Instalation

You can install this plugin with your favorite package manager. For example I use [`packer.nvim`](https://github.com/wbthomason/packer.nvim).

### Example of how to install using `packer.nvim`

**Filename:** `init.lua`

```lua
vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function()
  use {'wbthomason/packer.nvim', opt = true}
  use {'datwaft/bubbly.nvim', config = function()
    vim.g.bubbly_palette = {
       background = "#34343c",
       foreground = "#c5cdd9",
       black = "#3e4249",
       red = "#ec7279",
       green = "#a0c980",
       yellow = "#deb974",
       blue = "#6cb6eb",
       purple = "#d38aea",
       cyan = "#5dbbc1",
       white = "#c5cdd9",
       lightgrey = "#57595e",
       darkgrey = "#404247",
    }
  end}
end)
```

## Configuration

Here are the options that you can modify to modify the behaviour of the plugin.

### Palette

#### Example

**Default:** by default the plugin uses the default vim 8 bit colors.

**Note:** you can assign only part of the palette and it uses the default values for the not assigned values.

##### Lua

```lua
vim.g.bubbly_palette = {
   background = "#34343c",
   foreground = "#c5cdd9",
   black = "#3e4249",
   red = "#ec7279",
   green = "#a0c980",
   yellow = "#deb974",
   blue = "#6cb6eb",
   purple = "#d38aea",
   cyan = "#5dbbc1",
   white = "#c5cdd9",
   lightgrey = "#57595e",
   darkgrey = "#404247",
}
```

##### VimL

```viml
let g:bubbly_palette = {
\   background: "#34343c",
\   foreground: "#c5cdd9",
\   black: "#3e4249",
\   red: "#ec7279",
\   green: "#a0c980",
\   yellow: "#deb974",
\   blue: "#6cb6eb",
\   purple: "#d38aea",
\   cyan: "#5dbbc1",
\   white: "#c5cdd9",
\   lightgrey: "#57595e",
\   darkgrey: "#404247",
\ }
```
