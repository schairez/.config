
require'nvim-treesitter.configs'.setup {
    ensure_installed = {"python", "bash", "javascript", "clojure", "go"},
    --"maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
        enable = true,
        disable = {"markdown", "lua", "cpp"},
      },
    indent = {
      enable = true,
    },
    autotag = {
        enable = true,
    },
 textobjects = {
      select = {
        enable = true,  -- you can also use a table with list of langs here (e.g. { "python", "javascript" })
        keymaps = {
          -- You can use the capture groups defined here:
	  -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects/blob/master/queries/c/textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ab"] = "@block.outer",
          ["ib"] = "@block.inner",
          ["as"] = "@statement.outer",
          ["is"] = "@statement.inner",
        },
      },
    },
}
