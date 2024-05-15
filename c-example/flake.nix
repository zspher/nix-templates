{
  description = "example c program";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = {nixpkgs, ...}: let
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
          # lsp
          clang-tools

          # debugger
          vscode-extensions.vadimcn.vscode-lldb.adapter
        ];

        nativeBuildInputs = with pkgs; [gnumake gcc];
      };
    });
  };
}
