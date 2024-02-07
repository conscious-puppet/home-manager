{}:
import ./theme.nix { } // {
  "explorer.compactFolders" = false;
  "terminal.integrated.fontSize" = 17;
  # "workbench.iconTheme" = "eq-material-theme-icons";
  # "workbench.colorTheme" = "Kanagawa";
  "editor.fontFamily" = "Iosevka, 'JetBrainsMono Nerd Font', Consolas, 'Courier New', monospace";
  "editor.fontLigatures" = true;
  "editor.formatOnPaste" = true;
  "editor.suggestSelection" = "first";
  "scm.defaultViewMode" = "tree";
  "editor.bracketPairColorization.enabled" = true;
  "editor.cursorBlinking" = "expand";
  "editor.guides.bracketPairs" = true;
  "files.autoSave" = "afterDelay";
  "material-icon-theme.folders.theme" = "specific";
  "material-icon-theme.hidesExplorerArrows" = false;
  "window.openFoldersInNewWindow" = "on";
  "workbench.enableExperiments" = false;
  "workbench.settings.editor" = "json";
  "debug.toolBarLocation" = "docked";
  "telemetry.telemetryLevel" = "error";
  "files.exclude" = {
    "**/.classpath" = true;
    "**/.project" = true;
    "**/.settings" = true;
    "**/.factorypath" = true;
  };
  "editor.formatOnSave" = false;
  "editor.tabSize" = 2;
  "git.autofetch" = true;
  "gitlens.codeLens.enabled" = false;
  "gitlens.currentLine.enabled" = false;
  "gitlens.blame.format" = "$${author|10-}, $${message|15-} $${agoOrDate|14-}";
  "workbench.editor.showTabs" = "multiple";
  "workbench.startupEditor" = "newUntitledFile";
  "terminal.integrated.defaultProfile.osx" = "zsh";
}

