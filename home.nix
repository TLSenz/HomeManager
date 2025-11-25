{ config, pkgs, ... }:
let
  nvf = import (builtins.fetchTarball {
    url = "https://github.com/notashelf/nvf/archive/v0.8.tar.gz";
    # Optionally, you can add 'sha256' for verification and caching
    # sha256 = "<sha256>";
  });
in {

   imports = [
    # Import the NixOS module from your fetched input
    nvf.homeManagerModules.nvf
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "thalium";
  home.homeDirectory = "/home/thalium";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.hello
    pkgs.docker pkgs.glab pkgs.gh pkgs.gcc pkgs.wget pkgs.curl 
    pkgs.htop pkgs.tree pkgs.jq pkgs.fd  pkgs.ripgrep pkgs.bat pkgs.fzf pkgs.coreutils pkgs.python3
    pkgs.nodejs pkgs.rustup pkgs.terraform pkgs.kubectl pkgs.helm pkgs.tmux pkgs.net-tools
    pkgs.openssl pkgs.htop pkgs.spotify pkgs.tailscale pkgs.nextcloud-client pkgs.trayscale 
    pkgs.starship pkgs.jetbrains.rust-rover pkgs.jetbrains.webstorm pkgs.jetbrains.idea-community-bin

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?

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

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/thalium/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
     EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
	enable = true;
        settings.user.email = "sven@zemp.email";
	settings.user.name = "TLSenZ";
}; 

programs.nvf.enableManpages = true;
 programs.nvf = {
    enable = true;
    # your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = {
      vim.viAlias = false;
      vim.vimAlias = true;
      vim.lsp = {
        enable = true;
      };
      vim.theme.enable = true;
      vim.theme.name = "gruvbox";
      vim.theme.style = "dark";
      vim.statusline.lualine.enable = true;
      vim.telescope.enable = true;
      vim.autocomplete.nvim-cmp.enable = true;
      vim.languages.enableLSP = true;
      vim.languages.enableTreesitter = true;
      vim.languages.nix.enable = true;
      vim.languages.rust.enable = true;
      vim.languages.ts.enable = true;

        
    };
  };
}
