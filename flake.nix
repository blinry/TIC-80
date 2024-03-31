{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: {
      devShells.default =
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        pkgs.mkShell {
          nativeBuildInputs = (with pkgs; [ cmake ]);
          buildInputs = (with pkgs; [
            SDL2
            SDL_gpu
          ]);
          shellHook = ''
            unset LD
            export SDLGPU_INCLUDE_DIR="${pkgs.SDL_gpu}/include/SDL2"
          '';
        };
    }
    );
}
