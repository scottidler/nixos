# default.nix

{ stdenv, fetchurl, autoPatchelfHook, gcc, glibc, lib, libgcc, ... }:

let
  version = "0.4.2";
  owner = "scottidler";
  repo = "aka";
  suffix = "linux";
  tarball = fetchurl {
    url = "https://github.com/${owner}/${repo}/releases/download/v${version}/aka-v${version}-${suffix}.tar.gz";
    sha256 = "05l5h2k2b6y9vaqfcwh3lhaj9pcmgl62286mh9cbhd415qd0n1jx";
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

