-- vim: nu fdm=marker

-- init.lua based on lazy and not packer.
--
-- Some notes {{{

-- Run without sources config/plugins/etc.
-- $ nvim --clean

-- }}}

require('core/options')  -- Options
require('core/autocmds') -- Autocommands

-- lazy.nvim {{{
-- https://github.com/folke/lazy.nvim
-- The Lazy Package Manager.
-- :Lazy check [plugins] - Check for updates and show the log (git fetch).
-- :Lazy clean - Clean plugins that are no longer needed. :Lazy install [plugins] - Install missing plugins.
-- :Lazy update [plugins] - Update plugins.
-- :Lazy log - Show recent updates.
-- :Lazy profile - plugin bootup profiler
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

-- }}}

-- Plugin Installation/Configuration {{{
require("lazy").setup({

    -- Colorschemes, UI, Chrome, etc. {{{

    -- tokyonight colorscheme {{{
    -- https://github.com/folke/tokyonight.nvim
    {
      "folke/tokyonight.nvim",
      lazy = false, -- make sure we load this during startup if it is your main colorscheme
      priority = 1000, -- make sure to load this before all the other start plugins
      config = function()
        require("tokyonight").setup({
          style = "night",
          -- Lighten the comments so that I can see them better.
          on_colors = function(colors)
            colors.comment = "#7982ab"
          end
	})
          -- load the colorscheme here
          -- FIX: Change the comment font - "Brush Script MT"; the hi cmd isn't working
          vim.cmd([[
            colorscheme tokyonight-night
            hi Comment font='Zapfino'
            ]])
      end,
    },
    -- }}}

    -- lualine {{{
    -- Use lualine & tabline together to get a faster airline.
    -- https://github.com/nvim-lualine/lualine.nvim
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'kyazdani42/nvim-web-devicons' },
        config = function()
          require('lualine').setup {
            options = { theme  = 'tokyonight' },
          }
        end,
    },
    -- }}}

    -- tabline {{{
    -- https://github.com/kdheepak/tabline.nvim
    {
        'kdheepak/tabline.nvim',
        config = function()
            require'tabline'.setup {
                -- Defaults configuration options
                enable = true,
                options = {
                    -- If lualine is installed tabline will use separators configured in lualine by default.
                    -- These options can be used to override those settings.
                    max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
                    show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
                    show_devicons = true, -- this shows devicons in buffer section
                    show_bufnr = false, -- this appends [bufnr] to buffer section,
                    show_filename_only = false, -- shows base filename only instead of relative path in filename
                    modified_icon = "+ ", -- change the default modified icon
                    modified_italic = false, -- set to true by default; this determines whether the filename turns italic if modified
                }
            }
            vim.cmd[[
            set guioptions-=e " Use showtabline in gui vim
            set sessionoptions+=tabpages,globals " store tabpages and globals in session
            ]]
        end,
        dependencies = {
          'nvim-lualine/lualine.nvim',
          'kyazdani42/nvim-web-devicons',
        },
    },
    -- }}}

    -- }}}

    -- Treesitter & Telescope {{{

    -- Treesitter {{{
    -- Modern syntax highlighting
	{
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      config = function()
        -- https://github.com/p00f/nvim-ts-rainbow/issues/30#issuecomment-850991264
        local parsers = require("nvim-treesitter.parsers")
        local enabled_list = {"clojure",  "commonlisp", "fennel", "go", "lua", "markdown", "markdown_inline", "Python", "ruby", "rust"}

        require('nvim-treesitter.configs').setup {
          ensure_installed = { "Python", "html", "c", "cmake", "lua", "go", "clojure", "json", "commonlisp", "bash", "dockerfile", "markdown", "markdown_inline",  "ruby", "rust", "toml", "vim", "yaml" },
          highlight = {
            enable = true,
          },
          rainbow = {
            enable = true,
            extended_mode = true,
            max_file_lines = 25000,
            colors = {"#ab47bc", "#ec407a", "#42a5f5", "#ffab91", "#82e0aa", "#ff7043" },
            -- Enable for certain filetypes.
            disable = vim.tbl_filter(
              function(p)
                local disable = true
                for _, lang in pairs(enabled_list) do
                  if p==lang then disable = false end
                end
                return disable
              end,
              parsers.available_parsers()
              )
          }
        }
      end,
    },

    -- nvim-treesiter-context {{{
    -- Show function context at the top of the file.
    -- https://github.com/nvim-treesitter/nvim-treesitter-context
    {'nvim-treesitter/nvim-treesitter-context'},
    -- }}}

    -- nvim-treesitter-textobjects {{{
    -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    -- TODO: take a look at creating our own textobjects
    -- import lines beginning & ending in Python
    {'nvim-treesitter/nvim-treesitter-textobjects'},
    -- }}}

    -- }}}

    -- Telescope {{{

    -- Telescope
    -- https://github.com/nvim-telescope/telescope.nvim
    -- https://github.com/debugloop/telescope-undo.nvim
    {'nvim-lua/popup.nvim'},
    {
      'nvim-telescope/telescope.nvim',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'BurntSushi/ripgrep',
        "debugloop/telescope-undo.nvim"
    },
      config = function()

        require('telescope').setup {
          pickers = {
            live_grep = {
              only_sort_test = true
            }
          },
          extensions = {
            dash = {
              file_type_keywords = {
                Python = { 'python3' },
              },
            },
            file_browser = {
              theme = "ivy",
              hijack_netrw = true,
            },
            fzf = {
              fuzzy = true,                    -- false will only do exact matching
                override_generic_sorter = true,  -- override the generic sorter
                override_file_sorter = true,     -- override the file sorter
                case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
              },
              undo = {
                side_by_side = true,
                layout_strategy = "vertical",
                layout_config = {
                  preview_height = 0.8,
                },
              },
            }
          }
          require('telescope').load_extension('fzf')

          require('telescope').load_extension('file_browser')
          vim.keymap.set('n', '<leader>fb', function()
            telescope.extensions.file_browser.file_browser({
                path = "%:p:h",
                cwd = telescope_buffer_dir(),
                respect_gitignore = false,
                hidden = true,
                grouped = true,
                initial_mode = "normal",
            })
          end)

          -- NOTE: Thu Mar 09 2023 12:09:20 => This didn't work right, need to revisit.
          -- require('telescope').extensions.yank_history.yank_history()
          -- vim.keymap.set('n', '<leader>y', '<cmd>Telescope yank_history<cr>')

          -- require('telescope').load_extension('possession')
          -- vim.keymap.set('n', '<leader>fp', '<cmd>Telescope possession list<cr>')

          vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
          vim.keymap.set('n', '<leader>fg', '<cmd>Telescope git_files<cr>')
          vim.keymap.set("n", "<Leader>fr", ":Telescope oldfiles<CR>", { noremap = true, silent = true })
          vim.keymap.set('n', '<leader>h', '<cmd>Telescope help_tags<cr>')
          vim.keymap.set('n', '<leader>i', '<cmd>Telescope buffers<cr>')
          vim.keymap.set('n', '<leader>r', '<cmd>Telescope live_grep<cr>')
          vim.keymap.set('n', '<leader>s', '<cmd>Telescope current_buffer_fuzzy_find<cr>')

          require("telescope").load_extension("undo")
          vim.keymap.set('n', '<leader>u', '<cmd>Telescope undo<cr>')
      end,
    },

    -- TODO: telescope_live_grep_args

    -- telescope-fzf-native.nvim
    -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
    -- Make Telescope just a little bit faster.
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },

    -- telescope-file-browser
    -- https://github.com/nvim-telescope/telescope-file-browser.nvim
    {
      'nvim-telescope/telescope-file-browser.nvim',
      dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
      config = function()
        -- open file_browser with the path of the current buffer
        vim.api.nvim_set_keymap("n", "<space>fb",
          ":Telescope file_browser path=%:p:h select_buffer=true<cr>",
          { noremap = true })
      end,
    },

    -- }}}

    -- }}}

    -- General Utilities {{{

    -- vim-abolish {{{
    -- https://github.com/tpope/tpope-vim-abolish
    -- Abbreviate multiple variants of words
    --
    -- Abbreviate:
    -- :Abolish {despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or}  {despe,sepa}rat{}
    --
    -- Substitution:
    -- :%Subvert/facilit{y,ies}/building{,s}/g
    --
    -- Coercion:
    -- Press crs (coerce to snake_case).
    -- MixedCase (crm),
    -- camelCase (crc),
    -- snake_case (crs),
    -- UPPER_CASE (cru),
    -- dash-case (cr-),
    -- dot.case (cr.),
    -- space case (cr<space>),
    -- and Title Case (crt) are all just 3 keystrokes away.
    -- These commands support repeat.vim.
    {
      'tpope/tpope-vim-abolish',
      config = function()
        vim.cmd[[
          if has('macunix')
              let g:abolish_save_file="~/.config/nvim/abolish-abbreviations.vim"
          elseif has('unix')
              let g:abolish_save_file="/home/erickb/.config/nvim/abolish-abbreviations.vim"
          endif
        ]]
      end,
    },
    -- }}}

	-- Beacon
	-- Highlight where your cursor is when you move around.
	-- https://github.com/DanilaMihailov/beacon.nvim
    {'DanilaMihailov/beacon.nvim'},

    -- bufdelete {{{
    -- https://github.com/famiu/bufdelete.nvim
    -- Delete buffers without trashing my window layout.
    {
        'famiu/bufdelete.nvim',
        config = function()
            vim.keymap.set('n', "<leader>k", "<cmd>:lua require('bufdelete').bufdelete(0, true)<cr>")
        end,
    },
    -- }}}

    -- indent-blankline {{{
    -- https://github.com/lukas-reineke/indent-blankline.nvim
    {
      'lukas-reineke/indent-blankline.nvim',
      config = function()
        local highlight = {
            "RainbowRed",
            "RainbowYellow",
            "RainbowBlue",
            "RainbowOrange",
            "RainbowGreen",
            "RainbowViolet",
            "RainbowCyan",
        }

          local hooks = require "ibl.hooks"
          -- create the highlight groups in the highlight setup hook, so they are reset
          -- every time the colorscheme changes
          hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
            vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
            vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
            vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
            vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
            vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
            vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
          end)

          -- require("ibl").setup { indent = { highlight = highlight } }
          require("ibl").setup()

      end,
    },
    -- }}}

    -- hop.nvim {{{
    -- https://github.com/phaazon/hop.nvim
    -- The latest/greatest EasyMotion like plugin.
    {
      'phaazon/hop.nvim',
      config = function()
        local hop = require('hop')
        local directions = require('hop.hint').HintDirection
        hop.setup()

        -- Use hop for fFtT & still works like normal.
        vim.keymap.set('', 'f', function()
          hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
          end, {remap=true})
        vim.keymap.set('', 'F', function()
          hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
          end, {remap=true})
        vim.keymap.set('', 't', function()
          hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
          end, {remap=true})
        vim.keymap.set('', 'T', function()
          hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
          end, {remap=true})

      end,

      vim.keymap.set('n', 'gs', '<cmd>HopChar2<cr>'),
      vim.keymap.set('n', 'gw', '<cmd>HopWord<cr>'),
    },
    -- }}}

    -- marks.nvim {{{
    -- https://github.com/chentoast/marks.nvim
    -- View marks in the sign column + preview them.

    -- TODO: Make 'gm' mapping to show local marks via Telescope

    -- Mappings:
    -- ============================
    -- mx              Set mark x
    -- m,              Set the next available alphabetical (lowercase) mark
    -- m;              Toggle the next available mark at the current line
    -- dmx             Delete mark x
    -- dm-             Delete all marks on the current line
    -- dm<space>       Delete all marks in the current buffer
    -- m]              Move to next mark
    -- m[              Move to previous mark
    -- m:              Preview mark. This will prompt you for a specific mark to
    --                 preview; press <cr> to preview the next mark.
    --
    -- m[0-9]          Add a bookmark from bookmark group[0-9].
    -- dm[0-9]         Delete all bookmarks from bookmark group[0-9].
    -- m}              Move to the next bookmark having the same type as the bookmark under
    --                 the cursor. Works across buffers.
    -- m{              Move to the previous bookmark having the same type as the bookmark under
    --                 the cursor. Works across buffers.
    -- dm=             Delete the bookmark under the cursor.
    {
      'chentoast/marks.nvim',
      config = function() require('marks').setup() end,
    },
    -- }}}

    -- Neotree {{{
    -- https://github.com/nvim-neo-tree/neo-tree.nvim
    --
    -- Tracking ticket for document_symbols feature.
    -- https://github.com/nvim-neo-tree/neo-tree.nvim/issues/879
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
       "nvim-lua/plenary.nvim",
       "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
       "MunifTanjim/nui.nvim",
      },
      config = function()

         -- Unless you are still migrating, remove the deprecated commands from v1.x
         vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
         require("neo-tree").setup({
           close_if_last_window = true,
           sources = {
               "filesystem",
               "git_status",
               "document_symbols",
           },
         })
         vim.keymap.set('n', '<leader>tn', '<cmd>Neotree filesystem reveal toggle<cr>')
         vim.keymap.set('n', '<leader>tg', '<cmd>Neotree git_status toggle position=float<cr>')
      end,
    },
    -- }}}

    -- nvim-surround {{{
    -- https://github.com/kylechui/nvim-surround
    -- An improved(?) Lua version of vim-surround from tpope - if it doesn't
    -- work, i'll just go back
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    -- }}}

    -- numb.nvim {{{
    -- https://github.com/nacro90/numb.nvim
    -- Peeking the buffer while entering command :{number}
    {
      'nacro90/numb.nvim',
      config = function()
        require('numb').setup()
      end,
    },
    -- }}}

    -- TODO: pretty-fold.nvim vs nvim-ufo??

    -- pretty-fold.nvim {{{
    -- https://github.com/anuvyklack/pretty-fold.nvim
    {
      'anuvyklack/pretty-fold.nvim',
       config = function()
        require('pretty-fold').setup{
           keep_indentation = false,
           fill_char = '•',
           sections = {
              left = {
                 '+', function() return string.rep('-', vim.v.foldlevel) end,
                 ' ', 'number_of_folded_lines', ':', 'content',
              }
           }
        }
       end,
    },
    -- }}}

    -- nvim-ufo {{{
    -- https://github.com/kevinhwang91/nvim-ufo
    -- faster folding.
    {
      'kevinhwang91/nvim-ufo',
      dependencies = { 'kevinhwang91/promise-async' },
      config = function()
        vim.o.foldcolumn = '1' -- '0' is not bad
        vim.o.foldlevel = 250 -- Using ufo provider need a large value, feel free to decrease the value
        vim.o.foldlevelstart = 99
        -- vim.o.foldenable = true

        require('ufo').setup({
            provider_selector = function(bufnr, filetype, buftype)
              return {'treesitter', 'indent' }
            end
          })

        -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
        vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
        vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
      end,
    },
    -- }}}

    -- nvim-window {{{
    -- https://gitlab.com/yorickpeterse/nvim-window
    -- Switch between windows ace-window style.
    {
      'https://gitlab.com/yorickpeterse/nvim-window.git',
      config = function()
        require('nvim-window').setup({
          normal_hl = 'NvimWindowLetter',
          hint_hl = 'Bold',
          border = 'single',
          -- keep the chars on the home row.
          chars = {'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';'}
        })
        vim.keymap.set("n", "<leader>-", "<cmd>:lua require('nvim-window').pick()<cr>")
        vim.cmd[[
          hi NvimWindowLetter guifg=#ff3393 guibg=#1e2030 font='Impact:h14'
        ]]
      end,
    },
    -- }}}

    -- open-browser {{{
	-- https://github.com/tyru/open-browser.vim
	{
      "tyru/open-browser.vim",
      config = function()
        vim.g.netrw_nogx = 1
        vim.keymap.set('n','gx','<Plug>(openbrowser-smart-search)')
        vim.keymap.set('v','gx','<Plug>(openbrowser-smart-search)')
      end,
    },
    -- }}}

    -- nvim-colorizer.lua {{{
    -- Show the color of the rgb code.
    -- https://github.com/NvChad/nvim-colorizer.lua
    {
      'NvChad/nvim-colorizer.lua',
      config = function()
        require('colorizer').setup({
            filetypes = {
              'lua',
              'css',
              'vim',
              html = { mode = 'foreground', }
            },
          })
      end,
    },
    -- }}}

    -- Sort.nvim {{{
    -- Line-wise and delimiter sorting.
    {
      'sQVe/sort.nvim',

      -- Optional setup for overriding defaults.
      config = function()
        require("sort").setup({
          -- Input configuration here.
        })
        vim.cmd([[
          nnoremap <silent> go <Cmd>Sort<CR>
          vnoremap <silent> go <Esc><Cmd>Sort<CR>
        ]])
      end,
    },
    -- }}}

    -- targets.vim {{{
	-- https://github.com/wellle/targets.vim
	{'wellle/targets.vim'},

	--  Tabfold {{{
	-- https://github.com/thalesmello/tabfold
	-- Plugin that enables fold toggle using the <Tab> key
    {'thalesmello/tabfold'},
	-- }}}

    -- toggleterm.nvim {{{
    -- https://github.com/akinsho/toggleterm.nvim
    {
      'akinsho/toggleterm.nvim',
      version = '*',
      config = function()
        require('toggleterm').setup({
            winbar = {
              enabled = true,
              name_formatter = function(term) return term.name end,
            },
          })
      end,
    },
    -- }}}

    -- }}}

    -- vim-active-numbers {{{
	-- https://github.com/AssailantLF/vim-active-numbers
    -- Only turn on line numbers in the active window.
	{
      'AssailantLF/vim-active-numbers',
      config = function()
        vim.g.active_number = 1
        vim.g.actnum_exclude = { "help", "neo-tree", "fugitive", "terminal" }
      end,
    },
    -- }}}

    -- vim-arpeggio {{{
    -- https://github.com/kana/vim-arpeggio
    -- Define 2 or more keymappings together, e.g. 'jk' together maps to ':'
    {'kana/vim-arpeggio'},
    -- }}}

    -- vim-auto-abbrev {{{
    -- https://github.com/omrisarig13/vim-auto-abbrev
    -- TODO: Look at changing/modifying the mapping.
    -- '<leader>aa' - call AutoAbbrevAddCurrentWord
    -- '<leader>al' - call AutoAbbrevAddCurrentLhsWord
    -- '<leader>ar' - call AutoAbbrevAddCurrentRhsWord
    -- '<leader>ae' - call AutoAbbrevReload
    -- Had to change from `config = function()` to `init = function()` in order
    -- to get the file path read at the right time.
	{
      'omrisarig13/vim-auto-abbrev',
      init = function()
        vim.cmd[[
          if has('macunix')
              let g:auto_abbrev_file_path="~/.config/nvim/abbreviates"
          elseif has('unix')
              let g:auto_abbrev_file_path="/auto/homecxo.nas03/bodine/Downloads/neovimrc/abbreviates"
          endif
          ]]
      end,
    },
    -- }}}

    -- AnsiEsc {{{
    -- https://github.com/powerman/vim-plugin-AnsiEsc
    -- Conceal or highlight ansi escape sequences.  This is a fork of the original
    -- with some improvements.
    {'powerman/vim-plugin-AnsiEsc'},
    -- }}}

    -- vim-eunuch {{{
    -- https://github.com/tpope/vim-eunuch
    -- Some Vim sugar for Unix commands that we might use.
    -- :Chmod
    -- :Rename
    -- :SudoWrite & :SudoEdit
    -- The most usefull is that typing a shebang line will cause the filetype
    -- to be re-detected and the file will automatically be made executable.
    {'tpope/vim-eunuch'},
    -- }}}

    -- vim-illuminate {{{
    -- https://github.com/RRethy/vim-illuminate
    -- Illuminate words under the cursor
    -- TODO: fix the highlighting for vim-illuminate.
    -- hi def IlluminatedWordText gui=underline
    {
      'RRethy/vim-illuminate',
      config = function()
        require('illuminate').configure({
            delay = 250,
            filetypes_allowlist = {"clojure", "commonlisp", "go", "lua", "Python", "rust" },
          })
      end,
    },
    -- }}}

    -- vim-matchup {{{
    -- https://github.com/andymass/vim-matchup
    -- An improvement on machit & matchparens.
    {
      'andymass/vim-matchup',
      event = 'BufRead',
      init = function()
        vim.g.matchup_surround_enabled = 1
        vim.g.matchup_transmute = 1
        vim.g.matchup_matchparen_deferred = 1
        vim.g.matchup_matchparen_offscreen = {}
      end,
    },
    -- }}}

    -- vim-polyglot {{{
    -- https://github.com/sheerun/vim-polyglot
    -- Some backup highlighting when we don't have a treesitter parser/query/module for given ft.
    {'sheerun/vim-polyglot'},
    -- }}}

    -- vim-repeat {{{
    -- https://github.com/tpope/vim-repeat
    {'tpope/vim-repeat'} ,
    -- }}}

    -- vim-strip-trailing-whitespace {{{
    -- https://github.com/axelf4/vim-strip-trailing-whitespace
    -- NOTE: Tue Jun 06 2023 12:07:27 - Conflicts with Neogit, commenting out for now.
    -- {'axelf4/vim-strip-trailing-whitespace'},
    -- }}}

    -- vim-unimpaired {{{
    -- https://github.com/tpope/vim-unimpaired
    -- [<space> - Add [count] blank lines above the cursor.
    -- ]<space> - Add [count] blank lines below the cursor.
    -- [e - Exchange the current line with [count] lines above it.
    -- ]e - Exchange the current line with [count] lines below it.
    {'tpope/vim-unimpaired'},
    -- }}}

    -- which-key {{{
    -- https://github.com/folke/which-key.nvim
    -- Display keybindings.
    {
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup()
        vim.keymap.set('n', '<leader>hk', '<cmd>WhichKey<cr>')
        vim.keymap.set('n', '<leader>hl', '<cmd>WhichKey <leader><cr>')
      end,
    },
    -- }}}

    -- TODO: Implement keybindings.
    -- yanky.nvim {{{
    -- https://github.com/gbprod/yanky.nvim
    -- Yank ring, yank history
    {
      'gbprod/yanky.nvim',
      dependencies = { "kkharji/sqlite.lua" },
      config = function()
        require("yanky").setup({
            ring = {
              history_length = 250,
            },
          })
      end,
    },

    -- }}}

    -- end General Utilities }}}

    -- Software Development {{{

    -- aerial.nvim {{{
    -- https://github.com/stevearc/aerial.nvim
    -- Symbol outline viewer and symbol navigation thru Telescope integration.
    -- Uses treesitter, LSP, markdown, manual in order to find symbols.
    --
    -- symbols-outline.nvim has preview & can turn off line numbers BUT the
    -- preview isn't accuate.
    {
      'stevearc/aerial.nvim',
      config = function()
        require("aerial").setup({
            layout = {
              max_width = 75,
              min_width = 50,
            },
            highlight_on_hover = true,
            show_guides = true,
            default_direction = "right",
            post_jump_cmd = "normal! zt",
            -- A list of all symbols to display.
            -- This can be a filetype map (see :help aerial-filetype-map)
            -- To see all available values, see :help SymbolKind
            -- Setting to false shows all of the symbols... maybe makes things slow??
            filter_kind = false,
          })

        vim.keymap.set('n', '<leader>tt', '<cmd>AerialToggle<cr>')

        -- Telescope integration
        require('telescope').load_extension('aerial')
        vim.keymap.set('n', '<leader>ta', '<cmd>Telescope aerial<cr>')
      end,
    },
    -- }}}

    -- Auto pairs {{{
    -- https://github.com/windwp/nvim-autopairs
    {
      'windwp/nvim-autopairs',
      config = function()
        require('nvim-autopairs').setup({
            disable_filetype = { "TelescopePrompt" },
            enable_check_bracket_line = false,
          })
      end,
    },
    -- }}}

    -- TODO: Investigate if there is a dedocs plugin for neovim - and if there is a
    -- way to set global bookmarks that could be recalled.

    -- dash.nvim {{{
    -- Query the Dash.app with telescope
    --   :Telescope dash search
    -- OR
    -- Query the word under the cursor.
    --   :DashWord
    -- https://github.com/mrjones2014/dash.nvim
    {
        'mrjones2014/dash.nvim',
        build = 'make install',
    },
    -- }}}

    -- Comment.nvim {{{
    -- https://github.com/numToStr/Comment.nvim
    -- Comment/Uncomment plugin - successor to kommentary.
    --
    -- Supports treesitter. Read more
    -- Supports commentstring. Read :h comment.commentstring
    -- Supports line (//) and block (/* */) comments
    -- Dot (.) repeat support for gcc, gbc and friends
    -- Count support for [count]gcc and [count]gbc
    -- Left-right (gcw gc$) and Up-Down (gc2j gc4k) motions
    -- Use with text-objects
    -- Supports pre and post hooks
    -- Ignore certain lines, powered by Lua regex
    {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup()
      end,
    },
    -- }}}

    -- hlargs {{{
    -- https://github.com/m-demare/hlargs.nvim
    -- Highlight argument definitions and usages
    -- supported languages: go, lua, Python, ruby, rust
    {
        'm-demare/hlargs.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
          require('hlargs').setup()
        end,
    },
    -- }}}

    -- iron.nvim {{{
    -- A REPL in Neovim...
    -- https://github.com/Vigemus/iron.nvim
    {
      'Vigemus/iron.nvim',
      config = function()
        local iron = require("iron.core")
        iron.setup {
          config = {
            repl_definition = {
              python = {
                command = {"ipython"}
              }
            },
            repl_open_cmd = require('iron.view').bottom(45),
          },
         keymaps = {
            send_motion = "<space>sc",
            visual_send = "<space>sc",
            send_file = "<space>sf",
            send_line = "<space>sl",
            send_until_cursor = "<space>su",
            send_mark = "<space>sm",
            mark_motion = "<space>mc",
            mark_visual = "<space>mc",
            remove_mark = "<space>md",
            cr = "<space>s<cr>",
            interrupt = "<space>s<space>",
            exit = "<space>sq",
            clear = "<space>cl",
          },
        }

        -- iron also has a list of commands, see :h iron-commands for all available commands
        vim.keymap.set('n', '<space>rs', '<cmd>IronRepl<cr>')
        vim.keymap.set('n', '<space>rr', '<cmd>IronRestart<cr>')
        vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>')
        vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')
      end,
    },
    -- }}}

    -- LSP, nvim-cmp & snippets {{{

    -- lsp-overloads {{
    -- https://github.com/Issafalcon/lsp-overloads.nvim
    -- Using mainly for method overloads - shows different signaatures.
    --
    -- keymaps = {
    --      next_signature = "<C-j>",
    --      previous_signature = "<C-k>",
    --      next_parameter = "<C-l>",
    --      previous_parameter = "<C-h>",
    --      close_signature = "<A-s>"
    --    },
    --
    -- ** The configuration is done in on_attach function below.
    {
      'Issafalcon/lsp-overloads.nvim',
    },
    -- }}

    -- nvim-lspconfig {{{
    {
      'neovim/nvim-lspconfig',
      event = 'BufReadPre',
      config = function()
        local lspconfig = require("lspconfig")

        local on_attach = function(client, bufnr)
        if client.server_capabilities.signatureHelpProvider then
            require('lsp-overloads').setup(client, {
                keymaps = {
                  close_signature = "C-x C-c",
                }
              })
          end

        local bufopts = { noremap=true, silent=true, buffer=bufnr }
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        end

        -- put a box around LspInfo
        local _border = "single"
        require('lspconfig.ui.windows').default_options = {
          border = _border
        }

        -- Python server setup
        lspconfig.pyright.setup({
            on_attach = on_attach,
            root_dir = function(fname)
              return lspconfig.util.root_pattern("pyrightconfig.json", ".git", "setup.py", "requirements.txt")(fname) or
                lspconfig.util.path.dirname(fname)
              end,
          })
      end,
    },
    -- }}}

    -- nvim-cmp {{{
    --
    --
    -- https://github.com/L3MON4D3/LuaSnip
    -- I am using the snipmate style of snippets because i find the VSCode style annoying.
    --
    -- https://github.com/onsails/lspkind.nvim
    -- Add pictograms to LSP dropdown.
    {
      'hrsh7th/nvim-cmp',
      event = { 'InsertEnter', 'CmdLineEnter' },
      dependencies = {
        'onsails/lspkind.nvim',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'f3fora/cmp-spell',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lsp-document-symbol',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/cmp-nvim-lua',
        'davidsierradz/cmp-conventionalcommits',
        {
          'L3MON4D3/LuaSnip',
          dependencies = {
            'honza/vim-snippets',
            'saadparwaiz1/cmp_luasnip',
          },
          config = function() require('luasnip.loaders.from_snipmate').lazy_load({ paths = { "./deftpunk_snippets" } }) end,
        },
      },
      config = function()
        local cmp = require'cmp'
        local select_opts = { behavior = cmp.SelectBehavior.Select }
        local lspkind = require('lspkind')
        lspkind.init({
            mode = 'symbol_text',
          })
        cmp.setup({
            snippet = {
              expand = function(args)
                require'luasnip'.lsp_expand(args.body)
                -- luasnip.lsp_expand(args.body)
              end,
            },
            formatting = {
              fields = { "kind", "abbr", "menu" },
              format = function (entry, vim_item)
                local kind = lspkind.cmp_format({
                    mode = "symbol_text",
                    menu = {
                      luasnip = "[Snip]",
                      nvim_lsp = "[LSP]",
                      nvim_lsp_signature_help = "[Sign]",
                      nvim_lua =  "[Lua]",
                      buffer = "[Buf]",
                      crates = "[Crate]",
                      path = "[Path]",
                      git = "[Git]",
                      conventionalcommits = "[Conv]",
                    },
                  })(entry, vim_item)
                local strings = vim.split(kind.kind, "%s", { trimempty = true })
                kind.kind = " " .. strings[1] .. " "
                return kind
              end
            },
            window = {
              completion = cmp.config.window.bordered(),
              documentation = cmp.config.window.bordered(),
            },
            sources = {
              -- { name = 'conjure' },
              -- { name = 'nvim_lua' },
              -- { name = 'path' },
              -- { name = 'buffer', keyword_length = 3 },
              { name = 'luasnip' },
              { name = 'nvim_lsp', max_item_count = 50, keyword_length = 1 },
              { name = 'nvim_lsp_signature_help'},
              -- { name = 'treesitter', max_item_count = 10 },
              -- { name = 'crates' },
            },
            mapping = {
              ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
              ['<Down>'] = cmp.mapping.select_next_item(select_opts),

              ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
              ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

              ['<C-u>'] = cmp.mapping.scroll_docs(-4),
              ['<C-d>'] = cmp.mapping.scroll_docs(4),

              ['<C-g>'] = cmp.mapping.abort(),
              ['<CR>'] = cmp.mapping.confirm({select = false}),

              ['<C-f>'] = cmp.mapping(function(fallback)
                if luasnip.jumpable(1) then
                  luasnip.jump(1)
                else
                  fallback()
                end
              end, {'i', 's'}),

              -- luasnip bindings while we are in cmp
              ['<C-b>'] = cmp.mapping(function(fallback)
                if luasnip.jumpable(-1) then
                  luasnip.jump(-1)
                else
                  fallback()
                end
              end, {'i', 's'}),

              ['<Tab>'] = cmp.mapping(function(fallback)
                local col = vim.fn.col('.') - 1

                if cmp.visible() then
                  cmp.select_next_item(select_opts)
                elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                  fallback()
                else
                  cmp.complete()
                end
              end, {'i', 's'}),

              ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item(select_opts)
                else
                  fallback()
                end
              end, {'i', 's'}),
            },
          })

        cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources( {
                { name = 'git' },
                { name = 'buffer' },
                { name = 'conventionalcommits' },
                { name = 'luasnip' },
              })
          })

      end,

    },

    {
      'petertriho/cmp-git',
      ft = { 'gitcommit', 'gitrebase', 'octo' },
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function() require('cmp_git').setup() end,
    },

    -- }}}

    -- lspsaga {{{
    -- https://github.com/glepnir/lspsaga.nvim
    -- Highly performant LSP UI based on Neovim's built-in LSP.
    {
        "glepnir/lspsaga.nvim",
        event = "BufRead",
        dependencies = {
          'kyazdani42/nvim-web-devicons',
          'nvim-treesitter/nvim-treesitter',
        },
        config = function()
          require("lspsaga").setup({
              preview = {
                lines_above = 2,
                lines_below = 12,
              },
              scroll_preview = {
                scroll_down = "<C-f>",
                scroll_up = "<C-b>",
              },
            })

          vim.keymap.set("n", "<A-d>", "<cmd>Lspsaga open_floaterm lazygit<cr>", { silent = true })
        end,
    },
    -- }}}

    -- toggle-lsp-diagnostics.nvim {{{
    -- https://github.com/WhoIsSethDaniel/toggle-lsp-diagnostics.nvim
    -- What it says.
    {
      "https://github.com/WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
      config = function()
        -- remove the regular diagnostic virtual text since its just duplication.
        vim.diagnostic.config({
            virtual_text = false,
          })
        require('toggle_lsp_diagnostics').init()
        vim.keymap.set("n", "<leader>td", "<cmd>ToggleDiag<cr>", { silent = true })
      end,
    },
    -- }}}

    -- nvim-lightbulb {{{

    -- }}}

    -- lsp-lines {{{
    -- https://github.com/ErichDonGubler/lsp_lines.nvim
    {
      "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
      config = function()
        -- remove the regular diagnostic virtual text since its just duplication.
        vim.diagnostic.config({
            virtual_text = false,
          })
        require("lsp_lines").setup()
        vim.keymap.set("n", "<leader>tl", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })
      end,
    },
   -- }}}

   -- mason & mason-lspconfig {{{
   -- Install and manage LSP servers with mason
   -- https://www.github.com/williamboman/mason.nvim
   -- https://www.github.com/williamboman/mason-lspconfig.nvim
   -- Use :MasonInstall <lsp server> to install LSP servers.
    {
      'williamboman/mason.nvim',
      config = function()
        require("mason").setup({ ui = { border = 'single' } })
      end,
    },
    {
      'williamboman/mason-lspconfig.nvim',
      config = function()
        require("mason-lspconfig").setup({
            -- TODO: When getting back to clojure/nim, re-enable
            ensure_installed = { "pyright", "rust_analyzer" }
            -- ensure_installed = { "clojure_lsp", "nimls", "pyright", "rust_analyzer" }
          })
      end,
    },
    -- }}}

    -- neotest {{{
    -- https://github.com/nvim-neotest/neotest
    {
      'nvim-neotest/neotest',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
        'antoinemadec/FixCursorHold.nvim',
        'rouge8/neotest-rust',
        'nvim-neotest/neotest-Python',
      },
      lazy = true
    },
    -- }}}

    -- A single panel for LSP Server errors & warnings.
    -- https://www.github.com/folke/trouble.nvim
    {
        'folke/trouble.nvim',
        dependencies = {"kyazdani42/nvim-web-devicons"},
    },
    -- }}}

    -- todo-comments {{{
    -- https://www.github.com/folke/todo-comments.nvim
    -- See all of the TODO/FIXME/NOTE ... comments in a file.
    {
      'folke/todo-comments.nvim',
      config = function()
        require("todo-comments").setup{
          FIX = {
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "XXX", "FIX"},
          },
        }

        -- TodoTrouble mapping is global in your current directory.
        vim.keymap.set('n', 'gr', '<cmd>TodoTrouble<cr>')
        -- TODO: THis is global, make it just for the current buffer.
        vim.keymap.set('n', '<leader>tc', '<cmd>TodoTelescope<cr>')
      end,
    },
    -- }}}

    -- end Software Development }}}

    -- Source Control - git and what else?? {{{

    -- diffview.nvim {{{
    -- https://github.com/sindrets/diffview.nvim
    -- Make diffs much better, not just visually.
    -- There are actions, hooks, modes and mode keymaps...
    --
    -- 'git log' equivalent -> :DiffviewFileHistory %
    {
      'sindrets/diffview.nvim',
      dependencies = {'nvim-lua/plenary.nvim'},
    },
    -- }}}

    -- fugitive
    -- https://github.com/tpope/vim-fugitive
    -- Pretty basic git support.
    {
      "tpope/vim-fugitive",
    },

    -- rhubarb.vim
    -- https://github.com/tpope/vim-rhubarb
    -- Support for Github in fugitive - i am changing it to support HPE's github enterprise.
    {
      "tpope/vim-rhubarb",
      config = function()
        vim.cmd[[
          let g:github_enterprise_urls = ['https://github.hpe.com']
        ]]
      end,
    },

    -- neogit
    -- https://github.com/TimUntersberger/neogit
    -- A kind of magit clone
    {
      'NeogitOrg/neogit',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
        require('neogit').setup({
          disable_commit_confirmation = true,
          integrations = {
            diffview = true
              },
            })

        vim.keymap.set('n', '<leader>gg', ':Neogit<cr>')
        vim.keymap.set('n', '<leader>gd', ':DiffviewOpen<cr>')
      end,
    },

    -- git-messenger
    -- https://github.com/rhysd/git-messenger.vim
    -- View commit info @ line in a popup window.
    -- Popup window mappings
    -- ================================
    -- q	Close the popup window
    -- o	older. Back to older commit at the line
    -- O	Opposite to o. Forward to newer commit at the line
    -- d	Toggle unified diff hunks only in current file of the commit
    -- D	Toggle all unified diff hunks of the commit
    -- r	Toggle word diff hunks only in current file of the commit
    -- R	Toggle all word diff hunks of current commit
    -- ?	Show mappings help
    {
      "rhysd/git-messenger.vim",
      config = function()
        vim.cmd[[
          let g:git_messenger_always_into_popup=v:true
          let g:git_messenger_include_dir="current"
          let g:git_messenger_floating_win_opts = { 'border': 'single'}
          let g:git_messenger_popup_content_margins = v:false
        ]]

        vim.keymap.set('n', '<leader>gm', ':GitMessenger<cr>')
      end,
    },

    -- Super fast git decorations.
    -- Integrates with vim-fugitive, repeat (repeat) staging, trouble.nvim
    -- https://github.com/lewis6991/gitsigns.nvim
    {
      'lewis6991/gitsigns.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
        require('gitsigns').setup {
          watch_gitdir = {
            interval = 1000,
            follow_files = true,
          },
          attach_to_untracked = true,
          current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
          current_line_blame_formatter = '<author>@<author_time:%Y-%m-%d>: <summary>',
          max_file_length = 40000, -- Disable if file is longer than this (in lines)
        }
      end,
    },

    -- octo.nvim {{{
    -- https://github.com/pwntester/octo.nvim
    -- Edit GitHub issues and PRs
    -- Add/Modify/Delete comments
    -- Add/Remove label, reactions, assignees, project cards, reviewers, etc.
    -- Add Review PRs
    -- * NEEDS GitHub CLI installed *
    {
      'pwntester/octo.nvim',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
        'kyazdani42/nvim-web-devicons',
      },
      cmd = 'Octo',
      config = function() require('octo').setup() end,
    },
    -- }}}

    -- end of Source Control }}}

    -- Clojure {{{

    -- Conjure
    -- https://github.com/Olical/conjure
    {'Olical/conjure'},

    -- https://github.com/PaterJason/cmp-conjure
    {'PaterJason/cmp-conjure'},

    -- vim-clojure-static
    -- https://github.com/guns/vim-clojure-static
    {'guns/vim-clojure-static'},

    -- vim-clojure-highlight
    -- https://github.com/guns/vim-clojure-highlight
    -- Extended clojure highlighting
    -- use 'guns/vim-clojure-highlight'

    -- vim-sexp
    -- https://github.com/guns/vim-sexp
    -- Precision editing of S-expressions in Clojure, Common Lisp
    {'guns/vim-sexp'},

    -- vim-sexp-mappings-for-regular-people
    -- https://github.com/tpope/vim-sexp-mappings-for-regular-people
    -- Make the sexp mappings easier in the beginning.
    {'tpope/vim-sexp-mappings-for-regular-people'},

    -- The stuff to be able to Jack-in like CIDER does for Emacs - use :Clj
    {'tpope/vim-dispatch'},
    {'clojure-vim/vim-jack-in'},
    {'radenling/vim-dispatch-neovim'},

    -- }}}

    -- Nim {{{
    {
      'alaviss/nim.nvim',
    },
    -- }}}

    -- Python {{{

    -- With nvim-lspconfig + pyright, the PyrightOrganizeImports cmd is available.

    -- https://github.com/cjrh/vim-conda


    -- vim-pythonsense {{{
    -- https://github.com/jeetsukumaran/vim-pythonsense
    --
    -- Text objects, keymaps specific to using Python - superior to vim-textobj-Python.
    --
    -- Python Text Objects
    -- "ac" : Outer class text object. This includes the entire class, including the
    --     header (class name declaration) and decorators, the class body, as well as a
    --     blank line if this is given after the class definition.
    -- "ic" : Inner class text object. This is the class body only, thus excluding the
    --     class name declaration line and any blank lines after the class definition.
    -- "af" : Outer function text object. This includes the entire function, including
    --         the header (function name declaration) and decorators, the function
    --                 body, as well as a blank line if this is given after the
    --                     function definition.
    -- "if" : Inner function text object. This is the function body only, thus
    --             excluding the function name declaration line and any blank lines
    --                 after the function definition.
    -- "ad" : Outer docstring text object.
    -- "id" : Inner docstring text object.
    --
    -- The differences between inner and outer class and method/function text objects
    --     are illustrated by the following:
    --
    -- class OneRing(object):             -----------------------------+
    --                                    --------------------+        |
    --     def __init__(self):                                |        |
    --         print("One ring to ...")                       |        |
    --                                                        |        |
    --     def rule_them_all(self):                           |        |
    --         self.find_them()                               |        |
    --                                                        |        |
    --     def find_them(self):           ------------+       |        |
    --         a = [3, 7, 9, 1]           ----+       |       |        |
    --         self.bring_them(a)             |- `if` |- `af` |- `ic`  | - `ac`
    --         self.bind_them("darkness") ----+       |       |        |
    --                                    ------------+       |        |
    --     def bring_them_all(self, a):                       |        |
    --         self.bind_them(a, "#000")                      |        |
    --                                                        |        |
    --     def bind_them(self, a, c):                         |        |
    --         print("shadows lie.")      --------------------+        |
    --                                    -----------------------------+
    -- Python Object Motions
    -- "]]" : Move (forward) to the beginning of the next Python class.
    -- "][" : Move (forward) to the end of the current Python class.
    -- "[[" : Move (backward) to beginning of the current Python class (or beginning
    --         of the previous Python class if not currently in a class or already at
    --             the beginning of a class).
    -- "[]" : Move (backward) to end of the previous Python class.
    -- "]m" : Move (forward) to the beginning of the next Python method or function.
    -- "]M" : Move (forward) to the end of the current Python method or function.
    -- "[m" : Move (backward) to the beginning of the current Python method or
    --         function (or to the beginning of the previous method or function if not
    --                     currently in a method/function or already at the beginning
    --                             of a method/function).
    -- "[M" : Move (backward) to the end of the previous Python method or function.
    --
    {'jeetsukumaran/vim-pythonsense'},
    -- }}}

    -- requirements.txt.vim {{{
    -- https://github.com/raimon49/requirements.txt.vim
    -- the Requirements File Format syntax support for Vim
    {'raimon49/requirements.txt.vim'},
    -- }}}

    -- }}}

    -- Rust {{{

    -- https://rsdlt.github.io/posts/rust-nvim-ide-guide-walkthrough-development-debug/#better-coding-experience

    -- crates.nvim
    -- https://github.com/Saecki/crates.nvim
    -- Help manage crates.io dependencies.
   {
      "Saecki/crates.nvim",
      event = { "BufRead Cargo.toml" },
      config = function()
        require("crates").setup()
      end,
    },

    -- rust-tools.nvim {{{
    -- Enables more of the funcitons of rust-analyzer
    -- https://github.com/simrat39/rust-tools.nvim
    {
      'simrat39/rust-tools.nvim',
      config = function()
        local rt = require("rust-tools")
        rt.setup({
            server = {
              on_attach = function(_, bufnr)
                -- Hover actions
                vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
                -- Code action groups
                vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
              end,
            },
        })
      end,
    },
    -- }}}

    -- }}}

    -- Markdown {{{

    -- headlines {{{
    -- https://github.com/lukas-reineke/headlines.nvim
    -- For markdown neorg
    {
        'lukas-reineke/headlines.nvim',
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = true, -- or `opts = {}`
    },
    -- }}}

    -- markdown-preview {{{
    -- https://github.com/iamcco/markdown-preview.nvim
    {
      'iamcco/markdown-preview.nvim',
      config = function()
        vim.cmd[[
          let g:mkdp_refresh_slow = 1
        ]]
      end,
    },
    -- }}}

    -- glow.nvim {{{
    -- https://github.com/ellisonleao/glow.nvim
    -- Preview markdown code directly in neovim terminal via charm's glow
    {
      "ellisonleao/glow.nvim", 
      config = function()
        require('glow').setup({
            glow_path = "/opt/homebrew/bin/glow",
          })
      end,
    },
    -- }}}

    -- }}}

    -- neorg {{{
    -- https://github.com/nvim-neorg/neorg
    {
      "nvim-neorg/neorg",
      build = ":Neorg sync-parsers", -- update the treesitter parsers
      ft = 'norg', -- lazy load on filetype
      cmd = 'Neorg', -- lazy load on command
      priority = 30, -- makes neorg load after treesitter
      dependencies = { "nvim-lua/plenary.nvim" },
      opts = {
          load = {
            ["core.defaults"] = {}, -- Loads default behaviour
            ["core.concealer"] = {
              config = {
                init_open_folds = "always",
              }
            }, -- Adds pretty icons to your documents
            ["core.dirman"] = { -- Manages Neorg workspaces
              config = {
                workspaces = {
                  work = "~/Neorg/work",
                  home = "~/Neorg/home",
                },
              },
            },
          },
        },
      keys = {
        { "<leader>ni", "<cmd>Neorg index<cr>", desc="Neorg Index"},
      },
    },
    -- }}}

    -- }}}

    -- Obsidian {{{
    -- https://github.com/epwalsh/obsidian.nvim
    -- :ObsidianBacklinks - for getting a location list of references to the current buffer.
    -- :ObsidianToday - to create a new daily note.
    -- :ObsidianYesterday - to open (eventually creating) the daily note for the previous working day.
    -- :ObsidianOpen - to open a note in the Obsidian app. This command has one
    --    optional argument: the ID, path, or alias of the note to open. If not given,
    --    the note corresponding to the current buffer is opened.
    -- :ObsidianNew - to create a new note. This command has one optional argument:
    --    the title of the new note.
    -- :ObsidianSearch - to search for notes in your vault using ripgrep
    -- :ObsidianQuickSwitch - to quickly switch to another notes in your vault,
    -- :ObsidianLink - to link an in-line visual selection of text to a note. This
    --    command has one optional argument: the ID, path, or alias of the note to
    --    link to. If not given, the selected text will be used to find the note with
    --    a matching ID, path, or alias.
    -- :ObsidianLinkNew - to create a new note and link it to an in-line visual
    --    selection of text. This command has one optional argument: the title of the
    --    new note. If not given, the selected text will be used as the title.
    -- :ObsidianFollowLink - to follow a note reference under the cursor.
    -- :ObsidianTemplate - to insert a template from the templates folder, selecting
    --    from a list using telescope.nvim or one of the fzf alternatives.
    {
      "epwalsh/obsidian.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "preservim/vim-markdown",
        "godlygeek/tabular",
      },
      config = function()
        require("obsidian").setup({
            dir = "~/WorkStuff/WorkVault",
            completion = {
              nvim_cmp = true,
            }
          })
      end,
    },

    -- }}}

})

