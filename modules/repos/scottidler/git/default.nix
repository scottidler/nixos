# modules/repos/scottidler/git/default.nix

{ config, pkgs, lib, ... }:

let
  USER = config.home.username;
  HOME = config.home.homeDirectory;
  path = pkgs.fetchFromGitHub {
    owner = "scottidler";
    repo = "git";
    rev = "055de809a5939b38780f5e596759254d78b30422";
    sha256 = "sha256-E6Z1LgeDG3EJl408tPC305xRBa55o2VhcP+QkOU8a9Q=";
  };
in
{
  home.activation.createLogDir = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p ${HOME}/.clone
    chown ${config.home.username} ${HOME}/.clone
    chmod 755 ${HOME}/.clone
  '';
  home.file = {
    "${HOME}/bin/clone".source = "${path}/bin/clone";
    "${HOME}/bin/clone-lite".source = "${path}/bin/clone-lite";
    "${HOME}/bin/reponame".source = "${path}/bin/reponame";
    "${HOME}/bin/git-objects".source = "${path}/bin/git-objects";
    "${HOME}/bin/ls-git-repos".source = "${path}/bin/ls-git-repos";
    "${HOME}/bin/ls-github-repos".source = "${path}/bin/ls-github-repos";
    "${HOME}/bin/default-branch".source = "${path}/bin/default-branch";
    "${HOME}/bin/stale-branches".source = "${path}/bin/stale-branches";
    "${HOME}/bin/filter-ref".source = "${path}/bin/filter-ref";
    "${HOME}/.shell-functions.d/clone.sh".source = "${path}/shell-functions.sh";
    "${HOME}/.clone/clone/clone.cfg".source = "${path}/cfg/clone.cfg";
  };
}
