{
  imports = [
    ./hardware-configuration.nix
  ];
  users.mutableUsers = false;
  users.users.dhaines.initialPassword = "1234qwer"; 
  networking.hostName = "impermanent";
}
