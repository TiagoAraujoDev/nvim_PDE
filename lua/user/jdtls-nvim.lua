local M = {
  "mfussenegger/nvim-jdtls",
  commit = "96e3978c3fdae3950f6ccda548775e8b8952f74a",
  ft = { "java" },
}

M.opts = function()
  -- calculate workspace dir
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
  local workspace_dir = "/home/tma/.local/share/nvim/site/java/workspace-root/" .. project_name
  os.execute("mkdir " .. workspace_dir)

  -- get the current OS
  local os
  if vim.fn.has "mac" == 1 then
    os = "mac"
  elseif vim.fn.has "unix" == 1 then
    os = "linux"
  elseif vim.fn.has "win32" == 1 then
    os = "win"
  end

  -- ensure that OS is valid
  if not os or os == "" then
    print "jdtls: Could not detect valid OS"
  end

  local on_attach = function(client, bufnr)
    local keymap = vim.api.nvim_buf_set_keymap
    keymap(
      bufnr,
      "n",
      "gD",
      "<cmd>lua vim.lsp.buf.declaration()<CR>",
      { noremap = true, silent = true, desc = "GoTo declaration" }
    )
    keymap(
      bufnr,
      "n",
      "gd",
      "<cmd>lua vim.lsp.buf.definition()<CR>",
      { noremap = true, silent = true, desc = "GoTo definition" }
    )
    keymap(bufnr, "n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true, desc = "Hover" })
    keymap(
      bufnr,
      "n",
      "gI",
      "<cmd>lua vim.lsp.buf.implementation()<CR>",
      { noremap = true, silent = true, desc = "GoTo implementation" }
    )
    keymap(
      bufnr,
      "n",
      "gr",
      "<cmd>lua vim.lsp.buf.references()<CR>",
      { noremap = true, silent = true, desc = "GoTo references" }
    )
    keymap(
      bufnr,
      "n",
      "gl",
      "<cmd>lua vim.diagnostic.open_float()<CR>",
      { noremap = true, silent = true, desc = "Float diagnostic" }
    )
    keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", { noremap = true, silent = true, desc = "Lsp info" })
    keymap(bufnr, "n", "<leader>lI", "<cmd>Mason<cr>", { noremap = true, silent = true, desc = "Mason" })
    keymap(
      bufnr,
      "n",
      "<leader>la",
      "<cmd>lua vim.lsp.buf.code_action()<cr>",
      { noremap = true, silent = true, desc = "Code action" }
    )
    keymap(
      bufnr,
      "n",
      "<leader>lj",
      "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>",
      { noremap = true, silent = true, desc = "Next diagnostic" }
    )
    keymap(
      bufnr,
      "n",
      "<leader>lk",
      "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>",
      { noremap = true, silent = true, desc = "Previous diagnostic" }
    )
    keymap(
      bufnr,
      "n",
      "<leader>lr",
      "<cmd>lua vim.lsp.buf.rename()<cr>",
      { noremap = true, silent = true, desc = "Rename" }
    )
    keymap(
      bufnr,
      "n",
      "<leader>ls",
      "<cmd>lua vim.lsp.buf.signature_help()<CR>",
      { noremap = true, silent = true, desc = "Signature help" }
    )
    keymap(
      bufnr,
      "n",
      "<leader>lq",
      "<cmd>lua vim.diagnostic.setloclist()<CR>",
      { noremap = true, silent = true, desc = "Setloclist" }
    )

    keymap(
      bufnr,
      "n",
      "<leader>lo",
      "<Cmd>lua require('jdtls').organize_imports()<CR>",
      { noremap = true, silent = true, desc = "Organize imports" }
    )
    keymap(
      bufnr,
      "n",
      "<leader>le",
      "<Cmd>lua require('jdtls').extract_variable()<CR>",
      { noremap = true, silent = true, desc = "Extract variable" }
    )
    keymap(
      bufnr,
      "n",
      "<leader>lc",
      "<Cmd>lua require('jdtls').extract_constant()<CR>",
      { noremap = true, silent = true, desc = "Extract constant" }
    )

    -- compile (javac)
    keymap(
      bufnr,
      "n",
      "<leader>lc",
      "<Cmd>!javac -d bin src/**/*.java<CR>",
      { noremap = true, silent = true, desc = "Compile java code" }
    )

    require("illuminate").on_attach(client)
  end

  local defaults = {
    cmd = {
      -- 💀
      "java", -- or '/path/to/java17_or_newer/bin/java'
      -- depends on if `java` is in your $PATH env variable and if it points to the right version.
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true",
      "-Dlog.level=ALL",
      "-Xmx1g",
      "--add-modules=ALL-SYSTEM",
      "--add-opens",
      "java.base/java.util=ALL-UNNAMED",
      "--add-opens",
      "java.base/java.lang=ALL-UNNAMED",
      -- 💀
      "-jar",
      -- org.eclipse.equinox.launcher_1.6.500.v20230717-2134
      "/home/tma/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar",

      -- 💀
      "-configuration",
      "/home/tma/.local/share/nvim/mason/packages/jdtls/config_linux/",
      "-data",
      workspace_dir,
    },

    -- 💀
    root_dir = require("jdtls.setup").find_root { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", ".project" },

    settings = {
      java = {},
    },

    init_options = {
      bundles = {},
    },
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
    end,
  }

  return defaults
end

M.config = function(_, opts)
  -- setup autocmd on filetype detect java
  vim.api.nvim_create_autocmd("Filetype", {
    pattern = "java", -- autocmd to start jdtls
    callback = function()
      if opts.root_dir and opts.root_dir ~= "" then
        require("jdtls").start_or_attach(opts)
      else
        print "jdtls: root_dir not found. Please specify a root marker"
      end
    end,
  })
end

return M
