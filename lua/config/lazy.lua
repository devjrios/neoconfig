local py_interpreter_exists = (vim.fn.executable("python3") == 1)
local py_interpreter
if not py_interpreter_exists then
  py_interpreter = vim.api.nvim_cmd({
    cmd = "python",
    args = { "print(sys.executable)" },
    mods = { silent = true, emsg_silent = true, noswapfile = true, confirm = true, hide = true, noautocmd = true },
  }, { output = true })
else
  py_interpreter = vim.fn.system({ "/usr/bin/env", "python3", "-c", "import sys;print(sys.executable)" })
end

py_interpreter = string.gsub(py_interpreter, ".[0-9]+$", "")
vim.g.python3_host_prog = py_interpreter
vim.env.PATH = vim.env.PATH .. ":" .. string.gsub(py_interpreter, "/python3$", "")

local node_interpreter_exists = (vim.fn.executable("node") == 1)
if node_interpreter_exists then
  local node_interpreter = vim.fn.system({ "/usr/bin/env", "node", "-e", "console.log(process.execPath);" })
  vim.g.node_host_prog = node_interpreter
end

vim.env.DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = 1

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim",                                import = "lazyvim.plugins" },
    -- import any extras modules here
    -- { import = "lazyvim.plugins.extras.lsp.none-ls" },
    { import = "lazyvim.plugins.extras.dap.core" },
    { import = "lazyvim.plugins.extras.dap.nlua" },
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.lang.java" },
    { import = "lazyvim.plugins.extras.lang.yaml" },
    { import = "lazyvim.plugins.extras.lang.tex" },
    { import = "lazyvim.plugins.extras.lang.tailwind" },
    { import = "lazyvim.plugins.extras.lang.python" },
    { import = "lazyvim.plugins.extras.lang.markdown" },
    -- { import = "lazyvim.plugins.extras.lang.go" },
    { import = "lazyvim.plugins.extras.lang.docker" },
    { import = "lazyvim.plugins.extras.ui.mini-animate" },
    { import = "lazyvim.plugins.extras.util.project" },
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = false }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
