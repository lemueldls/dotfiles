init:
    nix run home-manager/master -- init --switch --flake .#lemuel --extra-experimental-features flakes --extra-experimental-features nix-command

update:
    home-manager switch --flake .#lemuel

clean:
    nix-collect-garbage -d
