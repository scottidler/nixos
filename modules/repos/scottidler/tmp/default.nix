{ config, pkgs, lib, ... }:

let
  HOME = config.home.homeDirectory;
  path = pkgs.fetchFromGitHub {
    owner = "scottidler";
    repo = "tmp";
    rev = "03850b057066f525a827405ec6316a528b25ae91";
    sha256 = "sha256-2sEJEVvUaZsb1InvUQ6DONYgG68WFm2eraqfWBRhWsM=";
  };
  
  # Create a Python environment that includes ruamel.yaml
  pythonDeps = pkgs.python3.withPackages (ps: with ps; [ ruamel_yaml ]);

in
{
  # Ensure the custom Python environment is available
  home.packages = [ pythonDeps ];

  home.file = {
    "${HOME}/bin/tmp".source = "${path}/bin/tmp";
  };
}

