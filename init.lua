--------------------------------------------------------
--===run packercompile whenever changing this file===---
--------------------------------------------------------

vim.cmd [[packadd packer.nvim]]

--nvim-tree config
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

require('packer').startup(function(use)
	--- package itself----------
	use 'wbthomason/packer.nvim'
	----------------------------
	
	use 'EdenEast/nightfox.nvim'
	-- use 'navarasu/onedark.nvim' --theme

	use {
		'nvim-treesitter/nvim-treesitter',
		run = function()
			local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
			ts_update()
		end,
	}
	
-- 	use {
		-- 'nvim-tree/nvim-tree.lua',
		-- requires = {
			-- 'nvim-tree/nvim-web-devicons',
		-- }
	-- }
	use {
		'nvim-neo-tree/neo-tree.nvim',
		requires = {
			'nvim-lua/plenary.nvim',
			'nvim-tree/nvim-web-devicons',
			'MunifTanjim/nui.nvim',
		}
	}

	use 'tpope/vim-fugitive'
	use 'sheerun/vim-polyglot'
	use {
		'nvim-lualine/lualine.nvim',
		requires = {
			'nvim-tree/nvim-web-devicons',
			opt = true
		}
	}

	use 'nanozuki/tabby.nvim'
	use 'gelguy/wilder.nvim'

	-- LSP
	use({
			"neovim/nvim-lspconfig",
			config = function()
					require("configs.lsp")
			end,
	})

	use("onsails/lspkind-nvim")
	use({
			"L3MON4D3/LuaSnip",
			-- follow latest release.
			tag = "v<CurrentMajor>.*",
	})

	-- cmp: Autocomplete
	use({
			"hrsh7th/nvim-cmp",
			event = "InsertEnter",
			config = function()
					require("configs.cmp")
			end,
	})

	use("hrsh7th/cmp-nvim-lsp")

	use({ "hrsh7th/cmp-path", after = "nvim-cmp" })

	use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })

	-- LSP diagnostics, code actions, and more via Lua.
	use({
			"jose-elias-alvarez/null-ls.nvim",
			config = function()
					require("configs.null-ls")
			end,
			requires = { "nvim-lua/plenary.nvim" },
	})

	-- Mason: Portable package manager
	use({
			"williamboman/mason.nvim",
			config = function()
					require("mason").setup()
			end,
	})

	use({
			"williamboman/mason-lspconfig.nvim",
			config = function()
					require("configs.mason-lsp")
			end,
	})

	-- Markdown Preview
	use({
			"iamcco/markdown-preview.nvim",
			run = function()
					vim.fn["mkdp#util#install"]()
			end,
	})

	-- Auto pairs
	use({
			"windwp/nvim-autopairs",
			config = function()
					require("configs.autopairs")
			end,
	})
end)

local palette = {
	high = "#DBD4BD",
	mid  = "#979381",
	low  = "#57544A",
	alert= "#CD664D",
	green= "#74BD85",
}

require('nightfox').setup({
	options = {
		transparent = true,
		styles = {
			comments = "italic",
		},
	},
	--palettes = {
	--	all = {
	--		bg0 = palette.high,
	--	},
	--},
})

vim.cmd("colorscheme carbonfox")

local lualine_theme = require 'lualine.themes.ayu_mirage'
local b = {bg = palette.mid, fg = palette.low}
local c = {bg = palette.low, fg = palette.mid}
local x = {bg = palette.low, fg = palette.mid}
local y = {bg = palette.mid, fg = palette.low}
local z = {bg = palette.high, fg = palette.mid}
lualine_theme.normal = {
	a = {bg = palette.high, fg = palette.mid},
	b = b,
	c = c,
	x = x,
	y = y,
	z = z,
}
lualine_theme.insert = {
	a = {bg = palette.high, fg = palette.low, gui = 'bold'},
	b = b,
	c = c,
	x = x,
	y = y,
	z = z,
}
lualine_theme.visual = {
	a = {bg = palette.high, fg = palette.green, gui = 'bold'},
	b = b,
	c = c,
	x = x,
	y = y,
	z = z,
}
lualine_theme.replace = {
	a = {bg = palette.high, fg = palette.alert, gui = 'bold'},
	b = b,
	c = c,
	x = x,
	y = y,
	z = z,
}
lualine_theme.command = {
	a = {bg = palette.alert, fg = palette.high, gui = 'bold'},
	b = b,
	c = c,
	x = x,
	y = y,
	z = z,
}
lualine_theme.pending = {
	a = {bg = palette.alert, fg = palette.high, gui = 'bold'},
	b = b,
	c = c,
	x = x,
	y = y,
	z = z,
}
lualine_theme.inactive = {
	a = {bg = palette.low, fg = palette.mid, gui = 'bold'},
	b = b,
	c = c,
	x = x,
	y = y,
	z = z,
}
lualine_theme.terminal = {
	a = {bg = palette.green, fg = palette.high, gui = 'bold'},
  b = b,
	c = c,
	x = x,
	y = y,
	z = z,
}
require('lualine').setup({
		options = {
			theme = lualine_theme,
		},
	}
)

