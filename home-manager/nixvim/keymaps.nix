{ config, lib, pkgs, ... }: {
  programs.nixvim.globals = {
    mapleader = " ";
    maplocalleader = " ";
  };
  programs.nixvim.maps = {
    terminal = {
      "<ESC>" = {
        action = "<C-\\><C-n>";
      };
      "w".action = "<CMD>lua require('spider').motion('w')<CR>";
      "e".action = "<CMD>lua require('spider').motion('e')<CR>";
      "b".action = "<CMD>lua require('spider').motion('b')<CR>";
      "ge".action = "<CMD>lua require('spider').motion('ge')<CR>";
    };
    normalVisualOp = {
      "w".action = "<CMD>lua require('spider').motion('w')<CR>";
      "e".action = "<CMD>lua require('spider').motion('e')<CR>";
      "b".action = "<CMD>lua require('spider').motion('b')<CR>";
      "ge".action = "<CMD>lua require('spider').motion('ge')<CR>";
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
        action = "<CMD>lua MiniBufremove.delete(0)<CR>";
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
      "<leader>wv" = {
        desc = "Vertical split";
        action = "<CMD>vsplit<CR>";
      };
      "<leader>wh" = {
        desc = "Horizontal split";
        action = "<CMD>split<CR>";
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
        action = "<CMD>Neogit<CR>";
        desc = "Open Neogit";
      };
      "<leader>p" = {
        desc = "Project";
      };
      "<leader>pp" = {
        action = "<CMD>Telescope projects<CR>";
        desc = "Select Project";
      };
      "<leader>c" = {
        desc = "Code";
      };
      "<leader>cd" = {
        action = "<CMD>Trouble<CR>";
        desc = "Diagnostics";
      };
    };
  };
}
