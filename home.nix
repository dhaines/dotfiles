{
  config,
  pkgs,
  lib,
  ...
}: {
  home.username = "dhaines";
  home.homeDirectory = "/home/dhaines";

  home.sessionVariables = {
    DISABLE_TELEMETRY = "";
  };

  home.sessionPath = [
    "$HOME/.krew/bin"
  ];

  home.packages = with pkgs; [
    abiword
    ansible
    awscli2
    b612
    cdrtools
    cifs-utils
    cloud-nuke
    dex
    dig
    docker-compose
    feh
    ffmpeg
    file
    fluxcd
    fping
    freerdp
    github-cli
    gnome.gnome-font-viewer
    gnumeric
    graphviz
    ifuse
    jq
    krew
    kubectl
    kubernetes-helm
    kubevirt
    libpcap
    linux-manual
    lsof
    man-pages
    minicom
    mplayer
    ncmpc
    nerdfonts
    nfs-utils
    nmap
    openssl
    p7zip
    packer
    parallel
    pavucontrol
    pciutils
    polkit_gnome
    posix_man_pages
    pstree
    pulsarctl
    pwgen
    python311Packages.ipython
    s3cmd
    s5cmd
    scrot
    slack
    socat
    swtpm
    talosctl
    tcpdump
    teams-for-linux
    terminus_font
    terraform
    tigervnc
    tree
    unzip
    urxvt_font_size
    usbutils
    virt-manager
    virt-viewer
    wally-cli
    whois
    wireshark
    xclip
    xdotool
    yq
    zoom-us

    # LunarVim packages
    cargo
    fd
    gcc
    gnumake
    lazygit
    lemminx
    nil
    node2nix
    nodejs
    python311Full
    python311Packages.pip
    python311Packages.pynvim
    ripgrep
    tree-sitter
  ];

  home.file.".config/autostart/polkit-gnome-authentication-agent-1.desktop".text = builtins.concatStringsSep "\n" (
    builtins.filter (x: (builtins.match "^(OnlyShowIn|AutostartCondition)=.*" x) == null) (
      builtins.filter builtins.isString (
        builtins.split "\n" (
          builtins.readFile (
            pkgs.polkit_gnome + /etc/xdg/autostart/polkit-gnome-authentication-agent-1.desktop
          )
        )
      )
    )
  );

  services.autorandr.enable = true;
  programs.autorandr.enable = true;
  programs.autorandr.profiles = {
    work = {
      fingerprint = {
        eDP-1 = "00ffffffffffff004c83934100000000231e0104b51e1378020cf1ae523cb9230c505400000001010101010101010101010101010101a4c34050b0085070082088002ebd1000001ba4c34050b008fc73082088002ebd1000001b0000000f00ff0a5aff0a3c28800000000000000000fe0041544e413430594b31352d3020016202030f00e3058000e606050174600700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b7";
        DP-3 = "00ffffffffffff0030aec1620000000017200104b55d27789a52f5b04f42ab250f5054a1080081c0810081809500a9c0b300d1c0d1004dd000a0f0703e8030203500a1883100001a000000fc00503430772d32300a2020202020000000fd00324c1eaa64000a202020202020000000ff00563930414b3931300a2020202002df020326f34e0102030445104c5a616b667b7d7e23097f0783010000e305c301e6060701544e31d9650050a0402e6008200808a1883100001a565e00a0a0a0295030203500a1883100001a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000907012670300030164cd0e0186ff134f0007801f006f083d002f800700ede30086ff139f002f801f006f083200028009008b870086ff139f002f801f006f081e0002800900701d0106ff136801188060006f083d002f800800175a0106ff139f002f801f006f084d00028009005100000000000000000000000000000000000090";
      };
      config = {
        eDP-1.enable = false;
        DP-3 = {
          enable = true;
          primary = true;
          mode = "5120x2160";
        };
      };
    };
    standalone = {
      fingerprint = {
        eDP-1 = "00ffffffffffff004c83934100000000231e0104b51e1378020cf1ae523cb9230c505400000001010101010101010101010101010101a4c34050b0085070082088002ebd1000001ba4c34050b008fc73082088002ebd1000001b0000000f00ff0a5aff0a3c28800000000000000000fe0041544e413430594b31352d3020016202030f00e3058000e606050174600700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b7";
      };
      config = {
        eDP-1 = {
          enable = true;
          primary = true;
          mode = "2880x1800";
        };
      };
    };
  };

  services.ssh-agent.enable = true;

  xresources.extraConfig = builtins.readFile (
    pkgs.fetchFromGitHub {
      owner = "solarized";
      repo = "xresources";
      rev = "025ceddbddf55f2eb4ab40b05889148aab9699fc";
      sha256 = "0lxv37gmh38y9d3l8nbnsm1mskcv10g3i83j0kac0a2qmypv1k9f";
    }
    + "/Xresources.dark"
  );

  programs.dircolors.enable = true;
  programs.zathura.enable = true;

  programs.git = {
    enable = true;
    userName = "David Haines";
    userEmail = "dhaines@gmail.com";
    lfs.enable = true;
    extraConfig = {
      push.autoSetupRemote = true;
    };
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
    historyFileSize = -1;
    profileExtra = ''
      ssh-add
    '';
    initExtra = ''
      BLACK="\[\033[0;30m\]"
      LIGHT_BLACK="\[\033[1;30m\]"
      RED="\[\033[0;31m\]"
      LIGHT_RED="\[\033[1;31m\]"
      GREEN="\[\033[0;32m\]"
      LIGHT_GREEN="\[\033[1;32m\]"
      YELLOW="\[\033[0;33m\]"
      LIGHT_YELLOW="\[\033[1;33m\]"
      BLUE="\[\033[0;34m\]"
      LIGHT_BLUE="\[\033[1;34m\]"
      PURPLE="\[\033[0;35m\]"
      LIGHT_PURPLE="\[\033[1;35m\]"
      CYAN="\[\033[0;36m\]"
      LIGHT_CYAN="\[\033[1;36m\]"
      WHITE="\[\033[0;37m\]"
      LIGHT_WHITE="\[\033[1;37m\]"
      COLOR_NONE="\[\e[0m\]"

      function parse_git_branch(){
        git branch --show-current 2> /dev/null | sed -e 's/\(.*\)/(\1) /'
      }

      function set_branch() {
        branch=$(parse_git_branch)
        BRANCH="''${branch}"
      }

      function set_k8s_namespace() {
        kubectl config view --minify -o jsonpath="{.contexts[0].context.namespace}" 2> /dev/null
      }

      function set_k8s_context() {
        kubectl config current-context 2> /dev/null
      }

      function set_k8s_prompt () {
        CONTEXT=$(set_k8s_context)
        NAMESPACE=$(set_k8s_namespace)
        K8S="[''${CONTEXT}|''${NAMESPACE}] "
      }

      function set_prompt_symbol () {
        if test $1 -eq 0 ; then
            PROMPT_SYMBOL="\$"
        else
            PROMPT_SYMBOL="$1 \$"
        fi
      }

      function set_bash_prompt () {
        set_prompt_symbol $?
        set_branch
        set_k8s_prompt
        PS1="
      ''${PURPLE}''${BRANCH}''${CYAN}''${K8S}
      ''${YELLOW}\u@\h:''${COLOR_NONE} \w''${COLOR_NONE}
      ''${PROMPT_SYMBOL} "
      }

      PROMPT_COMMAND=set_bash_prompt
    '';
  };

  programs.less.enable = true;

  programs.neovim = {
    enable = true;
    withPython3 = true;
    withNodeJs = true;
    #coc.enable = true;
    plugins = with pkgs.vimPlugins; [
      #copilot-lua
      #copilot-cmp
    ];
  };

  programs.urxvt = {
    enable = true;
    extraConfig = {
      saveLines = 65535;
      "perl-ext-common" = "font-size";
    };
    fonts = [
      "xft:SauceCodePro Nerd Font Mono:pixelsize=15"
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
            --uc-sidebar-width: 35px;
            --uc-sidebar-hover-width: 210px;
            --uc-autohide-sidebar-delay: 0ms;
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
    theme.name = "Adwaita-dark";
  };

  qt = {
    enable = true;
    style.name = "adwaita-dark";
    platformTheme = "gnome";
  };

  xsession.windowManager.i3.enable = true;
  xsession.windowManager.i3.config.modifier = "Mod4";
  xsession.windowManager.i3.config.startup = [
    {command = "dex --autostart";}
  ];
  xsession.windowManager.i3.config.keybindings = let
    modifier = config.xsession.windowManager.i3.config.modifier;
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
  programs.i3status = {
    enable = true;
    modules = {
      "tztime utc" = {
        position = 7;
        settings = {
          format = "%Y-%m-%d %H:%M:%S %Z";
          timezone = "UTC";
        };
      };
      "tztime local".settings.format = "%Y-%m-%d %H:%M:%S %Z";
    };
  };
}
