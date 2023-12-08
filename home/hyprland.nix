{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./waybar.nix
  ];

  programs.lf.enable = true;
  programs.foot.enable = true;
  programs.zathura.enable = true;

  services.dunst = {
    enable = true;
  };

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "${pkgs.foot}/bin/foot";
    plugins = with pkgs; [
      rofi-top
      rofi-emoji
      rofi-calc
      rofi-file-browser
    ];
    extraConfig = {
      modi = "drun,emoji,file-browser-extended,calc,top,window";
      sidebar-mode = true;
      show-icons = true;
      # display-drun = " ";
      display-file-browser-extended = "files";
    };
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

  home.packages = with pkgs; [
    wf-recorder
    slurp
    swappy
    wl-clipboard
    cliphist
    hyprpaper
    grim
  ];

  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload = ~/.setup/resources/wallpapers/48.png
    wallpaper = eDP-1,~/.setup/resources/wallpapers/48.png
  '';

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    extraConfig = ''
      exec-once = waybar
      exec-once = dunst
      exec-once = hyprpaper
      exec-once = swaylock
      exec-once = nm-applet
      exec-once = wl-paste --watch cliphist store

      # Wallpaper
      exec = swww img ~/.setup/resources/wallpapers/48.png

      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor=,highrr,auto,1

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more

      env = XCURSOR_SIZE,24

      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input {
      kb_layout = us
      kb_variant =
      kb_model =
      kb_options =
      kb_rules =

      follow_mouse = 1

      touchpad {
          natural_scroll = yes
      }

      sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      }

      general {
      # See https://wiki.hyprland.org/Configuring/Variables/ for more

          gaps_in = 5
          gaps_out = 10
          border_size = 2

          layout = dwindle
      }

      decoration {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          rounding = 0

          blur {
              enabled = false
              size = 3
              passes = 1
          }

          active_opacity = 1.0;
          inactive_opacity = 1.0;
          fullscreen_opacity = 1.0;

          drop_shadow = yes
          shadow_range = 4
          shadow_render_power = 3
          col.shadow = rgba(1a1a1aee)
      }
      blurls = waybar

      animations {
          enabled = yes
          bezier = wind, 0.05, 0.9, 0.1, 1.05
          bezier = winIn, 0.1, 1.1, 0.1, 1.1
          bezier = winOut, 0.3, -0.3, 0, 1
          bezier = liner, 1, 1, 1, 1
          animation = windows, 1, 6, wind, slide
          animation = windowsIn, 1, 6, winIn, slide
          animation = windowsOut, 1, 5, winOut, slide
          animation = windowsMove, 1, 5, wind, slide
          animation = border, 1, 1, liner
          animation = borderangle, 1, 30, liner, loop
          animation = fade, 1, 10, default
          animation = workspaces, 1, 5, wind
      }

      dwindle {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = yes # you probably want this
      }

      master {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
          new_is_master = true
      }

      gestures {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          workspace_swipe = on
      }

      # Example per-device config
      # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
      device:epic-mouse-v1 {
          sensitivity = -0.5
      }

      # Example windowrule v1
      # windowrule = float, ^(kitty)$
      # Example windowrule v2
      # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more


      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      $mainMod = SUPER

      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      bind = $mainMod, Return, exec, foot
      bind = $mainMod, B, exec, google-chrome-stable
      bind = $mainMod SHIFT, R, exec, wf-recorder -g "$(slurp)"
      bind = $mainMod, R, exec, wf-recorder --audio --file=recording_with_audio.mp4
      bind = $mainMod, F, exec, foot -e lf
      bind = $mainMod, C, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy
      bind = $mainMod, S, exec, grim - | swappy -f -
      bind = $mainMod SHIFT, S, exec, grim -g "$(slurp)" - | swappy -f -
      bind = $mainMod, N, exec, swaync-client -t -sw
      bind = $mainMod SHIFT, Q, killactive,
      bind = $mainMod, M, exit,
      bind = $mainMod, V, togglefloating,
      bind = $mainMod SHIFT, Return, exec, rofi -show drun -show-icons
      bind = $mainMod, TAB, exec, rofi -show window
      bind = $mainMod, D, togglesplit, # dwindle
      bind = $mainMod SHIFT, F, fullscreen

      binde =, XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+
      binde =, XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-
      bind =, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

      bind =, XF86MonBrightnessDown, exec, light -U 10
      bind =, XF86MonBrightnessUp, exec, light -A 10

      # Move focus with mainMod + arrow keys
      bind = $mainMod, h, movefocus, l
      bind = $mainMod, l, movefocus, r
      bind = $mainMod, k, movefocus, u
      bind = $mainMod, j, movefocus, d

      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow
    '';
  };
}
