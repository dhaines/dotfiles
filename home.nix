{ config, pkgs, ... }:

{
  home.username = "dhaines";
  home.homeDirectory = "/home/dhaines";

  home.packages = with pkgs; [terminus-nerdfont neovim];

  programs.git = {
    enable = true;
    userName = "David Haines";
    userEmail = "dhaines@gmail.com";
    lfs.enable = true;
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    historyControl = [
      "ignoredups"
      "ignorespace"
    ];
    historyIgnore = [
      "fg"
      "history"
      "ls"
      "pwd"
    ];
  };

  programs.less.enable = true;

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
    profiles = {
      default = {
        search.default = "DuckDuckGo";
        settings = {
          "browser.newtabpage.activity-stream.discoverystream.saveToPocketCard.enabled" = false;
          "browser.newtabpage.activity-stream.discoverystream.sendToPocket.enabled" = false;
          "browser.newtabpage.activity-stream.feeds.system.topstories" = false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.havePinned" = "";
        };
      };
    };
  };

  home.stateVersion = "23.05";
  programs.home-manager.enable = true;
}
