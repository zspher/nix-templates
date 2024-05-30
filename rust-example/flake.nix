{
  description = "example rust program";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  inputs.rust-overlay.url = "github:oxalica/rust-overlay";
  inputs.rust-overlay.inputs.nixpkgs.follows = "nixpkgs";

  outputs = {
    self,
    nixpkgs,
    rust-overlay,
  }: let
    systems = [
      "aarch64-linux"
      "x86_64-linux"
    ];
    perSystem = f:
      nixpkgs.lib.genAttrs systems (system:
        f {
          pkgs = import nixpkgs {
            inherit system;
            overlays = [(import rust-overlay)];
          };
        });
  in {
    devShells = perSystem ({pkgs}: {
      default = pkgs.mkShell {
        packages = [];
        nativeBuildInputs = [
          pkgs.rust-bin.stable.latest.default
        ];
      };
    });
  };
}
