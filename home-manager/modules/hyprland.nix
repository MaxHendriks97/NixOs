{ config, lib, pkgs, ... }: {
  options = {
    hyprlandLayout = lib.mkOption {
      default = "master";
      description = ''
        hyprland window layout
      '';
    };

    hyprlandMonitor = lib.mkOption {
      default = ",preferred,auto,1";
      description = ''
        hyprland monitor
      '';
    };

    hyprlandWorkspace = lib.mkOption {
      default = [];
      description = ''
        hyprland workspace options
      '';
    };
  };

  config = {
    home.packages = [
      pkgs.swaylock-effects
      pkgs.swayidle
      pkgs.wlogout
      pkgs.swaybg
      pkgs.wayland-protocols
      pkgs.libsForQt5.qt5.qtwayland
      pkgs.libsForQt5.lightly
      pkgs.libsForQt5.qt5ct
      pkgs.qt6.qtwayland
      pkgs.gtk-engine-murrine
      pkgs.catppuccin-gtk
      pkgs.mako
      pkgs.viewnior
      pkgs.pavucontrol
      pkgs.vlc
      pkgs.sway-contrib.grimshot
      pkgs.pamixer
      pkgs.brightnessctl
      pkgs.gtk3
      pkgs.libnotify
      pkgs.poweralertd
      pkgs.dbus
      pkgs.catppuccin-kvantum
      pkgs.gnome-themes-extra
      pkgs.grim
      pkgs.slurp
      pkgs.playerctl
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      settings = {
        #################################################
        #██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗  #
        #██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝ #
        #██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗#
        #██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║#
        #╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝#
        #╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝  #
        #################################################

        monitor = config.hyprlandMonitor;

        exec-once = [
          "mako"
          "waybar"
          "lxqt-policykit-agent"
          "systemctl --user start graphical-session.target"
          "poweralertd"
          "blueman-applet"

          # Wallpaper
          "bash ~/NixOs/home-manager/modules/waybar/scripts/changewallpaper.sh"
          "gnome-keyring-daemon --start --components=secrets"

          "dbus-update-activation-environment --systemd --all WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
          "systemctl --user import-environment QT_QPA_PLATFORMTHEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        ];

        input = {
          kb_layout = "us";
          follow_mouse = 1;

          touchpad = {
            natural_scroll = "no";
          };

          sensitivity = 0;
        };

        general = {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          gaps_in = 5;
          gaps_out = 20;
          border_size = 2;
          "col.active_border" = "rgb(${config.colorScheme.palette.base0D}) rgb(${config.colorScheme.palette.base0B}) 45deg";
          "col.inactive_border" = "rgb(${config.colorScheme.palette.base04})";

          layout = config.hyprlandLayout;
        };

        decoration = {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          #rounding = 10
          #blur = yes
          #blur_size = 3
          #blur_passes = 0
          #blur_new_optimizations = on

          #drop_shadow = yes
          #shadow_range = 5
          #shadow_render_power = 3
          #col.shadow = rgba(1a1a1aee)
        };

        animations = {
          enabled = "yes";

          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        dwindle = {
            # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
            pseudotile = "yes"; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
            preserve_split = "yes"; # you probably want this
            force_split= 2;
        };

        master = {
            # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
            new_status = "slave";
            always_center_master = true;
            orientation = "center";
        };

        gestures = {
            # See https://wiki.hyprland.org/Configuring/Variables/ for more
            workspace_swipe = "off";
        };

        xwayland = {
            force_zero_scaling = true;
        };

        misc = {
          disable_hyprland_logo = true;
        };


        #################################################################################################
        #██╗    ██╗██╗███╗   ██╗██████╗  ██████╗ ██╗    ██╗    ██████╗ ██╗   ██╗██╗     ███████╗███████╗#
        #██║    ██║██║████╗  ██║██╔══██╗██╔═══██╗██║    ██║    ██╔══██╗██║   ██║██║     ██╔════╝██╔════╝#
        #██║ █╗ ██║██║██╔██╗ ██║██║  ██║██║   ██║██║ █╗ ██║    ██████╔╝██║   ██║██║     █████╗  ███████╗#
        #██║███╗██║██║██║╚██╗██║██║  ██║██║   ██║██║███╗██║    ██╔══██╗██║   ██║██║     ██╔══╝  ╚════██║#
        #╚███╔███╔╝██║██║ ╚████║██████╔╝╚██████╔╝╚███╔███╔╝    ██║  ██║╚██████╔╝███████╗███████╗███████║#
        #╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝╚═════╝  ╚═════╝  ╚══╝╚══╝     ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝╚══════╝ #
        #################################################################################################

        # Example windowrule v1
        # windowrule = float, ^(kitty)$
        # Example windowrule v2
        # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
        # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
        windowrule = [
          "float, ^(pavucontrol)$"
          "float, ^(blueman-manager)$"
        ];

        ################################################################
        #██╗  ██╗███████╗██╗   ██╗██████╗ ██╗███╗   ██╗██████╗ ███████╗#
        #██║ ██╔╝██╔════╝╚██╗ ██╔╝██╔══██╗██║████╗  ██║██╔══██╗██╔════╝#
        #█████╔╝ █████╗   ╚████╔╝ ██████╔╝██║██╔██╗ ██║██║  ██║███████╗#
        #██╔═██╗ ██╔══╝    ╚██╔╝  ██╔══██╗██║██║╚██╗██║██║  ██║╚════██║#
        #██║  ██╗███████╗   ██║   ██████╔╝██║██║ ╚████║██████╔╝███████║#
        #╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═════╝ ╚═╝╚═╝  ╚═══╝╚═════╝ ╚══════╝#
        ################################################################


        # See https://wiki.hyprland.org/Configuring/Keywords/ for more
        "$mainMod" = "SUPER";

        # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
        bind = [
          "$mainMod, Q, exec, kitty"
          "$mainMod, C, killactive,"
          "$mainMod, B, exit,"
          "$mainMod, E, exec, thunar"
          "$mainMod, V, togglefloating,"
          "$mainMod, R, exec, rofi -show drun"
          "$mainMod, P, pseudo, # dwindle"
          "$mainMod, J, togglesplit, # dwindle"
          "$mainMod, F, fullscreen,"
          "$mainMod, L, exec, hyprlock"

          # Move focus with mainMod + arrow keys
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"

          # Switch orientation
          "$mainMod SHIFT, left, layoutmsg, orientationleft"
          "$mainMod SHIFT, right, layoutmsg, orientationright"
          "$mainMod SHIFT, up, layoutmsg, orientationtop"
          "$mainMod SHIFT, down, layoutmsg, orientationbottom"
          "$mainMod SHIFT, M, layoutmsg, orientationcenter"

          # Switch master
          "$mainMod, M, layoutmsg, swapwithmaster"

          # Switch workspaces with mainMod + [0-9]
          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"

          # Move active window to a workspace with mainMod + SHIFT + [0-9]
          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"
          "$mainMod SHIFT, 7, movetoworkspace, 7"
          "$mainMod SHIFT, 8, movetoworkspace, 8"
          "$mainMod SHIFT, 9, movetoworkspace, 9"
          "$mainMod SHIFT, 0, movetoworkspace, 10"

          # Scroll through existing workspaces with mainMod + scroll
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
        ];

        workspace = config.hyprlandWorkspace;

        bindm = [
          # Move/resize windows with mainMod + LMB/RMB and dragging
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];
      };
    };

    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          disable_loading_bar = true;
          grace = 5;
          hide_cursor = true;
          no_fade_in = false;
        };

        background = [
          {
            path = "screenshot";
            blur_passes = 3;
            blur_size = 8;
          }
        ];

        input-field = [
          {
            size = "200, 50";
            position = "0, -80";
            monitor = "";
            dots_center = true;
            fade_on_empty = false;
            font_color = "rgb(202, 211, 245)";
            inner_color = "rgb(91, 96, 120)";
            outer_color = "rgb(24, 25, 38)";
            outline_thickness = 5;
            placeholder_text = "Password...";
            shadow_passes = 2;
          }
        ];
      };
    };
  };
}
