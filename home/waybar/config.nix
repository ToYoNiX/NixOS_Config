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
    #] ++ (if config.hostId == "laptop" then [ "battery" ] else [ ])
    #++ [
    "clock"
    "tray"
  ];
  "hyprland/workspaces" = {
    "disable-scroll" = true;
    "all-outputs" = true;
    "on-click" = "activate";
    "persistent_workspaces" = {
      "1" = [];
      "2" = [];
      "3" = [];
      "4" = [];
      "5" = [];
      "6" = [];
      "7" = [];
      "8" = [];
      "9" = [];
      "10" = [];
    };
  };
  battery = {
    format = "{capacity}% {icon}";
    format-alt = "{time} {icon}";
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
  "sway/mode" = {format = ''<span style="italic">{}</span>'';};
  temperature = {
    critical-threshold = 80;
    format = "{temperatureC}°C {icon}";
    format-icons = ["" "" ""];
  };
}
