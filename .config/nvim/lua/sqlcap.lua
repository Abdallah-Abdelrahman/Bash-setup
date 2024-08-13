-- script intends to capitalize every keyword in `sql`
local S = {}

function S.capitalize()
	S.filename = vim.fn.expand('%:t')
	-- executing bash command `sqlcap`
	S.msg = vim.fn.system('sqlcap' .. ' ' .. S.filename)

	if vim.v.shell_error ~= 0 then
		print('error: ')
		return
	end

	-- force the buffer to reload
	-- and flush updates
	vim.cmd('e')
end

function S.setup()
	vim.keymap.set(
		'n', '<leader>q',
		S.capitalize,
		{ noremap = true, silent = true, desc = 'capitalize sql keywords' }
	)
end

return S
