{ self, lib, ... }: {
    flake.wrappers.niri = { wlib, pkgs, config, ... }: let
        noctaliaExe = lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.noctalia-shell;
    in {
        imports = [wlib.wrapperModules.niri];

        options.terminal = lib.mkOption {
            type = lib.types.str;
            default = "kitty";
        };

        config.settings = {
            prefer-no-csd = _: {};

            input = {
                focus-follows-mouse = _: {};

                keyboard = {
                    xkb = {
                        layout = "us,th";
                        options = "grp:alt_shift_toggle";
                    };
                    repeat-rate = 40;
                    repeat-delay = 250;
                };

                touchpad = {
                    natural-scroll = _: {};
                    tap = _: {};
                };

                mouse = {
                    accel-speed = 0.25;
                    accel-profile = "flat";
                };
            };

            clipboard = {
                disable-primary = _: {};
            };

            binds = {
                "Mod+Return".spawn = config.terminal;

                "Mod+Shift+Q".close-window = _: {};
                "Mod+F".maximize-column = _: {};
                "Mod+G".fullscreen-window = _: {};
                "Mod+Shift+F".toggle-window-floating = _: {};
                "Mod+C".center-column = _: {};

                "Mod+H".focus-column-left = _: {};
                "Mod+L".focus-column-right = _: {};
                "Mod+K".focus-window-up = _: {};
                "Mod+J".focus-window-down = _: {};

                "Mod+Left".focus-column-left = _: {};
                "Mod+Right".focus-column-right = _: {};
                "Mod+Up".focus-window-up = _: {};
                "Mod+Down".focus-window-down = _: {};

                "Mod+Shift+H".move-column-left = _: {};
                "Mod+Shift+L".move-column-right = _: {};
                "Mod+Shift+K".move-window-up = _: {};
                "Mod+Shift+J".move-window-down = _: {};

                "Mod+Shift+Left".move-column-left = _: {};
                "Mod+Shift+Right".move-column-right = _: {};
                "Mod+Shift+Up".move-window-up = _: {};
                "Mod+Shift+Down".move-window-down = _: {};

                "Mod+1".focus-workspace = "w0";
                "Mod+2".focus-workspace = "w1";
                "Mod+3".focus-workspace = "w2";
                "Mod+4".focus-workspace = "w3";
                "Mod+5".focus-workspace = "w4";
                "Mod+6".focus-workspace = "w5";

                "Mod+Shift+1".move-column-to-workspace = "w0";
                "Mod+Shift+2".move-column-to-workspace = "w1";
                "Mod+Shift+3".move-column-to-workspace = "w2";
                "Mod+Shift+4".move-column-to-workspace = "w3";
                "Mod+Shift+5".move-column-to-workspace = "w4";
                "Mod+Shift+6".move-column-to-workspace = "w5";

                # Switch between monitors
                "Mod+Period".focus-monitor-right = _: {};
                "Mod+Comma".focus-monitor-left = _: {};
                "Mod+Shift+Period".move-column-to-monitor-right = _: {};
                "Mod+Shift+Comma".move-column-to-monitor-left = _: {};

                "Mod+S".spawn-sh = "${noctaliaExe} ipc call launcher toggle";

                "XF86AudioRaiseVolume".spawn-sh = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+";
                "XF86AudioLowerVolume".spawn-sh = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-";

                "Mod+Ctrl+H".set-column-width = "-5%";
                "Mod+Ctrl+L".set-column-width = "+5%";
                "Mod+Ctrl+J".set-window-height = "-5%";
                "Mod+Ctrl+K".set-window-height = "+5%";

                "Mod+WheelScrollUp".focus-column-left = _: {};
                "Mod+WheelScrollDown".focus-column-right = _: {};
                "Mod+Shift+WheelScrollDown".focus-workspace-down = _: {};
                "Mod+Shift+WheelScrollUp".focus-workspace-up = _: {};

                "Mod+Ctrl+S".spawn-sh = "${pkgs.grim}/bin/grim -l 0 - | ${pkgs.wl-clipboard}/bin/wl-copy";

                "Mod+Shift+E".spawn-sh = "${pkgs.wl-clipboard}/bin/wl-paste | ${pkgs.swappy}/bin/swappy -f -";

                "Mod+Shift+S".spawn-sh = "${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp -w 0)\" - | ${pkgs.wl-clipboard}/bin/wl-copy";
            };

            layout = {
                gaps = 2;
                focus-ring = {
                    width = 1;
                    active-color = "#${self.themeNoHash.base04}";
                };
            };

            window-rules = [
                # Brave (Work) -- Default profile
                # ponytail: --class sets wayland app-id
                {
                    matches = [{ app-id = "brave-work"; }];
                    open-maximized = true;
                }
                # Brave (Personal) -- Profile 1
                {
                    matches = [{ app-id = "brave-personal"; }];
                    open-maximized = true;
                }
                # Coding: VS Code, IntelliJ IDEA
                {
                    matches = [
                        { app-id = "code-url-handler"; }
                        { app-id = "code"; }
                        { app-id = "idea"; }
                    ];
                    open-on-workspace = "w1";
                    open-maximized = true;
                }
                # Gaming: Steam, proton/wine/umu games
                # ponytail: fullscreen covers noctalia bar on w3 — no layer-rule needed
                {
                    matches = [
                        { app-id = "steam"; }
                        { app-id = "Steam"; }
                        { app-id = "gamescope"; }
                        # proton/wine/umu — app-id is usually the game exe
                        { app-id = ".exe"; }
                        { app-id = "wine"; }
                        { app-id = "proton"; }
                        { app-id = "umu"; }
                    ];
                    open-on-workspace = "w2";
                    open-fullscreen = true;
                }
                # Discord (Vesktop)
                {
                    matches = [{ app-id = "vesktop"; }];
                    open-on-workspace = "w4";
                    open-maximized = true;
                }
            ];

            outputs = {
                "DP-1" = {
                    position = _: {
                        props = {
                            x = 0;
                            y = 0;
                        };
                    };
                };
                "HDMI-A-1" = {
                    position = _: {
                        props = {
                            x = 1920;
                            y = 0;
                        };
                    };
                };
            };

            workspaces = let
                settings = {layout.gaps = 2;};
                monitor1 = { open-on-output = "DP-1"; };
                monitor2 = { open-on-output = "HDMI-A-1"; };
            in {
                # DP-1 (left monitor): workspaces 1-3
                "w0" = settings // monitor1;
                "w1" = settings // monitor1;
                "w2" = settings // monitor1;
                # HDMI-A-1 (right monitor): workspaces 4-6
                "w3" = settings // monitor2;
                "w4" = settings // monitor2;
                "w5" = settings // monitor2;
            };

            xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

            spawn-at-startup = [
                noctaliaExe
                "${pkgs.swaybg}/bin/swaybg -c ${self.themeNoHash.base00}"
                # ponytail: nirinit restores brave/vesktop/bitwarden/thunderbird from saved session
                # ponytail: steam skipped in nirinit (restore unreliable), still autostarted
                "steam"
            ];
        };
    };
}