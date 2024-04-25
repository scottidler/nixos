# modules/repos/default.nix

{ pkgs, ...}:
{
  imports = [
    ./scottidler/cert-tools
    ./scottidler/dock
    ./scottidler/helpful
    ./scottidler/repo
    ./scottidler/tmp
  ];    
}
