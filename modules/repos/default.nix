# modules/repos/default.nix

{...}:
{
  imports = [
    (import ./scottidler/git)
    (import ./scottidler/tmp)
    (import ./scottidler/repo)
    (import ./scottidler/dock)
  ];    
}
