{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  stylix.targets.waybar.enable = false;

  programs.waybar = {
    enable = true;
    style = ''
      @keyframes blink-warning {
        70% {
            color: @wm_icon_bg;
        } to {
            color: @wm_icon_bg;
            background-color: @warning_color;
        }
      }

      @keyframes blink-critical {
        70% {
            color: @wm_icon_bg;
        } to {
            color: @wm_icon_bg;
            background-color: @error_color;
        }
      }

      /* Reset all styles */
      * {
        border: none;
        border-radius: 0px;
        font-family: "JetBrainsMono Nerd Font";
        font-weight: bold;
        font-size: 13px;
        min-height: 10px;
      }

      /* The whole bar */
      #waybar {
        background: @theme_bg_color;
        opacity: 1;
      }

      #window {
        margin-left: 10px;
      }

      window#waybar {
        margin-left: 10px;
        border-radius: 0;
      }

      window#waybar.hidden {
          opacity: 0.2;
      }

      #workspaces button {
          /* To compensate for the top border and still have vertical centering */
          padding: 0 0.5em;
          margin: 4px 3px;
          color: @wm_icon_bg;
      }

      #workspaces button.active {
          border-color: @theme_selected_bg_color;
          color: @wm_icon_bg;
          background-color: @theme_selected_bg_color;
      }

      #workspaces button.focused {
          border-color: @theme_selected_bg_color;
          color: @wm_icon_bg;
          background-color: @theme_selected_bg_color;
      }

      #workspaces button.urgent {
          border-color: @error_color;
          color: @error_color;
      }

      #mode {
          background: @background_color;
      }

      #clock,
      #custom-playerctl,
      #custom-power,
      #custom-scratchpad,
      #custom-weather,
      #custom-wlsunset,
      #custom-clipboard,
      #custom-menu,
      #custom-dnd,
      #temperature,
      #battery,
      #cpu,
      #language,
      #memory,
      #network,
      #bluetooth,
      #pulseaudio,
      #tray,
      #mode,
      #idle_inhibitor {
          padding-left: 10px;
          padding-right: 10px;
          margin: 4px 3px;
      }

      #clock {
          background: @theme_selected_bg_color;
          color: @theme_selected_fg_color;
      }

      #temperature {
          background: @theme_selected_bg_color;
          color: @theme_selected_fg_color;
      }

      #custom-weather {
          background: @theme_selected_bg_color;
          color: @theme_selected_fg_color;
      }

      #custom-wlsunset {
          background: @theme_selected_bg_color;
          color: @theme_selected_fg_color;
      }

      #custom-playerctl {
          background: @theme_selected_bg_color;
          color: @theme_selected_fg_color;
      }

      #custom-power {
          background: @theme_selected_bg_color;
          color: @theme_selected_fg_color;
      }

      #custom-scratchpad {
          background: @theme_selected_bg_color;
          color: @theme_selected_fg_color;
      }

      #custom-clipboard {
          background: @theme_selected_bg_color;
          color: @theme_selected_fg_color;
      }

      #custom-menu {
          background: @theme_selected_bg_color;
          color: @theme_selected_fg_color;
      }

      #custom-dnd {
          background: @theme_selected_bg_color;
          color: @theme_selected_fg_color;
      }

      #battery {
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
          background: @theme_selected_bg_color;
          color: @theme_selected_fg_color;
      }

      #battery.warning {
          color: @warning_color;
      }

      #battery.critical {
          color: @error_color;
      }

      #battery.warning.discharging {
          animation-name: blink-warning;
          animation-duration: 3s;
      }

      #battery.critical.discharging {
          animation-name: blink-critical;
          animation-duration: 2s;
      }

      label:focus {
          background-color: #000000;
      }

      #cpu {
          background: @theme_selected_bg_color;
          color: @theme_selected_fg_color;
      }

      #language {
          background: @theme_selected_bg_color;
          color: @theme_selected_fg_color;
      }

      #memory {
          background: @theme_selected_bg_color;
          color: @theme_selected_fg_color;
      }

      #custom-gpu-usage {
          background: @theme_selected_bg_color;
          color: @theme_selected_fg_color;
      }

      #network {
          background: @theme_selected_bg_color;
          color: @theme_selected_fg_color;
      }

      #bluetooth {
          background: @theme_selected_bg_color;
          color: @theme_selected_fg_color;
      }

      #bluetooth.disabled {
          background: @theme_bg_color;
          color: @wm_icon_bg;
      }

      #network.disconnected {
          background: @theme_bg_color;
          color: @wm_icon_bg
      }

      #pulseaudio {
          background: @theme_selected_bg_color;
          color: @theme_selected_fg_color;
      }

      #pulseaudio.muted {
          background: @theme_bg_color;
          color: @wm_icon_bg;
      }

      #custom-wf-recorder {
          color: @error_color;
          padding-right: 10px;
      }

      #tray {
          padding-left: 10px;
          padding-right: 10px;
      }

      #idle_inhibitor {
          background: @theme_selected_bg_color;
      }

      #idle_inhibitor.activated {
          background: @theme_selected_bg_color;
          color: @theme_selected_fg_color;
      }
    '';
    settings = [
      {
        height = 30;
        layer = "top";
        position = "top";
        tray = {spacing = 10;};
        modules-left = [
          "cpu"
          "temperature"
          "memory"
        ];
        modules-center = [
          "hyprland/workspaces"
          "hyprland/window"
        ];
        modules-right = [
          "pulseaudio"
          "battery"
          "clock"
          "tray"
        ];
        # "hyprland/workspaces" = {
        #   "disable-scroll" = true;
        #   "all-outputs" = true;
        #   "on-click" = "activate";
        #   "persistent_workspaces" = {
        #     "1" = [];
        #     "2" = [];
        #     "3" = [];
        #     "4" = [];
        #     "5" = [];
        #     "6" = [];
        #     "7" = [];
        #     "8" = [];
        #     "9" = [];
        #     "10" = [];
        #   };
        # };
        battery = {
          format = "{capacity}% {icon}";
          # format-alt = "{time} {icon}";
          format-charging = "{capacity}% ";
          format-icons = ["" "" "" "" ""];
          format-plugged = "{capacity}% ";
          states = {
            critical = 15;
            warning = 30;
          };
        };
        clock = {
          format = "{:%a %b %d | %I:%M %p}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
        };
        cpu = {
          format = "{usage}% ";
          tooltip = false;
        };
        memory = {format = "{}% ";};
        network = {
          interval = 1;
          format-alt = "{ifname}: {ipaddr}/{cidr}";
          format-disconnected = "Disconnected ⚠";
          format-ethernet = "{ifname}: {ipaddr}/{cidr}   up: {bandwidthUpBits} down: {bandwidthDownBits}";
          format-linked = "{ifname} (No IP) ";
          format-wifi = "{essid} ({signalStrength}%) ";
        };
        pulseaudio = {
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-icons = {
            car = "";
            default = ["" "" ""];
            handsfree = "";
            headphones = "";
            headset = "";
            phone = "";
            portable = "";
          };
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          on-click = "pavucontrol";
        };
        temperature = {
          critical-threshold = 80;
          format = "{temperatureC}°C {icon}";
          format-icons = ["" "" ""];
        };
      }
    ];
  };
}
