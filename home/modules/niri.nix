{ ... }:
{
  programs.fuzzel.enable = true;
  programs.alacritty = {
    enable = true;
    settings.window.decorations = "None";
  };
  programs.swaylock.enable = true;
  xdg.configFile."niri/config.kdl".source = ./niri.kdl;
}
