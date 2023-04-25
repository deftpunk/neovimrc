-- vim: nu fdm=marker

-- init.lua based on lazy and not packer.
--
-- $ nvim --clean

-- Some sensible defaults {{{
vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.opt.termguicolors = true
vim.opt.syntax = 'on'
vim.opt.errorbells = false
vim.opt.smartcase = true
vim.opt.showmode = false
vim.bo.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath('config') .. '/undodir'
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.hidden = true
vim.opt.completeopt = {'menu','menuone','noselect'}
vim.opt.listchars:append('trail:•,extends:❯,precedes:❮')
vim.bo.autoindent = true
vim.bo.smartindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.wo.number = true
vim.wo.relativenumber = false
vim.wo.signcolumn = 'yes'
vim.wo.wrap = false

vim.opt.guifont='RobotoMono_Nerd_Font:h14:b:i:u:s'
-- Show colored columns so I know how far I've typed without looking down at the
-- statusline all the time.
-- Changed the last column to 100 as Clojure, Common Lisp & Rust use that as a
-- max column length guide.
vim.opt.colorcolumn={'80','100'}
vim.opt.cursorline = true

-- copy/paste from clipboard
vim.o.clipboard=unnamedplus

-- Some env variables 
vim.env.VISUAL = 'nvr -cc split --remote-wait'
vim.env.PYTHONUNBUFFERED = 1
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1

-- }}}

