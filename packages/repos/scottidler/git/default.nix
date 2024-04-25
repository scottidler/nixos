# modules/repos/scottidler/git/default.nix

{ lib, python3Packages, fetchFromGitHub, stdenv, writeShellScriptBin, poetry2nix }:

let
  src = fetchFromGitHub {
    owner = "scottidler";
    repo = "git";
    rev = "9684b422a537ee68b9a7a8c2783302a0b6835f01";
    sha256 = "sha256-JFJG4UNKrJgl/Fuzgj97NkBAIKdOQUga7RRA6nJMbOU=";
  };
in poetry2nix.mkPoetryApplication {
  inherit src;
  pname = "git-tools";
  version = "0.1.0";

  # If there are any pre-build or post-install hooks or specific build inputs or patches needed, add them here:
  nativeBuildInputs = [ stdenv writeShellScriptBin ]; # Add any other build inputs required for scripts or other parts

  # Example to include non-python executables or scripts that need to be available alongside the Python package
  postInstall = ''
    mkdir -p $out/bin
    cp ${src}/bin/* $out/bin/
    chmod +x $out/bin/*
  '';
}
