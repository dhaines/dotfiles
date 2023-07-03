{ config, pkgs, ... }:

{
  home.username = "dhaines";
  home.homeDirectory = "/home/dhaines";

  home.packages = with pkgs; [terminus-nerdfont];

  programs.git = {
    enable = true;
    userName = "David Haines";
    userEmail = "dhaines@gmail.com";
  };

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
      "xft:Terminess Nerd Font:size=10"
    ];
  };

  programs.firefox = {
    enable = true;
  };

  nix.settings = {
    "tarball-ttl" = 60;
  };

  home.stateVersion = "23.05";
  programs.home-manager.enable = true;
}
