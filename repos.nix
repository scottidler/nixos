# repos2.nix
{ config, lib, pkgs, ... }:

let
  homeDir = config.home.homeDirectory;
  reposDir = "${homeDir}/.../repos";

  reposAndLinks = {
    "scottidler/git" = {
      links = {
        "bin/clone" = "~/bin/clone";
        "bin/clone-lite" = "~/bin/clone-lite";
      };
    };
    "scottidler/tmp" = {
      links = {
        "bin/tmp" = "~/bin/tmp";
      };
    };
    # Add more repositories and their links here
  };

  createRepoSymlinks = slug: repoAttrs:
    let
      repoPath = "${reposDir}/${slug}";
    in
    lib.mapAttrs' (target: linkPath: {
      name = linkPath;
      value = {
        source = "${repoPath}/${target}";
        target = builtins.replaceStrings ["~/"] [homeDir + "/"] linkPath;
      };
    }) repoAttrs.links;

  symlinkAttrs = lib.flattenAttrs (lib.mapAttrsToList createRepoSymlinks reposAndLinks);

in
{
  home.file = symlinkAttrs;

  home.activation.cloneRepos = lib.hm.dag.entryAfter [ "writeBoundary" ] (lib.concatStringsSep "\n" (lib.mapAttrsToList (slug: repoAttrs: ''
      repoPath="${reposDir}/${slug}"
      if [ ! -d "$repoPath" ]; then
        echo "Cloning ${slug} into $repoPath"
        git clone https://github.com/${slug}.git "$repoPath"
      else
        echo "Repository ${slug} already exists at $repoPath; attempting to pull changes."
        (cd "$repoPath" && git pull)
      fi
    '') reposAndLinks));
}

