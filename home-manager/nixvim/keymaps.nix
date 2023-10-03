{ config, lib, pkgs, ... }: {
  programs.nixvim.globals = {
    mapleader = " ";
    maplocalleader = " ";
  };
  programs.nixvim.keymaps = [
    { key = "<ESC>"; action = "<C-\\><C-n>"; mode = "t"; }
    { key = "w"; action = "<CMD>lua require('spider').motion('w')<CR>"; }
    { key = "e"; action = "<CMD>lua require('spider').motion('e')<CR>"; }
    { key = "b"; action = "<CMD>lua require('spider').motion('b')<CR>"; }
    { key = "ge"; action = "<CMD>lua require('spider').motion('ge')<CR>"; }
    { key = " "; action = "<Nop>"; options.silent = true; }
    #{ key = "<leader>f"; options.desc = "File"; }
    { key = "<leader>ff"; action = "<CMD>Telescope find_files<CR>"; options.desc = "Find File"; }
    { key = "<leader>fs"; action = "<CMD>w<CR>"; options.desc = "Save"; }
    ##{ key = "<leader>q"; options.desc = "quit/session"; }
    { key = "<leader>qq"; action = "<CMD>qa<CR>"; options.desc = "quit"; }
    ##{ key = "<leader>b"; options.desc = "Buffer"; }
    { key = "<leader>bk"; action = "<CMD>lua MiniBufremove.delete(0)<CR>"; options.desc = "Kill buffer"; }
    { key = "<leader>bj"; action = "<CMD>BufferLinePick<CR>"; options.desc = "Jump to buffer"; }
    { key = "gt"; action = "<CMD>bn<CR>"; }
    { key = "gT"; action = "<CMD>bp<CR>"; }
    #{ key = "<leader>w"; options.desc = "Window"; }
    { key = "<leader>ws"; action = "<CMD>vs<CR>"; options.desc = "Vertical split"; }
    { key = "<leader>wc"; action = "<CMD>q<CR>"; options.desc = "Close window"; }
    { key = "<leader>w<up>"; action = "<CMD>wincmd k<CR>"; }
    { key = "<leader>w<down>"; action = "<CMD>wincmd j<CR>"; }
    { key = "<leader>w<left>"; action = "<CMD>wincmd h<CR>"; }
    { key = "<leader>w<right>"; action = "<CMD>wincmd l<CR>"; }
    { key = "<leader>wv"; action = "<CMD>vsplit<CR>"; options.desc = "Vertical split"; }
    { key = "<leader>wh"; action = "<CMD>split<CR>"; options.desc = "Horizontal split"; }
    #{ key = "<leader>o"; options.desc = "open"; }
    { key = "<leader>op"; action = "<CMD>CHADopen<CR>"; }
    { key = "<leader>of"; action = "<CMD>lua MiniFiles.open()<CR>"; options.desc = "Open Minifiles"; }
    #{ key = "<leader>g"; options.desc = "git"; }
    { key = "<leader>gg"; action = "<CMD>Neogit<CR>"; options.desc = "Open Neogit"; }
    #{ key = "<leader>p"; options.desc = "Project"; }
    { key = "<leader>pp"; action = "<CMD>Telescope projects<CR>"; options.desc = "Select Project"; }
    { key = "<leader>pd"; action = "<CMD>TroubleToggle workspace_diagnostics<CR>"; options.desc = "Diagnostics"; }
    { key = "<leader>pf"; action = "<CMD>Telescope live_grep<CR>"; options.desc = "Find string in project"; }
    #{ key = "<leader>c"; options.desc = "Code"; }
    { key = "<leader>cd"; action = "<CMD>TroubleToggle document_diagnostics<CR>"; options.desc = "Diagnostics"; }
  ];
}
