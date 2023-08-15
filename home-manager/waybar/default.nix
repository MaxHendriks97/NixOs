{ config, lib, pkgs, ... }: {
  programs = {
    waybar = {
      enable = true;
      package = pkgs.waybar-hyprland;
      settings = {
        mainBar = {
          layer = "top";
          modules-left = ["temperature" "cpu" "memory" "wlr/workspaces"];
          modules-center = ["mpris"];
          modules-right = ["network" "pulseaudio" "backlight" "battery" "clock" "tray" "custom/power-menu"];

          "wlr/workspaces" = {
              format = "{icon}";
              all-outputs = true;
              on-click = "activate";
              format-icons = {
                  active = "";
                  default = "";
              };
          };

          "hyprland/window" = {
              format = "{}";
          };

          tray = {
              spacing = 10;
          };

          clock = {
              tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
              format-alt = "{:%d-%m-%Y}";
          };

          cpu = {
              format = "{usage}% ";
              tooltip = false;
          };

          memory = {
              format = "{}% ";
          };

          temperature = {
              critical-threshold = 80;
              format = "{temperatureC}°C {icon}";
              format-icons = ["" "" ""];
          };

          backlight = {
              format = "{percent}% {icon}";
              format-icons = ["" "" "" "" "" "" "" "" ""];
          };

          battery = {
              interval = 60;
              states = {
                  warning = 30;
                  critical = 15;
              };
              format = "{capacity}% {icon}";
              format-charging = "{capacity}% ";
              format-plugged = "{capacity}% ";
              format-alt = "{time} {icon}";
              format-icons = ["" "" "" "" ""];
          };

          network = {
              format-wifi = "{essid} ({signalStrength}%) ";
              format-ethernet = "{ipaddr}/{cidr} ";
              tooltip-format = "{ifname} via {gwaddr} ";
              format-linked = "{ifname} (No IP) ";
              format-disconnected =  "Disconnected ⚠";
              format-alt = "{ifname}: {ipaddr}/{cidr}";
          };

          pulseaudio = {
              format = "{icon}";
              format-bluetooth = "{icon}";
              format-bluetooth-muted = "󰖁 {icon}";
              format-muted = "󰖁";
              format-icons = {
                  headphone = "";
                  hands-free = "";
                  headset = "";
                  default = ["" "" ""];
              };
              on-click = "pavucontrol";
          };

          "custom/lock" = {
              tooltip = false;
              on-click = "swaylock";
              format = "    ";
          };

          mpris = {
              format = "{player_icon} {title}";
              format-paused = "{status_icon} <i>{title}</i>";
              player-icons = {
                  spotify = "";
                  default = "▶";
              };
              status-icons = {
                  Playing = "▶";
                  Paused = "";
                  Stopped = " ";
              };
          };

          "custom/wallpaper" = {
              format = "wallpaper";
              on-click = "bash ~/nixos-config/home-manager/waybar/scripts/changewallpaper.sh";
          };

          "custom/power-menu" = {
              format = "";
              on-click = "bash ~/nixos-config/home-manager/waybar/scripts/power-menu/powermenu.sh &";
          };
        };
      };
      style = ''
        * {
            /* `otf-font-awesome` is required to be installed for icons */
            font-family: FontAwesome, Iosevka Nerd Font;
            font-size: 13px;
        }

        #temperature,
        #mpris,
        #cpu,
        #memory,
        #window,
        #network,
        #pulseaudio,
        #backlight,
        #battery,
        #clock,
        #tray,
        #wallpaper,
        #custom-power-menu {
            padding: 0 10px;
            border-radius: 15px;
            background: #11111b;
            color: #ffffff;
            box-shadow: rgba(0, 0, 0, 0.116) 2 2 5 2px;
            margin-top: 10px;
            margin-bottom: 10px;
            margin-right: 10px;
        }

        window#waybar {
            background-color: transparent;
        }

        window#waybar.hidden {
            opacity: 0.2;
        }

        /*
        window#waybar.empty {
            background-color: transparent;
        }
        window#waybar.solo {
            background-color: #FFFFFF;
        }
        */

        window#waybar.termite {
            background-color: #3F3F3F;
        }

        window#waybar.chromium {
            background-color: #000000;
            border: none;
        }

        button {
            /* Use box-shadow instead of border so the text isn't offset */
            box-shadow: inset 0 -3px transparent;
            /* Avoid rounded borders under each button name */
            border: none;
            border-radius: 0;
        }

        /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
        button:hover {
            background: inherit;
            box-shadow: inset 0 -3px #ffffff;
        }

        #workspaces {
            background-color: transparent;
            margin: 10px;
        }

        #workspaces button {
            box-shadow: rgba(0, 0, 0, 0.116) 2 2 5 2px;
            border-radius: 15px;
            margin-right: 10px;
            padding: 10px;
            padding-top: 4px;
            padding-bottom: 2px;
            font-weight: bolder;
            color: #ffffff;
            background-color: #11111b;
        }

        #workspaces button:hover {
            background: rgba(0, 0, 0, 0.2);
        }

        #workspaces button.focused {
            background-color: #64727D;
            box-shadow: inset 0 -3px #ffffff;
        }

        #workspaces button.urgent {
            background-color: #eb4d4b;
        }

        #mode {
            background-color: #64727D;
            border-bottom: 3px solid #ffffff;
        }

        /* If workspaces is the leftmost module, omit left margin */
        .modules-left > widget:first-child > #workspaces {
            margin-left: 0;
        }

        /* If workspaces is the rightmost module, omit right margin */
        .modules-right > widget:last-child > #workspaces {
            margin-right: 0;
        }

        #clock {
            background-color: #64727D;
        }

        #battery {
            background-color: #ffffff;
            color: #000000;
        }

        #battery.charging, #battery.plugged {
            color: #ffffff;
            background-color: #26A65B;
        }

        @keyframes blink {
            to {
                background-color: #ffffff;
                color: #000000;
            }
        }

        #battery.critical:not(.charging) {
            background-color: #f53c3c;
            color: #ffffff;
            animation-name: blink;
            animation-duration: 0.5s;
            animation-timing-function: linear;
            animation-iteration-count: infinite;
            animation-direction: alternate;
        }

        label:focus {
            background-color: #000000;
        }

        #cpu {
            background-color: #2ecc71;
            color: #000000;
        }

        #memory {
            background-color: #9b59b6;
        }

        #disk {
            background-color: #964B00;
        }

        #backlight {
            background-color: #90b1b1;
        }

        #network {
            background-color: #2980b9;
        }

        #network.disconnected {
            background-color: #f53c3c;
        }

        #pulseaudio {
            background-color: #f1c40f;
            color: #000000;
        }

        #pulseaudio.muted {
            background-color: #90b1b1;
            color: #2a5c45;
        }

        #wireplumber {
            background-color: #fff0f5;
            color: #000000;
        }

        #wireplumber.muted {
            background-color: #f53c3c;
        }

        #custom-media {
            background-color: #66cc99;
            color: #2a5c45;
            min-width: 100px;
        }

        #custom-media.custom-spotify {
            background-color: #66cc99;
        }

        #custom-media.custom-vlc {
            background-color: #ffa000;
        }

        #temperature {
            background-color: #f0932b;
            margin-left: 10px;
        }

        #temperature.critical {
            background-color: #eb4d4b;
        }

        #tray {
            background-color: #2980b9;
        }

        #tray > .passive {
            -gtk-icon-effect: dim;
        }

        #tray > .needs-attention {
            -gtk-icon-effect: highlight;
            background-color: #eb4d4b;
        }

        #idle_inhibitor {
            background-color: #2d3436;
        }

        #idle_inhibitor.activated {
            background-color: #ecf0f1;
            color: #2d3436;
        }

        #mpris {
            background-color: #66cc99;
        }

        #mpd {
            background-color: #66cc99;
            color: #2a5c45;
        }

        #mpd.disconnected {
            background-color: #f53c3c;
        }

        #mpd.stopped {
            background-color: #90b1b1;
        }

        #mpd.paused {
            background-color: #51a37a;
        }

        #language {
            background: #00b093;
            color: #740864;
            padding: 0 5px;
            margin: 0 5px;
            min-width: 16px;
        }

        #keyboard-state {
            background: #97e1ad;
            color: #000000;
            padding: 0 0px;
            margin: 0 5px;
            min-width: 16px;
        }

        #keyboard-state > label {
            padding: 0 5px;
        }

        #keyboard-state > label.locked {
            background: rgba(0, 0, 0, 0.2);
        }

        #scratchpad {
            background: rgba(0, 0, 0, 0.2);
        }

        #scratchpad.empty {
          background-color: transparent;
        }

        #custom-power-menu {
            background-color: #f53c3c;
        }
      '';
    };
  };
}
