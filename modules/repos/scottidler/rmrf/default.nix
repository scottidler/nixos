# modules/repos/scottidler/rmrf/default.nix
{ stdenv, fetchFromGitHub, ... }:

stdenv.mkDerivation rec {
  pname = "minimal-rmrf";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "example";
    repo = "minimal-repo";
    rev = "v${version}";
    sha256 = "0000000000000000000000000000000000000000000000000000";
  };

  installPhase = ''
    mkdir -p $out/bin
    echo "echo minimal-rmrf" > $out/bin/minimal-rmrf
    chmod +x $out/bin/minimal-rmrf
  '';

  meta = with stdenv.lib; {
    description = "A minimal test package";
    homepage = "https://example.com";
    license = licenses.mit;
  };
}