vim.o.showtabline=2

require('nvim-treesitter.configs').setup{
	ensure_installed = { "lua", "cpp", "python", "javascript", "json", "html", "css", "regex" },
	highlight = { enable = true, },
}

-- require('nvim-tree').setup()
-- --open nvim_tree at startup
-- local treeapi = require('nvim-tree.api')
-- local function open_nvim_tree()
	-- local win = vim.api.nvim_get_current_win()
	-- treeapi.tree.open({
		-- current_window = false
	-- })
	-- vim.api.nvim_set_current_win(win)
-- end
-- vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
-- 
-- --quit nvim_tree if last window
-- local function close_nvim_tree()
	-- local tree_wins = {}
	-- local floating_wins = {}
	-- local wins = vim.api.nvim_list_wins()
	-- for _, w in ipairs(wins) do
		-- local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
		-- if bufname:match("NvimTree_") ~= nil then
			-- table.insert(tree_wins, w)
		-- end
		-- if vim.api.nvim_win_get_config(w).relative ~= '' then
			-- table.insert(floating_wins, w)
		-- end
	-- end
	-- if 1 == #wins - #floating_wins - #tree_wins then
		-- -- Should quit, so we close all invalid windows.
		-- for _, w in ipairs(tree_wins) do
			-- vim.api.nvim_win_close(w, true)
		-- end
	-- end
-- end
-- vim.api.nvim_create_autocmd("QuitPre", { callback = close_nvim_tree })
-- 
-- --toggle nvim_tree
-- vim.api.nvim_set_keymap("n", "<C-h>", ":NvimTreeToggle<cr>", {silent = true, noremap = true})

require('neo-tree').setup({
		window = {
			mappings = {
				['P'] = function(state)
					local node = state.tree:get_node()
					require('neo-tree.ui.renderer').focus_node(state, node:get_parent_id())
				end
			}
		},
		close_if_last_window = true,
		enable_git_status = 'true',
		enable_normal_mode_for_inputs = false,
		filesystem = {
			filtered_items = {
				visible = true,
				hide_dotfiles = false,
				hide_gitignored = true,
			},
		},
		default_component_configs = {
			git_status = {
				symbols = {
					added     = "+",
					modified  = "M",
					deleted   = "D",
					renamed   = "R",
					-- Status type
					untracked = "U",
					ignored   = "",
					unstaged  = "󰄱",
					staged    = "",
					conflict  = "!",
				}
			},
			modified = {
				symbol = "*",
			},
			indent = {
				expander_collapsed = "",
        expander_expanded = "",
			},
		}
})
local function open_nvim_tree()
	vim.cmd [[ :Neotree action=show ]]
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
vim.api.nvim_create_autocmd({ "TabNew" }, { command = "Neotree action=show" })
vim.api.nvim_set_keymap("n", "<C-h>", ":Neotree toggle<cr>", {silent = true, noremap = true})

--exit terminal mode with C-/ C-n keystroke
vim.cmd [[ tnoremap <Esc> <C-\><C-n> ]]

--keep cursor in a small range in the center
vim.cmd [[ set scrolloff=10 ]]

