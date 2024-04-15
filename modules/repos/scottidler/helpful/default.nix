    
{ config, pkgs, lib, ... }:

let
  USER = config.home.username;
  HOME = config.home.homeDirectory;
  path = pkgs.fetchFromGitHub {
    owner = "scottidler";
    repo = "helpful";
    rev = "69206bbc68bf710cf676d616fc0c77798fc586a1";
    sha256 = "sha256-a/vtnSttJIytIRC08+9Tam53Bz4ILV1b47VazD6Jd18=";
  };
in
{
  home.file = {
    "${HOME}/bin/cidr".source = "${path}/bin/cidr";
    "${HOME}/bin/prepend".source = "${path}/bin/prepend";
    "${HOME}/bin/say".source = "${path}/bin/say";
    "${HOME}/bin/speedtest".source = "${path}/bin/speedtest";
    "${HOME}/bin/tab".source = "${path}/bin/tab";
    "${HOME}/bin/tab2".source = "${path}/bin/tab2";
    "${HOME}/bin/tab4".source = "${path}/bin/tab4";
    "${HOME}/bin/toggle".source = "${path}/bin/toggle";
    "${HOME}/bin/toggle-remote-url".source = "${path}/bin/toggle-remote-url";
  };
}
