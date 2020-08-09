{ pkgs ? import <nixpkgs> {} }:

let
  toolchain = (pkgs.callPackage ./toolchain.nix {});

  esp-sdk = (pkgs.callPackage ./esp.nix {});

  mach-nix = import (builtins.fetchGit { 
    url = "https://github.com/DavHau/mach-nix/"; 
    ref = "2.2.0";
  });

  esp-py-req = mach-nix.mkPython { 
    requirements = builtins.readFile "${esp-sdk}/requirements.txt";
    python = pkgs.python27;
  };

in
  pkgs.mkShell {
    buildInputs = with pkgs; [ 
      toolchain
      esp-sdk
      esp-py-req
      python27Packages.setuptools
    ];

    shellHook = ''
      export IDF_PATH="${esp-sdk}"
      . $IDF_PATH/add_path.sh

    '';
  }
