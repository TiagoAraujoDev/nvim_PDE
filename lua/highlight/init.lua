local hl = vim.api.nvim_set_hl

-- Illuminate
hl(0, "LspReferenceRead", { bg = "#424A56", underline = false })
hl(0, "LspReferenceWrite", { bg = "#424A56", underline = false })
hl(0, "LspReferenceText", { bg = "#424A56", underline = false })
hl(0, "IlluminatedWordRead", { bg = "#424A56", underline = false })
hl(0, "IlluminatedWordWrite", { bg = "#424A56", underline = false })
hl(0, "IlluminatedWordText", { bg = "#424A56", underline = false })
hl(0, "IlluminatedWordWrite", { bg = "#424A56", underline = false })
hl(0, "IlluminatedWordWrite", { bg = "#424A56", underline = false })
hl(0, "IlluminatedWordWrite", { bg = "#424A56", underline = false })

-- require colorscheme highlights
require("highlight.kanagawa-wave") -- Change to the active colorscheme or comment this line
