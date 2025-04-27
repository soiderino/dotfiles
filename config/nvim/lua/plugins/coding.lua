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

	-- comments
	{
		'folke/ts-comments.nvim',
		event = 'VeryLazy',
		opts = {},
	},
}
