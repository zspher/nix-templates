{
  description = "latex template";
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
        ];

        nativeBuildInputs = with pkgs; [
          (texliveBasic.withPackages (ps:
            with ps; [
              latexmk
            ]))
        ];
        buildInputs = with pkgs; [];
      };
    });
  };
}