-- lazy.nvim {{{
-- https://github.com/folke/lazy.nvim
-- The Lazy Package Manager.
-- :Lazy check [plugins] - Check for updates and show the log (git fetch).
-- :Lazy clean - Clean plugins that are no longer needed.
-- :Lazy install [plugins] - Install missing plugins.
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
    -- https://github.com/folke/tokyonight.nvim
    {
      "folke/tokyonight.nvim",
      lazy = false, -- make sure we load this during startup if it is your main colorscheme
      priority = 1000, -- make sure to load this before all the other start plugins
      config = function()
          -- load the colorscheme here
          vim.cmd([[colorscheme tokyonight]])
      end,
    },

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
        local enabled_list = {"clojure",  "commonlisp", "fennel", "go", "markdown", "python", "ruby", "rust"}

        -- cmd("hi rainbowcol1 guifg=#ff3393")

        require('nvim-treesitter.configs').setup {
          ensure_installed = { "python", "html", "c", "cmake", "lua", "go", "clojure", "json", "commonlisp", "bash", "dockerfile", "markdown", "ruby", "rust", "toml", "vim", "yaml" },
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

    -- nvim-treesiter-context
    -- Show function context at the top of the file.
    -- https://github.com/nvim-treesitter/nvim-treesitter-context
    {'nvim-treesitter/nvim-treesitter-context'},

    {'mrjones2014/nvim-ts-rainbow'},

    -- }}}

    -- Telescope {{{


    -- Telescope
    -- https://github.com/nvim-telescope/telescope.nvim
    {'nvim-lua/popup.nvim'},
    {
      'nvim-telescope/telescope.nvim',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'BurntSushi/ripgrep'
      },
      config = function()

        require('telescope').setup {
          pickers = {
            live_grep = {
              only_sort_test = true
            }
          },
          extensions = {
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
              }
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
      end,
    },

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
        require('indent_blankline').setup({
            show_current_context = true,
            show_current_context_start = true,
          })
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
    --
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

    -- neoscroll.nvim {{{
    -- https://github.com/karb94/neoscroll.nvim
    -- Make scrolling smoother.
    {
      'karb94/neoscroll.nvim',
      config = function()
        require('neoscroll').setup()
      end,
    },
    -- }}}

    -- numb.nvim {{{
    -- https://github.com/nacro90/numb.nvim
    -- numb.nvim is a Neovim plugin that peeks lines of the buffer in
    -- non-obtrusive way when you do ':<linenumber>'
    {
      'nacro90/numb.nvim',
      config = function()
        require('numb').setup()
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
          border = 'none'
        })
        vim.keymap.set("n", "<leader>-", "<cmd>:lua require('nvim-window').pick()<cr>")
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
	-- https://github.com/omrisarig13/vim-auto-abbrev
	-- {
 --      'omrisarig13/vim-auto-abbrev',
 --      config = function()
 --        vim.cmd[[let g:auto_abbrev_file_path = '~/.config/nvim/abbreviates']]
 --      end,
 --    },
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
            filetypes_allowlist = {"clojure", "commonlisp", "go", "lua", "python", "rust" },
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
    {'axelf4/vim-strip-trailing-whitespace'},
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
    {
      'stevearc/aerial.nvim',
      config = function()
        require("aerial").setup({
            layout = {
              max_width = 75,
              min_width = 50,
            },
            default_direction = "right",
            post_jump_cmd = "normal! zt",
            -- A list of all symbols to display.
            -- This can be a filetype map (see :help aerial-filetype-map)
            -- To see all available values, see :help SymbolKind
            -- Setting to false shows all of the symbols... maybe makes things slow??
            filter_kind = false,
            -- filter_kind = {
            --   "Class",
            --   "Constructor",
            --   "Enum",
            --   "Function",
            --   "Interface",
            --   "Module",
            --   "Method",
            --   "Namespace",
            --   "Package",
            --   "Struct",
            -- },
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

    -- dash.nvim {{{
    -- Query the Dash.app with telescope
    -- https://github.com/mrjones2014/dash.nvim
    {
        'mrjones2014/dash.nvim',
        build = 'make install',
    },
    -- }}}

    -- conflict-marker {{{
    -- https://github.com/rhysd/conflict-marker.vim
    -- Highlight, jump and resolve conflict markers quickly.
    {
      'rhysd/conflict-marker.vim',
      config = function()

        -- Change the highlighting so tht we can see more contrast.
        -- disable the default highlight group
        vim.g.conflict_marker_highlight_group = ''
        -- Include text after begin and end markers
        vim.g.conflict_marker_begin = '^<<<<<<< .*$'
        vim.g.conflict_marker_end   = '^>>>>>>> .*$'
        -- change some of the highlighting.
        vim.cmd('hi ConflictMarkerBegin guibg=#2f7366')
        vim.cmd('hi ConflictMarkerOurs guibg=#2e5049')
        vim.cmd('hi ConflictMarkerTheirs guibg=#344f69')
        vim.cmd('hi ConflictMarkerEnd guibg=#2f628e')
        vim.cmd('hi ConflictMarkerCommonAncestorsHunk guibg=#754a81')
      end,
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
    -- supported languages: go, lua, python, ruby, rust
    {
        'm-demare/hlargs.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
          require('hlargs').setup()
        end,
    },
    -- }}}

    -- LSP, nvim-cmp & snippets {{{
    {
      'neovim/nvim-lspconfig',
      event = 'BufReadPre',
      config = function()
        local lspconfig = require("lspconfig")

        local on_attach = function(client, bufnr)

          local bufopts = { noremap=true, silent=true, buffer=bufnr }
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        end

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
                luasnip.lsp_expand(args.body)
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
              { name = 'conjure' },
              { name = 'nvim_lua' },
              { name = 'path' },
              { name = 'buffer', keyword_length = 3 },
              { name = 'nvim_lsp', max_item_count = 50, keyword_length = 1 },
              { name = 'nvim_lsp_signature_help'},
              { name = 'treesitter', max_item_count = 10 },
              { name = 'luasnip', keyword_length = 2 },
              { name = 'crates' },
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
            ensure_installed = { "clojure_lsp", "nimls", "pyright", "rust_analyzer" }
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
        'nvim-neotest/neotest-python',
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
    -- NOTE: Maybe use trouble... :TodoTrouble
    {
      'folke/todo-comments.nvim',
      config = function()
        require("todo-comments").setup{
          FIX = {
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "XXX", "FIX"},
          },
        }

        vim.keymap.set('n', '<leader>tc', '<cmd>TodoTelescope<cr>')
      end,
    },
    -- }}}

    -- end Software Development }}}

    -- Source Control - git and what else?? {{{

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
      vim.keymap.set('n', '<leader>gm', ':GitMessenger<cr>')
    },

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

    -- vim-fugitive {{
        { 'tpope/vim-fugitive' },
    -- }}

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
    -- Text objects, keymaps specific to using Python - superior to vim-textobj-python.
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

    -- Obsidian + Markdown {{{
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
            dir = "~/Documents/FirstVault",
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

-- Start in Insert mode when opening a terminal buffer.
-- Don't show weird characters.
-- Turn off line numbers in the terminal buffer.
-- https://vi.stackexchange.com/questions/22307/neovim-go-into-insert-mode-when-clicking-in-a-terminal-in-a-pane
vim.cmd('autocmd! TermOpen term://* startinsert!')
vim.cmd('autocmd! TermEnter term://* startinsert!')
vim.cmd('autocmd! TermOpen * setlocal listchars= nonumber norelativenumber')

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
-- https://github.com/TimUntersberger/neogit

-- Markdown
-- https://github.com/ellisonleao/glow.nvim

-- delta is a "diff"(?) viewing program...
-- https://github.com/dandavison/delta

-- }}}
