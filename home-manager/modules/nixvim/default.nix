{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./keymaps.nix
    ./alpha.nix
    ./lsp.nix
  ];
  home.packages = [
    pkgs.nodePackages.jsonlint
    pkgs.yamllint
    pkgs.nodePackages.markdownlint-cli
    pkgs.shellcheck
    pkgs.prettierd
    pkgs.nodePackages.prettier
  ];
  programs.nixvim = {
    enable = true;
    opts = {
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
    plugins = {
      which-key = {
        enable = true;
        settings.icons = {
          breadcrumb = "»";
          separator = "➜";
          group = "+";
        };
      };
      treesitter = {
        enable = true;
        settings = {
          indent.enable = true;
          highlight = {
            additional_vim_regex_highlighting = false;
            enable = true;
          };
        };
      };
      treesitter-context = {
        enable = true;
        settings = {
          max_lines = 5;
          trim_scope = "inner";
          mode = "topline";
        };
      };
      treesitter-refactor.enable = true;
      lint = {
        enable = true;
        lintersByFt = {
          python = [ "flake8" ];
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
      nix.enable = true;
      nvim-ufo = {
        enable = false;
      };
      nvim-jdtls = {
        enable = true;
        cmd = [
          "${pkgs.jdt-language-server}/bin/jdtls"
          "-data"
          "/home/maxh/.cache/jdtls/workspace"
          "-configuration"
          "/home/maxh/.cache/jdtls/config"
        ];
      };
      project-nvim = {
        enable = true;
        enableTelescope = true;
      };
      telescope = {
        enable = true;
        settings.defaults = {
          path_display = [ "smart" ];
        };
        extensions = {
          fzf-native.enable = true;
        };
      };
      flash = {
        enable = true;
        settings.modes.search.enabled = false;
      };
      bufferline = {
        enable = true;
        settings.options.show_close_icon = false;
      };
      comment.enable = true;
      toggleterm = {
        enable = true;
        settings = {
          open_mapping = "[[<leader>ot]]";
          insert_mappings = false;
          terminal_mappings = false;
        };
      };
      fidget.enable = false;
      gitsigns.enable = true;
      intellitab.enable = true;
      ledger.enable = true;
      fugitive.enable = true;
      lualine = {
        enable = true;
        settings.extensions = [
          "toggleterm"
          "trouble"
          #"nvim-dap-ui"
        ];
      };
      mini = {
        enable = true;
        mockDevIcons = true;
        modules = {
          ai = { };
          basics = { };
          bufremove = { };
          cursorword = { };
          indentscope = { };
          pairs = { };
          trailspace = { };
          operators = { };
          surround = { };
          files = {
            mappings = {
              go_in = "<Right>";
              go_out = "<Left>";
            };
          };
          icons = { };
        };
      };
      trouble = {
        enable = true;
      };
      ts-autotag.enable = true;
      noice = {
        enable = true;
      };
      notify.enable = true;
      nvim-colorizer.enable = true;
      rainbow-delimiters.enable = true;
      rustaceanvim.enable = true;
      spider.enable = true;
      todo-comments.enable = true;
      hardtime = {
        enable = false;
        settings.disabledKeys = {
          "<Up>" = [ ];
          "<Down>" = [ ];
          "<Left>" = [ ];
          "<Right>" = [ ];
        };
      };
    };
    extraPlugins = [
      pkgs.vimPlugins.dressing-nvim
      pkgs.vimPlugins.zen-mode-nvim
    ];
  };
}
