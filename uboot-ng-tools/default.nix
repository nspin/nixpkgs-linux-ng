{ lib, fetchgit, uboot-ng, runCommand }:

with uboot-ng;

let
  source = doSource rec {
    version = "2019.04";
    src = fetchgit {
      url = "https://github.com/u-boot/u-boot";
      rev = "v${version}";
      sha256 = "1vc6dh9a0bjwgs8x5cl282gasn0hqcvjfsipgf7hyxq5jrhl3qyg";
    };
    postPatch = ''
      sed -i '/#undef MKIMAGE_DEBUG/d' tools/mkimage.h
    '';
  };

  config = makeConfig {
    inherit source;
    target = "alldefconfig";
    allconfig = ./defconfig;
  };

in doTools rec {
  inherit source config;
}
