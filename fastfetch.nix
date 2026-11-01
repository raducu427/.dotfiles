{
  programs.fastfetch = {
    enable = true;
    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";

      logo = {
        padding.top = 1;
        type = "kitty";
        width = 24;
      };

      display.separator = " ";

      modules = [
        { type = "title";    keywith = "10"; }
        { type = "os";       key = " OS";        keyColor = "yellow"; }
        { type = "kernel";   key = "├󰧨  Kernel";   keyColor = "yellow"; }
        { type = "packages"; key = "├󰏖 Packages"; keyColor = "yellow"; }
        { type = "shell";    key = "└ Shell";    keyColor = "yellow"; }
        "break"
        { type = "de";           key = " DE";              keyColor = "blue"; }
        { type = "wm";           key = "├󰧨 Window Manager"; keyColor = "blue"; }
        { type = "lm";           key = "├󰧨 Login Manager";  keyColor = "blue"; }
        { type = "wmtheme";      key = "├󰉼 WM Theme";       keyColor = "blue"; }
        { type = "theme";        key = "├󰉼 Color Themes";   keyColor = "blue"; }
        { type = "icons";        key = "├󰀻 System Icons";   keyColor = "blue"; }
        { type = "cursor";       key = "├󰀻 System Cursor";  keyColor = "blue"; }
        { type = "font";         key = "├ System Fonts";   keyColor = "blue"; }
        { type = "terminal";     key = "├ Terminal";       keyColor = "blue"; }
        { type = "terminalfont"; key = "└ Terminal Font";  keyColor = "blue"; }
        "break"
        { type = "chassis"; format = "{1} Type {2}";        key = "󰌢 PC";   keyColor = "green"; }
        { type = "cpu";     format = "{1} ({3}) @ {7}"; key = "├󰻠 CPU"; keyColor = "green"; }
        { type = "gpu";     format = "{1} {2} @ {15} GHz";  key = "├󰍛 GPU"; keyColor = "green"; }
        { type = "memory";  key = "├󰍛 Memory";     keyColor = "green"; }
        { type = "swap";    key = "├󰍛 Swap";       keyColor = "green"; }
        { type = "disk";    key = "├󰍛 Disk";       keyColor = "green"; }
        { type = "opengl";  key = "├󰍛 OpenGL";     keyColor = "green"; }
        { type = "vulkan";  key = "├󰍛 Vulkan";     keyColor = "green"; }
        { type = "display"; key = "└󰍹 Display(s)"; keyColor = "green"; }
      ];
    };
  };
}
