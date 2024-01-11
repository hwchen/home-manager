## Upgrade

Don't use `nix-channel --update`, even though I installed using channel.

Instead, my setup is actually controlled through nix flakes. So I need to do a `nix flake update` and then `home-manager switch`

## Monitors

If I want to turn a monitor off temporarily, I can use `xrandr --output <name> --off` and `xrandr --output <name> --auto`.
https://superuser.com/questions/959735/xrandr-to-set-display-to-use-single-monitor-even-if-you-have-another-monitor-co
