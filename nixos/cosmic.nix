{ config, pkgs, ... }: {
  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;

  environment.systemPackages = with pkgs; [
    chronos
    cosmic-applets
    cosmic-edit
    cosmic-ext-calculator
    cosmic-ext-forecast
    cosmic-ext-tasks
    cosmic-ext-tweaks
    cosmic-reader
    quick-webapps
  ];
}
