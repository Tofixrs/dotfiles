# Swicth to using nvim flake from NotAShelf
{
  inputs,
  lib,
  ...
}: {
  imports = [inputs.neovim-flake.homeManagerModules.default ./tree.nix ./lsp.nix ./terminal.nix ./keybinds.nix ./statusline.nix ./tabline.nix ./notes.nix ./visuals.nix ./utils.nix];
  programs.neovim-flake = {
    enable = true;

    settings.vim = {
      theme = {
        enable = true;
        name = "catppuccin";
        style = "mocha";
        transparent = true;
      };
      globals.editorconfig = true;
      enableLuaLoader = true;
      options = {
        autoindent = true;
        tabstop = 2;
        shiftwidth = 2;
      };
      autocomplete.nvim-cmp.enable = true;
      autopairs.nvim-autopairs.enable = true;
      bell = "visual";
      binds = {
        cheatsheet.enable = true;
        whichKey.enable = true;
      };
      comments = {
        comment-nvim.enable = true;
      };
      dashboard.alpha = let
        button = ''
          local function button(sc,txt,keybind,keybind_opts)
            local btn = dashboard.button(sc,txt,keybind,keybind_opts)
            btn.opts.align_shortcut = "left"
            btn.opts.width = 100
            btn.opts.shortcut = #sc < 6 and sc .. "       =>\t\t" or sc .. " =>\t\t"

            return btn
          end
        '';
      in {
        enable = true;
        theme = null;
        layout = [
          {
            type = "padding";
            val = 2;
          }
          {
            type = "text";
            val = lib.strings.splitString "\n" (builtins.readFile ./header.txt);
            opts = {
              position = "center";
              hl = "Type";
            };
          }
          {
            type = "padding";
            val = 2;
          }
          {
            type = "group";
            val = [
              {
                type = "text";
                val = "Recent sessions";
                opts = {
                  hl = "SpecialComment";
                  shrink_margin = false;
                  position = "center";
                };
              }
              {
                type = "padding";
                val = 1;
              }
              {
                type = "group";
                val = lib.generators.mkLuaInline ''
                  function()
                    local utils = require("session_manager.utils");
                    local dashboard = require("alpha.themes.dashboard")
                    local keybinds = {"1","2","3","4","5","q","w","e","r","t"}
                    local tbl = {};
                    ${button}
                    for i, v in ipairs(utils.get_sessions()) do
                      if i == 11 then break end
                      local keybind = keybinds[i]
                      local text = utils.shorten_path(v.dir)
                      local function on_press()
                          utils.load_session(v.filename)
                      end
                      local btn = button(keybind,text,on_press)
                      btn.on_press = on_press
                      table.insert(tbl, btn)
                    end

                    return tbl
                  end
                '';
                opts = {
                  shrink_margin = false;
                };
              }
            ];
          }
          {
            type = "padding";
            val = 2;
          }
          (lib.generators.mkLuaInline
            ''
              (function ()
                  local dashboard = require("alpha.themes.dashboard")
                  ${button}
                  return {
                    type = "group",
                    val = {
                        button("e", "  New file", "<cmd>ene <CR>"),
                        button("SPC f f", "󰈞  Find file"),
                        button("SPC f h", "󰊄  Recently opened files"),
                        button("SPC f r", "  Frecency/MRU"),
                        button("SPC f g", "󰈬  Find word"),
                        button("SPC f m", "  Jump to bookmarks"),
                        button("SPC s l", "  Open last session"),
                    },
                    opts = {
                        spacing = 1,
                    },
                }

              end)()
            '')
        ];
      };
      viAlias = true;
      vimAlias = true;
      telescope = {
        setupOpts.file_ignore_patterns = ["file.lock" "@girs"];
        enable = true;
      };
      snippets.luasnip.enable = true;
      notify.nvim-notify.enable = true;
      ui = {
        noice.enable = true;
        colorizer.enable = true;
        fastaction.enable = true;
      };
      session.nvim-session-manager = {
        enable = true;
        setupOpts.autoload_mode = lib.generators.mkLuaInline "sm.AutoloadMode.GitSession";
      };
      keymaps = [
        {
          key = "<ESC>";
          mode = "t";
          silent = true;
          desc = "Leave terminal mode";
          action = "<C-\\><C-n>";
        }
      ];
    };
  };
}
