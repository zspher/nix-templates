{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs =
    { nixpkgs, ... }:
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
          dotnetPkgs = (
            with pkgs.dotnetCorePackages;
            combinePackages [
              sdk_10_0
              runtime_10_0-bin
            ]
          );
        in
        {
          default = pkgs.mkShellNoCC {
            packages = with pkgs; [
              dotnetPkgs
            ];

            env.DOTNET_ROOT = "${dotnetPkgs}/share/dotnet";
            env.LD_LIBRARY_PATH = "$LD_LIBRARY_PATH:${lib.makeLibraryPath [ pkgs.icu ]}";
          };
        }
      );
    };
}