-- }}}

-- Normal Mode Maps {{{

-- Disable some bindings that I find annoying & potentially dangerous if hit accidentally.
-- ZZ - save and close Vim
-- ZQ - close Vim
vim.keymap.set('n', 'ZZ', '<Nop>')
vim.keymap.set('n', 'ZQ', '<Nop>')

-- Some OG 'g' bindings
-- next/previous buffers.
vim.keymap.set('n', 'gb', ':bnext')
vim.keymap.set('n', 'gB', ':bprev')

 -- Make D behave
vim.keymap.set('n', 'D', 'd$')
--  Yank to the end of the line.
vim.keymap.set('n', 'Y', 'y$')
--  U is a better redo
vim.keymap.set('n', 'U', '<C-r>')

--  vv to generate new vertical split
vim.keymap.set('n', 'vv', '<C-w>v <C-w>=')
--  ss to generate new horizontal split
vim.keymap.set('n', 'ss', '<C-w>s <C-w>=')

-- Quickly move the adjacent windows
vim.keymap.set('n', '<c-h>', '<c-w>h')
vim.keymap.set('n', '<c-j>', '<c-w>j')
vim.keymap.set('n', '<c-k>', '<c-w>k')
vim.keymap.set('n', '<c-l>', '<c-w>l')

-- Tue Nov 28 2023 21:38:24 -> Neovim + kitty terminal looks like it maps Super(D) keys!!
-- vim.keymap.set('n', '<D-l>', '<c-w>l')


-- Remap for dealing with word wrap
-- vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
-- vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- }}}

