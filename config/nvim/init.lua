local gh = function(x) return 'https://github.com/' .. x end

-- @soiderino (todo): move everything in separate folders
-- vim pack (plugins, themes)
vim.pack.add({
  gh('folke/tokyonight.nvim'),
  gh('nvim-lualine/lualine.nvim'),
  gh('nvim-tree/nvim-tree.lua'),
  gh('windwp/nvim-autopairs'),
  gh('numToStr/Comment.nvim'),
  gh('nvim-mini/mini.surround'),
  gh('mfussenegger/nvim-dap')
})

-- plugin setups
require('tokyonight').setup({ style = 'night', transparent = true })
require('lualine').setup({
  options = {
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    icons_enabled = false
  }
})
require('Comment').setup()
require('mini.surround').setup()
require('nvim-autopairs').setup()
require('nvim-tree').setup()

-- global settings
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.wrap = false
opt.scrolloff = 5
opt.sidescrolloff = 5

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false

opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.updatetime = 250
opt.timeoutlen = 300

opt.undofile = true
opt.swapfile = false
opt.backup = false
opt.clipboard = "unnamedplus"

vim.cmd.colorscheme('tokyonight')

local map = vim.keymap.set

map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move lines down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move lines up" })

map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa!<cr>", { desc = "Force quit" })

map("n", "<Esc>", "<cmd>nohlsearch<cr>")

map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle explorer" })

map("n", "<C-Up>", "<cmd>resize +2<cr>")
map("n", "<C-Down>", "<cmd>resize -2<cr>")
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>")
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>")


-- autocommands
local au = vim.api.nvim_create_autocmd
local function augroup(name)
  return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

au("TextYankPost", {
  group = augroup("highlight_yank"),
  desc  = "Highlight yanked text",
  callback = function()
    vim.hl.on_yank({ hitgroup = "IncSearch", timeout = 150 })
  end,
})

au("BufWritePre", {
  group = augroup("trim_whitespace"),
  desc = "Remove trailing whitespace",
  callback = function()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[silent! %s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, pos)
  end,
})

au('VimResized', {
  group = augroup("resize_splits"),
  desc = "Equalize splits on resize",
  callback = function() vim.cmd('tabdo wincmd =') end,
})

au('FileType', {
  group = augroup("close_with_q"),
  pattern = {
    'help', 'man', 'lspinfo', 'qf', 'checkhealth',
    'startuptime', 'tsplayground', 'trouble', 'notify',
    'PlenaryTestPopup', 'spectre_panel',
  },
  callback = function(ev)
    map('n', 'q', '<cmd>close<cr>', { buffer = ev.buf, silent = true })
  end,
})

au('FileType', {
  group = augroup('spell_prose'),
  pattern = { 'markdown', 'text', 'gitcommit', 'NeogitCommitMessage' },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = 'en_us'
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.conceallevel = 0

    map('n', 'j', 'gj', { buffer = true })
    map('n', 'k', 'gk', { buffer = true })
  end,
})

au('TermOpen', {
  group = augroup('terminal_settings'),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = 'no'
    vim.cmd('startinsert')
  end,
})

au({ 'FocusGained', 'BufEnter', 'CursorHold' }, {
  group = augroup("auto_reload"),
  desc  = "Check if buffer changed on disk",
  callback = function()
    if vim.fn.getcmdwintype() == "" then vim.cmd("checktime") end
  end,
})

