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
      rust.enable = true;
      ts.enable = true;
      nix.enable = true;
      html.enable = true;
      css.enable = true;
    };
    lsp = {
      enable = true;
      formatOnSave = true;
      lspkind.enable = true;
      lightbulb.enable = true;
      trouble.enable = true;
      lspconfig.sources.csharp_ls = ''
        lspconfig.csharp_ls.setup {
          capabilities = capabilities;
          on_attach = default_on_attach;
          cmd = {"${getExe pkgs.csharp-ls}"};
        }
      '';
      lspconfig.sources.lua-lsp = ''
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
    };
  };

  home.packages = with pkgs; [
    csharp-ls
    dotnet-sdk_8
  ];
}
