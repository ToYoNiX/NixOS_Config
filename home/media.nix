{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.yt-dlp = {
    enable = true;
    settings = {
      embed-thumbnail = true;
      embed-subs = true;
      sub-langs = "all";
    };
  };

  programs.mpv.enable = true;
}
