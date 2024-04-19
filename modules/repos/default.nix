# modules/repos/default.nix

{...}:
{
  imports = [
    #(import ./scottidler/aka)
    (import ./scottidler/cert-tools)
    (import ./scottidler/dock)
    (import ./scottidler/git)
    (import ./scottidler/helpful)
    (import ./scottidler/repo)
    (import ./scottidler/requote)
    #(import ./scottidler/rmrf)
    (import ./scottidler/tmp)
  ];    
}
