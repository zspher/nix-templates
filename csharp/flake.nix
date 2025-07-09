{
  description = "example c# program";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs =
    {
      self,
      nixpkgs,
    }:
    let
      systems = [
        "x86_64-linux" # 64-bit Intel/AMD Linux
        "aarch64-linux" # 64-bit ARM Linux
        "x86_64-darwin" # 64-bit Intel macOS
        "aarch64-darwin" # 64-bit ARM macOS
      ];

      perSystem =
        f: nixpkgs.lib.genAttrs systems (system: f { pkgs = nixpkgs.legacyPackages.${system}; });
    in
    {
      devShells = perSystem (
        { pkgs }:
        let
          dotnetPkgs = (
            with pkgs.dotnetCorePackages;
            combinePackages [
              sdk_9_0
              runtime_9_0-bin
            ]
          );
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              netcoredbg
              csharpier
              dotnetPkgs
            ];

            shellHook = ''
              export DOTNET_ROOT=${dotnetPkgs}
              # export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${pkgs.lib.makeLibraryPath [ ]}
            '';
          };
        }
      );
    };
}
