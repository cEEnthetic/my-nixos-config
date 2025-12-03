{ config, pkgs, lib, ... }:
let
  # interesting
in
{
  home.packages = with pkgs; [
    sxhkd
  ];

  xdg.configFile."sxhkd/sxhkdrc".text = ''
    #Auto generated with home-manager
    super + {Return,f,space}	
      {xterm,firefox,rlaunch}

    super + alt + {q,r}	
      bspc {quit,wm -f ; pkill -USR1 -x sxhkd}

    super + w	
      bspc node -c

    {F8,F9}
      blugon -S {"-600","+600"}

    super + shift + s
      flameshot gui

    super + {_,shift + }{Left,Right,1-5}
      bspc {desktop -f,node -d} {prev,next,I,II,III,IV,V}

    super + {h,j,k,l}
      bspc node -f {west,south,north,east}

    super + ctrl + button1 ; super + ctrl + button1
      bspc node -t ~floating
  '';
}
