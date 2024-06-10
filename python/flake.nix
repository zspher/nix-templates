{
  description = "";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    systems = [
      "aarch64-linux"
      "x86_64-linux"
    ];
    perSystem = f:
      nixpkgs.lib.genAttrs systems (system: f {pkgs = nixpkgs.legacyPackages.${system};});
  in {
    devShells = perSystem ({pkgs}: {
      default = pkgs.mkShell {
        packages = with pkgs; [
          nodePackages_latest.pyright # LSP
          ruff-lsp # linter, formatter via LSP
          python3Packages.debugpy # debugger
        ];

        nativeBuildInputs = with pkgs; [];
        buildInputs = with pkgs; [];
      };
    });
  };
}
