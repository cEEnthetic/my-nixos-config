{ ... }:
{
  programs.fuzzel.enable = true;
  programs.alacritty = {
    enable = true;
    settings.window.decorations = "None";
  };
  xdg.configFile."niri/config.kdl".source = ./niri.kdl;
}
