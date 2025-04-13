{ config, pkgs, ... }:
let
    nixvim = import (builtins.fetchGit {
        url = "https://github.com/nix-community/nixvim/";
        # When using a different channel you can use `
	ref = "nixos-24.11";
	#` to set it here
    });
in
{
  # Home Manager needs a bit of information about you and the paths it should
  home.username = "olli";
  home.homeDirectory = "/home/olli";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  imports = [ nixvim.homeManagerModules.nixvim ];
  home.packages = [
    pkgs.zellij
    pkgs.htop
    pkgs.ripgrep
    pkgs.tilix
    pkgs.neofetch

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

# Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    ".config/zellij/config.kdl".source = dotfiles/zellij/config.kdl;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };
        
  programs.nixvim = {
    config = {


    enable = true;
    globals.mapleader = " ";
    colorschemes.gruvbox.enable = true;
    options={
	  tabstop = 4;
	  softtabstop = 4;
	  shiftwidth = 4;
	  expandtab = true;
	  smartindent = true;
	  number = true;
	  relativenumber = true;
    };
    keymaps = [
      {
      action = "<cmd>Telescope live_grep<CR>";
      key = "<leader>fg";
      }
      {
      action = "<cmd>Telescope buffers<CR>";
      key = "<leader>fb";
      }
      {
      action = "<cmd>Telescope treesitter<CR>";
      key = "<leader>ft";
      }
      {
      action = "<cmd>Neotree toggle<CR>";
      key = "<leader>t";
      }



#buffer navigation


      {
      action = "<C-w>j";
      key = "<C-j>";
      }
      {
      action = "<C-w>k";
      key = "<C-k>";
      }
      {
      action = "<C-w>l";
      key = "<C-l>";
      }
      {
      action = "<C-w>h";
      key = "<C-h>";
      }
      {
      action = "<cmd>bn<CR>";
      key = "<leader>n";
      }
      {
      action = "<cmd>bp<CR>";
      key = "<leader>b";
      }
      {
      action = "<cmd>new<CR>";
      key = "<leader>n";
      }
      {
      action = "<cmd>exit<CR>";
      key = "<leader>x";
      }
    ];



    plugins = {
      lualine.enable = true;
      telescope.enable = true;
      treesitter.enable = true;
      oil.enable = true;
      web-devicons.enable = true;
      #vimtex.enable = true;



        neo-tree = {
          enable = true;
          enableDiagnostics = true;
          enableGitStatus = true;
          enableModifiedMarkers = true;
          enableRefreshOnWrite = true;
          closeIfLastWindow = true;
          popupBorderStyle = "rounded"; # Type: null or one of “NC”, “double”, “none”, “rounded”, “shadow”, “single”, “solid” or raw lua code
          buffers = {
            bindToCwd = false;
            followCurrentFile = {
              enabled = true;
            };
          };
          window = {
            width = 40;
            height = 15;
            autoExpandWidth = false;
            mappings = {
              "<space>" = "none";
            };
          };
        };

    };




    plugins.lsp = {
      enable = true;
      servers = {
        rust_analyzer.enable = true;
        pyright.enable = true;
        svelte.enable = true;
      };
    };
    plugins.cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
            sources = [{name = "nvim_lsp";} {name = "path";} {name = "buffer";}];
            
        


    
            mapping = {
                    "<C-Space>" = "cmp.mapping.complete()";
                    "<C-d>" = "cmp.mapping.scroll_docs(-4)";
                    "<C-e>" = "cmp.mapping.close()";
                    "<C-f>" = "cmp.mapping.scroll_docs(4)";
                    "<CR>" = "cmp.mapping.confirm({ select = true })";
                    "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
                    "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
                    };
                };
        
            };




    };
  };
  
  wayland.windowManager.hyprland.enable = true; # enable Hyprland

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
  #  /etc/profiles/per-user/olli/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.git.enable = true;
}
