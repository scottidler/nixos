{ config, pkgs, lib, ... }:
let
  link_sh = "${config.home.homeDirectory}/repos/scottidler/nixos/link.sh";
in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "saidler";
  home.homeDirectory = "/home/saidler";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # For a specific user
  # users.users.saidler.shell = pkgs.zsh; 
  # environment.shells = with pkgs; [ zsh ];
  # users.users.officialrajdeepsingh.shell = pkgs.zsh;

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      history.share = true;
      # zsh-autoenv.enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [
          "git"
          "npm"
          "history"
          "node"
          "rust"
          "kubectl"
        ];
      };
    };
    starship = {
      enable = true;
      settings = {
        format = "$directory$all$character";
        directory = {
          truncation_length = 0;
          truncate_to_repo = false;
          format = "[$path]($style)[$read_only]($read_only_style) ";
        };
      };
    };
  };

  # Ensure the script is executable
  home.activation.linkDotfiles = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.bash}/bin/bash ${link_sh}
  '';

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    pkgs.hello
    # Optional: Ensure git and bash are available in the user environment, if not already
    pkgs.git
    pkgs.bash

    pkgs.unzip
    pkgs.wget
    pkgs.gnupg
    pkgs.keychain
    pkgs.vlc
    pkgs.btop
    pkgs.whois
    pkgs.gimp
    pkgs.imagemagick
    pkgs.gcc
    # (pkgs.rustChannels.stable.rust.override { extensions = ["rust-src"]; })
    pkgs.jq
    pkgs.yq
    pkgs.meld
    pkgs.neovim

    pkgs.eza
    pkgs.tokei
    pkgs.fd
    pkgs.du-dust
    pkgs.fend
    #pkgs.irust
    pkgs.procs
    pkgs.sccache
    pkgs.sd 
    pkgs.ripgrep
    pkgs.starship 
    pkgs.bat
    pkgs.zoxide
    pkgs.fzf

    pkgs.coreutils
    pkgs.libreoffice
    # pkgs.zoom-us
    pkgs.xclip

    pkgs.wofi
    pkgs.waybar

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    (pkgs.writeShellScriptBin "my-hello" ''
      echo "Hello, ${config.home.username}!"
    '')
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
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    defaultCacheTtl = 1800;
  };

#  home.activation.copySSHKey = dagEntryAfter ["writeBoundary"] ''
#      install -D -m600 ${./private/id_rsa} $HOME/.ssh/id_rsa
#  '';
#
#  home.activation.authorizedKeys = dagEntryAfter ["writeBoundary"] ''
#      install -D -m600 ${./id_rsa.pub} $HOME/.ssh/authorized_keys
#  '';

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/saidler/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
