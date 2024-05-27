-- script intends to capitalize every keyword in `sql`
local S = {}

function S.capitalize()
	S.filename = vim.fn.expand('%:t')
	-- executing bash command `sqlcap`
	S.msg =  vim.fn.system('sqlcap'..' '..S.filename)

	if vim.v.shell_error ~= 0 then
		print('error: ')
		return
	end

	-- force the buffer to reload
	vim.cmd('e')
end

return S
