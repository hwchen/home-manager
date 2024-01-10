## Upgrade

Don't use `nix-channel --update`, even though I installed using channel.

Instead, my setup is actually controlled through nix flakes. So I need to do a `nix flake update` and then `home-manager switch`
