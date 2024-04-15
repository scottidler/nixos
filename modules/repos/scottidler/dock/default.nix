{ config, pkgs, lib, ... }:

let
  HOME = config.home.homeDirectory;
  path = pkgs.fetchFromGitHub {
    owner = "scottidler";
    repo = "dock";
      rev = "2236b0882c67a7336fcf04c2ef51b20f260e8f23";
      sha256 = "sha256-BwHxyL7MLlnAhP3eYH/QFfq7ovTSH3c5h7FbA9Aui7M=";
  };

in
{

  home.file = {
    "${HOME}/bin/dock".source = "${path}/dock";
  };
}
