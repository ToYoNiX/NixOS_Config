{
  inputs,
  outputs,
  vars,
  lib,
  config,
  pkgs,
  ...
}: {
  services.gnome-keyring.enable = true;

  home.pointerCursor = {
    gtk.enable = true;

    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";

    size = 16;
  };

  gtk = {
    enable = true;

    theme = {
      name = "FlatColor";
    };

    iconTheme = {
      name = "flattrcolor";
    };
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

  # Add all wallpapers to wpgtk
  home.file."/home/assem/.config/wpg/wallpapers".source = ./../wallpapers;

  # Hyprland wpgtk template
  home.file."/home/assem/.config/wpg/templates/hyprland.conf.base".text = ''
    $MOD = SUPER
    general {{
      gaps_in = 3
      gaps_out = 8
      border_size = 2
      col.active_border = rgb({color11.strip})
      col.inactive_border = rgb({color0.strip})
      layout = dwindle
      resize_on_border = true
    }}

    group {{
      col.border_active = rgb({color11.strip})
      col.border_inactive = rgb({color0.strip})
      col.border_locked_active = rgb({color11.strip})
      col.border_locked_inactive = rgb({color0.strip})
    }}
    animations {{
      bezier=pop,0.91,0.25,0.06,0.9
      animation=windowsIn,1,6,default,slide
      animation=windowsOut,1,6,default,slide
      animation=windowsMove,1,6,default,slide
      animation=workspaces,1,6,pop,fade
      enabled=true
    }}

    decoration {{
      drop_shadow=true
      rounding=0
      shadow_range=4
      shadow_render_power=3
    }}

    general {{
      apply_sens_to_raw=0
      border_size=3
      gaps_in=5
      gaps_out=5
      resize_on_border=false
      sensitivity=1.000000
    }}

    input {{
      accel_profile=flat
    }}
    bind=$MOD,RETURN,exec,kitty
    bind=$MODSHIFT,Q,killactive,
    bind=$MOD,M,exit,
    bind=$MOD,P,exec,rofi -show drun
    bind=$MOD,B,exec,google-chrome-stable
    bind=$MOD,F,exec,pcmanfm
    bind=$MODSHIFT,F,fullscreen,
    bind=$MOD,V,togglefloating,
    bind=$MOD,1,workspace,1
    bind=$MOD,2,workspace,2
    bind=$MOD,3,workspace,3
    bind=$MOD,4,workspace,4
    bind=$MOD,5,workspace,5
    bind=$MOD,6,workspace,6
    bind=$MOD,7,workspace,7
    bind=$MOD,8,workspace,8
    bind=$MOD,9,workspace,9
    bind=$MOD,0,workspace,10
    bind=$MODSHIFT,1,movetoworkspace,1
    bind=$MODSHIFT,2,movetoworkspace,2
    bind=$MODSHIFT,3,movetoworkspace,3
    bind=$MODSHIFT,4,movetoworkspace,4
    bind=$MODSHIFT,5,movetoworkspace,5
    bind=$MODSHIFT,6,movetoworkspace,6
    bind=$MODSHIFT,7,movetoworkspace,7
    bind=$MODSHIFT,8,movetoworkspace,8
    bind=$MODSHIFT,9,movetoworkspace,9
    bind=$MODSHIFT,0,movetoworkspace,10
    bind=$MOD,mouse_down,workspace,e+1
    bind=$MOD,mouse_up,workspace,e-1
    binde=$MODSHIFT,H,resizeactive, -10 0
    binde=$MODSHIFT,L,resizeactive, 10 0
    binde=$MODSHIFT,K,resizeactive, 0 -10
    binde=$MODSHIFT,J,resizeactive, 0 10
    binde=$MODSHIFT,U,exec,wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+
    binde=$MODSHIFT,D,exec,wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-
    binde=$MODSHIFT,M,exec,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    binde=,XF86AudioRaiseVolume,exec,wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+
    binde=,XF86AudioLowerVolume,exec,wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-
    binde=,XF86AudioMute,exec,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    binde=,XF86MonBrightnessUp,exec,light -A 10
    binde=,XF86MonBrightnessDown,exec,light -U 10
    blurls=gtk-layer-shell
    blurls=ironbar
    blurls=rofi
    blurls=notifications
    blurls=wlogout
    exec-once=uget-gtk
    exec-once=lxsession
    exec-once=sleep 5 && vesktop
    exec-once=swaylock
    exec-once=~/.config/wpg/wp_init.sh
    exec=swaybg -i "$(cat ~/.cache/wal/wal)" -m fill
    exec=pkill waybar & sleep 1 && waybar
    monitor=,highrr,auto,1
  '';

  home.file = {
    hyprland_template.source = config.lib.file.mkOutOfStoreSymlink /home/assem/.config/wpg/templates/hyprland.conf;
    hyprland_template.target = "/home/assem/.config/hypr/hyprland.conf";
  };

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
      image = "$(cat ~/.cache/wal/wal)";
    };
  };

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "${pkgs.kitty}/bin/kitty";
  };
  home.file."/home/assem/.config/rofi/config.rasi".text = ''
    /* Light theme. */
    @import "~/.cache/wal/colors-rofi-light"
  '';

  programs.kitty = {
    enable = true;
    extraConfig = ''
      # Color scheme
      include ~/.cache/wal/colors-kitty.conf

      # Close confirmation 0 disables it; -1 enables it
      confirm_os_window_close 0
    '';
  };

  services.avizo.enable = true;
  services.mako.enable = true;
  services.poweralertd.enable = true;

  services.gammastep = {
    enable = true;
    provider = "geoclue2";
    tray = true;
    dawnTime = "6:00-7:45";
    duskTime = "18:35-20:15";
  };
}
