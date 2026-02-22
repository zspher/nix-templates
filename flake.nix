{
  description = "a collection of templates";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      inherit (nixpkgs) lib;
      perSystem = lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

    in
    {
      devShells = perSystem (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            packages = [ self.packages.${system}.build_readme ];
          };
        }
      );
      packages = perSystem (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          build_readme =
            let
              readme = pkgs.callPackage ./scripts/readme.nix { flake = ./flake.nix; };
            in
            pkgs.writeShellApplication {
              name = "build_readme";
              text = ''
                cp ${readme} README.md
              '';
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
        python-uv = {
          path = ./python-uv;
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
