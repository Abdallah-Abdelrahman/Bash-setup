vim.api.nvim_create_autocmd('BufWritePost', {
	pattern = '*.html',
	callback = function ()
		-- Save the current cursor position
		--local cursor_pos = vim.api.nvim_win_get_cursor(0)
		---- split each tag into separate line
		--vim.cmd([[silent! %s/<[^>]*>/\r&\r/g]])
		---- Apply automatic indentation to the entire file
		--vim.cmd('silent! normal! gg=G')
		---- delete empty lines
		--vim.cmd([[silent! %s/^\n//g]])
		---- Restore the cursor position
		--vim.api.nvim_win_set_cursor(0, cursor_pos)
	end
})
