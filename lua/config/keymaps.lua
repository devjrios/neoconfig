-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
map({ "x", "n", "s" }, "<leader>fs", "<cmd>w<cr><esc>", { desc = "Save file" })
-- Lexplore
map({ "n" }, "<leader>-", "<cmd>Oil<cr><esc>", { desc = "Open Netrw" })
-- mbbill/undotree
map({ "n" }, "<leader>#", "<cmd>UndotreeToggle<cr><esc>", { desc = "Undo history" })
