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
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forEachSupportedSystem =
        f:
        nixpkgs.lib.genAttrs supportedSystems (
          system:
          f {
            pkgs = import nixpkgs { inherit overlays system; };
          }
        );
    in
    {
      devShells = forEachSupportedSystem (
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
        notebook = {
          path = ./notebook;
        };
        python = {
          path = ./python;
        };
        rust = {
          path = ./rust;
        };
      };
    };
}
