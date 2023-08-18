{ config, lib, pkgs, ... }: {
  programs.nixvim = {
    enable = true;
    clipboard = {
      register = "unnamedplus";
      providers.wl-copy.enable = true;
    };
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
    maps.normal = {
      " " = {
        action = "<Nop>";
        silent = true;
      };
      "<leader>f" = {
        desc = "File";
      };
      "<leader>ff" = {
        action = "<CMD>Telescope find_files<CR>";
        desc = "Find File";
      };
      "<leader>fs" = {
        action = "<CMD>w<CR>";
        desc = "Save";
      };
      "<leader>q" = {
        desc = "quit/session";
      };
      "<leader>qq" = {
        action = "<CMD>qa<CR>";
        desc = "quit";
      };
    };
    colorschemes.catppuccin = {
      enable = true;
      flavour = "mocha";
      integrations.which_key = true;
    };
    options = {
      number = true;
      relativenumber = true;
    };
    plugins = {
      which-key = {
        enable = true;
        icons = {
          breadcrumb = "»";
          separator = "➜";
          group = "+";
        };
      };
      copilot-lua = {
        enable = true;
        suggestion = {
          enabled = true;
          autoTrigger = true;
        };
      };
      treesitter = {
        enable = true;
        indent = true;
      };
      treesitter-context.enable = true;
      treesitter-refactor.enable = true;
      lspkind = {
        enable = true;
        cmp = {
          enable = true;
          menu = {
            nvim_lsp = "[LSP]";
            treesitter = "[TS]";
            nvim_lua = "[LUA]";
            buffer = "[BUF]";
            path = "[PATH]";
          };
        };
      };
      nvim-cmp = {
        enable = true;
        sources = [
          { name = "nvim_lsp"; }
          { name = "treesitter"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
      };
      lsp = {
        enable = true;
        servers = {
          pylsp = {
            enable = true;
            settings.plugins = {
              pyflakes.enabled = true;
            };
          };
          nixd.enable = true;
          tsserver.enable = true;
        };
      };
      nix.enable = true;
      nvim-jdtls = {
        enable = true;
        configuration = "/home/maxh/.cache/jdtls/config";
        data = "/home/maxh/.cache/jdtls/workspace";
      };
      nvim-autopairs.enable = true;
      alpha = {
        enable = true;
        layout = [
          {
            type = "padding";
            val = 1;
          }
          {
            opts = {
              hl = "Identifier";
              position = "center";
            };
            type = "text";
            val = [
              "          ▗▄▄▄       ▗▄▄▄▄    ▄▄▄▖         "
              "          ▜███▙       ▜███▙  ▟███▛         "
              "           ▜███▙       ▜███▙▟███▛          "
              "            ▜███▙       ▜██████▛           "
              "     ▟█████████████████▙ ▜████▛     ▟▙     "
              "    ▟███████████████████▙ ▜███▙    ▟██▙    "
              "           ▄▄▄▄▖           ▜███▙  ▟███▛    "
              "          ▟███▛             ▜██▛ ▟███▛     "
              "         ▟███▛               ▜▛ ▟███▛      "
              "▟███████████▛                  ▟██████████▙"
              "▜██████████▛                  ▟███████████▛"
              "      ▟███▛ ▟▙               ▟███▛         "
              "     ▟███▛ ▟██▙             ▟███▛          "
              "    ▟███▛  ▜███▙           ▝▀▀▀▀           "
              "    ▜██▛    ▜███▙ ▜██████████████████▛     "
              "     ▜▛     ▟████▙ ▜████████████████▛      "
              "           ▟██████▙       ▜███▙            "
              "          ▟███▛▜███▙       ▜███▙           "
              "         ▟███▛  ▜███▙       ▜███▙          "
              "         ▝▀▀▀    ▀▀▀▀▘       ▀▀▀▘          "
            ];
          }
          {
            type = "padding";
            val = 2;
          }
          {
            type = "group";
            val = [
              {
                command = "<CMD>Telescope find_files<CR>";
                desc = "  Find File";
                shortcut = "f";
              }
              {
                command = ":qa<CR>";
                desc = "  Quit Neovim";
                shortcut = "q";
              }
            ];
          }
          {
            type = "padding";
            val = 2;
          }
          {
            opts = {
              hl = "Constant";
              position = "center";
            };
            type = "text";
            val = "https://github.com/siph/nixvim-flake";
          }
        ];
      };
      project-nvim.enable = true;
      telescope = {
        enable = true;
        extensions = {
          project-nvim.enable = true;
        };
      };
    };
  };
}
