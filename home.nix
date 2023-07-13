{ config, pkgs, lib, ... }:

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
    kubectl
    kubernetes-helm
    mplayer
    ncmpc
    openssl
    parallel
    pavucontrol
    slack
    talosctl
    terminus-nerdfont
    terminus_font
    terminus_font_ttf
    unzip
    virt-manager
    xclip
    yq
    zoom-us
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
        search.default = "DuckDuckGo";
        settings = {
          "browser.newtabpage.enabled" = false;
          "extensions.pocket.enabled" = false;
          "browser.startup.homepage" = "chrome://browser/content/blanktab.html";
          "startup.homepage_welcome_url" = "";
          "datareporting.policy.firstRunURL" = "";
          "services.sync.username" = "dhaines@gmail.com";
          "browser.aboutConfig.showWarning" = false;
          "browser.tabs.firefox-view" = false;
        };
      };
    };
  };

  home.stateVersion = "23.05";
  programs.home-manager.enable = true;

  gtk = {
    enable = true;
    gtk2.extraConfig = "gtk-application-prefer-dark-theme = true";
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  xsession.windowManager.i3.enable = true;
  xsession.windowManager.i3.config.modifier = "Mod4";
  xsession.windowManager.i3.config.keybindings =
    let modifier = config.xsession.windowManager.i3.config.modifier;
    in
    lib.mkOptionDefault {
      "${modifier}+h" = "focus left";
      "${modifier}+j" = "focus down";
      "${modifier}+k" = "focus up";
      "${modifier}+l" = "focus right";
      "${modifier}+Shift+h" = "move left";
      "${modifier}+Shift+j" = "move down";
      "${modifier}+Shift+k" = "move up";
      "${modifier}+Shift+l" = "move right";
      "${modifier}+v" = null;
      "${modifier}+backslash" = "split toggle";
      "${modifier}+d" = "exec ${pkgs.i3}/bin/i3-dmenu-desktop";
      "${modifier}+Shift+d" = "exec ${pkgs.dmenu}/bin/dmenu_run";
    };
}
