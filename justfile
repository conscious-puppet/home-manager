default:
    @just --list

# Auto-format the source tree
fmt:
    treefmt

# Rebuild home-manager config
switch:
    home-manager switch
