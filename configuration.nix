# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).
{
  config,
  pkgs,
  lib,
  ...
}: {
  # services.qemuGuest.enable = true;
  # users.mutableUsers = false;
  # users.users.dhaines.initialPassword = "1234qwer";
  # virtualisation.vmVariant = {
  #   virtualisation = {
  #     memorySize = 2048;
  #     cores = 2;
  #   };
  # };

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = ["nix-command" "flakes"];
    tarball-ttl = 0;
    trusted-users = ["dhaines"];
  };

  environment.systemPackages = with pkgs; [
    git
    curl
  ];

  environment.localBinInPath = true;

  environment.variables = {
    EDITOR = "vim";
  };

  environment.etc = {
    "ovmf/edk2-x86_64-secure-code.fd" = {
      source = config.virtualisation.libvirtd.qemu.package + "/share/qemu/edk2-x86_64-secure-code.fd";
    };
    "lvm/lvm.conf".text = ''
      devices {
        issue_discards = 1
      }
    '';
    "resolv.conf".source = lib.mkForce "/run/systemd/resolve/resolv.conf";
    "systemd/network/99-ethernet-default-dhcp.network.d/50-use-domains.conf".text = ''
      [Network]
      MulticastDNS=resolve

      [DHCP]
      UseDomains=true
    '';
    "systemd/network/99-wireless-client-dhcp.network.d/50-use-domains.conf".text = ''
      [Network]
      MulticastDNS=resolve

      [DHCP]
      UseDomains=true
    '';
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.configurationLimit = 16;
  boot.loader.systemd-boot.editor = false;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfree = true;

  hardware.keyboard.zsa.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.supportedFilesystems = ["nfs"];

  systemd.network.enable = true;
  systemd.network.wait-online.anyInterface = true;

  time.timeZone = "EST5EDT";

  documentation.man.generateCaches = true;

  hardware.bluetooth.enable = true;

  services.xserver.enable = true;
  services.xserver.xkbOptions = "ctrl:nocaps";
  services.xserver.libinput.touchpad.tapping = false;
  services.xserver.libinput.touchpad.middleEmulation = false;

  services.xserver.windowManager.i3.enable = true;

  networking.useNetworkd = true;

  networking.wireless.enable = true;
  networking.wireless.userControlled.enable = true;

  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.ovmf.packages = [pkgs.OVMFFull.fd];
  virtualisation.libvirtd.qemu.swtpm.enable = true;
  networking.firewall.checkReversePath = false;

  virtualisation.docker = {
    enable = true;
    package = pkgs.docker_24;
  };

  services.resolved.enable = true;

  services.openssh.enable = true;

  security.sudo.wheelNeedsPassword = false;
  security.rtkit.enable = true;
  security.polkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.usbmuxd.enable = true;

  services.rpcbind.enable = true;

  users.users.dhaines = {
    isNormalUser = true;
    extraGroups = ["wheel" "libvirtd" "docker" "video"]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [];
  };

  programs._1password.enable = true;
  programs._1password-gui.enable = true;
  programs._1password-gui.polkitPolicyOwners = ["dhaines"];

  programs.dconf.enable = true;

  programs.vim.defaultEditor = true;
  programs.vim.package = pkgs.vim-full;

  programs.npm.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
