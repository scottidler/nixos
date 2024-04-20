# default.nix

{ stdenv, fetchurl, autoPatchelfHook, gcc, glibc, lib, libgcc, ... }:

let
  version = "0.1.4";
  owner = "scottidler";
  repo = "requote";
  suffix = "linux";
  tarball = fetchurl {
    url = "https://github.com/${owner}/${repo}/releases/download/v${version}/requote-v${version}-${suffix}.tar.gz";
    sha256 = "0495c72na8njy8gx6y43nzsv16532k7hfaf3r9g46ycjd7rkic2h";
  };
in stdenv.mkDerivation rec {
  pname = "requote";
  inherit version;

  src = tarball;

  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [ gcc glibc libgcc ];

  dontBuild = true;

  unpackPhase = ''
    mkdir -p $out/bin
    tar -xzf $src -C $out/bin --strip-components=0
  '';

  meta = with lib; {
    description = "tool for requoting double->single or single->double";
    homepage = "https://github.com/${owner}/${repo}";
    license = licenses.mit;
    platforms = platforms.linux ++ platforms.darwin;
    maintainers = with maintainers; [ maintainers.scottidler ];
  };
}

