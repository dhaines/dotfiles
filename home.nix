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
    alejandra
    file
    firefox
    gawk
    gnused
    gnutar
    jq
    lsof
    rxvt-unicode
    strace
    terminus_font
    tree
    which
  ];

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  home.stateVersion = "23.05";
  programs.home-manager.enable = true;
}
