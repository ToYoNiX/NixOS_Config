{
  pkgs,
  lib,
  config,
  ...
}: {
  home.file."/home/assem/scripts".source = ./../scripts;

  programs.neovim = {
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

  programs.bat = {
    enable = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.tmux = {
    enable = true;
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };
  programs.git = {
    enable = true;
    userName = "ToYoNiX";
    userEmail = "toyonix.assemmohamed.2005@gmail.com";
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.nushell = {
    enable = true;
  };
}
