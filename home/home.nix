{ config, pkgs, ... }:
{
  home.stateVersion = "24.05";
  home.username = "regular";
  home.homeDirectory = "/home/regular";

  imports = [ 
    ./modules/bspwm.nix
    ./modules/sxhkd.nix
    ./modules/xserver.nix
    ./modules/vim.nix
    ./modules/fonts.nix
  ];
}
