{
  description = "Mojo puzzles flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    cornflake.url = "github:onbernard/cornflake";
  };

  outputs = inputs@{ self, ... }:
  with inputs;
  flake-utils.lib.eachDefaultSystem (system:
  let
    pkgs = import nixpkgs { inherit system; overlay = [];};
  in
  {
    devShell = pkgs.mkShell {
      packages = with pkgs; [
        uv
        cornflake.packages.x86_64-linux.mojo
        helix
      ];
      shellHook = ''
        uv sync && source .venv/bin/activate
      '';
    };
  });
}
