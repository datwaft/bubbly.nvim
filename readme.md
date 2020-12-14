# bubbly.nvim

**Warning:** this plugin probably requires Neovim nightly.

## Introduction

Hello, my username is _datwaft_ and this is a status line plugin that I created.

The ideology of this status line is using bubbles for almost every part of the status line. And tries to be fully configurable and modular.

This plugin has support for [`coc.nvim`](https://github.com/neoclide/coc.nvim) and [`signify`](https://github.com/mhinz/vim-signify).

Feel free to open an _issue_ if have some idea about how to make this plugin better or if you find some bug or functionality you don't like.

Also, feel free to copy/steal the code of this plugin, I tried to make he code the most understandable posible so if you want to make a fork to add your own functionality, you are welcome.

**Note:** feel free to make pull requests with custom components/bubbles you want to add.

Here are some screenshots:

<details>
<summary><b>Screenshots</b></summary>

![image](https://user-images.githubusercontent.com/37723586/101704640-ce6a5c80-3a4a-11eb-8020-5da1869b1600.png)

---

![image](https://user-images.githubusercontent.com/37723586/101704746-01145500-3a4b-11eb-98a1-1e41a3dbf7cf.png)

---

![image](https://user-images.githubusercontent.com/37723586/101704807-25703180-3a4b-11eb-83fb-864cd66bf30b.png)

---

![image](https://user-images.githubusercontent.com/37723586/101720701-e30b1c80-3a6b-11eb-981d-afd3d8758551.png)

</details>

## Current bubbles

Here is the list of the bubbles that are available right now:

- Mode bubble
- Current file bubble
- Branch bubble
- Signify bubble
- Coc.nvim bubble
- Filetype bubble
- Progress bubble

## Installation

You can install this plugin with your favorite package manager. For example I use [`packer.nvim`](https://github.com/wbthomason/packer.nvim).

### Example of how to install using `packer.nvim`

**Filename:** `init.lua`

```lua
vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function()
  use {'wbthomason/packer.nvim', opt = true}
  use {'datwaft/bubbly.nvim', config = function()
   -- Here you can add the configuration for the plugin
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

**Note:** you can add only a part of the configuration and the rest will use the default.

### Components

This option is used to configure which bubble components to show in the statusline and the order.

It's a list that follows this pattern:

```lua
{ 'mode', 'thingy', 'coc', 'divisor', 'branch', {{ data = 'ddd', color = 'red', style = 'bold' }} }
```

<details>
<summary><b>Note</b></summary>

---

Sadly **neovim** cannot insert lua functions inside vim variables (`g:variable` for example), I don't know if it's a problem from neovim lua api or viml, so you technically cannot use functions here, but the support is there. Tell me if you have any suggestion about this. The functions must have been like `function(inactive) ... end`.

The function must have accepted a parameter that is `true` when the buffer is **inactive** and `false`/`nil` when the buffer is **active** and reacted properly to the parameter.

The function must have returned a table like `{{ data = '%F', color = 'blue', style = '' }}`.
  - `data` and `color` are obligatory, `style` is optional.
  - As you can see, it technically is a list of objects that contain `data`, `color`, and (optionally) `style`.

---

</details>

The elements of the list can be:
- **Strings** like `'mode'`.
  - The string represents the module name of some preexisting component.
  - If the string is `divisor` or `division` then the rest of the list will go to the right.
  - If the string is `trucate` or `truc` then if the size is insuficient it will conserve everything at the left of the string.
- **Tables** like `{{ data = '%F', color = 'blue', style = '' }}`
  - `data` and `color` are obligatory, `style` is optional.
  - As you can see, it technically is a list of objects that contain `data`, `color`, and (optionally) `style`.

<details>
<summary><b>Default configuration</b></summary>

```lua
vim.g.bubbly_statusline = {
   'mode',

   'truncate',

   'path',
   'branch',
   'signify',
   'coc',

   'divisor',

   'filetype',
   'progress',
}
```

</details>

---

<details>
<summary><b>Lua configuration example</b></summary>

```lua
vim.g.bubbly_statusline = {
   'mode',

   'truncate',

   'path',
   'branch',
   {{ data = 'my name', color = 'red', style = 'bold' }},

   'divisor',

   {
     { data = 'test1', color = 'yellow', style = 'italic' },
     { data = 'test2', color = 'red' },
   },
   'filetype',
   'progress',
}
```

</details>



### Palette

This option is used to set the exact color for each color used in the status line.

<details>
<summary><b>Default configuration</b></summary>

```lua
vim.g.bubbly_palette = {
   background = "Black",
   foreground = "White",
   black = "Black",
   red = "Red",
   green = "Green",
   yellow = "Yellow",
   blue = "Blue",
   purple = "Magenta",
   cyan = "Cyan",
   white = "White",
   lightgrey = "LightGrey",
   darkgrey = "Grey",
}
```

</details>

---

<details>
<summary><b>Lua configuration example</b></summary>

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

</details>

<details>
<summary><b>VimL configuration example</b></summary>

```viml
let g:bubbly_palette = #{
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

</details>

### Characters

This option is used to configure the delimiters of the bubble.

<details>
<summary><b>Default configuration</b></summary>

```lua
vim.g.bubbly_characters = {
   left = '',
   right = '',
}
```

</details>

---

<details>
<summary><b>Lua configuration example</b></summary>

```lua
vim.g.bubbly_characters = {
   left = '(',
   right = ')',
}
```

</details>

### Symbols

This option is used to configure the symbols that are used in bubbles.

It uses a function similar to the format from the C library so if there is more `%s` than necessary then the plugin would fail. If there were less than necessary it would simply not show that part.

<details>
<summary><b>Default configuration</b></summary>

```lua
vim.g.bubbly_symbols = {
   path = {
      readonly = 'RO',
      unmodifiable = '',
      modified = '+',
   },
   signify = {
      added = '+%s', -- requires 1
      modified = '~%s', -- requires 1
      removed = '-%s', -- requires 1
   },
   coc = {
      error = 'E%s', -- requires 1
      warning = 'W%s', -- requires 1
   },
   branch = ' %s' -- requires 1
}
```

</details>

---

<details>
<summary><b>Lua configuration example</b></summary>

```lua
vim.g.bubbly_symbols = {
   path = {
      readonly = 'ro',
      unmodifiable = 'lk',
      modified = '*',
   },
   signify = {
      added = '++%s',
      modified = '!%s',
      removed = '_%s',
   },
   coc = {
      error = 'Errors: %s',
      warning = 'Warnings: %s',
   },
   branch = 'B '
}
```

</details>

### Tags

This option is used to configure the text used in the bubbles.

If it's empty the bubble disappears instead of showing the text.

<details>
<summary><b>Default configuration</b></summary>

```lua
vim.g.bubbly_tags = {
   mode = {
      normal = 'NORMAL',
      insert = 'INSERT',
      visual = 'VISUAL',
      visualblock = 'VISUAL-B',
      command = 'COMMAND',
      terminal = 'TERMINAL',
      replace = 'REPLACE',
      default = 'UNKOWN',
   },
   paste = 'PASTE',
   filetype = {
      noft = 'no ft',
   },
}
```

</details>

---

<details>
<summary><b>Lua configuration example</b></summary>

```lua
vim.g.bubbly_tags = {
   mode = {
      normal = 'normal',
      insert = 'insertar',
      visual = 'visual',
      visualblock = 'bloque visual',
      command = 'comando',
      terminal = 'terminal',
      replace = 'reemplazar',
      default = 'desconocido',
   },
   paste = 'pegar',
   filetype = {
      noft = '', -- If it's empty the bubble disappears
   },
}
```

</details>

### Colors

This option is used to configure which color uses which bubble in some case.

<details>
<summary><b>Default configuration</b></summary>

```lua
vim.g.bubbly_colors = {
   mode = {
      normal = 'green',
      insert = 'blue',
      visual = 'red',
      visualblock = 'red',
      command = 'red',
      terminal = 'blue',
      replace = 'yellow',
      default = 'white'
   },
   path = {
      readonly = 'lightgrey',
      unmodifiable = 'darkgrey',
      path = 'white',
      modified = 'lightgrey',
   },
   branch = 'purple',
   signify = {
      added = 'green',
      modified = 'blue',
      removed = 'red',
   },
   paste = 'red',
   coc = {
      error = 'red',
      warning = 'yellow',
      status = 'lightgrey',
   },
   filetype = 'blue',
   progress = {
      rowandcol = 'lightgrey',
      percentage = 'darkgrey',
   },
}
```

</details>

---

<details>
<summary><b>Lua configuration example</b></summary>

```lua
vim.g.bubbly_colors = {
   mode = {
      normal = 'red',
      insert = 'blue',
      visual = 'purple',
      visualblock = 'green',
      command = 'green',
      terminal = 'blue',
      replace = 'yellow',
      default = 'darkgrey'
   },
   path = {
      readonly = 'lightgrey',
      unmodifiable = 'darkgrey',
      path = 'white',
      modified = 'lightgrey',
   },
   branch = 'purple',
   signify = {
      added = 'green',
      modified = 'blue',
      removed = 'red',
   },
   paste = 'red',
   coc = {
      error = 'red',
      warning = 'yellow',
      status = 'darkgrey',
   },
   filetype = 'blue',
   progress = {
      rowandcol = 'red',
      percentage = 'green',
   },
}
```

</details>

### Styles

This option is used to configure which style to use for which bubble.

<details>
<summary><b>Default configuration</b></summary>

```lua
vim.g.bubbly_styles = {
   mode = 'bold',
   path = {
      readonly = 'bold',
      unmodifiable = '',
      path = '',
      modified = '',
   },
   branch = 'bold',
   signify = {
      added = 'bold',
      modified = 'bold',
      removed = 'bold',
   },
   paste = 'bold',
   coc = {
      error = 'bold',
      warning = 'bold',
      status = ''
   },
   filetype = '',
   progress = {
      rowandol = '',
      percentage = '',
   },
}
```

</details>

---

<details>
<summary><b>Lua configuration example</b></summary>

```lua
vim.g.bubbly_styles = {
   mode = 'bold',
   path = {
      readonly = 'bold',
      unmodifiable = '',
      path = 'italic',
      modified = '',
   },
   branch = 'bold',
   signify = {
      added = 'bold',
      modified = 'bold',
      removed = 'bold',
   },
   paste = 'bold',
   coc = {
      error = 'bold',
      warning = 'bold',
      status = 'italic'
   },
   filetype = '',
   progress = {
      rowandol = 'bold',
      percentage = 'bold',
   },
}
```

</details>


