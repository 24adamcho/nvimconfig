local function setup()
	local treeapi = require('nvim-tree.api')

	local function open_nvim_tree()
		treeapi.tree.open()
	end

	vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
	-- vim.api.nvim_create_autocmd({ "WinEnter" }, {
	vim.cmd [[ autocmd WinClosed, WinEnter * if winnr('$') == 1 && &ft == 'neo-tree' | q | endif ]]
end

return {
	setup = setupd
}
