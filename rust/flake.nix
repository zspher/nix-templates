{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, fenix, ... }:
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
          rustToolchain =
            with fenix.packages.${pkgs.stdenv.hostPlatform.system};
            combine (
              with stable;
              [
                clippy
                rustc
                cargo
                rustfmt
                rust-src
              ]
            );
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              rustToolchain
              openssl
              pkg-config

              cargo-deny
              bacon
              rust-analyzer
            ];

            env.RUST_SRC_PATH = "${rustToolchain}/lib/rustlib/src/rust/library";
          };
        }
      );
    };
}
