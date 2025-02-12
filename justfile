default:
    @just --list

# Auto-format the source tree
fmt:
    treefmt

# Rebuild home-manager config
hm-switch:
    home-manager switch

nx-switch:
  /run/wrappers/bin/sudo nixos-rebuild switch --flake .#nixos
