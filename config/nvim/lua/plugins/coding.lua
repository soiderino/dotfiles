return {
  {
    'echasnovski/mini.pairs',
    event = 'VeryLazy',
    opts = {
      modes = { insert = true, command = true, terminal = true },
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      skip_ts = { 'string' },
      skip_unbalanced = true,
      markdown = true,
    },
  },

  {
    'echasnovski/mini.surround',
    version = '*',
    opts = {

    },
  },

  -- comments
  {
    'numToStr/Comment.nvim',
    lazy = false,
    opts = {
      padding = true,
      sticky = false,
      toggler = {
        line = 'gcc',
        block = 'gbc'
      },
    },
  },
}
