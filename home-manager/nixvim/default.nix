{ config, lib, pkgs, ... }: {
  imports = [
    ./alpha.nix
  ];
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
    maps.terminal = {
      "<ESC>" = {
        action = "<C-\\><C-n>";
      };
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
      "<leader>b" = {
        desc = "Buffer";
      };
      "<leader>bk" = {
        action = "<CMD>bd<CR>";
        desc = "Kill buffer";
      };
      "<leader>bj" = {
        action = "<CMD>BufferLinePick<CR>";
        desc = "Jump to buffer";
      };
      "gt" = {
        action = "<CMD>bn<CR>";
      };
      "gT" = {
        action = "<CMD>bp<CR>";
      };
      "<leader>w" = {
        desc = "Window";
      };
      "<leader>ws" = {
        action = "<CMD>vs<CR>";
        desc = "Vertical split";
      };
      "<leader>wc" = {
        action = "<CMD>q<CR>";
        desc = "Close window";
      };
      "<leader>w<up>" = {
        action = "<CMD>wincmd k<CR>";
      };
      "<leader>w<down>" = {
        action = "<CMD>wincmd j<CR>";
      };
      "<leader>w<left>" = {
        action = "<CMD>wincmd h<CR>";
      };
      "<leader>w<right>" = {
        action = "<CMD>wincmd l<CR>";
      };
      "<leader>o" = {
        desc = "open";
      };
      "<leader>op" = {
        action = "<CMD>CHADopen<CR>";
      };
      "<leader>g" = {
        desc = "git";
      };
      "<leader>gg" = {
        action = "<CMD>LazyGit<CR>";
        desc = "Open LazyGit";
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
      termguicolors = true;
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
        suggestion.enabled = true;
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
          { name = "calc"; }
        ];
        mapping = {
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<Tab>" = {
            modes = [ "i" "s" ];
            action = ''
              function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                elseif luasnip.expandable() then
                  luasnip.expand()
                elseif luasnip.expand_or_jumpable() then
                  luasnip.expand_or_jump()
                elseif check_backspace() then
                  fallback()
                else
                  fallback()
                end
              end
            '';
          };
        };
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
      project-nvim.enable = true;
      telescope = {
        enable = true;
        extensions = {
          project-nvim.enable = true;
        };
      };
      leap.enable = true;
      bufferline = {
        enable = true;
        showCloseIcon = false;
      };
      auto-session.enable = true;
      chadtree.enable = true;
      comment-nvim.enable = true;
      toggleterm = {
        enable = true;
        insertMappings = false;
        openMapping = "<leader>ot";
        terminalMappings = false;
      };
    };
    extraPlugins = [
      pkgs.vimPlugins.lazygit-nvim
    ];
  };
}
