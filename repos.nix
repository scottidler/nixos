{ config, pkgs, lib }:
let
  #nvim = pkgs.fetchFromGitHub {
  #  owner = "scottidler";
  #  repo = "nvim";
  #  rev = "b9f67dbff267faf8cf0757bcff9cc9305865c431";
  #  sha256 = "sha256-Fg/g+CdnO7aIPCJcOBxEYUinwh2RjeWgf8xmyw3qvgo=";
  #};

  HOME = config.home.homeDirectory;
  repos = [
    #{
    #  owner = "scottidler";
    #  repo = "nvim";
    #  rev = "9023255952d562bd3214e1fbbbf7c8233d85e4ee";
    #  sha256 = "sha256-ZZyz04vsxonr2Sob8Gp6qfdDMUfu2mPhYKdoeod1TPM=";
    #  links = {
    #    "./" = "${HOME}/.config/nvim";
    #  };
    #}
    {
      owner = "scottidler";
      repo = "helpful";
      rev = "fdb84318c3ca560a7e858459649dfb9a5c08d49e";
      sha256 = "sha256-gTn4Im8ydpQ06RvLD3KF1cX3qFQEYBqhmV/aUyPqb+0=";
      links = {
        "bin/cidr" = "${HOME}/bin/cidr";
        "bin/say" = "${HOME}/bin/say";
        "bin/speedtest" = "${HOME}/bin/speedtest";
        "bin/tab" = "${HOME}/bin/tab";
        "bin/tab1" = "${HOME}/bin/tab1";
        "bin/tab2" = "${HOME}/bin/tab2";
        "bin/tab3" = "${HOME}/bin/tab3";
        "bin/tab4" = "${HOME}/bin/tab4";
        "bin/toggle" = "${HOME}/bin/toggle";
        "bin/prepend" = "${HOME}/bin/prepend";
        "bin/toggle-remote-url" = "${HOME}/bin/toggle-remote-url";
        "shell-functions.sh" = "${HOME}/.shell-functions.d/helpful.sh";
      };
    }
    {
      owner = "scottidler";
      repo = "cert-tools";
      rev = "35cbad5b63f1c27d65b4febf6d1e9e40914f1bac";
      sha256 = "sha256-nnckSkJQj6ObBD9xEgvQD9ms1BpUTXxJ+b1K/lBkWzU=";
      links = {
        "findcert" = "${HOME}/bin/findcert";
        "modcert" = "${HOME}/bin/modcert";
        "ssl-compare" = "${HOME}/bin/ssl-compare";
        "ssl-inspect" = "${HOME}/bin/ssl-inspect";
        "ssl-sans" = "${HOME}/bin/ssl-sans";
        "ssl-validity" = "${HOME}/bin/ssl-validity";
      };
    }
    {
      owner = "scottidler";
      repo = "git";
      rev = "a3f5bd07197037e5af2315770136ccd32f6424d4";
      sha256 = "sha256-mxVJf918VE9hpkhhvfy8MDJICCevRdJWplmjfYI1PV8=";
      links = {
        "bin/clone" = "${HOME}/bin/clone";
        "bin/clone-lite" = "${HOME}/bin/clone-lite";
        "bin/reponame" = "${HOME}/bin/reponame";
        "bin/git-objects" = "${HOME}/bin/git-objects";
        "bin/ls-git-repos" = "${HOME}/bin/ls-git-repos";
        "bin/ls-github-repos" = "${HOME}/bin/ls-github-repos";
        "bin/default-branch" = "${HOME}/bin/default-branch";
        "bin/stale-branches" = "${HOME}/bin/stale-branches";
        "bin/filter-ref" = "${HOME}/bin/filter-ref";
        "shell-functions.sh" = "${HOME}/.shell-functions.d/clone.sh";
        "cfg/clone.cfg" = "${HOME}/.clone/clone/clone.cfg";
      };
    }
    {
      owner = "scottidler";
      repo = "tmp";
      rev = "03850b057066f525a827405ec6316a528b25ae91";
      sha256 = "sha256-2sEJEVvUaZsb1InvUQ6DONYgG68WFm2eraqfWBRhWsM=";
      links = {
        "bin/tmp" = "${HOME}/bin/tmp";
      };
    }
    {
      owner = "scottidler";
      repo = "repo";
      rev = "69bcd3a5d43da3bcba33e6ef4cde629bbee115cd";
      sha256 = "sha256-hTArEDz3ziaSwWeMarZWNhe2lVSwWzJNbqwW+XEld0k=";
      links = {
        "bin/repo" = "${HOME}/bin/repo";
      };
    }
    {
      owner = "scottidler";
      repo = "dock";
      rev = "520a4c4723a6d161cc1b328248ec66c62f161aaf";
      sha256 = "sha256-Bt8mlKMlWFTc8qOOpwOO12QvHQk3rl9Huj+XZMb8mZ0=";
      links = {
        "dock" = "${HOME}/bin/dock";
      };
    }
    {
      owner = "scottidler";
      repo = "xpndr";
      rev = "04ca06b448ee71ea5450324d2b5d5fdb99826e49";
      sha256 = "sha256-MliR/r9AEq+0/uJcVvQbB1TQZ+/xxQnmm0b2LI7nmV8=";
      links = {
        "xpndr" = "${HOME}/bin/xpndr";
      };
    }
    {
      owner = "awslabs";
      repo = "awscli-aliases";
      rev = "5357e18bc27b42a827b6780564ea873a72ca1f01";
      sha256 = "sha256-E2tRNEQaboeCm+Od0BPSwm2hEiFzFtK+pFLEg7t0FUg=";
      links = {
        "alias" = "${HOME}/.awscli-aliases";
      };
    }
    {
      owner = "awslabs";
      repo = "git-secrets";
      rev = "cc9f8185ba85bea28cf64326e10ae2c5be9cc080";
      sha256 = "sha256-CsYapHFx10rJkXj3xjL4vlVNZh3T9emZQRdCFcmJa/Y=";
      links = {
        "git-secrets" = "${HOME}/bin/git-secrets";
      };
    }
    #{
    # owner = "scottidler";
    # repo = "pimp";
    # rev = "specify-revision";
    # sha256 = "specify-sha256";
    # links = {
    #   "pimp" = "${HOME}/bin/pimp";
    # };
    #}
    #{
    #  owner = "scottidler";
    #  repo = "ls-stat";
    #  rev = "specify-revision";
    #  sha256 = "specify-sha256";
    #  links = {
    #    "ls-stat" = "${HOME}/bin/ls-stat";
    #  };
    #}
    #{
    #  owner = "scottidler";
    #  repo = "y2j";
    #  rev = "5fd3ad8dd5fb5a49ebd62f03e9b47699e00dd12c";
    #  sha256 = "sha256-km8z/ozD3g4hhGGeqolS2peLdKmOfO92IF5qLiogSbY=";
    #  links = {
    #    "bin/y2j" = "${HOME}/bin/y2j";
    #    "bin/j2y" = "${HOME}/bin/j2y";
    #  };
    #}
    #{
    #  owner = "sahsanu";
    #  repo = "lectl";
    #  rev = "specify-revision";
    #  sha256 = "specify-sha256";
    #  links = {
    #    "lectl" = "${HOME}/bin/lectl";
    #  };
    #}
    #{
    #  owner = "esc";
    #  repo = "git-big-picture";
    #  rev = "specify-revision";
    #  sha256 = "specify-sha256";
    #  links = {
    #    "git-big-picture" = "${HOME}/bin/gbp";
    #  };
    #}
    #{
    #  owner = "powerline";
    #  repo = "powerline";
    #  rev = "specify-revision";
    #  sha256 = "specify-sha256";
    #  links = {
    #    "font/10-powerline-symbols.conf" = "${HOME}/.config/fontconfig/conf.d/10-powerline-symbols.conf";
    #    "font/PowerlineSymbols.otf" = "${HOME}/.fonts/PowerlineSymbols.otf";
    #  };
    #}
    #{
    #  owner = "joel-porquet";
    #  repo = "zsh-dircolors-solarized";
    #  rev = "specify-revision";
    #  sha256 = "specify-sha256";
    #  links = {
    #    "zsh-dircolors-solarized.zsh" = "${HOME}/.zsh/zsh-dircolors-solarized/zsh-dircolors-solarized.zsh";
    #  };
    #}
    #{
    #  owner = "robbyrussell";
    #  repo = "oh-my-zsh";
    #  rev = "specify-revision";
    #  sha256 = "specify-sha256";
    #  links = {
    #    "." = "${HOME}/.oh-my-zsh";
    #  };
    #}
    #{
    #  owner = "tfutils";
    #  repo = "tfenv";
    #  rev = "specify-revision";
    #  sha256 = "specify-sha256";
    #  links = {
    #    "bin/terraform" = "${HOME}/bin/terraform";
    #  };
    #}
  ];

#in {
#  mappings = {
#    ".config/nvim".source = nvim;
#  };
#}

  # Function to apply all repositories and mappings
  applyMappings = repo: let
    path = pkgs.fetchFromGitHub {
      inherit (repo) owner repo rev sha256;
    };
  in
    lib.mapAttrs' (file: target: lib.nameValuePair target { source = "${path}/${file}"; }) repo.links;

in {
  home.file = lib.foldl' (acc: repo: acc // applyMappings repo) {} repos;


}
