{pkgs, ...}: {
  programs = {
    zsh = {
      enable = true;
      enableCompletion = false; # enabled in oh-my-zsh
      initExtra = ''
        test -f ~/.dir_colors && eval $(dircolors ~/.dir_colors)
      '';
      shellAliases = {
        ne = "nix-env";
        ni = "nix-env -iA";
        no = "nixops";
        ns = "nix-shell --pure";
        please = "sudo";
      };
      zplug = {
        enable = true;
        plugins = [
          {name = "zsh-users/zsh-autosuggestions";} # Simple plugin installation
          {
            name = "romkatv/powerlevel10k";
            tags = [as:theme depth:1];
          } # Installations with additional options. For the list of options, please refer to Zplug README.
        ];
      };
      oh-my-zsh = {
        enable = true;
        plugins = ["git" "thefuck"];
        theme = "robbyrussell";
      };
    };
  };
}
