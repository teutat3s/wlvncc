let
  unstable = import (fetchTarball https://github.com/nixos/nixpkgs/archive/nixos-22.11.tar.gz) { };
in
{ nixpkgs ? import <nixpkgs> {} }:
with nixpkgs; mkShell {
  buildInputs = [
    cmake
    cyrus_sasl
    gcc
    ffmpeg
    gnutls
    libGL
    libdrm
    libgcrypt
    libjpeg
    libpng
    libxkbcommon
    lzo
    mesa
    meson
    ninja
    openssl
    pkg-config
    pixman
    wayland
    zlib
  ];
}

