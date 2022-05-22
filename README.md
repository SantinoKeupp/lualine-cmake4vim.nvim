# lualine-cmake4vim.nvim

[Lualine](https://github.com/nvim-lualine/lualine.nvim) component for [cmake4vim](https://github.com/ilyachur/cmake4vim). It displays the selected kit, build_type and build_target.

## Requirements

- [cmake4vim](https://github.com/ilyachur/cmake4vim)
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
- [Nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons) (optional)

## Installation

### [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug "SantinoKeupp/lualine-cmake4vim.nvim"
```

### [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use "SantinoKeupp/lualine-cmake4vim.nvim"
```

### cmake4vim component options

```lua
sections = {
  lualine_a = {
    {
      "cmake4vim",
      prefix = "",  -- Text to show befor the actual configuration
      cmake4vim_separator = ">",  -- Seperator used between the configuration items
      colored = true,  -- Displays filetype icon in color if set to true
    }
  }
}
```

_Note:_ A condition is set by default that checks if ```cmake4vim``` is actually loaded
