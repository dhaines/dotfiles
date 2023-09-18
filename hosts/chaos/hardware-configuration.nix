# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "thunderbolt" "nvme" "usbhid"];
  boot.initrd.kernelModules = ["dm-snapshot"];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/d7a0a578-2155-44ff-a6f2-5d725630204d";
    fsType = "ext4";
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/35155848-f997-455a-ac19-1a8daffcfa3a";
    fsType = "ext4";
  };

  fileSystems."/var" = {
    device = "/dev/disk/by-uuid/3a4909c0-cacd-4c61-b152-1a4f3d4df23d";
    fsType = "ext4";
  };

  fileSystems."/var/lib/docker" = {
    device = "/dev/disk/by-uuid/df0e2d4d-aaf2-495f-af44-86b1d32b2cb7";
    fsType = "ext4";
  };

  fileSystems."/var/lib/libvirt" = {
    device = "/dev/disk/by-uuid/a1631437-72c6-4d42-8aea-2acd88a860c2";
    fsType = "ext4";
  };

  fileSystems."/opt" = {
    device = "/dev/disk/by-uuid/d6032804-6b87-4734-a2f4-29b56d830d90";
    fsType = "ext4";
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/e96b8736-f8df-41b1-8b83-34bb003cd142";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/9611-8998";
    fsType = "vfat";
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/e2e44089-cb08-43c2-8cb3-40c73267eca4";}
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  # networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp121s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.acpilight.enable = true;
}
