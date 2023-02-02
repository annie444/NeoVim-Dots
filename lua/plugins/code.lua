return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    -- stylua: ignore
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true, silent = true, mode = "i",
      },
      { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
  },
  {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  {
    "petertriho/cmp-git",
    config = function()
      local format = require("cmp_git.format")
      local sort = require("cmp_git.sort")
      local cmpgit = require("cmp_git")
      cmpgit.setup({
        -- defaults
        filetypes = { "gitcommit", "octo" },
        remotes = { "upstream", "origin" }, -- in order of most to least prioritized
        enableRemoteUrlRewrites = false, -- enable git url rewrites, see https://git-scm.com/docs/git-config#Documentation/git-config.txt-urlltbasegtinsteadOf
        git = {
          commits = {
            limit = 100,
            sort_by = sort.git.commits,
            format = format.git.commits,
          },
        },
        github = {
          issues = {
            fields = { "title", "number", "body", "updatedAt", "state" },
            filter = "all", -- assigned, created, mentioned, subscribed, all, repos
            limit = 100,
            state = "open", -- open, closed, all
            sort_by = sort.github.issues,
            format = format.github.issues,
          },
          mentions = {
            limit = 100,
            sort_by = sort.github.mentions,
            format = format.github.mentions,
          },
          pull_requests = {
            fields = { "title", "number", "body", "updatedAt", "state" },
            limit = 100,
            state = "open", -- open, closed, merged, all
            sort_by = sort.github.pull_requests,
            format = format.github.pull_requests,
          },
        },
        gitlab = {
          issues = {
            limit = 100,
            state = "opened", -- opened, closed, all
            sort_by = sort.gitlab.issues,
            format = format.gitlab.issues,
          },
          mentions = {
            limit = 100,
            sort_by = sort.gitlab.mentions,
            format = format.gitlab.mentions,
          },
          merge_requests = {
            limit = 100,
            state = "opened", -- opened, closed, locked, merged
            sort_by = sort.gitlab.merge_requests,
            format = format.gitlab.merge_requests,
          },
        },
        trigger_actions = {
          {
            debug_name = "git_commits",
            trigger_character = ":",
            action = function(sources, trigger_char, callback, params, git_info)
              return sources.git:get_commits(callback, params, trigger_char)
            end,
          },
          {
            debug_name = "gitlab_issues",
            trigger_character = "#",
            action = function(sources, trigger_char, callback, params, git_info)
              return sources.gitlab:get_issues(callback, git_info, trigger_char)
            end,
          },
          {
            debug_name = "gitlab_mentions",
            trigger_character = "@",
            action = function(sources, trigger_char, callback, params, git_info)
              return sources.gitlab:get_mentions(callback, git_info, trigger_char)
            end,
          },
          {
            debug_name = "gitlab_mrs",
            trigger_character = "!",
            action = function(sources, trigger_char, callback, params, git_info)
              return sources.gitlab:get_merge_requests(callback, git_info, trigger_char)
            end,
          },
          {
            debug_name = "github_issues_and_pr",
            trigger_character = "#",
            action = function(sources, trigger_char, callback, params, git_info)
              return sources.github:get_issues_and_prs(callback, git_info, trigger_char)
            end,
          },
          {
            debug_name = "github_mentions",
            trigger_character = "@",
            action = function(sources, trigger_char, callback, params, git_info)
              return sources.github:get_mentions(callback, git_info, trigger_char)
            end,
          },
        },
      })
    end,
  },
  -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  {
    "L3MON4D3/LuaSnip",
    version = "1.2.*",
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
  },
  {
    "tzachar/cmp-fuzzy-buffer",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "tzachar/fuzzy.nvim",
    },
  },
  {
    "tzachar/cmp-fuzzy-path",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "tzachar/fuzzy.nvim",
    },
  },
  {
    "saadparwaiz1/cmp_luasnip",
  },
  {
    "hrsh7th/cmp-emoji",
  },
  {
    "hrsh7th/cmp-cmdline",
  },
  {
    "hrsh7th/cmp-buffer",
  },
  {
    "hrsh7th/cmp-path",
  },
  {
    "hrsh7th/cmp-nvim-lsp",
  },
  {
    "doxnit/cmp-luasnip-choice",
  },
  {
    "hrsh7th/cmp-calc",
  },
  {
    "uga-rosa/cmp-dictionary",
  },
  {
    "f3fora/cmp-spell",
  },
  {
    "hrsh7th/cmp-nvim-lsp-document-symbol",
  },
  {
    "hrsh7th/cmp-nvim-lsp-signature-help",
  },
  {
    "dmitmel/cmp-cmdline-history",
  },
  {
    "tzachar/cmp-fuzzy-buffer",
  },
  {
    "tzachar/cmp-fuzzy-path",
  },
  {
    "lukas-reineke/cmp-rg",
  },
  {
    "andersevenrud/cmp-tmux",
  },
  {
    "saecki/crates.nvim",
    tag = "v0.3.0",
    setup = true,
  },
  {
    "David-Kunz/cmp-npm",
    setup = true,
    opts = {},
  },
  {
    "nat-418/cmp-color-names.nvim",
    setup = true,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    init = function()
      require("copilot").setup({
        suggestion = {
          enabled = false,
        },
        panel = {
          enabled = false,
          auto_refresh = true,
        },
        filetypes = {
          ["*"] = true,
        },
        copilot_node_command = "node",
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = {
      "copilot.lua",
    },
    setup = function()
      require("copilot_cmp").setup({
        method = "getCompletionsCycling",
        formatters = {
          label = require("copilot.format").format_label_text,
          insert_text = require("copilot.format").format_insert_text,
          preview = require("copilot.format").deindent,
        },
      })
    end,
    lazy = false,
  },
  {
    "max397574/cmp-greek",
  },
  {
    "chrisgrieser/cmp-nerdfont",
  },
  {
    "hrsh7th/cmp-nvim-lua",
  },
  {
    "ray-x/cmp-treesitter",
  },
  {
    "amarakon/nvim-cmp-fonts",
  },
  {
    "onsails/lspkind.nvim",
  },
  -- then: setup supertab in cmp

  {
    "doxnit/cmp-luasnip-choice",
    setup = true,
    opts = {
      auto_open = true, -- Automatically open nvim-cmp on choice node (default: true)
    },
  },
  {
    "saadparwaiz1/cmp_luasnip",
  },
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "petertriho/cmp-git",
      "hrsh7th/cmp-nvim-lsp",
      "neovim/nvim-lspconfig",
      "doxnit/cmp-luasnip-choice",
      "hrsh7th/cmp-calc",
      "uga-rosa/cmp-dictionary",
      "f3fora/cmp-spell",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "dmitmel/cmp-cmdline-history",
      "tzachar/cmp-fuzzy-buffer",
      "tzachar/cmp-fuzzy-path",
      "lukas-reineke/cmp-rg",
      "andersevenrud/cmp-tmux",
      "saecki/crates.nvim",
      "nat-418/cmp-color-names.nvim",
      "chrisgrieser/cmp-nerdfont",
      "zbirenbaum/copilot-cmp",
      "max397574/cmp-greek",
      "hrsh7th/cmp-nvim-lua",
      "ray-x/cmp-treesitter",
      "amarakon/nvim-cmp-fonts",
      "onsails/lspkind.nvim",
    },
    setup = true,
    opts = function()
      vim.opt.completeopt = { "menu", "menuone", "noselect" }

      require("luasnip.loaders.from_vscode").lazy_load()

      local cmp = require("cmp")
      local dict = require("cmp_dictionary")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")
      local select_opts = { behavior = cmp.SelectBehavior.Select }

      lspkind.init({
        mode = "symbol_text",
        preset = "codicons",
        symbol_map = {
          Copilot = "",
        },
      })

      local sign = function(opts)
        vim.fn.sign_define(opts.name, {
          texthl = opts.name,
          text = opts.text,
          numhl = "",
        })
      end

      sign({ name = "DiagnosticSignError", text = "✘" })
      sign({ name = "DiagnosticSignWarn", text = "▲" })
      sign({ name = "DiagnosticSignHint", text = "⚑" })
      sign({ name = "DiagnosticSignInfo", text = "" })

      local has_words_before = function()
        if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
          return false
        end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
      end

      vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

      cmp.setup({
        enabled = function()
          -- disable completion in comments
          local context = require("cmp.config.context")
          -- keep command mode completion enabled when cursor is in a comment
          if vim.api.nvim_get_mode().mode == "c" then
            return true
          else
            return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
          end
        end,
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<Up>"] = cmp.mapping.select_prev_item(select_opts),
          ["<Down>"] = cmp.mapping.select_next_item(select_opts),

          ["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
          ["<C-n>"] = cmp.mapping.select_next_item(select_opts),

          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),

          ["<C-e>"] = cmp.mapping.abort(),

          ["<C-d>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<C-b>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() and has_words_before() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            elseif cmp.visible() then
              cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- they way you will only jump inside the snippet region
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<CR>"] = cmp.mapping.confirm({
            -- this is the important line
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
          }),

          ["<C-Space>"] = cmp.mapping.complete(),
        },
        sorting = {
          priority_weight = 2,
          comparators = {
            require("copilot_cmp.comparators").prioritize,
            require("copilot_cmp.comparators").score,
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.sort_text,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.kind,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        sources = cmp.config.sources({
          { name = "copilot" },
          { name = "luasnip" },
          { name = "nvim_lua" },
          { name = "luasnip_choice" },
          { name = "path" },
          {
            name = "emoji",
            insert = true,
          },
          { name = "greek" },
          { name = "nerdfont" },
          { name = "cmdline" },
          { name = "cmp-git" },
          { name = "calc" },
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
          { name = "fuzzy_buffer" },
          { name = "fuzzy_path" },
          { name = "crates" },
          { name = "color_names" },
          { name = "treesitter" },
          {
            name = "fonts",
            option = {
              space_filter = "-",
            },
          },
          {
            name = "rg",
            keyword_length = 3,
          },
          {
            name = "npm",
            keyword_length = 4,
          },
          {
            name = "dictionary",
            keyword_length = 2,
          },
          {
            name = "spell",
            option = {
              keep_all_entries = false,
              enable_in_context = function()
                return require("cmp.config.context").in_treesitter_capture("spell")
              end,
            },
          },
          {
            name = "buffer",
            option = {
              get_bufnrs = function()
                local bufs = vim.api.nvim_list_bufs()
                local rets = {}
                for buf in bufs do
                  local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
                  if not byte_size > 1024 * 1024 then -- 1 Megabyte max
                    table.insert(rets, buf)
                  end
                end
                return rets
              end,
            },
          },
          {
            name = "tmux",
            option = {
              all_panes = false,
              label = "[tmux]",
              trigger_characters = { "." },
              trigger_characters_ft = {},
              keyword_pattern = [[\w\+]],
            },
          },
          experimental = {
            ghost_text = {
              hl_group = "LspCodeLens",
            },
          },
        }),
        formatting = {
          format = function(entry, item)
            local icons = require("lazyvim.config").icons.kinds
            if icons[item.kind] then
              item.kind = " " .. (icons[item.kind] or "❔") .. " "
            end
            item.menu = "(" .. entry.source.name .. ")"
            return item
          end,
        },
      })
      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "cmp-git" }, -- You can specify the `cmp_git` source if you were installed it.
        }, {
          { name = "buffer" },
        }),
      })
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "nvim_lsp_document_symbol" },
          { name = "buffer" },
        }, {
          { name = "buffer" },
        }),
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
          { name = "cmdline_history" },
          {
            name = "fuzzy_path",
            option = {
              fd_timeout_msec = 1500,
            },
          },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      })
      cmp.setup.cmdline({ ":", "/", "?", "@" }, {
        sources = {
          { name = "cmdline_history" },
        },
      })
      cmp.setup.filetype({ "conf", "config" }, {
        sources = {
          { name = "fonts" },
        },
      })
      dict.setup({
        dic = {
          ["*"] = { "/Users/annieehler/english.dict" },
          spelllang = {
            en = "/Users/annieehler/english.dict",
          },
        },
      })
    end,
  },
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    config = function(_, opts)
      require("mini.pairs").setup(opts)
    end,
  },
  {
    "echasnovski/mini.surround",
    keys = function(plugin, keys)
      -- Populate the keys based on the user's options
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      local mappings = {
        { opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
        { opts.mappings.delete, desc = "Delete surrounding" },
        { opts.mappings.find, desc = "Find right surrounding" },
        { opts.mappings.find_left, desc = "Find left surrounding" },
        { opts.mappings.highlight, desc = "Highlight surrounding" },
        { opts.mappings.replace, desc = "Replace surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = "gza", -- Add surrounding in Normal and Visual modes
        delete = "gzd", -- Delete surrounding
        find = "gzf", -- Find surrounding (to the right)
        find_left = "gzF", -- Find surrounding (to the left)
        highlight = "gzh", -- Highlight surrounding
        replace = "gzr", -- Replace surrounding
        update_n_lines = "gzn", -- Update `n_lines`
      },
    },
    config = function(_, opts)
      -- use gz mappings instead of s to prevent conflict with leap
      require("mini.surround").setup(opts)
    end,
  },
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      hooks = {
        pre = function()
          require("ts_context_commentstring.internal").update_commentstring({})
        end,
      },
    },
    config = function(_, opts)
      require("mini.comment").setup(opts)
    end,
  },
  {
    "echasnovski/mini.ai",
    keys = {
      { "a", mode = { "x", "o" } },
      { "i", mode = { "x", "o" } },
    },
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        init = function()
          -- no need to load the plugin, since we only need its queries
          require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
        end,
      },
    },
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
        },
      }
    end,
    config = function(_, opts)
      local ai = require("mini.ai")
      ai.setup(opts)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    build = function()
      vim.cmd("TSUpdate")
    end,
    init = function()
      -- no need to load the plugin, since we only need its queries
      require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
    end,
  },
}
