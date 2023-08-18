local M = {
  "p00f/clangd_extensions.nvim",
  commit = "b3b0eb798ecbdd16832fd38d4b07ba31ab4fe831",
  ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
}

M.config = function()
  local status_ok, clangd = pcall(require, "clangd_extensions")
  if not status_ok then
    return
  end

  local cmp_nvim_lsp = require "cmp_nvim_lsp"

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

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

    -- compile (g++)
    keymap(bufnr, "n", "<leader>lc", "<cmd>!g++ %<CR>", { noremap = true, silent = true, desc = "Compile C/C++ code" })

    require("illuminate").on_attach(client)
  end

  Opts = {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  clangd.setup {
    server = Opts,
    extensions = {
      -- defaults:
      -- Automatically set inlay hints (type hints)
      autoSetHints = vim.fn.has "nvim-0.10" ~= 1,
      -- These apply to the default ClangdSetInlayHints command
      inlay_hints = {
        inline = vim.fn.has "nvim-0.10" == 1,
        -- Options other than `highlight' and `priority' only work
        -- if `inline' is disabled
        -- Only show inlay hints for the current line
        only_current_line = false,
        -- Event which triggers a refersh of the inlay hints.
        -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
        -- not that this may cause  higher CPU usage.
        -- This option is only respected when only_current_line and
        -- autoSetHints both are true.
        only_current_line_autocmd = "CursorHold",
        -- whether to show parameter hints with the inlay hints or not
        show_parameter_hints = true,
        -- prefix for parameter hints
        parameter_hints_prefix = "<- ",
        -- prefix for all the other hints (type, chaining)
        other_hints_prefix = "=> ",
        -- whether to align to the length of the longest line in the file
        max_len_align = false,
        -- padding from the left if max_len_align is true
        max_len_align_padding = 1,
        -- whether to align to the extreme right or not
        right_align = false,
        -- padding from the right if right_align is true
        right_align_padding = 7,
        -- The color of the hints
        highlight = "Comment",
        -- The highlight group priority for extmark
        priority = 100,
      },
      ast = {
        -- These are unicode, should be available in any font
        role_icons = {
          type = "",
          declaration = "",
          expression = "",
          specifier = "",
          statement = "",
          ["template argument"] = "",
        },

        kind_icons = {
          Compound = "",
          Recovery = "",
          TranslationUnit = "",
          PackExpansion = "",
          TemplateTypeParm = "",
          TemplateTemplateParm = "",
          TemplateParamObject = "",
        },
        highlights = {
          detail = "Comment",
        },
      },
      memory_usage = {
        border = "none",
      },
      symbol_info = {
        border = "none",
      },
    },
  }
end

return M
