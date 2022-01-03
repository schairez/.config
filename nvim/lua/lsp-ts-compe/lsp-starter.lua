
local LSP_signature_setup = {
  on_attach = function(client, bufnr)

    -- Better pop up documentation
		require('lsp_signature').on_attach{
      bind = true,  -- Mandatory for config
      doc_lines = 5,
      floating_window = true,
      fix_pos = false,
      hint_enable = true,
      hint_prefix = "<> ",
      hint_scheme = "String",
      use_lspsaga = false,
      hi_parameter = "Search",
      max_height = 12,
      max_width = 120,
      handler_opts = {
        border = "double" -- single/double/shadow
      },
    }
  require('vim.lsp.protocol').CompletionItemKind = {
    '', -- Text
    '', -- Method
    '', -- Function
    '', -- Constructor
    '', -- Field
    '', -- Variable
    '', -- Class
    'ﰮ', -- Interface
    '', -- Module
    '', -- Property
    '', -- Unit
    '', -- Value
    '', -- Enum
    '', -- Keyword
    '﬌', -- Snippet
    '', -- Color
    '', -- File
    '', -- Reference
    '', -- Folder
    '', -- EnumMember
    '', -- Constant
    '', -- Struct
    '', -- Event
    'ﬦ', -- Operator
    '', -- TypeParameter
  }
  -- autoformat on save
    if client.resolved_capabilities.document_formatting then
      vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting_seq_sync()")
    end
  end, --end func
}

-- LSPSaga
local lsp_saga = require('lspsaga')
lsp_saga.init_lsp_saga{
  use_saga_diagnostic_sign = true,
  error_sign = '',
  warn_sign = '',
  hint_sign = '',
  infor_sign = '',
  dianostic_header_icon = '  ',
  code_action_prompt = {
    enable = false,
  },
  border_style = "round",
}

local snippet_enable = vim.lsp.protocol.make_client_capabilities()
snippet_enable.textDocument.completion.completionItem.snippetSupport = true
snippet_enable.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}



local nvim_lsp = require('lspconfig')
-- local on_attach = require'completion'.on_attach
local protocol = require('vim.lsp.protocol')

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  --buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  --buf_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  --The following have been replaced by |vim.diagnostic.open_float()|.
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.open_float()<CR>', opts)
  --buf_set_keymap('n', '<C-j>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', '<S-C-j>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  -- formatting
  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_command [[augroup Format]]
    vim.api.nvim_command [[autocmd! * <buffer>]]
    vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
    vim.api.nvim_command [[augroup END]]
  end

  require'completion'.on_attach(client, bufnr)
  --
  -- https://blog.inkdrop.info/how-to-set-up-neovim-0-5-modern-plugins-lsp-treesitter-etc-542c3d9c9887
end
nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" }
}
nvim_lsp.diagnosticls.setup {
  on_attach = on_attach,
  filetypes = { 'javascript', 'javascriptreact', 'json', 'typescript', 'typescriptreact', 'css', 'less', 'scss', 'markdown', 'pandoc' },
  init_options = {
    linters = {
      eslint = {
        command = 'eslint_d',
        rootPatterns = { '.git' },
        debounce = 100,
        args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
        sourceName = 'eslint_d',
        parseJson = {
          errorsRoot = '[0].messages',
          line = 'line',
          column = 'column',
          endLine = 'endLine',
          endColumn = 'endColumn',
          message = '[eslint] ${message} [${ruleId}]',
          security = 'severity'
        },
        securities = {
          [2] = 'error',
          [1] = 'warning'
        }
      },
    },
    filetypes = {
      javascript = 'eslint',
      javascriptreact = 'eslint',
      typescript = 'eslint',
      typescriptreact = 'eslint',
    },
    formatters = {
      eslint_d = {
        command = 'eslint_d',
        args = { '--stdin', '--stdin-filename', '%filename', '--fix-to-stdout' },
        rootPatterns = { '.git' },
      },
      prettier = {
        command = 'prettier',
        args = { '--stdin-filepath', '%filename' }
      }
    },
    formatFiletypes = {
      css = 'prettier',
      javascript = 'eslint_d',
      javascriptreact = 'eslint_d',
      json = 'prettier',
      scss = 'prettier',
      less = 'prettier',
      typescript = 'eslint_d',
      typescriptreact = 'eslint_d',
      markdown = 'prettier',
    }
  }
}

-- icon
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    -- This sets the spacing and the prefix, obviously.
    virtual_text = {
      spacing = 4,
      prefix = ''
    }
  }
)

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

-- 'jsonls', 'sqlls'
local servers = {'gopls', 'pyright', 'rust_analyzer', 'tsserver', 'dockerls','yamlls'}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
      capabilities = capabilities,
      on_attach = LSP_signature_setup.on_attach,
   }
end


require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    snippets_nvim = true;
    treesitter = true;
  };
}

USER = vim.fn.expand('$USER')
HOME = vim.fn.expand('$HOME')
local sumneko_root_path = HOME .. '/tools/lua-language-server'
local sumneko_binary = sumneko_root_path .. "/bin/macOS/lua-language-server"

--local sumneko_binary = vim.fn.exepath('lua-language-server')
--local sumneko_root_path = vim.fn.fnamemodify(sumneko_binary, ':h:h:h')
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")


-- local sumneko_root_path = '/Users/' .. USER .. '/.config/nvim/lua-language-server'
-- local sumneko_binary = sumneko_root_path .. "/bin/macOS/lua-language-server"

--local on_attach = require'completion'.on_attach

nvim_lsp.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
  settings = {
    Lua = {
      completion = {
        callSnippet = "Both"
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        enable = true,
        globals = {'vim'}
      },
      runtime = {
        -- Tell the language server which version of Lua you are using. LuaJIT for NVIM
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
        --path = vim.split(package.path, ';')
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        checkThirdParty = true,
        library = {
          [HOME .. "/.config/nvim/lua/?.lua"] = true,
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          ["?.lua"] = true,
          ["?/init.lua"] = true,
          ["lua/?.lua"] = true,
          ["lua/?/?.lua"] = true,
          ["lua/?/init.lua"] = true
        },
        maxPreload = 2000,
        preloadFileSize = 50000,

       -- maxPreload = 2000,
        --preloadFileSize = 50000
        --maxPreload = 12500,
        --preloadFileSize = 150,
        --preloadFileSize = 120
      },

      telemetry = {
        enable = false,
      },
    },
  },
  on_attach = LSP_signature_setup.on_attach,
  capabilities = snippet_enable,
}
