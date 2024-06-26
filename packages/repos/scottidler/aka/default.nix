# default.nix

{ stdenv, fetchurl, autoPatchelfHook, gcc, glibc, lib, libgcc, ... }:

let
  version = "0.3.17";
  owner = "scottidler";
  repo = "aka";
  suffix = "linux";
  tarball = fetchurl {
    url = "https://github.com/${owner}/${repo}/releases/download/v${version}/aka-v${version}-${suffix}.tar.gz";
    sha256 = "17cidpkvrxdmavqvgm8g9h7l2jlyxkkaamscp8y3nbccfkg1z49i";
  };
in stdenv.mkDerivation rec {
  pname = "aka";
  inherit version;

  src = tarball;

  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [ gcc glibc libgcc ];

  dontBuild = true;

  unpackPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share/zsh/site-functions
    tar -xzf $src -C $out/bin --strip-components=0
  '';

  installPhase = ''
    mv $out/bin/_aka $out/share/zsh/site-functions/
  '';

  meta = with lib; {
    description = "[a]lso [k]nown [a]s: an aliasing program";
    homepage = "https://github.com/${owner}/${repo}";
    license = licenses.mit;
    platforms = platforms.linux ++ platforms.darwin;
    maintainers = with maintainers; [ maintainers.scottidler ];
  };
}

