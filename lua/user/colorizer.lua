local M = {
  "NvChad/nvim-colorizer.lua",
  commit = "dde3084106a70b9a79d48f426f6d6fec6fd203f7",
  event = "BufEnter",
}

M.config = function()
  local status_ok, colorizer = pcall(require, "colorizer")
  if not status_ok then
    return
  end

  colorizer.setup {
    filetypes = {
      "*",
      -- "css",
      -- "html",
      -- typescript = { names = false, mode = "background" },
      -- javascript = { names = false, mode = "background" },
      -- tsx = { names = false, mode = "background" },
    },
    user_default_options = {
      RGB = true, -- #RGB hex codes
      RRGGBB = true, -- #RRGGBB hex codes
      names = true, -- "Name" codes like Blue or blue
      RRGGBBAA = true, -- #RRGGBBAA hex codes
      AARRGGBB = true, -- 0xAARRGGBB hex codes
      rgb_fn = false, -- CSS rgb() and rgba() functions
      hsl_fn = false, -- CSS hsl() and hsla() functions
      css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
      css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      -- Available modes for `mode`: foreground, background,  virtualtext
      mode = "background", -- Set the display mode.
      -- Available methods are false / true / "normal" / "lsp" / "both"
      -- True is same as normal
      tailwind = true, -- Enable tailwind colors
      -- parsers can contain values used in |user_default_options|
      sass = { enable = false, parsers = { "css" } }, -- Enable sass colors
      virtualtext = "■",
      -- update color values even if buffer is not focused
      -- example use: cmp_menu, cmp_docs
      always_update = false,
    },
  }
end

return M
