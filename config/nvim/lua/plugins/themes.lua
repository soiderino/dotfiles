return {
	'datsfilipe/vesper.nvim',
	opts = function()
		-- goofiest method ever
		vim.cmd.colorscheme('vesper')
		vim.cmd([[ highlight Normal guifg=NONE guibg=NONE ]])
	end,
}
