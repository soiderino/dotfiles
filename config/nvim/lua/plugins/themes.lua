return {
  'Shatur/neovim-ayu',
  config = function()
    vim.cmd.colorscheme('ayu')
    vim.cmd([[ highlight Normal guifg=NONE guibg=NONE ]])
  end,
}
