{
  description = "containers-storage CLI";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      forAllSystems =
        f:
        nixpkgs.lib.genAttrs systems (
          system:
          f (
            import nixpkgs {
              inherit system;
            }
          )
        );
    in
    {
      packages = forAllSystems (
        pkgs:
        let
          go =
            pkgs.go_1_25
              or (throw "containers-storage requires Go 1.25 (storage/go.mod); use a nixpkgs with go_1_25");
        in
        rec {
          containers-storage = pkgs.stdenv.mkDerivation {
            pname = "containers-storage";
            version = "0.0.0-${self.shortRev or "dirty"}";

            src = ./.;

            nativeBuildInputs = [ go ];

            buildPhase = ''
              runHook preBuild

              export HOME="$TMPDIR"
              export GOCACHE="$TMPDIR/go-cache"
              export GOMODCACHE="$TMPDIR/go-mod-cache"
              export GOFLAGS="-mod=vendor -trimpath"

              go build \
                -compiler gc \
                -tags "exclude_graphdriver_btrfs" \
                -ldflags "-s -w" \
                -o containers-storage \
                ./storage/cmd/containers-storage

              runHook postBuild
            '';

            installPhase = ''
              runHook preInstall
              install -Dm755 containers-storage "$out/bin/containers-storage"
              runHook postInstall
            '';

            meta = {
              description = "CLI for manipulating local layer, image, and container stores";
              homepage = "https://github.com/containers/storage";
              license = pkgs.lib.licenses.asl20;
              mainProgram = "containers-storage";
              platforms = systems;
            };
          };

          default = containers-storage;
        }
      );

      apps = forAllSystems (
        pkgs:
        let
          containers-storage = {
            type = "app";
            program = "${self.packages.${pkgs.system}.containers-storage}/bin/containers-storage";
          };
        in
        {
          inherit containers-storage;
          default = containers-storage;
        }
      );
    };
}
