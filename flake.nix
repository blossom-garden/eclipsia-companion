{
  description = "Beet enviroment for the Eclipsia Companion Datapack";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      perSystem =
        { pkgs, ... }:
        {
          devShells.default =
            let
              pyPkgs = with pkgs.python314Packages; [ numpy ];
            in
            pkgs.mkShell {
              buildInputs =
                with pkgs;
                [
                  pkg-config
                  uv
                ]
                ++ pyPkgs;
            };
        };
    };
}
