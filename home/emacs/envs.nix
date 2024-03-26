{ pkgs, lib, ... }:
let
  inherit (lib) types;

  formatElValue = value:
    if builtins.isString value then builtins.toJSON value
    else if value ? _expr then value._expr
    else if builtins.isInt value then toString value
    else if builtins.isBool value then (if value then "1" else "nil")
    else throw "Unrecognized type";
  formatEl = attrs:
    lib.concatStringsSep "\n" (lib.mapAttrsToList (key: value: "(setenv \"${key}\" ${formatElValue value})") attrs);
  writeEnvs = envs: pkgs.writeText "envs.el" (formatEl envs);
in
writeEnvs ({
  SHELL = "${pkgs.zsh}/bin/zsh";
})
