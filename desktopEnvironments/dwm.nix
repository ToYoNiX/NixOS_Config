{ config, pkgs, callPackage, ... }: 

{
  services.xserver.windowManager.dwm.enable = true;
  environment.systemPackages = with pkgs; [
    picom-next
    st # teminal
    dmenu #application launcher most people use
  ];
}
