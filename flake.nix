{
  description = "devs & ops environment for nix'ing with triton";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    devshell.url = "github:numtide/devshell";
    devshell.inputs.flake-utils.follows = "flake-utils";
    devshell.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, flake-utils, devshell, nixpkgs }:
    flake-utils.lib.simpleFlake {
      inherit self nixpkgs;
      name = "infra-project";
      overlay = devshell.overlays.default;
      shell = { pkgs }:
        pkgs.devshell.mkShell {
          # Add additional packages you'd like to be available in your devshell
          # PATH here
          imports = [ "${devshell}/extra/language/c.nix" ];
          devshell.packages = with pkgs; [
            cmake
            meson
            ninja
          ];
          language.c.includes = with pkgs; [
            cyrus_sasl
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
            openssl
            pixman
            wayland
            zlib
          ];
          bash.extra = ''
            export PATH=${pkgs.lib.getBin pkgs.wayland}/bin:$PATH
          '';
        };
    };
}
