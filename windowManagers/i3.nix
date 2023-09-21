{ config, pkgs, callPackage, ... }:

{
  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw 
  services.xserver = {
    desktopManager = {
      xterm.enable = false;
    };
   
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        rofi # application launcher most people use
        i3lock # default i3 screen locker
        i3blocks-gaps # if you are planning on using i3blocks over i3status
	picom-next # compositor
	autotiling # autotiling for i3
     ];
    };
  };
}
