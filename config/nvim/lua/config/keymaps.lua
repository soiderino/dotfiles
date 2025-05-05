local keybind = vim.keymap.set

keybind('n', '<C-s>', ':w<CR>', { noremap = true, silent = true, desc = 'Save File' })
keybind('i', '<C-s>', '<Esc>:w<CR>', { noremap = true, silent = true, desc = 'Save File' })
keybind('n', '<Esc>', ':nohlsearch<CR>', { noremap = true, silent = true, desc = 'Clean Search' })

keybind('n', '<leader>ne', ':Neotree toggle<cr>', { noremap = true, silent = true, desc = 'Open File Explorer' })
keybind('n', '<leader>nf', ':Neotree focus<cr>', { noremap = true, silent = true, desc = 'Focus on File Explorer' })

keybind('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
keybind('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
keybind('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
keybind('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

keybind('t', '<esc>', [[<c-\><c-n>]], { noremap = true })

keybind('n', '<left>', '<cmd>echo "use h to move!!"<cr>')
keybind('n', '<right>', '<cmd>echo "use l to move!!"<cr>')
keybind('n', '<up>', '<cmd>echo "use k to move!!"<cr>')
keybind('n', '<down>', '<cmd>echo "use j to move!!"<cr>')
