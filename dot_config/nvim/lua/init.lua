vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "
vim.keymap.set("n", "<Leader>/", ':let @/=""<CR>', { silent = true })
vim.g.omni_sql_no_default_maps = 1

require("options")
require("init_lazy")
