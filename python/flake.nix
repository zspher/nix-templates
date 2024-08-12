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
          (python.withPackages (ps:
            with ps; [
            ]))
        ];

        nativeBuildInputs = with pkgs; [];
        buildInputs = with pkgs; [];
      };
    });
  };
}
