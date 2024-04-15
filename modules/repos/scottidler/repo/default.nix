{ config, pkgs, lib, ... }:

let
  HOME = config.home.homeDirectory;
  path = pkgs.fetchFromGitHub {
    owner = "scottidler";
    repo = "tmp";
    rev = "dd9b231e93f11a5331b1edbbd9e423831e836ada";
    sha256 = "sha256-T7QqWXAlBwyEeFNtIakQisEf2L3/Sw1IfbtSOjN0Lts=";
  };

  # Create a Python environment that includes ruamel.yaml
  pythonDeps = pkgs.python3.withPackages (ps: with ps; [ ruamel_yaml ]);

in
{
  # Ensure the custom Python environment is available
  home.packages = [
    pythonDeps
  ];

  home.file = {
    "${HOME}/bin/branch".source = "${path}/bin/branch";
    "${HOME}/bin/change".source = "${path}/bin/change";
    "${HOME}/bin/commit".source = "${path}/bin/commit";
    "${HOME}/bin/conflict".source = "${path}/bin/conflict";
    "${HOME}/bin/create".source = "${path}/bin/create";
    "${HOME}/bin/merge".source = "${path}/bin/merge";
    "${HOME}/bin/munge".source = "${path}/bin/munge";
    "${HOME}/bin/rebase".source = "${path}/bin/rebase";
    "${HOME}/bin/repo".source = "${path}/bin/repo";
    "${HOME}/bin/reset".source = "${path}/bin/reset";
    "${HOME}/bin/word".source = "${path}/bin/word";
  };
}

