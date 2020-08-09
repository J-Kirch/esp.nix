{ pkgs, stdenv }:

stdenv.mkDerivation rec {
  name = "esp8266_rtos_sdk";

  src = pkgs.fetchgit { 
    url = "https://github.com/espressif/ESP8266_RTOS_SDK"; 
    rev = "deeb395ee6a72e10d455484a074ca8e2c9b20b7c";
    sha256 = "0w87knahh202mn6ww0xipjrx1ab7z1vl10s1fdzwpvhl13b3pdhq";
  };

  buildInputs = with pkgs; [ 
    bison 
    flex 
    gperf 
    ncurses 
    pkgconfig 
  ];

  installPhase = ''
    mkdir -p $out
    cp -ra * $out
  '';

  buildPhase = ''
    # Compile conf-idf and mconf-idf
    cd tools/kconfig
    make
    cd ../..
  '';

  dontStrip = true;
}

