-- Minimal init.lua for tests
-- This configuration is used by test scripts to set up a minimal Neovim environment

-- Set runtimepath to include the test directory and plugin directory
vim.cmd [[set runtimepath=$VIMRUNTIME]]
vim.cmd [[set packpath=/tmp/nvim/site]]

-- Add parent directory to runtimepath
local plugin_root = vim.fn.expand('%:p:h:h')
vim.opt.runtimepath:append(plugin_root)

-- Add Plenary to runtime path (for tests)
local plenary_root = vim.fn.expand('~/.local/share/nvim/site/pack/vendor/start/plenary.nvim')
vim.opt.runtimepath:append(plenary_root)

-- Print some debug information
print("Runtime path: " .. vim.o.runtimepath)
print("Checking for plenary.nvim...")
local plenary_available, _ = pcall(require, 'plenary')
print("Plenary available: " .. tostring(plenary_available))

-- Optional: Set up some basic vim options
vim.o.termguicolors = true
vim.o.swapfile = false
vim.o.hidden = true

-- Load the plugin
local status_ok, claude_code = pcall(require, 'claude-code')
if status_ok then
  -- Set up the plugin with minimal config for testing
  claude_code.setup({
    window = {
      height_ratio = 0.3,
    },
    -- Disable keymaps for testing
    keymaps = {
      toggle = {
        normal = false,
        terminal = false,
      },
      window_navigation = false,
      scrolling = false,
    },
  })
end

return {
  plugin_root = plugin_root,
}