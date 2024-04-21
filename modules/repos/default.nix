# modules/repos/default.nix

{ pkgs, ...}:
{
  imports = [
    ./scottidler/cert-tools
    ./scottidler/dock
    ./scottidler/git
    ./scottidler/helpful
    ./scottidler/repo
    ./scottidler/tmp
  ];    
}
