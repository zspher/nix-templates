{
  description = "a collection of templates";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      overlays = [
        (final: prev: {
          build_readme =
            let
              readme = final.callPackage ./scripts/readme.nix { flake = ./flake.nix; };
            in
            final.writeShellApplication {
              name = "build_readme";
              text = ''
                cp ${readme} README.md
              '';
            };
        })
      ];
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      perSystem =
        f:
        nixpkgs.lib.genAttrs systems (
          system:
          f {
            pkgs = import nixpkgs { inherit overlays system; };
          }
        );
    in
    {
      devShells = perSystem (
        { pkgs }:
        {
          default = pkgs.mkShell {
            packages = with pkgs; [ build_readme ];
          };
        }
      );
      templates = {
        default = {
          path = ./empty;
        };
        c-cpp = {
          path = ./c-cpp;
        };
        csharp = {
          path = ./csharp;
        };
        latex = {
          path = ./latex;
        };
        python = {
          path = ./python;
        };
        rust = {
          path = ./rust;
        };
        zig = {
          path = ./zig;
        };
      };
    };
}
