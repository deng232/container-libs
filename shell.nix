{
  pkgs ? import <nixpkgs> { },
}:
let
  jail-nix = import (builtins.fetchGit {
    url = "https://git.sr.ht/~alexdavid/jail.nix";
    #      rev = "42b355c38ca63dab4904acc5c0d95f17954a8c9b";
    ref = "main";
  }) { };
  jail = jail-nix.init pkgs;
  codex-jailed = import ./jail.nix { inherit jail pkgs; };
in

pkgs.mkShell {
  packages = with pkgs; [
    go
    codex-jailed
    slirp4netns
  ];

  shellHook = ''
    export CC=clang
    export CXX=clang++
    echo "Meson dev shell ready"
    echo "Run: meson setup build && meson compile -C build"
  '';
}
