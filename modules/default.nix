# modules/default.nix

{...}:
{
  imports = [
    (import ./neovim)
    (import ./firefox)
    (import ./repos)
  ];    
}
