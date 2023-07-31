{ config, pkgs, lib, ... }:

{
  users.mutableUsers = false;
  users.users.dhaines.initialPassword = "1234qwer";
}
