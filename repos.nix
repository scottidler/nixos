{ config, pkgs, lib }:
let
  #nvim = pkgs.fetchFromGitHub {
  #  owner = "scottidler";
  #  repo = "nvim";
  #  rev = "b9f67dbff267faf8cf0757bcff9cc9305865c431";
  #  sha256 = "sha256-Fg/g+CdnO7aIPCJcOBxEYUinwh2RjeWgf8xmyw3qvgo=";
  #};

  repos = [
    {
      owner = "scottidler";
      repo = "nvim";
      rev = "b9f67dbff267faf8cf0757bcff9cc9305865c431";
      sha256 = "sha256-Fg/g+CdnO7aIPCJcOBxEYUinwh2RjeWgf8xmyw3qvgo=";
      links = {
        "." = "/home/user/.config/nvim";
      };
    }
    {
      owner = "scottidler";
      repo = "git";
      rev = "a3f5bd07197037e5af2315770136ccd32f6424d4";
      sha256 = "sha256-mxVJf918VE9hpkhhvfy8MDJICCevRdJWplmjfYI1PV8=";
      links = {
        "bin/clone" = "/home/user/bin/clone";
        "bin/clone-lite" = "/home/user/bin/clone-lite";
        "bin/reponame" = "/home/user/bin/reponame";
        "bin/git-objects" = "/home/user/bin/git-objects";
        "bin/ls-git-repos" = "/home/user/bin/ls-git-repos";
        "bin/ls-github-repos" = "/home/user/bin/ls-github-repos";
        "bin/default-branch" = "/home/user/bin/default-branch";
        "bin/stale-branches" = "/home/user/bin/stale-branches";
        "bin/filter-ref" = "/home/user/bin/filter-ref";
        "shell-functions.sh" = "/home/user/.shell-functions.d/clone.sh";
        "cfg/clone.cfg" = "/home/user/.clone/clone/clone.cfg";
      };
    }
    {
      owner = "scottidler";
      repo = "tmp";
      rev = "03850b057066f525a827405ec6316a528b25ae91";
      sha256 = "sha256-2sEJEVvUaZsb1InvUQ6DONYgG68WFm2eraqfWBRhWsM=";
      links = {
        "bin/tmp" = "/home/user/bin/tmp";
      };
    }
    {
      owner = "scottidler";
      repo = "helpful";
      rev = "939675b960bd2d923bb7f192af3c42d612a08dd9";
      sha256 = "sha256-gzcbdazGTyzudW/3TsIFtFTPnShENR3qjoz9tJbM/FM=";
      links = {
        "bin/cidr" = "/home/user/bin/cidr";
        "bin/say" = "/home/user/bin/say";
        "bin/speedtest" = "/home/user/bin/speedtest";
        "bin/tab" = "/home/user/bin/tab";
        "bin/tab1" = "/home/user/bin/tab1";
        "bin/tab2" = "/home/user/bin/tab2";
        "bin/tab3" = "/home/user/bin/tab3";
        "bin/tab4" = "/home/user/bin/tab4";
        "bin/toggle" = "/home/user/bin/toggle";
        "bin/prepend" = "/home/user/bin/prepend";
        "bin/toggle-remote-url" = "/home/user/bin/toggle-remote-url";
        "shell-functions.sh" = "/home/user/.shell-functions.d/helpful.sh";
      };
    }
    {
      owner = "scottidler";
      repo = "dock";
      rev = "520a4c4723a6d161cc1b328248ec66c62f161aaf";
      sha256 = "sha256-Bt8mlKMlWFTc8qOOpwOO12QvHQk3rl9Huj+XZMb8mZ0=";
      links = {
        "dock" = "/home/user/bin/dock";
      };
    }
    #{
    # owner = "scottidler";
    # repo = "pimp";
    # rev = "specify-revision";
    # sha256 = "specify-sha256";
    # links = {
    #   "pimp" = "/home/user/bin/pimp";
    # };
    #}
    #{
    #  owner = "scottidler";
    #  repo = "ls-stat";
    #  rev = "specify-revision";
    #  sha256 = "specify-sha256";
    #  links = {
    #    "ls-stat" = "/home/user/bin/ls-stat";
    #  };
    #}
    {
      owner = "scottidler";
      repo = "xpndr";
      rev = "04ca06b448ee71ea5450324d2b5d5fdb99826e49";
      sha256 = "sha256-MliR/r9AEq+0/uJcVvQbB1TQZ+/xxQnmm0b2LI7nmV8=";
      links = {
        "xpndr" = "/home/user/bin/xpndr";
      };
    }
    #{
    #  owner = "scottidler";
    #  repo = "y2j";
    #  rev = "5fd3ad8dd5fb5a49ebd62f03e9b47699e00dd12c";
    #  sha256 = "sha256-km8z/ozD3g4hhGGeqolS2peLdKmOfO92IF5qLiogSbY=";
    #  links = {
    #    "bin/y2j" = "/home/user/bin/y2j";
    #    "bin/j2y" = "/home/user/bin/j2y";
    #  };
    #}
    {
      owner = "scottidler";
      repo = "repo";
      rev = "69bcd3a5d43da3bcba33e6ef4cde629bbee115cd";
      sha256 = "sha256-hTArEDz3ziaSwWeMarZWNhe2lVSwWzJNbqwW+XEld0k=";
      links = {
        "bin/repo" = "/home/user/bin/repo";
      };
    }
    {
      owner = "scottidler";
      repo = "cert-tools";
      rev = "0abd4bfb88aa91a689eeb6d2f466c6b9db27da4e";
      sha256 = "sha256-tfTNMNuFClDpJ2PUFNKtoOV9qoaXCXmmjrRk1uNlkE8=";
      links = {
        "findcert" = "/home/user/bin/findcert";
        "modcert" = "/home/user/bin/modcert";
        "ssl-compare" = "/home/user/bin/ssl-compare";
        "ssl-inspect" = "/home/user/bin/ssl-inspect";
        "ssl-sans" = "/home/user/bin/ssl-sans";
        "ssl-validity" = "/home/user/bin/ssl-validity";
      };
    }
    #{
    #  owner = "sahsanu";
    #  repo = "lectl";
    #  rev = "specify-revision";
    #  sha256 = "specify-sha256";
    #  links = {
    #    "lectl" = "/home/user/bin/lectl";
    #  };
    #}
    #{
    #  owner = "esc";
    #  repo = "git-big-picture";
    #  rev = "specify-revision";
    #  sha256 = "specify-sha256";
    #  links = {
    #    "git-big-picture" = "/home/user/bin/gbp";
    #  };
    #}
    {
      owner = "awslabs";
      repo = "awscli-aliases";
      rev = "5357e18bc27b42a827b6780564ea873a72ca1f01";
      sha256 = "sha256-E2tRNEQaboeCm+Od0BPSwm2hEiFzFtK+pFLEg7t0FUg=";
      links = {
        "alias" = "/home/user/.awscli-aliases";
      };
    }
    #{
    #  owner = "powerline";
    #  repo = "powerline";
    #  rev = "specify-revision";
    #  sha256 = "specify-sha256";
    #  links = {
    #    "font/10-powerline-symbols.conf" = "/home/user/.config/fontconfig/conf.d/10-powerline-symbols.conf";
    #    "font/PowerlineSymbols.otf" = "/home/user/.fonts/PowerlineSymbols.otf";
    #  };
    #}
    #{
    #  owner = "joel-porquet";
    #  repo = "zsh-dircolors-solarized";
    #  rev = "specify-revision";
    #  sha256 = "specify-sha256";
    #  links = {
    #    "zsh-dircolors-solarized.zsh" = "/home/user/.zsh/zsh-dircolors-solarized/zsh-dircolors-solarized.zsh";
    #  };
    #}
    #{
    #  owner = "robbyrussell";
    #  repo = "oh-my-zsh";
    #  rev = "specify-revision";
    #  sha256 = "specify-sha256";
    #  links = {
    #    "." = "/home/user/.oh-my-zsh";
    #  };
    #}
    {
      owner = "awslabs";
      repo = "git-secrets";
      rev = "cc9f8185ba85bea28cf64326e10ae2c5be9cc080";
      sha256 = "sha256-CsYapHFx10rJkXj3xjL4vlVNZh3T9emZQRdCFcmJa/Y=";
      links = {
        "git-secrets" = "/home/user/bin/git-secrets";
      };
    }
    #{
    #  owner = "tfutils";
    #  repo = "tfenv";
    #  rev = "specify-revision";
    #  sha256 = "specify-sha256";
    #  links = {
    #    "bin/terraform" = "/home/user/bin/terraform";
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
