{ config, pkgs, ... }:

{
  home.username = "dhaines";
  home.homeDirectory = "/home/dhaines";

  programs.git = {
    enable = true;
    userName = "David Haines";
    userEmail = "dhaines@gmail.com";
  };

  home.packages = with pkgs; [
    file
    firefox
    rxvt-unicode
    terminus_font
  ];

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  home.stateVersion = "23.05";
  programs.home-manager.enable = true;
}