--tabby config
local tabline = {fg = palette.high, bg = palette.mid}
local tablinese={fg = palette.low, bg = palette.high}
local theme = {
  -- fill = 'TabLineFill',
  -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
	fill = {fg=palette.high, bg=palette.low},
--   head = 'TabLine',
  -- current_tab = 'TabLineSel',
  -- tab = 'TabLine',
  -- win = 'TabLine',
  -- tail = 'TabLine',
	head = tabline,
	current_tab = tablinese,
	tab=tabline,
	current_win = tablinese,
	win=tabline,
	tail=tabline,
}
require('tabby.tabline').set(function(line)
  return {
    {
      line.sep('', theme.head, theme.fill),
      { '  ', hl = theme.head },
      line.sep('', theme.head, theme.fill),
    },
    line.tabs().foreach(function(tab)
      local hl = tab.is_current() and theme.current_tab or theme.tab
      return {
        line.sep('', hl, theme.fill),
        tab.is_current() and '' or '󰆣',
        tab.number(),
        tab.name(),
        tab.close_btn(''),
        line.sep('', hl, theme.fill),
        hl = hl,
        margin = ' ',
      }
    end),
    line.spacer(),
    line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
			local hl = win.is_current() and theme.current_win or theme.win
      return {
        line.sep('', hl, theme.fill),
        win.is_current() and '' or '',
        win.buf_name(),
				win.file_icon(),
				win.buf().is_changed() and '*' or '',
        line.sep('', hl, theme.fill),
        hl = hl,
        margin = ' ',
      }
    end),
    {
      line.sep('', theme.tail, theme.fill),
			{ '  ', hl = theme.tail },
      line.sep('', theme.tail, theme.fill),
    },
    hl = theme.fill,
  }
end)

--wilder.nvim config
local wilder = require('wilder')
wilder.setup({
		modes = {
			':',
			'/',
			'?',
		}
	}
)
wilder.set_option('renderer', wilder.popupmenu_renderer(
		wilder.popupmenu_border_theme({
			highlights = { border = 'Normal' },
			border = 'single',
			highlighter = wilder.basic_highlighter(),
			pumblend = 20,
			left = {' ', wilder.popupmenu_devicons()},
			right = {' ', wilder.popupmenu_scrollbar()},
		})
))


--tamton-aquib/essentials.nvim

--toggle comment
local comment_map = {
    javascript = '//', 
		typescript = '//', 
		javascriptreact = '//',
    c = '//', 
		java = '//', 
		rust = '//',
		cpp = '//', 
		lua = '--',
    python = '#', 
		sh = '#', 
		conf = '#', 
		dosini = '#', 
		yaml = '#',
}

--> A Simple comment toggling function.
--> tried commentstring but something was off.
---@param visual boolean
local function toggle_comment(visual)
    -- local startrow, endrow = vim.fn.getpos("'<")[2], vim.fn.getpos("'>")[2]
    local startrow, endrow = vim.fn.getpos("v")[2], vim.fn.getpos(".")[2]
		if endrow < startrow then
				startrow, endrow = endrow, startrow
		end

    local leader = comment_map[vim.bo.ft] or "//"
    local current_line = vim.api.nvim_get_current_line()
    local cursor_position = vim.api.nvim_win_get_cursor(0)
    local noice = visual and startrow..','..endrow or ""

    vim.cmd(current_line:find("^%s*"..vim.pesc(leader))
        and noice..'norm ^'..('x'):rep(#leader+1)
        or noice..'norm I'..leader..' ')

    vim.api.nvim_win_set_cursor(0, cursor_position)
    if visual then vim.cmd [[norm gv]] end
end
vim.keymap.set('n', '<C-_>', toggle_comment)
vim.keymap.set('v', '<C-_>', function() toggle_comment(true) end)

-- default number state
vim.cmd [[ set number ]]
vim.cmd [[ set norelativenumber ]]

--function to toggle numbers
local function toggle_relative_numbers()
	if vim.o.relativenumber and vim.o.number then
		vim.cmd [[ set nonumber ]]
		vim.cmd [[ set norelativenumber ]]
	elseif not vim.o.relativenumber and vim.o.number then
		vim.cmd [[ set relativenumber ]]
	else
		vim.cmd [[ set number ]]
		vim.cmd [[ set norelativenumber ]]
	end
end
vim.keymap.set('n', "<C-M-N>", toggle_relative_numbers) --bind to ctrl-alt-n because fucking vim

