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
    feh
    file
    gnumeric
    ifuse
    jq
    kubectl
    kubernetes-helm
    mplayer
    ncmpc
    nmap
    openssl
    parallel
    pavucontrol
    pstree
    pwgen
    scrot
    slack
    talosctl
    terminus-nerdfont
    terminus_font
    terminus_font_ttf
    tree
    unzip
    virt-manager
    wally-cli
    whois
    xclip
    xdotool
    yq
    zoom-us
  ];

  programs.zathura.enable = true;

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
        search.force = true;
        settings = {
          "browser.newtabpage.enabled" = false;
          "extensions.pocket.enabled" = false;
          "browser.startup.homepage" = "chrome://browser/content/blanktab.html";
          "startup.homepage_welcome_url" = "";
          "datareporting.policy.firstRunURL" = "";
          "services.sync.username" = "dhaines@gmail.com";
          "browser.aboutConfig.showWarning" = false;
          "browser.tabs.firefox-view" = false;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "svg.context-properties.content.enabled" = true;
        };
        userChrome = ''
                     #TabsToolbar {
                       visibility: collapse;
                     }
                     #sidebar-box #sidebar-header {
                       visibility: collapse !important;
                     }

                     /* Source file https://github.com/MrOtherGuy/firefox-csshacks/tree/master/chrome/autohide_sidebar.css made available under Mozilla Public License v. 2.0
                     See the above repository for updates as well as full license text. */

                     /* Show sidebar only when the cursor is over it  */
                     /* The border controlling sidebar width will be removed so you'll need to modify these values to change width */

                     #sidebar-box{
                       --uc-sidebar-width: 40px;
                       --uc-sidebar-hover-width: 210px;
                       --uc-autohide-sidebar-delay: 600ms; /* Wait 0.6s before hiding sidebar */
                       position: relative;
                       min-width: var(--uc-sidebar-width) !important;
                       width: var(--uc-sidebar-width) !important;
                       max-width: var(--uc-sidebar-width) !important;
                       z-index:1;
                     }

                     #sidebar-box[positionend]{ direction: rtl }
                     #sidebar-box[positionend] > *{ direction: ltr }

                     #sidebar-box[positionend]:-moz-locale-dir(rtl){ direction: ltr }
                     #sidebar-box[positionend]:-moz-locale-dir(rtl) > *{ direction: rtl }

                     #main-window[sizemode="fullscreen"] #sidebar-box{ --uc-sidebar-width: 1px; }

                     #sidebar-splitter{ display: none }

                     #sidebar-header{
                       overflow: hidden;
                       color: var(--chrome-color, inherit) !important;
                       padding-inline: 0 !important;
                     }

                     #sidebar-header::before,
                     #sidebar-header::after{
                       content: "";
                       display: flex;
                       padding-left: 8px;
                     }

                     #sidebar-header,
                     #sidebar{
                       transition: min-width 115ms linear var(--uc-autohide-sidebar-delay) !important;
                       min-width: var(--uc-sidebar-width) !important;
                       will-change: min-width;
                     }
                     #sidebar-box:hover > #sidebar-header,
                     #sidebar-box:hover > #sidebar{
                       min-width: var(--uc-sidebar-hover-width) !important;
                       transition-delay: 0ms !important;
                     }

                     .sidebar-panel{
                       background-color: transparent !important;
                       color: var(--newtab-text-primary-color) !important;
                     }

                     .sidebar-panel #search-box{
                       -moz-appearance: none !important;
                       background-color: rgba(249,249,250,0.1) !important;
                       color: inherit !important;
                     }

                     /* Add sidebar divider and give it background */

                     #sidebar,
                     #sidebar-header{
                       background-color: inherit !important;
                       border-inline: 1px solid rgb(80,80,80);
                       border-inline-width: 0px 1px;
                     }

                     #sidebar-box:not([positionend]) > :-moz-locale-dir(rtl),
                     #sidebar-box[positionend] > *{
                       border-inline-width: 1px 0px;
                     }

                     /* Move statuspanel to the other side when sidebar is hovered so it doesn't get covered by sidebar */

                     #sidebar-box:not([positionend]):hover ~ #appcontent #statuspanel{
                       inset-inline: auto 0px !important;
                     }
                     #sidebar-box:not([positionend]):hover ~ #appcontent #statuspanel-label{
                       margin-inline: 0px !important;
                       border-left-style: solid !important;
                     }
                     '';
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
  xsession.windowManager.i3.config.startup = [
    { command = "firefox"; }
    { command = "slack"; }
  ];
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
  xsession.windowManager.i3.config.modes = {
    resize = {
      j = "resize grow height 5 px or 5 ppt";
      Escape = "mode default";
      h = "resize shrink width 5 px or 5 ppt";
      l = "resize grow width 5 px or 5 ppt";
      k = "resize shrink height 5 px or 5 ppt";
    };
  };
}
