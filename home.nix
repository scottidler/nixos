# home.nix
{ config, pkgs, lib, ... }:
let
  # repos = import ./repos2.nix { inherit config lib pkgs; };
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

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # FIXME: would be nice to have the fetch commands installed
    # nix-prefetch-scripts
    # gitAndTools.nix-prefetch-git
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
    (callPackage /home/saidler/repos/scottidler/rmrf/default.nix {})
  ];

  programs = {
    bash = {
      enable = true;
      enableCompletion = true;
      historySize = 10000;
      historyFile = "~/.bash_eternal_history";
      historyControl = [ "ignoredups" "ignorespace" "erasedups" ];
      historyIgnore = [ "ls" "cd .." ];
      shellAliases = {
        ll = "ls -alF";
        la = "ls -A";
        l = "ls -CF";
      };
      initExtra = ''
        # Initialize programmable completion features
        if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
          . /etc/bash_completion
        fi
      '';
      bashrcExtra = ''
        # Define your PS1 here
        PS1='\\[\e[1;32m\]\u@\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\]\$ '
        
        # Any other bashrc configurations can go here
      '';
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true; # autosuggestion.enable = true; was told to use this, but it didnt work
      history.share = true;
      syntaxHighlighting.enable = true;
      initExtra = ''source ${pkgs.callPackage /home/saidler/repos/scottidler/aka/default.nix {} }/share/zsh/site-functions/_aka'';
      plugins = [
        {
          name = "zsh-nix-shell";
          file = "nix-shell.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "chisui";
            repo = "zsh-nix-shell";
            rev = "v0.8.0";
            sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
          };
        }
      ];
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
        format = "$directory $all$character";
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
    # ".bash_prompt".source = ./HOME/.bash_prompt;
    # ".bashrc".source = ./HOME/.bashrc;
    ".config/aka/aka.yml".source = ./HOME/.config/aka/aka.yml;
    ".config/clone/clone.cfg".source = ./HOME/.config/clone/clone.cfg;
    ".config/nvim/init.lua".source = ./HOME/.config/nvim/init.lua;
    ".config/pip/pip.conf".source = ./HOME/.config/pip/pip.conf;
    ".config/rmrf/rmrf.cfg".source = ./HOME/.config/rmrf/rmrf.cfg;
    ".config/tmp/tmp.yml".source = ./HOME/.config/tmp/tmp.yml;
    ".expand-aka".source = ./HOME/.expand-aka;
    ".gitconfig".source = ./HOME/.gitconfig;
    ".gitconfig-ssh".source = ./HOME/.gitconfig-ssh;
    ".gitconfig-work".source = ./HOME/.gitconfig-work;
    ".gnupg/gpg.conf".source = ./HOME/.gnupg/gpg.conf;
    ".local/share/applications/.obsidian.png".source = ./HOME/.local/share/applications/.obsidian.png;
    ".local/share/applications/Obsidian.desktop".source = ./HOME/.local/share/applications/Obsidian.desktop;
    ".rustfmt.toml".source = ./HOME/.rustfmt.toml;
    ".shell-aliases".source = ./HOME/.shell-aliases;
    ".shell-exports".source = ./HOME/.shell-exports;
    ".shell-exports.d/rust.env".source = ./HOME/.shell-exports.d/rust.env;
    ".shell-functions".source = ./HOME/.shell-functions;
    ".ssh/config".source = ./HOME/.ssh/config;
    ".ssh-ident".source = ./HOME/.ssh-ident;
    ".tmux.conf".source = ./HOME/.tmux.conf;
    ".vimrc".source = ./HOME/.vimrc;
    ".zsh/functions/_exercism".source = ./HOME/.zsh/functions/_exercism;
    ".zsh-dircolors.config".source = ./HOME/.zsh-dircolors.config;

    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    ".config/rmrf/rmrf2.cfg".text = ''
      # where to store tarballs of removed files
      rmrf_path=/var/tmp/rmrf2
      bkup_path=/var/tmp/bkup2

      # use sudo by default
      sudo=yes

      # how many days to keep files in tarball at /var/tmp/rmrf
      keep=21

      # value used in fuzzy searching
      threshold=70
    '';
  };

  # Apply the activation scripts from repos
  # home.activation = repos.activation // {
    # any activation scripts
  # };

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
    # PATH = "${config.home.homeDirectory}/bin:$PATH";
    # PATH = "${config.environment.systemPackages}/bin:${pkgs.git}/bin:/run/current-system/sw/bin:$PATH"; 
    # PATH = lib.makeBinPath [ pkgs.git ] + ":/run/current-system/sw/bin:$PATH"; THIS FUCKED ME
    # PATH = "&PATH:${pkgs.nix-prefetch-scripts}/bin:${pkgs.gitAndTools.nix-prefetch-git}/bin";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
