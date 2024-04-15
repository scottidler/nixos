{ config, pkgs, lib }:
let
  HOME = config.home.homeDirectory;
  repos = [
    {
      owner = "scottidler";
      repo = "cert-tools";
      rev = "35cbad5b63f1c27d65b4febf6d1e9e40914f1bac";
      sha256 = "sha256-nnckSkJQj6ObBD9xEgvQD9ms1BpUTXxJ+b1K/lBkWzU=";
      links = {
        "findcert" = "${HOME}/bin/findcert";
        "modcert" = "${HOME}/bin/modcert";
        "ssl-compare" = "${HOME}/bin/ssl-compare";
        "ssl-inspect" = "${HOME}/bin/ssl-inspect";
        "ssl-sans" = "${HOME}/bin/ssl-sans";
        "ssl-validity" = "${HOME}/bin/ssl-validity";
      };
    }
    {
      owner = "scottidler";
      repo = "dock";
      rev = "520a4c4723a6d161cc1b328248ec66c62f161aaf";
      sha256 = "sha256-Bt8mlKMlWFTc8qOOpwOO12QvHQk3rl9Huj+XZMb8mZ0=";
      links = {
        "dock" = "${HOME}/bin/dock";
      };
    }
    {
      owner = "scottidler";
      repo = "xpndr";
      rev = "04ca06b448ee71ea5450324d2b5d5fdb99826e49";
      sha256 = "sha256-MliR/r9AEq+0/uJcVvQbB1TQZ+/xxQnmm0b2LI7nmV8=";
      links = {
        "xpndr" = "${HOME}/bin/xpndr";
      };
    }
    {
      owner = "awslabs";
      repo = "awscli-aliases";
      rev = "5357e18bc27b42a827b6780564ea873a72ca1f01";
      sha256 = "sha256-E2tRNEQaboeCm+Od0BPSwm2hEiFzFtK+pFLEg7t0FUg=";
      links = {
        "alias" = "${HOME}/.awscli-aliases";
      };
    }
    {
      owner = "awslabs";
      repo = "git-secrets";
      rev = "cc9f8185ba85bea28cf64326e10ae2c5be9cc080";
      sha256 = "sha256-CsYapHFx10rJkXj3xjL4vlVNZh3T9emZQRdCFcmJa/Y=";
      links = {
        "git-secrets" = "${HOME}/bin/git-secrets";
      };
    }
  ];

  applyMappings = repo: let
    path = pkgs.fetchFromGitHub {
      inherit (repo) owner repo rev sha256;
    };
  in
    lib.mapAttrs' (file: target: lib.nameValuePair target { source = "${path}/${file}"; }) repo.links;

in {
  home.file = lib.foldl' (acc: repo: acc // applyMappings repo) {} repos;
}
