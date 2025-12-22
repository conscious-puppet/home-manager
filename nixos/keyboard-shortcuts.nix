{ config, pkgs, ... }:
{
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ]; # what goes into the [id] section, here we select all keyboard
        extraConfig = ''
          [main]
          meta = layer(mac_meta)

          [mac_meta:M]
          a = C-a
          c = C-c
          v = C-v
          x = C-x
          z = C-z
          f = C-f
          w = C-w
          t = C-t
          q = C-q
          l = C-l
          r = C-r

          [mac_meta+shift]
          l = M-l
        '';
      };
    };
  };

}
