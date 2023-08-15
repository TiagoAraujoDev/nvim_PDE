# A Basic Stable IDE config for Neovim

> Why stable?

All the included plugins are pinned to a version that ensures they are compatible and will not update potentially introducing errors into config.

## Install Neovim 0.9

You can install Neovim with your package manager e.g. brew, apt, pacman etc.. but remember that when you update your packages Neovim may be upgraded to a newer version.

If you would like to make sure Neovim only updates when you want it to than I recommend installing from source:

**NOTE** Verify the required [build prerequisites](https://github.com/neovim/neovim/wiki/Building-Neovim#build-prerequisites) for your system.

```sh
git clone https://github.com/neovim/neovim.git
cd neovim
git checkout release-0.9
make CMAKE_BUILD_TYPE=Release
sudo make install
```

## Install the configuration

Make sure to remove or backup your current `nvim` directory

```sh
git clone https://github.com/TiagoAraujoDev/nvim_basic.git ~/.config/nvim
```

Run `nvim` and wait for the plugins to be installed

**NOTE** (You will notice treesitter pulling in a bunch of parsers that are useful for me)

## Get healthy

Open `nvim` and enter the following:

```
:checkhealth
```

You'll probably notice you don't have support for copy/paste also that python and node haven't been set up

So let's fix that

First we'll fix copy/paste

- On mac `pbcopy` should be builtin

- On Ubuntu

  ```sh
  sudo apt install xsel # for X11
  sudo apt install wl-clipboard # for wayland
  ```

Next we need to install python support (node is optional)

- Neovim python support

  ```sh
  pip install pynvim
  ```

- Neovim node support

  ```sh
  npm i -g neovim
  ```

We will also need `ripgrep` for Telescope to work:

- Ripgrep

  ```sh
  sudo apt install ripgrep
  ```

---

**NOTE** make sure you have [node](https://nodejs.org/en/) installed, I recommend a node manager like [fnm](https://github.com/Schniz/fnm).

## Fonts

I recommend using the following repo to get a "Nerd Font" (Font that supports icons)

[getnf](https://github.com/ronniedroid/getnf)

## Configuration

### LSP

To add a new LSP

First Enter:

```
:Mason
```

...and press `i` on the Language Server you wish to install

Note: Builtin LSP doesn't contain all lsps from [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#terraform_lsp).

If you want to install any from there, for example terraform_lsp(which adds more functionality than terraformls, like complete resource listing),

```lua
-- lua/utils/init.lua
M.servers = {
	"lua_ls",
	"cssls",
	"html",
	"tsserver",
	"pyright",
	"bashls",
	"jsonls",
	"yamlls",
  	"terraform_lsp" -- New LSP
}
```

2. Manually install the binary of the lsp and put it in your path by downloading the binary or through your package manager. For terraform_lsp [example](https://github.com/juliosueiras/terraform-lsp/releases)

### Plugins

- Core
    - [lazy.nvim](https://github.com/folke/lazy.nvim)
    - [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
    - [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)
    - [mason.nvim](https://github.com/williamboman/mason.nvim)
    - [null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim)
    - [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
    - [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
    - [cmp-buffer](https://github.com/hrsh7th/cmp-buffer)
    - [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
    - [cmp-nvim-lua](https://github.com/hrsh7th/cmp-nvim-lua)
    - [cmp-path](https://github.com/hrsh7th/cmp-path)
    - [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)
    - [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
    - [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
    - [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
    - [Comment.nvim](https://github.com/numToStr/Comment.nvim)
    - [nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring)
    - [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)
    - [vim-illuminate](https://github.com/RRethy/vim-illuminate)
    - [bufdelete.nvim](https://github.com/famiu/bufdelete.nvim)
    - [nvim-autopairs](https://github.com/windwp/nvim-autopairs)
    - [promise-async](https://github.com/kevinhwang91/promise-async)

- Ui
    - [kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim)
    - [tokyonight.nvim](https://github.com/folke/tokyonight.nvim)
    - [alpha-nvim](https://github.com/goolord/alpha-nvim)
    - [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
    - [which-key.nvim](https://github.com/folke/which-key.nvim)
    - [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
    - [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)
    - [nvim-colorizer.lua](https://github.com/NvChad/nvim-colorizer.lua)
    - [telescope-ui-select.nvim](https://github.com/nvim-telescope/telescope-ui-select.nvim)
    - [noice.nvim](https://github.com/folke/noice.nvim)
    - [nui.nvim](https://github.com/MunifTanjim/nui.nvim)
    - [nvim-notify](https://github.com/rcarriga/nvim-notify)
    - [todo-comments.nvim](https://github.com/folke/todo-comments.nvim)

- Functional plugins
    - [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
    - [project.nvim](https://github.com/ahmedkhalf/project.nvim)
    - [harpoon](https://github.com/ThePrimeagen/harpoon)
    - [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
    - [nvim-spectre](https://github.com/nvim-pack/nvim-spectre)
    - [trouble.nvim](https://github.com/folke/trouble.nvim)
    - [hop.nvim](https://github.com/phaazon/hop.nvim)
    - [better-escape.nvim](https://github.com/max397574/better-escape.nvim)
    - [neoscroll.nvim](https://github.com/karb94/neoscroll.nvim)
    - [nvim-surround](https://github.com/kylechui/nvim-surround)
    - [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo)
    - [nvim-bqf](https://github.com/kevinhwang91/nvim-bqf)
    
- Languages plugins
    - [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls)
    - [clangd_extensions.nvim](https://github.com/p00f/clangd_extensions.nvim)


---

> XGH doesn't think, it does what comes to mind first. There is no second option, the fastest option is the one that goes.
\- GENIUS
