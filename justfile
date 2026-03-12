default:
    @just --list

# Auto-format the source tree
fmt:
    treefmt

# Rebuild home-manager config
hm-switch:
    USER=abhishek.singh1 home-manager switch

nx-switch *ARGS:
  /run/wrappers/bin/sudo nixos-rebuild switch --flake .#nixos {{ARGS}}
