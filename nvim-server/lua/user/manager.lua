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
	-- 'nvim-lua/popup.nvim',
	'nvim-lua/plenary.nvim',
	{
	  'nvim-telescope/telescope.nvim', tag = '0.1.5',
	  -- or                              , branch = '0.1.x',
	  dependencies = { 'nvim-lua/plenary.nvim' }
	},
	'rose-pine/neovim',
	'anuvyklack/hydra.nvim',
	-- 'sbdchd/neoformat',
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-path',
	'hrsh7th/nvim-cmp',
	{
	 'numToStr/Comment.nvim',
	 opts = {
	  -- add any options here
	 },
	 lazy = false,
	},
	{
	 'neovim/nvim-lspconfig',
	  -- opts = {
	  --   servers = {
	  --     nushell = {},
	  --     -- other config
	  --   },
	  -- },
	},
	 'hashivim/vim-terraform',
	 'alaviss/nim.nvim',
	 'LnL7/vim-nix',
	 'dense-analysis/ale',
	 'pocco81/auto-save.nvim',
	-- {
	--   'Exafunction/codeium.vim',
	--   config = function ()
	--     vim.keymap.set('i', '<C-a>', function () return vim.fn['codeium#Accept']() end, { expr = true })
	--   end
	-- },
	-- 'pearofducks/ansible-vim',
	'lambdalisue/suda.vim',
	'nanotee/zoxide.vim',
}

require("lazy").setup(plugins, opts)
