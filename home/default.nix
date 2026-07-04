{ pkgs, ... }:
{
  home.stateVersion = "24.05";
  home.username = "regular";
  home.homeDirectory = "/home/regular";

  programs.fuzzel.enable = true;
  programs.alacritty.enable = true;

  imports = [ 
    ./modules/vim.nix
    ./modules/fonts.nix
    ./modules/tmux.nix
    ./modules/gitlfs.nix
    ./modules/picard.nix
    ./modules/syncthing.nix
    ./modules/anki.nix
    ./modules/niri.nix
  ];
}
