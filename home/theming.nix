{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # System-Wide Cursor
  home.pointerCursor = {
    gtk.enable = true;

    #package = pkgs.catppuccin-cursors.mochaDark;
    #name = "Catppuccin-Mocha-Dark-Cursors";

    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";

    size = 16;
  };

  gtk = {
    enable = true;

    theme = {
      # package = pkgs.nordic;
      # name = "Nordic";

      package = pkgs.dracula-theme;
      name = "Dracula";

      #name = "FlatColor";
    };

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "ePapirus-Dark";

      #name = "flattrcolor";
    };
  };

  # home.packages = with pkgs; [
  #   pywal
  #   wpgtk
  #   qt5ct
  #   python311Packages.pygobject3
  #   python311Packages.pillow
  #   python311Packages.libxslt
  #   libxslt
  #   xsettingsd
  #   gtk-engine-murrine
  #   wrapGAppsHook
  #   gtk3
  # ];
}
