{ pkgs, ... }: {
  programs.nixvim.plugins = {
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
          ts_ls.enable = true;
          intelephense = {
            enable = true;
            package = pkgs.intelephense;
          };
          eslint.enable = true;
        };
      };
      none-ls = {
        enable = true;
        sources = {
          diagnostics = {
            phpstan = {
              enable = true;
            };
          };
        };
      };
      lsp-format = {
        enable = true;
        lspServersToEnable = [
          "nixd"
          "ts_ls"
          "eslint"
        ];
      };
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
  };
}
