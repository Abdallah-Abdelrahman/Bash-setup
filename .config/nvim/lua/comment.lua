local C = {};

function C.comment_block()
	local line_start = vim.fn.line("'<");
	local line_end = vim.fn.line("'>");
	local l_line = 0;

	vim.cmd('normal! O');
	vim.fn.setline(line_start, '/**')

	for line = line_start + 1, line_end + 1 do
		local curr_line = vim.fn.getline(line)
		vim.fn.setline(line, ' * '..curr_line)
		l_line = line
	end

	vim.cmd('normal!'..(l_line)..'gg') -- navigate to the last line
	vim.cmd('normal! o') -- insert empty line after
	vim.fn.setline(l_line + 1, ' */') -- close the comment
end

function C.comment_line()
	local line = vim.fn.getline('.');
	vim.fn.setline('.', '/* '..line..' */');
end

return C
