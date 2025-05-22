default:
    @just --list

# Auto-format the source tree
fmt:
    treefmt

# Rebuild home-manager config
hm-switch:
    USER=abhisheksingh home-manager switch

nx-switch *ARGS:
  /run/wrappers/bin/sudo nixos-rebuild switch --flake .#nixos {{ARGS}}
