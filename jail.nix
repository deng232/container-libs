{
  pkgs ? import <nixpkgs> { },
  jail,
}:
let
  codexProfile = pkgs.buildEnv {
    name = "codex-env-profile";
    paths = with pkgs; [
      codex
      zsh
      git
      coreutils
      findutils
      gnugrep
      gnused
      gawk
      curl
    ];
    ignoreCollisions = true;
  };
  name = "codex-jail";
  jail-env = jail name "${pkgs.codex}/bin/codex" (
    c: with c; [
      mount-cwd

      # Nix profile is a symlink tree; the store must be visible too.
      (readonly "/nix/store")
      (readonly codexProfile)

      (set-env "PATH" "${codexProfile}/bin")
      (set-env "HOME" "/tmp")
      (set-env "SHELL" "${pkgs.zsh}/bin/zsh")
      network
      (add-runtime "export BROWSER=firefox")
      open-urls-in-browser
      # If your jail DSL supports argv only:
      #(set-argv [ "-i" ])
    ]
  );

  codex-jail-netns = pkgs.writeShellScriptBin "codex-jailed" ''
    exec ${pkgs.rootlesskit}/bin/rootlesskit \
      --net=slirp4netns \
      --port-driver=builtin \
      -p 127.0.0.1:1455:1455/tcp \
      ${jail-env}/bin/${name}
  ''; # port mapping and codex use this port
in
#jail-env
codex-jail-netns
