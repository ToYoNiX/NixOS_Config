{pkgs, ...}: {
  programs = {
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      extraConfig = ''
        set number
        set number relativenumber
        set clipboard+=unnamedplus

        set tabstop=4
        set shiftwidth=4
        set expandtab
      '';
    };
  };
}
