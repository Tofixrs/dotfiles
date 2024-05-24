{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) getExe;
in {
  programs.neovim-flake.settings.vim = {
    visuals.fidget-nvim = {
      enable = true;
      setupOpts = {
        integration.nvim-tree.enable = true;
        notification.window = {
          align = "top";
          border = "rounded";
          winblend = 0;
        };
      };
    };
    languages = {
      enableLSP = true;
      enableFormat = true;
      enableTreesitter = true;
      enableExtraDiagnostics = true;
      rust.enable = true;
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
    };
    lsp = {
      enable = true;
      formatOnSave = true;
      lspkind.enable = true;
      lightbulb.enable = true;
      trouble.enable = true;
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
          lspconfig.html.setup {
            capabilities = capabilities;
            on_attach = default_on_attach;
          }
        '';
        emmet = ''
          lspconfig.emmet_language_server.setup {
            capabilities = capabilities;
            on_attach = default_on_attach;
            cmd = {"${getExe pkgs.emmet-ls}", "--stdio"}
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
