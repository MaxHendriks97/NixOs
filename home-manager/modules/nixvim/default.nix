{ config, lib, pkgs, ... }: {
  imports = [
    ./keymaps.nix
    ./alpha.nix
  ];
  home.packages = [
    pkgs.nodePackages.eslint_d
    pkgs.nodePackages.jsonlint
    pkgs.nodePackages.intelephense
    pkgs.yamllint
    pkgs.nodePackages.markdownlint-cli
    pkgs.shellcheck
  ];
  programs.nixvim = {
    enable = true;
    options = {
      number = true;
      relativenumber = true;
      termguicolors = true;
      wrap = false;
      expandtab = true;
      tabstop = 4;
      shiftwidth = 4;
      guifont = "Iosevka Nerd Font:h12";
    };
    extraConfigLua = ''
      if vim.g.neovide then
        vim.g.neovide_hide_mouse_when_typing = true
        vim.g.neovide_fullscreen = true
        vim.g.neovide_transparency = 0.9
      end
    '';
    clipboard = {
      register = "unnamedplus";
      providers.wl-copy.enable = true;
    };
    colorschemes.base16 = {
      enable = true;
      colorscheme = {
        base00 = "#${config.colorScheme.palette.base00}";
        base01 = "#${config.colorScheme.palette.base01}";
        base02 = "#${config.colorScheme.palette.base02}";
        base03 = "#${config.colorScheme.palette.base03}";
        base04 = "#${config.colorScheme.palette.base04}";
        base05 = "#${config.colorScheme.palette.base05}";
        base06 = "#${config.colorScheme.palette.base06}";
        base07 = "#${config.colorScheme.palette.base07}";
        base08 = "#${config.colorScheme.palette.base08}";
        base09 = "#${config.colorScheme.palette.base09}";
        base0A = "#${config.colorScheme.palette.base0A}";
        base0B = "#${config.colorScheme.palette.base0B}";
        base0C = "#${config.colorScheme.palette.base0C}";
        base0D = "#${config.colorScheme.palette.base0D}";
        base0E = "#${config.colorScheme.palette.base0E}";
        base0F = "#${config.colorScheme.palette.base0F}";
      };
    };
    #colorschemes.catppuccin = {
    #  enable = true;
    #  flavour = "mocha";
    #  integrations = {
    #    alpha = true;
    #    cmp = true;
    #    flash = true;
    #    gitsigns = true;
    #    lsp_trouble = true;
    #    mini.enabled = true;
    #    neotest = true;
    #    noice = true;
    #    notify = true;
    #    rainbow_delimiters = true;
    #    telescope.enabled = true;
    #    treesitter = true;
    #    treesitter_context = true;
    #    which_key = true;
    #    native_lsp.enabled = true;
    #  };
    #  terminalColors = true;
    #};
    plugins = {
      auto-session = {
        enable = true;
        autoSession = {
          enabled = true;
          enableLastSession = true;
          createEnabled = true;
        };
      };
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
          keymap.accept = "<Right>";
        };
      };
      treesitter = {
        enable = true;
        indent = true;
      };
      treesitter-context = {
        enable = true;
        maxLines = 5;
        trimScope = "inner";
        mode = "topline";
      };
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
      lint = {
        enable = true;
        lintersByFt = {
          python = [ "flake8" ];
          javascript = [ "eslint_d" ];
          json = [ "jsonlint" ];
          yaml = [ "yamllint" ];
          markdown = [ "markdownlint" ];
          sh = [ "shellcheck" ];
        };
      };
      cmp = {
        enable = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "treesitter"; }
            { name = "path"; }
            { name = "buffer"; }
            { name = "calc"; }
          ];
          mapping = {
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = ''
              cmp.mapping(
                function(fallback)
                  if cmp.visible() then
                    cmp.select_next_item()
                  else
                    fallback()
                  end
                end,
                {'i', 's'}
              )
            '';
            "<S-Tab>" = ''
              cmp.mapping(
                function(fallback)
                  if cmp.visible() then
                    cmp.select_prev_item()
                  else
                    fallback()
                  end
                end,
                {'i', 's'}
              )
            '';
          };
        };
      };
      lsp = {
        enable = true;
        keymaps.lspBuf = {
          "gd" = "definition";
          "gD" = "references";
          "gi" = "implementation";
          "<leader>ca" = "code_action";
        };
        servers = {
          nixd.enable = true;
          tsserver.enable = true;
          #phpactor.enable = true;
          intelephense = {
            enable = true;
          };
        };
      };
      nix.enable = true;
      nvim-jdtls = {
        enable = true;
        cmd = [
          "${pkgs.jdt-language-server}/bin/jdtls"
          "-data" "/home/maxh/.cache/jdtls/workspace"
          "-configuration" "/home/maxh/.cache/jdtls/config"
        ];
      };
      project-nvim.enable = true;
      telescope = {
        enable = true;
        defaults = {
          path_display = ["smart"];
        };
        extensions = {
          project-nvim.enable = true;
          fzf-native.enable = true;
        };
      };
      flash = {
        enable = true;
        modes.search.enabled = false;
      };
      bufferline = {
        enable = true;
        showCloseIcon = false;
      };
      comment-nvim.enable = true;
      toggleterm = {
        enable = true;
        insertMappings = false;
        settings = {
          open_mapping = "[[<leader>ot]]";
        };
        terminalMappings = false;
      };
      fidget.enable = false;
      gitsigns.enable = true;
      intellitab.enable = true;
      ledger.enable = true;
      fugitive.enable = true;
      lualine = {
        enable = true;
        extensions = [
          "toggleterm"
          "trouble"
          #"nvim-dap-ui"
        ];
      };
      mini = {
        enable = true;
        modules = {
          ai = {};
          basics = {};
          bufremove = {};
          cursorword = {};
          indentscope = {};
          pairs = {};
          trailspace = {};
          files = {
            mappings = {
              go_in = "<Right>";
              go_out = "<Left>";
            };
          };
        };
      };
      trouble = {
        enable = true;
        mode = "document_diagnostics";
      };
      ts-autotag.enable = true;
      noice = {
          enable = true;
      };
      notify.enable = true;
      nvim-colorizer.enable = true;
      rainbow-delimiters.enable = true;
      rust-tools.enable = true;
      spider.enable = true;
      todo-comments.enable = true;
      hardtime = {
        enable = false;
        disabledKeys = {
          "<Up>" = [];
          "<Down>" = [];
          "<Left>" = [];
          "<Right>" = [];
        };
      };
    };
    extraPlugins = with pkgs; [
      vimPlugins.dressing-nvim
      vimPlugins.zen-mode-nvim
      (pkgs.vimUtils.buildVimPlugin {
        name = "chuck-nvim";
        src = pkgs.fetchFromGitHub {
          owner = "gacallea";
          repo = "chuck-nvim";
          rev = "master";
          hash = "sha256-vWmE47paJV9S13hYR3qjCp+9DVSQEYXZ7X3NgjpFJF0=";
        };
      })
    ];
  };
}
