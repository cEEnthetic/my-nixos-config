{ pkgs, lib, ... }:
let
  # interesting
in
{
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-vinegar ];
  
    extraConfig = ''
      " Auto generated with home-manager
      set tabstop=2
      set shiftwidth=2
      set expandtab 
      set number 
      set ruler  
      set ai
      syntax on
      colorscheme morning
      nnoremap <C-j> <cmd>bprev<cr> 
      nnoremap <C-k> <cmd>bnext<cr> 
    '';
  };
}
