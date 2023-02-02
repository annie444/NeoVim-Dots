-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end
-- navigate jupyter notebooks better
map("n", "]x", "ctrih/^# %%<CR><CR>", {})

map("n", "<leader>r", ":MagmaInit<cr>", { expr = true, silent = true, noremap = true, desc = "IPython Tools" })
map("n", "<leader>rr", ":MagmaInit<cr>", { expr = true, noremap = true, silent = true, desc = "Start Kernel" })
map(
  "n",
  "<leader>ra",
  ":MagmaEvaluateOperator<CR>",
  { silent = true, expr = true, noremap = true, desc = "Evaluate current operator" }
)
map("n", "<leader>rl", ":MagmaEvaluateLine<CR>", { noremap = true, silent = true, desc = "Evaluate line" })
map(
  "x",
  "<leader>rv",
  ":<C-u>MagmaEvaluateVisual<CR>",
  { noremap = true, silent = true, desc = "Evaluate visual selection" }
)
map("n", "<leader>rc", ":MagmaReevaluateCell<CR>", { noremap = true, silent = true, desc = "Reevaluate cell" })
map("n", "<leader>rd", ":MagmaDeinit<cr>", { expr = true, silent = true, noremap = true, desc = "Terminate kernel" })
map("n", "<leader>ro", ":MagmaShowOutput<CR>", { silent = true, desc = "Toggle showing the output" })
map("n", "<leader>rn", ":MagmaRestart!<CR>", { silent = true, desc = "Restart kernel" })
map("n", "<leader>rp", ":noautocmd MagmaEnterOutput<CR>", { silent = true, desc = "Enter the output buffer" })
map("n", "<leader>rs", ":MagmaDelete<CR>", { silent = true, desc = "Delete output/cell" })
-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

map("n", "gw", "*N")
map("x", "gw", "*N")

-- better up/down
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
map("n", "<A-j>", ":m .+1<cr>==", { desc = "Move down" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("n", "<A-k>", ":m .-2<cr>==", { desc = "Move up" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- buffers
if Util.has("nvim-bufferline.lua") then
  map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
  map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
  map("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
  map("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
else
  map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
  map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
  map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
  map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
end
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

map("n", "gw", "*N")
map("x", "gw", "*N")

map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- lazy
map("n", "<leader>l", "<cmd>:Lazy<cr>", { desc = "Lazy" })

-- Telescope mappings
local builtin = require("telescope.builtin")

-- Files
map("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
map("n", "<leader>fl", builtin.live_grep, { desc = "Grep Find" })
map("n", "<leader>fs", builtin.grep_string, { desc = "Grep string under cursor" })
map("x", "<leader>fs", builtin.grep_string, { desc = "Grep string under cursor" })
map("n", "<leader>fg", builtin.git_files, { desc = "Search git files" })

-- Search
map("n", "<leader>sc", builtin.commands, { desc = "Search commands" })
map("n", "<leader>sh", builtin.command_history, { desc = "Search command history" })
map("n", "<leader>sf", builtin.search_history, { desc = "Search history" })
map("n", "<leader>st", builtin.help_tags, { desc = "Show Help Tags" })
map("n", "<leader>sp", builtin.man_pages, { desc = "Search Man Pages" })
map("n", "<leader>sk", builtin.keymaps, { desc = "Search keymaps" })
map("n", "<leader>sa", builtin.registers, { desc = "Search clipboard" })
map("n", "<leader>si", builtin.current_buffer_fuzzy_find, { desc = "Search current buffer" })

-- Code {a,d,f,l,m,o,R,r,s}
map("n", "<leader>cS", builtin.marks, { desc = "Show mark values" })
map("n", "<leader>cq", builtin.quickfix, { desc = "Show quickfix" })
map("n", "<leader>ch", builtin.quickfixhistory, { desc = "Search Quickfix History " })

-- Search LSP
map("n", "<leader>sL", builtin.lsp_references, { desc = "Search LSP" })
map("n", "<leader>sLr", builtin.lsp_references, { desc = "LSP References" })
map("n", "<leader>sLc", builtin.lsp_incoming_calls, { desc = "LSP Calls" })
map("n", "<leader>sLo", builtin.lsp_outgoing_calls, { desc = "LSP Outgoing" })
map("n", "<leader>sLs", builtin.lsp_document_symbols, { desc = "LSP Document Symbols" })
map("n", "<leader>sLw", builtin.lsp_dynamic_workspace_symbols, { desc = "LSP Workplace Symbols" })
map("n", "<leader>sLd", builtin.diagnostics, { desc = "LSP Diagnostics" })
map("n", "<leader>sLe", builtin.lsp_definitions, { desc = "LSP Definition" })
map("n", "<leader>sLi", builtin.lsp_implementations, { desc = "LSP Implementations" })
map("n", "<leader>sLt", builtin.lsp_type_definitions, { desc = "LSP Types" })

-- Git {g,G,h}
map("n", "<leader>gc", builtin.git_commits, { desc = "Search Git Commits" })
map("n", "<leader>gl", builtin.git_bcommits, { desc = "Search Buffer Commits" })
map("n", "<leader>gb", builtin.git_branches, { desc = "Search Branches" })
map("n", "<leader>ga", builtin.git_status, { desc = "Show Git Status" })
map("n", "<leader>gs", builtin.git_stash, { desc = "List Git Stash" })

map("n", "<leader>T", builtin.treesitter, { desc = "Show Treesitter" })

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Open Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Open Quickfix List" })

-- toggle options
map("n", "<leader>uf", require("lazyvim.plugins.lsp.format").toggle, { desc = "Toggle format on Save" })
map("n", "<leader>us", function()
  Util.toggle("spell")
end, { desc = "Toggle Spelling" })
map("n", "<leader>uw", function()
  Util.toggle("wrap")
end, { desc = "Toggle Word Wrap" })
map("n", "<leader>ul", function()
  Util.toggle("relativenumber", true)
  Util.toggle("number")
end, { desc = "Toggle Line Numbers" })
map("n", "<leader>ud", Util.toggle_diagnostics, { desc = "Toggle Diagnostics" })
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", "<leader>uc", function()
  Util.toggle("conceallevel", false, { 0, conceallevel })
end, { desc = "Toggle Conceal" })

-- lazygit
map("n", "<leader>gg", function()
  Util.float_term({ "lazygit" }, { cwd = Util.get_root() })
end, { desc = "Lazygit (root dir)" })
map("n", "<leader>gG", function()
  Util.float_term({ "lazygit" })
end, { desc = "Lazygit (cwd)" })

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- highlights under cursor
if vim.fn.has("nvim-0.9.0") == 1 then
  map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
end

-- floating terminal
map("n", "<leader>ft", function()
  Util.float_term(nil, { cwd = Util.get_root() })
end, { desc = "Terminal (root dir)" })
map("n", "<leader>fT", function()
  Util.float_term()
end, { desc = "Terminal (cwd)" })

-- windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other window" })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window" })
map("n", "<leader>w-", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>w|", "<C-W>v", { desc = "Split window right" })
map("n", "<leader>-", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>|", "<C-W>v", { desc = "Split window right" })

-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
