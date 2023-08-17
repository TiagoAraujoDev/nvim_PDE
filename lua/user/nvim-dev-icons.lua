local M = {
  "nvim-tree/nvim-web-devicons",
  event = "VeryLazy",
  commit = "e283ab937e0197b37ec5d8013e49495193407324",
}

function M.config()
  local get_icon = require("utils.icons").get_icon
  require("nvim-web-devicons").setup {
    override = {
      zsh = {
        icon = "",
        color = "#428850",
        cterm_color = "65",
        name = "Zsh",
      },
    },
    color_icons = true,
    default = true,
    override_by_filename = {
      [".gitignore"] = {
        icon = get_icon "Git",
        color = "#f1502f",
        name = "Gitignore",
      },
      [".luacheckrc"] = {
        icon = get_icon "Lua",
        color = "#51A0CF",
        name = "Luacheck",
      },
      [".eslintrc.json"] = {
        icon = get_icon "Eslint",
        color = "#4b32c3",
        name = "Eslintrc",
      },
      [".eslintignore"] = {
        icon = get_icon "Eslint",
        color = "#4b32c3",
        name = "Eslintignore",
      },
      [".env.example"] = {
        icon = get_icon "Env",
        color = "#fcf003",
        name = "Env_example",
      },
      [".env.production"] = {
        icon = get_icon "Env",
        color = "#fcf003",
        name = "Env_prod",
      },
      [".env.development"] = {
        icon = get_icon "Env",
        color = "#fcf003",
        name = "Env_dev",
      },
    },
    override_by_extension = {
      ["json"] = {
        icon = get_icon "Json",
        color = "#fcf003",
        name = "JSON",
      },
      ["java"] = {
        icon = get_icon "Coffe",
        color = "#FB1A00",
        name = "Java",
      },
      ["class"] = {
        icon = get_icon "Coffe",
        color = "#4A61EA",
        name = "Java_bytecode",
      },
      ["js"] = {
        icon = get_icon "Javascript",
        color = "#F0DB4F",
        name = "Javascript",
      },
      ["mjs"] = {
        icon = get_icon "Javascript",
        color = "#F0DB4F",
        name = "Michael_Jackson_script",
      },
      ["ts"] = {
        icon = get_icon "Typescript",
        color = "#007acc",
        name = "Typescript",
      },
      ["astro"] = {
        icon = get_icon("Astro"),
        color = "#FF6900",
        name = "Astro",
      },
    },
  }
end

return M
