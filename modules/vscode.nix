{ pkgs, user, ... }:

{
  environment.systemPackages = with pkgs; [ nil ];

  home-manager.users.${user} =
    { pkgs, ... }:
    {
      programs.vscode = {
        enable = true;
        profiles.default.extensions = with pkgs.vscode-marketplace; [
          jnoortheen.nix-ide
          vscode-icons-team.vscode-icons
          zhuangtongfa.material-theme
        ];
        profiles.default.userSettings = {
          "editor.fontFamily" = "'FiraCode Nerd Font Mono'";
          "editor.fontLigatures" = true;
          "telemetry.telemetryLevel" = "off";
          "workbench.enableExperiments" = false;
          "chat.disableAIFeatures" = true;
          "workbench.startupEditor" = "none";
          "workbench.colorTheme" = "One Dark Pro";
          "workbench.iconTheme" = "vscode-icons";
          "vsicons.dontShowNewVersionMessage" = true;
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nil";
        };
      };
    };
}