-- Insert Mode Maps {{{

-- TODO: Some <C-l> equivalent that recenters like the Emacs version.

-- Delete the previous word.
vim.keymap.set('i', '<C-b>', '<C-o>diw')
-- Delete the next character, like all the shells do.
vim.keymap.set('i', '<C-d>', '<C-o>x')

-- }}}

-- Command Mode Keymaps {{{

vim.keymap.set('c', '<C-a>', '<home>')
vim.keymap.set('c', '<C-e>', '<end>')

-- }}}

-- Terminal Maps {{{
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- }}}

-- Leader Keymaps {{{

-- Go to tab by number
vim.keymap.set('n','<leader>1','1gt')
vim.keymap.set('n','<leader>2','2gt')
vim.keymap.set('n','<leader>3','3gt')
vim.keymap.set('n','<leader>4','4gt')
vim.keymap.set('n','<leader>5','5gt')
vim.keymap.set('n','<leader>6','6gt')
vim.keymap.set('n','<leader>7','7gt')
vim.keymap.set('n','<leader>8','8gt')
vim.keymap.set('n','<leader>9','9gt')
vim.keymap.set('n','<leader>0',':tablast<cr>')

-- Write the file.
vim.keymap.set('n', '<leader>w', ':w<cr>')

-- Recenter
vim.keymap.set('n', '<leader><leader>l', 'zz')

-- The fill-paragraph equivalent.
vim.keymap.set('n', '<leader>=', 'gqq')

-- Toggle search highlight.
vim.keymap.set('n', '<leader>th',
	[[ (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n" <BAR> redraw<CR>]],
	{ silent = true, expr = true }
)
-- }}}

-- Arpeggio
-- Mapped here because of what arpeggio#load() does, which I am not really sure
-- about but this works.
vim.cmd[[
call arpeggio#load()
Arpeggioinoremap jk <Esc>:
Arpeggionnoremap jk :
Arpeggiocnoremap jk <Esc>
]]

-- Abbreviations {{{

vim.cmd('iab ydate <c-r>=strftime("%a %b %d %Y %T")<cr>')
-- }}}

-- Investigate {{{

--  Dashboard/Greeter
-- Fri Aug 26 2022 11:03:01 - don't think so, it doesn't timeout
-- https://github.com/goolord/alpha-nvim

-- split resizing and navigation
-- https://github.com/mrjones2014/smart-splits.nvim

-- Different autosave plugins
-- Looking for something that doesn't break undo/redo.
-- https://github.com/aidenlangley/auto-save.nvim
-- https://github.com/Pocco81/auto-save.nvim

-- Should I ever have the need for guessing indentation
-- nmac427/guess-indent.nvim

-- https://github.com/kdheepak/lazygit.nvim

-- delta is a "diff"(?) viewing program...
-- https://github.com/dandavison/delta

-- }}}
