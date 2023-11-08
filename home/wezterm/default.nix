{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = ''
      return {
          color_scheme = "Dracula (Official)",
          hide_tab_bar_if_only_one_tab = true,
          window_close_confirmation = "NeverPrompt"
      }
    '';
  };
}
