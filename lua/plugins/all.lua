return {
  -- add catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "latte", -- latte, frappe, macchiato, mocha
      transparent_background = false,
      show_end_of_buffer = false, -- show the '~' characters after the end of buffers
      term_colors = false,
      dim_inactive = {
        enabled = false,
      },
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        notify = false,
        mini = false,
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
      },
    },
  },
  -- set LazyVim to catppuccin
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    "Shougo/deoplete.nvim",
    build = ":UpdateRemotePlugins",
    lazy = false,
  },
  {
    "deoplete-plugins/deoplete-jedi",
    lazy = false,
    init = function()
      require("lspconfig").jedi_language_server.setup({})
    end,
  },
  -- setup jupytext
  {
    "goerz/jupytext.vim",
    lazy = false,
  },
  {
    "kana/vim-textobj-user",
    lazy = false,
  },
  {
    "kana/vim-textobj-line",
    lazy = false,
  },
  -- add hydrogen mapping
  {
    "GCBallesteros/vim-textobj-hydrogen",
    dependencies = {
      "kana/vim-textobj-user",
      "kana/vim-textobj-line",
    },
    lazy = false,
  },
  -- confiure MagmaNvim
  {
    "dccsillag/magma-nvim",
    build = ":UpdateRemotePlugins",
    lazy = false,
    setup = function()
      vim.g.magma_automatically_open_output = true
      vim.g.magma_image_provider = "kitty"
    end,
  },
  {
    "tpope/vim-fugitive",
    lazy = false,
  },
  -- configure IronREPL
  {
    "hkupty/iron.nvim",
    tag = "v3.0",
    lazy = false,
    setup = function()
      local iron = require("iron.core")
      iron.setup({
        config = {
          should_map_plug = false,
          scratch_repl = true,
          repl_definition = {
            python = {
              command = { "ipython" },
              format = require("iron.fts.common").bracketed_paste,
            },
          },
        },
        keymaps = {
          send_motion = "ctr",
          visual_send = "ctr",
        },
      })
    end,
  },
  -- change trouble config
  {
    "folke/trouble.nvim",
    -- opts will be merged with the parent spec
    opts = {
      use_diagnostic_signs = true,
    },
  },
  -- add symbols-outline
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = {
      { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" },
    },
    config = true,
  },
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
    -- Uncomment next line if you want to follow only stable versions
    version = "*",
  },
  -- change some telescope options and a keymap to browse plugin files
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = {
          prompt_position = "top",
        },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },
  -- add telescope-fzf-native
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },
  {
    "lifer0se/ezbookmarks.nvim",
    setup = true,
    opts = {
      cwd_on_open = 1, -- change directory when opening a bookmark
      use_bookmark_dir = 1, -- if a bookmark is part of a bookmarked directory, cd to that direcrtory (works independently of cwd_on_open)
      open_new_tab = 1, -- open bookmark in a new tab.
    },
    keys = {
      -- stylua: ignore
      {
        "<leader>bo",
        function() require("ezbookmarks").OpenBookmark() end,
        desc = "Open Bookmarks",
      },
      {
        "<leader>ba",
        function()
          require("ezbookmarks").AddBookmark()
        end,
        desc = "Add Bookmark to File",
      },
      {
        "<leader>bd",
        function()
          require("ezbookmarks").RemoveBookmark()
        end,
        desc = "Delete Bookmark",
      },
      {
        "<leader>bf",
        function()
          require("ezbookmarks").AddBookmarkDirectory()
        end,
        desc = "Add Bookmark to Folder",
      },
    },
  },
  -- add pyright to lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
      },
    },
  },
  -- add tsserver and setup with typescript.nvim instead of lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        end)
      end,
    },
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- tsserver will be automatically installed with mason and loaded with lspconfig
        tsserver = {},
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },
  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
  {
    import = "lazyvim.plugins.extras.lang.typescript",
  },
  {
    "neovim/nvim-lspconfig",
    setup = function()
      local lspconfig = require("lspconfig")
      local lsp_defaults = lspconfig.util.default_config

      lsp_defaults.capabilities =
        vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())
    end,
  },
  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "bash",
        "help",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },
  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        -- add tsx and treesitter
        ensure_installed = {
          "tsx",
          "typescript",
        },
      })
    end,
  },
  -- the opts function can also be used to change the default opts:
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, "😄")
    end,
  },
  -- use mini.starter instead of alpha
  {
    import = "lazyvim.plugins.extras.ui.mini-starter",
  },
  -- add jsonls and schemastore ans setup treesitter for json, json5 and jsonc
  {
    import = "lazyvim.plugins.extras.lang.json",
  },
  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      },
    },
  },
  {
    "MattesGroeger/vim-bookmarks",
  },
  {
    "folke/noice.nvim",
    dependencies = {
      "nvim-cmp",
    },
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    },
    -- stylua: ignore
    keys = {
      { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
      { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
      { "<c-f>",function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward" },
      { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward"},
    },
  },
}
