local C = {};
C.filetype = {
	py = '#',
	js = '//',
	c = { open = '/*', close = '*/' },
	jsx = { open = '{/*', close = '*/}' }
}

function C.comment_line()
	-- TODO: ADD UNCOMMENT AS WELL
	local ext = vim.fn.expand('%:e') -- file extension
	if ext:match('.+sx') then
		-- match against `.tsx` as well
		ext = 'jsx'
	end
	if ext:match('ts') then
		-- match against `.ts` as well
		ext = 'js'
	end
	local symbol = C.filetype[ext] -- get corresponding comment symbol
	local line = vim.fn.getline('.') -- current line under the cursor

	if symbol == nil then
		-- unsupported file extension
		print(' does not have corresponding comment')
		return
	end

	if type(symbol) == 'table' then
		vim.fn.setline('.', symbol.open .. line .. symbol.close)
	else
		vim.fn.setline('.', symbol .. line)
	end
end

function C.comment_block()
	-- comment `C` block
	local line_start = vim.fn.line("'<");
	local line_end = vim.fn.line("'>");
	local l_line = 0;

	vim.cmd('normal! O');
	vim.fn.setline(line_start, '/**')

	for line = line_start + 1, line_end + 1 do
		local curr_line = vim.fn.getline(line)
		vim.fn.setline(line, ' * ' .. curr_line)
		l_line = line
	end

	vim.cmd('normal!' .. (l_line) .. 'gg') -- navigate to the last line
	vim.cmd('normal! o')            -- insert empty line after
	vim.fn.setline(l_line + 1, ' */') -- close the comment
end

function C.setup()
	-- script loads once mapping is defined
	vim.keymap.set('v', '<leader>,', C.comment_block,
		{ noremap = true, silent = true, desc = 'comment block' })

	-- defer script loading until mapping executed
	vim.keymap.set('n', '<leader>,', C.comment_line,
		{ noremap = true, silent = true, desc = 'comment one line' })
end

return C
