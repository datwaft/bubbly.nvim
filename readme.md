# BUBBLY.NVIM

**Warning:** _Bubbly_ is a **highly experimental** plugin and can have its functionality changed overnight without any warning. I recommend you to check the readme in case the plugin doesn't work as before after an update.

![image](https://user-images.githubusercontent.com/37723586/101704746-01145500-3a4b-11eb-98a1-1e41a3dbf7cf.png)

Hello! _Bubbly_ is a plugin created by me with the intention of creating a good looking and efficient status line. _Bubbly_ is modular and easily extensible — more about this later in the [documentation for developers](#for-developers).

As this plugin is tries to be truly modular, you can enable and disable its modules — or bubbles, as I like to call them — with a simple configuration.

This plugin has support for these bubbles, feel free to open an issue or a pull request if you have an idea for a new bubble.

- Mode bubble (e.g. **Insert mode**).
- Current file bubble.
- _Git_ branch bubble.
- [_Signify_](https://github.com/mhinz/vim-signify) changes bubble.
- [_Coc.nvim_](https://github.com/neoclide/coc.nvim) diagnostics bubble.
- _Neovim built-in LSP_ current function and diagnostics bubble.
- Filetype bubble.
- Progress bubble.

## Table of Contents

   * [BUBBLY.NVIM](#bubblynvim)
      * [Table of Contents](#table-of-contents)
      * [Screenshots](#screenshots)
      * [Requirements](#requirements)
      * [Installation](#installation)
         * [Example of how to install this plugin using packer.nvim](#example-of-how-to-install-this-plugin-using-packernvim)
      * [Configuration](#configuration)
         * [`g:bubbly_statusline`](#gbubbly_statusline)
            * [List of supported modules](#list-of-supported-modules)
            * [Default configuration](#default-configuration)
         * [`g:bubbly_tabline`](#gbubbly_tabline)
            * [Default configuration](#default-configuration-1)
         * [`g:bubbly_palette`](#gbubbly_palette)
            * [Default configuration](#default-configuration-2)
         * [`g:bubbly_characters`](#gbubbly_characters)
            * [Default configuration](#default-configuration-3)
         * [`g:bubbly_symbols`](#gbubbly_symbols)
            * [Default configuration](#default-configuration-4)
         * [`g:bubbly_tags`](#gbubbly_tags)
            * [Default configuration](#default-configuration-5)
         * [`g:bubbly_colors`](#gbubbly_colors)
            * [Default configuration](#default-configuration-6)
         * [`g:bubbly_inactive_color`](#gbubbly_inactive_color)
            * [Default configuration](#default-configuration-7)
         * [`g:bubbly_styles`](#gbubbly_styles)
            * [Default configuration](#default-configuration-8)
         * [`g:bubbly_inactive_style`](#gbubbly_inactive_style)
            * [Default configuration](#default-configuration-9)
         * [`g:bubbly_width`](#gbubbly_width)
            * [Default configuration](#default-configuration-10)
      * [For Developers](#for-developers)
         * [Components](#components)
         * [Autocommands](#autocommands)

## Screenshots

<details>
<summary><b>Click to open</b></summary>

![image](https://user-images.githubusercontent.com/37723586/101704640-ce6a5c80-3a4a-11eb-8020-5da1869b1600.png)

---

![image](https://user-images.githubusercontent.com/37723586/101704746-01145500-3a4b-11eb-98a1-1e41a3dbf7cf.png)

---

![image](https://user-images.githubusercontent.com/37723586/101704807-25703180-3a4b-11eb-83fb-864cd66bf30b.png)

---

![image](https://user-images.githubusercontent.com/37723586/101720701-e30b1c80-3a6b-11eb-981d-afd3d8758551.png)

---

**Screenshot using the Windows Terminal and WSL 2**

![image](https://user-images.githubusercontent.com/37723586/103723977-e6c18e80-4f98-11eb-82f8-c7ca6c33c1b8.png)

**Note:** the bar in the upper part is my custom tmux bar, you can see it in my dotfiles.

</details>

## Requirements

These are the requirements to use this plugin:

- **Neovim nightly** — this is because this plugin uses the newest Lua API from this Neovim version.
- **True color support** — this may change in the future, but currently you need to have true color in your neovim configuration enabled (e.g. `set termguicolors`).

## Installation

You can install this plugin with any package manager you want, for example I use [`packer.nvim`](https://github.com/wbthomason/packer.nvim).

### Example of how to install this plugin using `packer.nvim`

**File name:** `init.lua`

```lua
vim.cmd [[packadd]]
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
   end}
end)
```

## Configuration

_Bubbly_ is also a highly configurable plugin, so you can configure almost anything. If you have an idea about something you would want to configure feel free to open an issue.

_Bubbly_ is configured using a dictionary in a global vim variable and is configured to use the _default_ key in the dictionary as a fallback in case a key doesn't exist. If you set the variable without some key that exists by default it will use the value defined in the default configuration.

### `g:bubbly_statusline`

This variable is used to configure which **modules**/**bubbles** are used in the statusline, and their order. Its a list of strings or lists of tables (that should follow the [same structure as the components](#components)), like the following:

```lua
{ 'component1', 'divisor', 'component2', {{ data = 'string', color = 'red', style = 'bold' }}, 'component 4' }
```

This list can also contain strings like the following, that work like a reserved keyword, and have special functionality:

- `divisor` or `division`: this divides the right part of the statusline from the left part, every component after this keyword goes to the right.
- `truncate` or `trunc`: this marks where, if the size of the window is insufficient to show the whole statusline, the statusline is truncated (everything to the left will be conserved).

Every string that is not a keyword should be the name of a module inside `lua/bubbly/components`, and if an autocommand in a file with the same name exists, it will be loaded.

#### List of supported modules

- `mode`
- `path`
- `branch`
- `signify`
- `coc`
- `builtinlsp.diagnostic_count`
- `builtinlsp.current_function`
- `filetype`
- `progress`

#### Default configuration

```lua
vim.g.bubbly_statusline = {
   'mode',

   'truncate',

   'path',

   'divisor',

   'filetype',
   'progress',
}
```

### `g:bubbly_tabline`

This variable is used to activate or deactivate _Bubbly_ tabline.

#### Default configuration

```lua
vim.g.bubbly_tabline = 1
```

### `g:bubbly_palette`

This variable is used to define the palette available to every component and their respective colors. You can define more colors than the default and use them in your components or in the configuration variable without any worry.

Accepted values are `cterm-colors` naming such as `LightGrey` or `DarkMagenta`, hexadecimal values such as `#123abc` and highlight groups such as `Normal background` or `LineNr foreground`.

#### Default configuration

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

### `g:bubbly_characters`

This variable is used to define special characters used in the bubbles.

#### Default configuration

```lua
vim.g.bubbly_characters = {
   -- Bubble delimiters.
   left = '',
   right = '',
   -- Close character for the tabline.
   close = 'x',
}
```

### `g:bubbly_symbols`

This variable is used to define the symbols used in some bubbles. Every string follows the format from the C library for formatting strings.

#### Default configuration

```lua
vim.g.bubbly_symbols = {
   default = 'PANIC!',

   path = {
      readonly = 'RO',
      unmodifiable = '',
      modified = '+',
   },
   signify = {
      added = '+%s', -- requires 1 '%s'
      modified = '~%s', -- requires 1 '%s'
      removed = '-%s', -- requires 1 '%s'
   },
   coc = {
      error = 'E%s', -- requires 1 '%s'
      warning = 'W%s', -- requires 1 '%s'
   },
   builtinlsp = {
      diagnostic_count = {
         error = 'E%s', -- requires 1 '%s'
         warning = 'W%s', --requires 1 '%s'
      },
   },
   branch = ' %s' -- requires 1 '%s'
}
```

### `g:bubbly_tags`

This variable defines the test used in some bubbles, if it's empty the bubble disappears.

#### Default configuration

```lua
vim.g.bubbly_tags = {
   default = 'HELP ME PLEASE!',

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

### `g:bubbly_colors`

This variable defines which colors is used by which bubble. Every color can be a string with the name of the color or a table with `foreground` and `background` keys, which define which color is used for foreground and background.

#### Default configuration

```lua
vim.g.bubbly_colors = {
   default = 'red',

   mode = {
      normal = 'green', -- uses by default 'background' as the foreground color.
      insert = 'blue',
      visual = 'red',
      visualblock = 'red',
      command = 'red',
      terminal = 'blue',
      replace = 'yellow',
      default = 'white'
   },
   path = {
      readonly = { background = 'lightgrey', foreground = 'foreground' },
      unmodifiable = { background = 'darkgrey', foreground = 'foreground' },
      path = 'white',
      modified = { background = 'lightgrey', foreground = 'foreground' },
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
      status = { background = 'lightgrey', foreground = 'foreground' },
   },
   builtinlsp = {
      diagnostic_count = {
         error = 'red',
         warning = 'yellow',
      },
      current_function = 'purple',
   },
   filetype = 'blue',
   progress = {
      rowandcol = { background = 'lightgrey', foreground = 'foreground' },
      percentage = { background = 'darkgrey', foreground = 'foreground' },
   },
   tabline = {
      active = 'blue',
      inactive = 'white',
   },
}
```

### `g:bubbly_inactive_color`

This variable defines the color used by bubbles when the statusline is inactive. It follows the same structure for colors as [`g:bubbly_colors`](#gbubbly_colors) (e.g. it can be `'red'` or `{ foreground = 'red', background = 'blue' }`).

#### Default configuration

```lua
vim.g.bubbly_inactive_color = { background = 'lightgrey', foreground = 'foreground' }
```

### `g:bubbly_styles`

This variable defines which style is used by which bubble. Styles can be `''`, `'bold'` and `'italic'`.

#### Default configuration

```lua
vim.g.bubbly_styles = {
   default = 'bold',

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
   builtinlsp = {
      diagnostic_count = {
         error = '',
         warning = ''
      },
      current_function = ''
   },
   filetype = '',
   progress = {
      rowandcol = '',
      percentage = '',
   },
   tabline = {
      active = 'bold',
      inactive = '',
   },
}
```

### `g:bubbly_inactive_style`

This variable defines the style for the bubbles in an inactive statusline.

#### Default configuration

```lua
-- Can be '' or 'bold' or 'italic'.
vim.g.bubbly_inactive_style = ''
```

### `g:bubbly_width`

This variable defines the minimum width of some bubbles.

If the value is 0 it doesn't have a minimum width.

#### Default configuration

```lua
vim.g.bubbly_width = {
   default = 0,

   progress = {
      rowandcol = 8,
   },
}
```

## For Developers

_Bubbly_ is a fully modular plugin, so you can add new modules using the folders `lua/bubbly/components` and `lua/bubbly/autocommands`. Every Lua file in these folders is loaded if the option `g:bubbly_statusline` has the module name in its list.

For example, if in these folders there is a file named `thingy.lua` and `g:bubbly_statusline` contains the string `"thingy"`, the file `lua/bubbly/components/thingy.lua` will be loaded as a bubble and the file `lua/bubbly/autocommands/thingy.lua` (if it exists) will have its return value used as _autocommands_. Additionally, I haven't tested it yet, but you technically should be able to have your own `lua/bubbly/components` and `lua/bubbly/autcommands` in your neovim configuration folder and those components should work with this plugin.

**Note:** If the component is inside another folder (e.g. `lua/bubbly/components/folder/thingy.lua`) you should use it inside `g:bubbly_statusline` with the same syntax of a Lua module (e.g. `folder.thingy`).

### Components

Components are bubbles inside the statusline that have some functionality. They can have two states, active and inactive; in their active state they should use the color the user defined for them in the configuration, and in their inactive state they should use the inactive color that the user defined.

The components go inside the `lua/bubbly/components` folder. They should be a Lua file that returns a function. This function should follow the following structure:

```lua
function(inactive)
   return {
      -- This is a list of tables
      -- Every table follows the following structure:
      {
         -- This is what the component shows in the statusline
	 data = 'string',
         -- This is what color the component uses when it is active. It should be the name of a color.
         color = 'string' or { foreground = 'string', background = 'string' },
         -- This is the style the component uses (optional).
         style = '' or 'bold' or 'italic',
         -- This is a string to place before the bubble (optional) (usually not used).
         pre = 'string',
         -- This is a string to place after the bubble (optional) (usually not used).
         post = 'string',
      },
   }
end
```

Usually  every part of the bubble gets its data from the `g:bubbly_something` variables, to be fully configurable.

You can use components like [`path`](https://github.com/datwaft/bubbly.nvim/blob/master/lua/bubbly/components/path.lua) as a reference to create your own.

### Autocommands

These are used to automate some part of a bubble. For example they are used to automate the _branch_ of the `branch` bubble so that every time a different file is opened the bubble changes to the branch of the file.

These go inside the `lua/bubbly/autocommands` folder and should be a Lua file that returns a list of tables with the following structure:

```lua
return {
   -- Every table inside the list should follow the following structure:
   {
      -- These are the events that activate the autocommand.
      events = { 'Event1', 'Event2' },
      -- This is the variable that contains the result of the autocommand.
      variable = {
         -- This is the type of the variable, it can be either 'buffer', 'window' or 'global'.
         type = 'buffer' or 'window' or 'global',
         -- This is the name the global function will have and also the name of the variable that contains the result.
         name = 'string',
      },
      -- This is the command that is executed by the autocommand, its return value will be saved into the variable.
      command = function() end,
   },
}
```

You can use components' autocommands like [`branch`](https://github.com/datwaft/bubbly.nvim/blob/master/lua/bubbly/autocommands/branch.lua) as a reference to create your own.
