{ pkgs, lib, ... }:
let
  # interesting
in
{
  home.packages = with pkgs; [
    #comfortaa
    #cantarell-fonts
  ];
  fonts.fontconfig.enable = true;
}
