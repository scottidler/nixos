# modules/repos/scottidler/requote/default.nix

{ stdenv, fetchurl, autoPatchelfHook, gcc, glibc, lib, libgcc, ... }:

let
  version = "0.1.10";
  owner = "scottidler";
  repo = "requote";
  pname = "requote";
  suffix = "linux";
  tarball = fetchurl {
    url = "https://github.com/${owner}/${repo}/releases/download/v${version}/requote-v${version}-${suffix}.tar.gz";
    sha256 = "11cm77rin3yia6axgixgrlp7pnpd9q98n6b22gam1328x1d9mkjq";
  };
in stdenv.mkDerivation {
  inherit repo pname version;

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

