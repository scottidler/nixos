{ config, pkgs, lib, ... }:
let
  link_sh = "${config.home.homeDirectory}/repos/scottidler/nixos/link.sh";
  dotfiles = "${config.home.homeDirectory}/repos/scottidler/nixos/HOME";
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

  # Ensure the script is executable
  home.activation.linkDotfiles = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.bash}/bin/bash ${link_sh}
  '';

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    hello
    # Optional: Ensure git and bash are available in the user environment, if not already
    git
    bash

    unzip
    wget
    gnupg
    keychain
    vlc
    btop
    whois
    gimp
    imagemagick
    gcc
    # (pkgs.rustChannels.stable.rust.override { extensions = ["rust-src"]; })
    jq
    yq
    meld
    neovim

    eza
    tokei
    fd
    du-dust
    fend
    #irust
    procs
    sccache
    sd 
    ripgrep
    starship 
    bat
    zoxide
    fzf

    coreutils
    libreoffice
    #zoom-us
    xclip

    wofi
    waybar

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

    # other packages
    (callPackage /home/saidler/repos/scottidler/aka/default.nix {})
  ];

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true; # autosuggestion.enable = true; was told to use this, but it didnt work
      history.share = true;
      syntaxHighlighting.enable = true;
      initExtra = ''source ${pkgs.callPackage /home/saidler/repos/scottidler/aka/default.nix {} }/share/zsh/site-functions/_aka'';
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
	username.disabled = true;
        directory = {
          truncation_length = 0;
          truncate_to_repo = false;
          format = "[$path]($style)[$read_only]($read_only_style)";
        };
      };
    };
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
    EDITOR = "nvim";
    # FIXME: this is a stop gap until I can solve for binaries and scripts int a more idiomatic way
    PATH = "${config.home.homeDirectory}/bin:$PATH";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
