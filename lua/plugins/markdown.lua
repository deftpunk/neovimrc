return {

  -- Markdown previewers {{{
  -- https://github.com/iamcco/markdown-preview.nvim
  --    Requires npm and yarn to install/preview.
  --
  -- https://github.com/brianhuster/live-preview.nvim
  --    Supports KaTeX & Mermaid
  --    No external dependencies or runtime (NodeJS)
  --
  -- https://github.com/yusukebe/gh-markdown-preview
  --    No mermaid diagram support.
  --    Have to run a server.
  --
  -- https://github.com/jannis-baum/vivify.vim
  --     Have to have the Vivify server (which) is actually pretty good -
  --        https://github.com/jannis-baum/Vivify
  -- }}}

  -- install without yarn or npm
  {
      "iamcco/markdown-preview.nvim",
      cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
      ft = { "markdown" },
      build = function()
        require("lazy").load({ plugins = { "markdown-preview.nvim" } })
        vim.fn["mkdp#util#install"]()
      end,
      config = function()
        vim.cmd([[
          function OpenMarkdownPreview (url)
            execute "silent ! open -a Firefox -n --args --new-window " . a:url
          endfunction
          let g:mkdp_browserfunc = "OpenMarkdownPreview"
        ]])
      end,
      -- TODO: Is mp a mapped key in markdown-plus?
      keys = {
          {
            "<leader>mp",
            ft = "markdown",
            "<cmd>MarkdownPreviewToggle<cr>",
            desc = "Markdown Preview",
          },
        },
  },

  -- markdown-plus {{{
  -- https://github.com/YousefHadder/markdown-plus.nvim
  -- A comprehensive Neovim plugin that provides modern markdown editing capabilities,
  -- implementing features found in popular editors like Typora, Mark Text, and Obsidian.
  --
  -- List Management (Normal & Visual mode)
  -- <leader>mr	Normal	Manual renumber ordered lists
  -- <leader>md	Normal	Debug list groups (development)
  -- <leader>mx	Visual	Toggle checkboxes in selection or at checkbox
  -- <leader>mb	Normal/Visual	Toggle bold formatting
  -- <leader>mi	Normal/Visual	Toggle italic formatting
  -- <leader>ms	Normal/Visual	Toggle strikethrough formatting
  -- <leader>mc	Normal/Visual	Toggle `code` formatting
  -- <leader>mw	Visual	Convert selection to code block
  -- <leader>mC	Normal/Visual	Clear all formatting
  --
  -- Headers & TOC (Normal mode)
  -- ]]	Normal	Jump to next header
  -- [[	Normal	Jump to previous header
  -- <leader>h+	Normal	Promote header (increase importance)
  -- <leader>h-	Normal	Demote header (decrease importance)
  -- <leader>h1 .. h6	Normal	Set/convert to H1 thru H6
  -- <leader>ht	Normal	Generate table of contents
  -- <leader>hu	Normal	Update existing table of contents
  -- <leader>hT	Normal	Toggle navigable TOC window
  -- gd	Normal	Follow TOC link (jump to header)
  --
  -- List & References (Normal & Visual mode)
  -- <leader>ml	Normal	Insert new markdown link
  -- <leader>ml	Visual	Convert selection to link
  -- <leader>me	Normal	Edit link under cursor
  -- <leader>ma	Normal	Convert URL to markdown link
  -- <leader>mR	Normal	Convert to reference-style link
  -- <leader>mI	Normal	Convert to inline link
  -- gx	Normal	Open link in browser (native Neovim)
  --
  -- Quotes Management (Normal & Visual mode)
  -- <leader>mq	Normal	Toggle blockquote on current line
  -- <leader>mq	Visual	Toggle blockquote on selected lines
  --
  -- Tables (Normal & Insert mode)
  -- <leader>tc	Normal	Create new table interactively
  -- <leader>tf	Normal	Format table at cursor
  -- <leader>tn	Normal	Normalize malformed table
  -- <leader>tir	Normal	Insert row below current row
  -- <leader>tiR	Normal	Insert row above current row
  -- <leader>tdr	Normal	Delete current row
  -- <leader>tyr	Normal	Duplicate current row
  -- <leader>tic	Normal	Insert column to the right
  -- <leader>tiC	Normal	Insert column to the left
  -- <leader>tdc	Normal	Delete current column
  -- <leader>tyc	Normal	Duplicate current column
  -- <leader>ta	Normal	Toggle cell alignment (left/center/right)
  -- <leader>tx	Normal	Clear cell content
  -- <leader>tmh	Normal	Move column left
  -- <leader>tml	Normal	Move column right
  -- <leader>tmk	Normal	Move row up
  -- <leader>tmj	Normal	Move row down
  -- <leader>tt	Normal	Transpose table (swap rows/columns)
  -- <leader>tsa	Normal	Sort table by column (ascending)
  -- <leader>tsd	Normal	Sort table by column (descending)
  -- <leader>tvx	Normal	Convert table to CSV
  -- <leader>tvi	Normal	Convert CSV to table
  -- <A-h>	Insert	Move to cell on the left (wraps)
  -- <A-l>	Insert	Move to cell on the right (wraps)
  -- <A-j>	Insert	Move to cell below (wraps)
  -- <A-k>	Insert	Move to cell above (wraps)
  --
  {
    "yousefhadder/markdown-plus.nvim",
    ft = "markdown",
    config = function()
      require("markdown-plus").setup({
        enabled = true,
        callouts = {
          custom_types = { "WARNING", "DEBUG", "TODO", "IMPORTANT" },
        },
      })
    end,
  },
  -- }}}

  --render-markdown.nvim
  --https://github.com/MeanderingProgrammer/render-markdown.nvim
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    opts = {},
  },
}
