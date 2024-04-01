{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: 
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in
    rec {
      packages = {
        blip-buf = pkgs.callPackage ./nix/blip-buf.nix {};
        zip = pkgs.callPackage ./nix/zip.nix {};
        msf-gif = pkgs.callPackage ./nix/msf-gif.nix {};
        argparse = pkgs.callPackage ./nix/argparse.nix {};
        pocketpy = pkgs.callPackage ./nix/pocketpy.nix {};
      };

      devShells.default =
        pkgs.mkShell {
          nativeBuildInputs = (with pkgs; [
            cmake
          ]) ++ (with packages; [
          ]);
          buildInputs = (with pkgs; [
            SDL2
            SDL_gpu
            libpng
            giflib
            zlib
            lua5_3
          ]) ++ (with packages; [
            zip
            argparse
            blip-buf
            zip
            msf-gif
            pocketpy
          ]);
          shellHook = ''
            unset LD
          '';
        };
    }
    );
}
