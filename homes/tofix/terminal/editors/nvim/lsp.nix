{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) getExe;
in {
  programs.neovim-flake.settings.vim = {
    treesitter = {
      enable = true;
      grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        typescript
        qmljs
      ];
    };
    debugger.nvim-dap = {
      enable = true;
      ui = {
        enable = true;
        autoStart = true;
      };
    };
    languages = {
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
        format.type = "prettierd";
      };
      nix.enable = true;
      html.enable = true;
      clang = {
        enable = true;
        cHeader = true;
        dap.enable = true;
      };
      css = {
        enable = true;
        format.enable = false;
      };
      php = {
        enable = true;
        lsp.server = "intelephense";
      };
      svelte = {
        extraDiagnostics.types = [];
        enable = true;
        format.enable = false;
      };
      tailwind.enable = true;
    };
    lsp = {
      enable = true;
      formatOnSave = true;
      lspkind.enable = true;
      lightbulb.enable = true;
      trouble.enable = true;
      lspSignature.enable = true;
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
        yaml = ''
          require('lspconfig').yamlls.setup {
            settings = {
              yaml = {
                schemas = {
                  ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                  ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.k8s.yaml",
                },
              },
              redhat = {
                telemetry = {
                  enabled = false,
                },
              },
            }
          }
        '';
        vls = ''
          require('lspconfig').volar.setup {
            capabilities = capabilities;
            on_attach = on_attach;
            filetypes = {"vue"};
            init_options = {
              vue = {
                hybridMode = false
              }
            };
          }
        '';
        qmlls = ''
          require('lspconfig').qmlls.setup {
            cmd = {"qmlls", "-E"}
          }
        '';
        gdscript = ''
          require("lspconfig").gdscript.setup {}
        '';
      };
    };
  };
  home.packages = with pkgs; [
    csharp-ls
    dotnet-sdk_8
    vscode-langservers-extracted
    emmet-ls
    yaml-language-server
    vue-language-server
    nodePackages.svelte-language-server
    kdePackages.qtdeclarative
  ];
}
