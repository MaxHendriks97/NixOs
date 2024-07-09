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
    { key = "<leader><leader>"; action.__raw = "function() require('telescope.builtin').find_files({ find_command = {'rg', '--files', '--no-ignore', '--hidden', '-g', '!.git' }, path_display = { 'absolute' }, wrap_results = true}) end"; options.desc = "Find project file"; }
    { key = "<leader>ff"; action.__raw = "function() require('telescope.builtin').find_files({cwd = '~', hidden = true}) end"; options.desc = "Find File"; }
    { key = "<leader>fs"; action = "<CMD>w<CR>"; options.desc = "Save"; }
    ##{ key = "<leader>q"; options.desc = "quit/session"; }
    { key = "<leader>qq"; action = "<CMD>qa<CR>"; options.desc = "quit"; }
    ##{ key = "<leader>b"; options.desc = "Buffer"; }
    {
      key = "<leader>bk";
      action__raw = "function() MiniBufremove.delete(0) end";
      options.desc = "Kill buffer";
    }
    {
      key = "<leader>bK";
      action = "<CMD>%bd<CR>";
    }
    { key = "<leader>bj"; action = "<CMD>BufferLinePick<CR>"; options.desc = "Jump to buffer"; }
    { key = "gt"; action = "<CMD>BufferLineCycleNext<CR>"; }
    { key = "gT"; action = "<CMD>BufferLineCyclePrev<CR>"; }
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
    {
      key = "<leader>op";
      action__raw = "function() require('mini.files').open(vim.api.nvim_buf_get_name(0)) end";
    }
    { key = "<leader>of"; action = "<CMD>lua MiniFiles.open()<CR>"; options.desc = "Open Minifiles"; }
    #{ key = "<leader>g"; options.desc = "git"; }
    { key = "<leader>gg"; action = "<CMD>Git<CR>"; options.desc = "Open Neogit"; }
    #{ key = "<leader>p"; options.desc = "Project"; }
    { key = "<leader>pp"; action = "<CMD>Telescope projects<CR>"; options.desc = "Select Project"; }
    { key = "<leader>pd"; action = "<CMD>TroubleToggle workspace_diagnostics<CR>"; options.desc = "Diagnostics"; }
    { key = "<leader>pf"; action = "<CMD>Telescope live_grep<CR>"; options.desc = "Find string in project"; }
    #{ key = "<leader>c"; options.desc = "Code"; }
    { key = "<leader>cd"; action = "<CMD>TroubleToggle document_diagnostics<CR>"; options.desc = "Diagnostics"; }
    { key = "s"; action = "<CMD>lua require('flash').jump()<CR>"; }
    { key = "S"; action = "<CMD>lua require('flash').jump()<CR>"; }
    { key = "<leader>m+"; action = "<CMD>! chuck + %<CR>"; }
    { key = "<leader>m-"; action = "<CMD>! chuck --<CR>"; }
  ];
}
