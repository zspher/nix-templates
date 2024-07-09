{
  description = "example c# program";
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
          netcoredbg # debugger
        ];

        buildInputs = with pkgs; [dotnet-sdk_8];

        # shellHook = with pkgs; ''
        #   export DOTNET_ROOT=${dotnet-sdk_8}
        #   export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${lib.makeLibraryPath []}
        # '';
      };
    });
  };
}
