{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "hwchen";
  home.homeDirectory = "/home/hwchen";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    # TODO:
    # steam?
    # docker?
    # spotify
    # zulip
    # firefox
    # vim plugins?
    pkgs.asciinema
    pkgs.awscli2
    pkgs.bat
    pkgs.cmake
    pkgs.deadbeef
    pkgs.direnv
    pkgs.dmenu
    pkgs.eva
    pkgs.evince
    pkgs.exa
    pkgs.fd
    pkgs.feh # image viewer
    pkgs.flameshot # screenshots
    pkgs.fzf
    pkgs.git
    pkgs.git-lfs
    pkgs.gf # gdb frontend
    pkgs.htop
    pkgs.just
    pkgs.jq
    pkgs.neovim
    pkgs.polybar
    pkgs.redshift
    pkgs.ripgrep
    pkgs.starship
    pkgs.unzip
    pkgs.watchexec
    pkgs.xcp
    pkgs.xsv
    pkgs.yt-dlp # youtube download
    pkgs.zsh-nix-shell # needed?
    pkgs.zip
    pkgs.zsh
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    # todo (vim, zsh, direnv, aws, kitty, i3)
    ".gitconfig".source = ./gitconfig;
    ".config/starship.toml".source = ./starship.toml;
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/hwchen/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
