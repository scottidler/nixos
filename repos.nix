# repos2.nix
{ config, lib, pkgs }:

let
  gitPath = "${pkgs.git}/bin/git"; # Explicitly define the path to git.

  cloneRepo = slug: {
    name = "clone-${slug}";
    value = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      repoPath="${config.home.homeDirectory}/.../repos/${slug}"
      if [ ! -d "$repoPath" ]; then
        echo "Cloning ${slug} into $repoPath"
        mkdir -p "$repoPath"
        ${gitPath} clone https://github.com/${slug}.git "$repoPath" # Use the full path to git
      else
        echo "$repoPath already exists; skipping."
      fi
    '';
  };

  slugs = [
    "scottidler/git"
    "scottidler/tmp"
    "scottidler/helpful"
    "scottidler/dock"
    "scottidler/pimp"
    "scottidler/ls-stat"
    "scottidler/xpndr"
    "scottidler/y2j"
    "scottidler/repo"
    "scottidler/cert-tools"
  ];

  activationScripts = builtins.listToAttrs (map cloneRepo slugs);
in {
  file = {}; # Placeholder for file attribute, maintaining structure.
  activation = activationScripts;
}

