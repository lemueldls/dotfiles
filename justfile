update:
    home-manager switch --flake .#lemuel

clean:
    nix-collect-garbage -d
