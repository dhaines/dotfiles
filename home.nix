{ config, pkgs, ... }:

{
  home.username = "dhaines";
  home.homeDirectory = "/home/dhaines";

  programs.git = {
    enable = true;
    userName = "David Haines";
    userEmail = "dhaines@gmail.com";
  };

  home.packages = with pkgs; [terminus-nerdfont];

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.urxvt = {
    enable = true;
    extraConfig = {
      background = "Black";
      foreground = "White";
      saveLines = 65535;
    };
    fonts = [
      "xft:Terminess Nerd Font:size=12"
    ];
  };

  home.stateVersion = "23.05";
  programs.home-manager.enable = true;
}
