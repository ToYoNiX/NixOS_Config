{
  inputs,
  outputs,
  vars,
  stylix,
  lib,
  config,
  pkgs,
  ...
}: {
  services.gnome-keyring.enable = true;

  gtk = {
    enable = true;
    iconTheme = {
      name = "Zafiro-icons-Dark";
      package = pkgs.zafiro-icons;
    };
  };

  qt = {
    enable = true;
  };

  # For HYPRLAND
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    settings = {
      exec-once = [
        "uget-gtk"
        "waybar"
        "lxsession"
        "webcord"
        "swaylock"
        "swaybg -i ${vars.wallpaper} -m fill"
      ];
      input = {
        accel_profile = "flat";
      };
      "$MOD" = "SUPER";
      general = {
        sensitivity = 1.0;
        gaps_in = 5;
        gaps_out = 5;
        border_size = 3;
        apply_sens_to_raw = 0;
        resize_on_border = false;
      };
      decoration = {
        rounding = 0;
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
      };
      animations = {
        enabled = true;
        animation = [
          "windowsIn,1,6,default,slide"
          "windowsOut,1,6,default,slide"
          "windowsMove,1,6,default,slide"
          "workspaces,1,6,pop,fade"
        ];
        bezier = "pop,0.91,0.25,0.06,0.9";
      };
      blurls = [
        "gtk-layer-shell"
        "ironbar"
        "rofi"
        "notifications"
        "wlogout"
      ];
      bind = [
        "$MOD,RETURN,exec,foot"
        "$MODSHIFT,Q,killactive,"
        "$MOD,M,exit,"
        "$MOD,P,exec,rofi -show drun"
        "$MOD,B,exec,google-chrome-stable"
        "$MOD,F,exec,pcmanfm"
        "$MODSHIFT,F,fullscreen,"
        "$MOD,V,togglefloating,"

        # move to workspace
        "$MOD,1,workspace,1"
        "$MOD,2,workspace,2"
        "$MOD,3,workspace,3"
        "$MOD,4,workspace,4"
        "$MOD,5,workspace,5"
        "$MOD,6,workspace,6"
        "$MOD,7,workspace,7"
        "$MOD,8,workspace,8"
        "$MOD,9,workspace,9"
        "$MOD,0,workspace,10"

        # move window to workspace
        "$MODSHIFT,1,movetoworkspace,1"
        "$MODSHIFT,2,movetoworkspace,2"
        "$MODSHIFT,3,movetoworkspace,3"
        "$MODSHIFT,4,movetoworkspace,4"
        "$MODSHIFT,5,movetoworkspace,5"
        "$MODSHIFT,6,movetoworkspace,6"
        "$MODSHIFT,7,movetoworkspace,7"
        "$MODSHIFT,8,movetoworkspace,8"
        "$MODSHIFT,9,movetoworkspace,9"
        "$MODSHIFT,0,movetoworkspace,10"

        # mouse keybindings
        "$MOD,mouse_down,workspace,e+1"
        "$MOD,mouse_up,workspace,e-1"
      ];
      binde = [
        "$MODSHIFT,H,resizeactive, -10 0"
        "$MODSHIFT,L,resizeactive, 10 0"
        "$MODSHIFT,K,resizeactive, 0 -10"
        "$MODSHIFT,J,resizeactive, 0 10"

        "$MODSHIFT,U,exec,wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
        "$MODSHIFT,D,exec,wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
        "$MODSHIFT,M,exec,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioRaiseVolume,exec,wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume,exec,wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute,exec,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86MonBrightnessUp,exec,light -A 10"
        ",XF86MonBrightnessDown,exec,light -U 10"
      ];
      monitor = ",highrr,auto,1";
    };
  };

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

      #clock,
      #temperature,
      #battery,
      #cpu,
      #language,
      #memory,
      #network,
      #bluetooth,
      #pulseaudio,
      #tray
      {
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

      #pulseaudio {
          background: @theme_selected_bg_color;
          color: @theme_selected_fg_color;
      }

      #pulseaudio.muted {
          background: @theme_bg_color;
          color: @wm_icon_bg;
      }

      #tray {
          padding-left: 10px;
          padding-right: 10px;
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

  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      clock = true;
      indicator-idle-visible = true;
      indicator-radius = 100;
      effect-blur = "7x5";
    };
  };

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "${pkgs.foot}/bin/foot";
    plugins = with pkgs; [
      rofi-emoji
      rofi-calc
      rofi-file-browser
    ];
    extraConfig = {
      modi = "drun,emoji,file-browser-extended,window";
      sidebar-mode = true;
      show-icons = true;
      display-file-browser-extended = "files";
    };
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      ms-vscode.cpptools
      ms-python.python
      ms-python.vscode-pylance
      jnoortheen.nix-ide
      kamadorueda.alejandra
    ];
    userSettings = {
      "terminal.integrated.enableMultiLinePasteWarning" = false;
      "workbench.startupEditor" = "none";
      "explorer.confirmDragAndDrop" = false;
    };
  };

  programs.foot.enable = true;

  services.avizo.enable = true;
  services.mako.enable = true;
  services.poweralertd.enable = true;

  services.clipmenu = {
    enable = true;
    launcher = "rofi";
  };

  services.gammastep = {
    enable = true;
    provider = "geoclue2";
    tray = true;
    dawnTime = "6:00-7:45";
    duskTime = "18:35-20:15";
  };
}
