{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    pyproject-nix = {
      url = "github:pyproject-nix/pyproject.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, pyproject-nix, ... }:
    let
      inherit (nixpkgs) lib;
      perSystem = lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      projectRoot = ./.;
      project =
        if builtins.pathExists (projectRoot + "/pyproject.toml") then
          pyproject-nix.lib.project.loadPyproject { inherit projectRoot; }
        else
          null;
    in
    {
      devShells = perSystem (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          python = pkgs.python3;
          pythonEnv =
            if project != null then
              python.withPackages (project.renderers.withPackages { inherit python; })
            else
              python;
        in
        {
          default = pkgs.mkShellNoCC {
            packages = with pkgs; [
              pythonEnv
            ];
          };
        }
      );
    };
}
