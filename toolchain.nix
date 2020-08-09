{ pkgs, stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "toolchain";

  src = fetchurl {
    url = "https://dl.espressif.com/dl/xtensa-lx106-elf-linux64-1.22.0-100-ge567ec7-5.2.0.tar.gz";
    sha256 = "1574p170cpd46pz5mpi22jsfqrj5bd7xys1gj5fzihjr6y2h4skh";
  };

  buildInputs = with pkgs; [ 
    autoPatchelfHook 
    stdenv.cc.cc.lib 
    zlib 
    ncurses5 
    python27 
  ];

  installPhase = ''
    mkdir -p $out
    cp -ra * $out
  '';

  dontStrip = true;
}
