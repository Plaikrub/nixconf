let
    theme = {
        base00 = "#282a36"; # bg
        base01 = "#44475a"; # current line
        base02 = "#44475a"; # selection
        base03 = "#6272a4"; # comment
        base04 = "#6272a4";
        base05 = "#f8f8f2"; # fg
        base06 = "#f8f8f2"; # fg
        base07 = "#f8f8f2"; # light fg
        base08 = "#ff5555"; # red
        base09 = "#ffb86c"; # orange
        base0A = "#f1fa8c"; # yellow
        base0B = "#50fa7b"; # green
        base0C = "#8be9fd"; # cyan
        base0D = "#bd93f9"; # purple
        base0E = "#ff79c6"; # pink
        base0F = "#ffb86c"; # orange
    };

    stripHash = str:
        if builtins.substring 0 1 str == "#"
        then builtins.substring 1 (builtins.stringLength str - 1) str
        else str;

    themeNoHash = builtins.mapAttrs (_: v: stripHash v) theme;
in {
    flake = {
        inherit theme themeNoHash;
    };
}