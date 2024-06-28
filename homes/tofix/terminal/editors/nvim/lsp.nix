{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) getExe;
in {
  programs.neovim-flake.settings.vim = {
    languages = {
      enableLSP = true;
      enableFormat = true;
      enableTreesitter = true;
      enableExtraDiagnostics = true;
      rust = {
        enable = true;
        crates.enable = true;
      };
      ts = {
        enable = true;
        extraDiagnostics.types = [];
      };
      nix.enable = true;
      html.enable = true;
      clang = {
        enable = true;
        cHeader = true;
      };
      css.enable = true;
      php = {
        enable = true;
        lsp.server = "phan";
      };
    };
    lsp = {
      enable = true;
      formatOnSave = true;
      lspkind.enable = true;
      lightbulb.enable = true;
      trouble.enable = true;
      nvimCodeActionMenu.enable = true;
      lspSignature.enable = true;
      lsplines.enable = true;
      nvim-docs-view.enable = true;
      lspconfig.sources = {
        jsonls = ''
          lspconfig.jsonls.setup {
            capabilities = capabilities;
            on_attach = default_on_attach;
          }
        '';
        csharp_ls = ''
          lspconfig.csharp_ls.setup {
            capabilities = capabilities;
            on_attach = default_on_attach;
            cmd = {"${getExe pkgs.csharp-ls}"};
          }
        '';
        lua-lsp = ''
          lspconfig.lua_ls.setup {
            capabilities = capabilities;
            on_attach = default_on_attach;
            cmd = {"${getExe pkgs.lua-language-server}"};

            settings  = {
            	Lua = {
            		workspace = {
            			library = {
            				vim.fn.expand("$HOME/sm.lua")
            			}
            		}
            	}
            }
          }
        '';
        html = ''
          lspconfig.html.setup{
            capabilities = capabilities;
            on_attach = default_on_attach;
            filetypes = {"html", "templ", "php"};
          }
        '';
        emmet = ''
          lspconfig.emmet_language_server.setup{
            capabilities = capabilities;
            on_attach = default_on_attach;
            cmd = {"${getExe pkgs.emmet-ls}", "--stdio"};
            filetypes = { "css", "eruby", "html", "htmldjango", "javascriptreact", "less", "pug", "sass", "scss", "typescriptreact", "php" };
          }
        '';
      };
    };
  };

  home.packages = with pkgs; [
    csharp-ls
    dotnet-sdk_8
    vscode-langservers-extracted
    emmet-ls
  ];
}
