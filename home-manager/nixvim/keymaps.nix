{ config, lib, pkgs, ... }: {
  programs.nixvim.maps = {
    terminal = {
      "<ESC>" = {
        action = "<C-\\><C-n>";
      };
    };
    normal = {
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
  };
}
