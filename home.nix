# Need to install pragmata pro font manually
# Inkdrop also manual
# For nvim, will need to :PlugInstall
# Get started: run `nix run . switch` to install home-manager, then `home-manager switch` to run this config
# Some resources:
# https://nix-community.github.io/home-manager/index.html
# https://mipmip.github.io/home-manager-option-search/
# https://search.nixos.org/packages
# https://www.reddit.com/r/NixOS/comments/vc3srj/in_home_manager_why_use_a_module_instead_of_a/
# https://github.com/virchau13/dots/blob/9eec548da8e72c5f2b41cdeb40e983dcc91aefd1/apps/nvim/default.nix
# https://github.com/the-nix-way/nome/blob/main/home-manager/neovim.nix
# https://github.com/YorikSar/dotfiles/blob/master/nix/neovim.nix
# TODO: why does zulip have small cursor?

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
    # spotify? (non-free)
    # vim plugins?
    pkgs.aerc
    pkgs.asciinema
    pkgs.bat
    pkgs.cmake
    pkgs.curl
    pkgs.deadbeef
    pkgs.dmenu
    pkgs.emacs29
    pkgs.eva
    pkgs.evince
    pkgs.eza
    pkgs.fd
    pkgs.feh # image viewer
    # pkgs.firefox broken openfl
    pkgs.flameshot # screenshots
    pkgs.fzf
    pkgs.git
    pkgs.git-lfs
    pkgs.gitui
    pkgs.gf # gdb frontend
    pkgs.htop
    pkgs.just
    pkgs.jq
    # pkgs.kitty broken https://github.com/NixOS/nixpkgs/issues/80936
    pkgs.nodePackages.bash-language-server
    pkgs.neovim
    pkgs.pyright
    pkgs.redshift
    pkgs.ripgrep
    pkgs.shellcheck
    pkgs.starship
    pkgs.unzip
    pkgs.watchexec
    pkgs.xcp
    pkgs.xsv
    pkgs.yt-dlp # youtube download
    pkgs.zsh-nix-shell # needed?
    pkgs.zip
    pkgs.zulip
    pkgs.zulip-term

    # work
    pkgs.teleport
  ];

  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    keychain = {
      # for managing ssh keys
      enable = true;
      # enableZshIntegration = true;
      # agents = ["ssh"];
      # keys = ["id_rsa"];
    };

    zsh.enable = true; # manage shell here
  };

  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3Support = true;
    };
    script = ""; # use script load.sh instead for now
  };

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

    # todo symlink some configs? https://github.com/virchau13/dots/blob/9eec548da8e72c5f2b41cdeb40e983dcc91aefd1/apps/nvim/default.nix
    ".gitconfig".source = ./gitconfig;
    ".zshrc".source = ./zshrc;
    ".config/starship.toml".source = ./starship.toml;
    ".config/kitty/kitty.conf".source = ./kitty/kitty.conf;
    ".config/kitty/theme.conf".source = ./kitty/theme.conf;
    ".config/nvim/init.vim".source = ./nvim/init.vim;
    ".config/i3/config".source = ./i3/config;
    ".config/polybar/launch.sh".source = ./polybar/launch.sh;
    ".config/polybar/config.ini".source = ./polybar/config.ini;
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
    #LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib"; # needed for tree-sitter-roc. But be careful, does this break everything else?
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
