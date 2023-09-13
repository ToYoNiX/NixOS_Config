{ config, pkgs, callPackage, ... }: 

{
  services.xserver.windowManager.dwm.enable = true;
  environment.systemPackages = with pkgs; [
    picom-jonaburg
    st # teminal
    dmenu #application launcher most people use
  ];
}
