{ config, pkgs, ... }:

{
  home.username = "dhaines";
  home.homeDirectory = "/home/dhaines";

  programs.git = {
    enable = true;
    userName = "David Haines";
    userEmail = "dhaines@gmail.com";
  };

  home.packages = with pkgs; [];

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.urxvt = {
    enable = true;
    extraConfig = {
      background = "black";
      foreground = "white";
    };
  };

  home.stateVersion = "23.05";
  programs.home-manager.enable = true;
}
