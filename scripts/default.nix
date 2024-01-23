{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  home.file."/home/assem/scripts".source = ./.;
  home.file."/home/assem/dwm" = {
    text = ''
      #!/bin/sh
      #
      uget-gtk &
      lxsession &
      blueman-applet &
      webcord &
      feh --bg-scale ${inputs.wallpaper} &
      sleep 5 && dwmblocks &
      xrandr -s 1280x1024 -r 75 &
      exec dwm

    '';
    executable = true;
  };
}
