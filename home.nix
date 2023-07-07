{ config, pkgs, ... }:

{
  home.username = "dhaines";
  home.homeDirectory = "/home/dhaines";

  home.sessionVariables = {
    DISABLE_TELEMETRY = "";
  };

  home.packages = with pkgs; [
    awscli2
    cloud-nuke
    jq
    parallel
    pavucontrol
    slack
    terminus-nerdfont
    terminus_font
    terminus_font_ttf
  ];

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
      "xft:Terminus:size=9"
    ];
  };

  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        #search.default = "DuckDuckGo";
        #settings = {
          #"browser.newtabpage.enabled" = false;
          #"extensions.pocket.enabled" = false;
          #"browser.startup.homepage" = "chrome://browser/content/blanktab.html";
        #};
      };
    };
  };

  home.stateVersion = "23.05";
  programs.home-manager.enable = true;
}
