{
  lib,
  pkgs,
  config,
  self',
  ...
}: let
  inherit (lib) getExe;
in {
  programs.neovim-flake.settings.vim = {
    formatter.conform-nvim = {
      enable = true;
      setupOpts.formatters_by_ft = {
        blade = ["blade-formatter"];
      };
    };
    treesitter = {
      enable = true;
      grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        typescript
        qmljs
        blade
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
      lua.enable = true;
      enableFormat = true;
      enableTreesitter = true;
      enableExtraDiagnostics = true;
      rust = {
        enable = true;
        extensions.crates-nvim.enable = true;
      };
      ts = {
        enable = true;
        extraDiagnostics.types = [];
        format.type = ["prettierd"];
      };
      nix.enable = true;
      html = {
        enable = true;
        lsp.servers = ["emmet-ls" "superhtml"];
      };
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
        lsp.servers = ["intelephense"];
      };
      svelte = {
        extraDiagnostics.types = [];
        enable = true;
        format.enable = false;
      };
      tailwind.enable = true;
      json.enable = true;
      just.enable = true;
      csharp = {
        enable = true;
        lsp.servers = ["omnisharp"];
      };
    };
    lsp = {
      enable = true;
      formatOnSave = true;
      lspkind.enable = true;
      lightbulb.enable = true;
      trouble.enable = true;
      lspSignature.enable = true;
      nvim-docs-view.enable = true;
      servers = {
        lua-language-server.settings.Lua.workspace.library = [
          "${config.home.homeDirectory}/sm.lua"
        ];
        emmet-ls.filetypes = [
          "css"
          "eruby"
          "html"
          "htmldjango"
          "javascriptreact"
          "less"
          "pug"
          "sass"
          "scss"
          "typescriptreact"
          "php"
          "blade"
        ];
        qmlls = {
          cmd = ["qmlls"];
          filetypes = ["qml" "qmljs"];
          root_markers = [".git"];
        };
        gdscript = {
          cmd = lib.generators.mkLuaInline ''
            (function()
              local port = os.getenv 'GDScript_Port' or '6005'
              return vim.lsp.rpc.connect('127.0.0.1', tonumber(port))
            end)()
          '';
          filetypes = ["gd" "gdscript" "gdscript3"];
          root_markers = ["project.godot" ".git"];
        };
        laravel_ls = {
          cmd = ["laravel-ls"];
          filetypes = ["php" "blade"];
          root_markers = ["artisan"];
        };
        intelephense = {
          filetypes = ["php" "blade"];
        };
      };
    };
  };
  home.packages = with pkgs; [
    (with dotnetCorePackages;
      combinePackages [
        sdk_9_0
        sdk_10_0
      ])
    vscode-langservers-extracted
    emmet-ls
    yaml-language-server
    vue-language-server
    nodePackages.svelte-language-server
    kdePackages.qtdeclarative
    go
    blade-formatter
  ];
}
