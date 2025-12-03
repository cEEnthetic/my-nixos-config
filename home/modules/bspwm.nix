{ config, pkgs, lib, ... }:
let
  # interesting
in
{
  home.packages = with pkgs; [
    bspwm
  ];

  xdg.configFile."bspwm/bspwmrc" = {
    text = ''
      #! /usr/bin/env bash

      #Auto generated with home-manager
      feh --bg-scale .wallpaper.jpg

      bspc monitor -d I II III IV V 

      bspc rule -a firefox:Navigator desktop=any.\!occupied
      bspc rule -a firefox:firefox state=floating desktop=focused rectangle=683x384+342+192
      bspc rule -a feh state=floating 

      bspc config single_monocle true
      bspc config borderless_monocle true
      bspc config gapless_monocle true
      bspc config focused_border_color "$(grep .Xdefaults -oP '^\*\.color2:\s*\K#[0-9a-fA-F]{6}')"
    '';
    executable = true;
  };
}
