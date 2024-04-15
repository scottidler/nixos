    
{ config, pkgs, lib, ... }:

let
  USER = config.home.username;
  HOME = config.home.homeDirectory;
  path = pkgs.fetchFromGitHub {
    owner = "scottidler";
    repo = "cert-tools";
    rev = "35cbad5b63f1c27d65b4febf6d1e9e40914f1bac";
    sha256 = "sha256-nnckSkJQj6ObBD9xEgvQD9ms1BpUTXxJ+b1K/lBkWzU=";
  };
in
{
  home.file = {
    "${HOME}/bin/findcert".source = "${path}/findcert";
    "${HOME}/bin/modcert".source = "${path}/modcert";
    "${HOME}/bin/ssl-compare".source = "${path}/ssl-compare";
    "${HOME}/bin/ssl-expires".source = "${path}/ssl-expires";
    "${HOME}/bin/ssl-inspect".source = "${path}/ssl-inspect";
    "${HOME}/bin/ssl-sans".source = "${path}/ssl-sans";
    "${HOME}/bin/ssl-unused".source = "${path}/ssl-unused";
    "${HOME}/bin/ssl-validity".source = "${path}/ssl-validity";
  };
}
