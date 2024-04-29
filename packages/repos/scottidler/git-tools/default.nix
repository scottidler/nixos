# packages/repos/scottidler/git-tools/default.nix
{ stdenv, fetchurl, autoPatchelfHook, openssl, zlib, lib }:

let
  version = "0.1.5";
  owner = "scottidler";
  repo = "git-tools";
  suffix = "linux";
  tarball = fetchurl {
    url = "https://github.com/${owner}/${repo}/releases/download/v${version}/${repo}-v${version}-${suffix}.tar.gz";
    sha256 = "0plr47wys2l5zsl4gv815iq4a59f47hjqs2l10vm10zx31nbxqii";
  };
in stdenv.mkDerivation rec {
  pname = repo;
  inherit version;

  src = tarball;

  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [ stdenv.cc.cc.lib openssl zlib ];

  dontBuild = true;

  unpackPhase = ''
    mkdir -p $out/bin
    tar -xzf $src -C $out/bin --strip-components=0
  '';

  installPhase = ''
    chmod +x $out/bin/*
  '';

  meta = with lib; {
    description = "Suite of tools for managing git repositories";
    homepage = "https://github.com/${owner}/${repo}";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux ++ lib.platforms.darwin;
    maintainers = with lib.maintainers; [ scottidler ];
  };
}
