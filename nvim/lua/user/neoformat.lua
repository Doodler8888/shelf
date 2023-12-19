-- Set GHC options for ormolu
vim.g.ormolu_ghc_opt = {"TypeApplications", "RankNTypes"}

-- Enable ormolu for Haskell
vim.g.neoformat_enabled_haskell = {'ormolu'}

-- Define the ormolu formatter
vim.g.neoformat_haskell_ormolu = {
    exe = 'ormolu',
    args = {},
    stdin = 1
}
