local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	"nvim-lua/plenary.nvim",
	"nvim-tree/nvim-web-devicons",
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		-- or                              , branch = '0.1.x',
		-- dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},
	"rose-pine/neovim",
	"anuvyklack/hydra.nvim",
	"folke/flash.nvim",
	-- "backdround/improved-ft.nvim",
	"ibhagwan/fzf-lua",
	"stevearc/oil.nvim",
	"stevearc/conform.nvim",
	'saecki/crates.nvim',
	'akinsho/toggleterm.nvim',
	'Raku/vim-raku',
	-- 'stevearc/resession.nvim',
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {}, -- this is equalent to setup({}) function
	},
	{
		"benlubas/wrapping-paper.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"numToStr/Comment.nvim",
		opts = {
			-- add any options here
		},
		lazy = false,
	},
	{
		"neovim/nvim-lspconfig",
	},
	{
	  "nvim-treesitter/nvim-treesitter",
	  config = function()
	    -- setup treesitter with config
	  end,
	  dependencies = {
	    -- note: additional parser
	    { "nushell/tree-sitter-nu" },
	  },
	  build = ":tsupdate",
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		-- after = "nvim-treesitter",
		-- requires = "nvim-treesitter/nvim-treesitter",
	},
	"hashivim/vim-terraform",
	"dense-analysis/ale",
	'pocco81/auto-save.nvim',
	-- {
	--   'Exafunction/codeium.vim',
	--   config = function ()
	--     vim.keymap.set('i', '<C-a>', function () return vim.fn['codeium#Accept']() end, { expr = true })
	--   end
	-- },
	"nanotee/zoxide.vim",
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-path",
	-- 'neovim/nvim-lspconfig',
	-- 'hrsh7th/cmp-nvim-lsp',
}

require("lazy").setup(plugins, opts)
