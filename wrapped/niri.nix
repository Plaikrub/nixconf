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
            prefer-no-csd = null;

            input = {
                focus-follows-mouse = null;

                keyboard = {
                    xkb = {
                        layout = "us,th";
                        options = "grp:alt_shift_toggle";
                    };
                    repeat-rate = 40;
                    repeat-delay = 250;
                };

                touchpad = {
                    natural-scroll = null;
                    tap = null;
                };

                mouse = {
                    accel-profile = "flat";
                };
            };

            binds = {
                "Mod+Return".spawn = config.terminal;

                "Mod+Q".close-window = null;
                "Mod+F".maximize-column = null;
                "Mod+G".fullscreen-window = null;
                "Mod+Shift+F".toggle-window-floating = null;
                "Mod+C".center-column = null;

                "Mod+H".focus-column-left = null;
                "Mod+L".focus-column-right = null;
                "Mod+K".focus-window-up = null;
                "Mod+J".focus-window-down = null;

                "Mod+Left".focus-column-left = null;
                "Mod+Right".focus-column-right = null;
                "Mod+Up".focus-window-up = null;
                "Mod+Down".focus-window-down = null;

                "Mod+Shift+H".move-column-left = null;
                "Mod+Shift+L".move-column-right = null;
                "Mod+Shift+K".move-window-up = null;
                "Mod+Shift+J".move-window-down = null;

                "Mod+1".focus-workspace = "w0";
                "Mod+2".focus-workspace = "w1";
                "Mod+3".focus-workspace = "w2";
                "Mod+4".focus-workspace = "w3";
                "Mod+5".focus-workspace = "w4";
                "Mod+6".focus-workspace = "w5";
                "Mod+7".focus-workspace = "w6";
                "Mod+8".focus-workspace = "w7";
                "Mod+9".focus-workspace = "w8";

                "Mod+Shift+1".move-column-to-workspace = "w0";
                "Mod+Shift+2".move-column-to-workspace = "w1";
                "Mod+Shift+3".move-column-to-workspace = "w2";
                "Mod+Shift+4".move-column-to-workspace = "w3";
                "Mod+Shift+5".move-column-to-workspace = "w4";
                "Mod+Shift+6".move-column-to-workspace = "w5";
                "Mod+Shift+7".move-column-to-workspace = "w6";
                "Mod+Shift+8".move-column-to-workspace = "w7";
                "Mod+Shift+9".move-column-to-workspace = "w8";

                # Switch between monitors
                "Mod+Period".focus-monitor-right = null;
                "Mod+Comma".focus-monitor-left = null;
                "Mod+Shift+Period".move-column-to-monitor-right = null;
                "Mod+Shift+Comma".move-column-to-monitor-left = null;

                "Mod+S".spawn-sh = "${noctaliaExe} ipc call launcher toggle";
                "Mod+V".spawn-sh = "${pkgs.alsa-utils}/bin/amixer sset Capture toggle";

                "XF86AudioRaiseVolume".spawn-sh = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+";
                "XF86AudioLowerVolume".spawn-sh = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-";

                "Mod+Ctrl+H".set-column-width = "-5%";
                "Mod+Ctrl+L".set-column-width = "+5%";
                "Mod+Ctrl+J".set-window-height = "-5%";
                "Mod+Ctrl+K".set-window-height = "+5%";

                "Mod+WheelScrollDown".focus-column-left = null;
                "Mod+WheelScrollUp".focus-column-right = null;
                "Mod+Ctrl+WheelScrollDown".focus-workspace-down = null;
                "Mod+Ctrl+WheelScrollUp".focus-workspace-up = null;

                "Mod+Ctrl+S".spawn-sh = "${pkgs.grim}/bin/grim -l 0 - | ${pkgs.wl-clipboard}/bin/wl-copy";

                "Mod+Shift+E".spawn-sh = "${pkgs.wl-clipboard}/bin/wl-paste | ${pkgs.swappy}/bin/swappy -f -";

                "Mod+Shift+S".spawn-sh = "${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp -w 0)\" - | ${pkgs.wl-clipboard}/bin/wl-copy";
            };

            layout = {
                gaps = 2;
                focus-ring = {
                    width = 1;
                    active-color = "#${self.themeNoHash.base09}";
                };
            };

            window-rules = [
                # Brave (Work) -- Default profile
                {
                    matches = [{ app-id = "Brave-browser"; title = ".* — Work — Brave"; }];
                    open-on-workspace = "w0";
                }
                # Brave (Personal) -- Profile 1
                {
                    matches = [{ app-id = "Brave-browser"; title = ".* — Personal — Brave"; }];
                    open-on-workspace = "w1";
                }
                # Coding: VS Code, IntelliJ IDEA
                {
                    matches = [
                        { app-id = "code-url-handler"; }
                        { app-id = "Code"; }
                        { app-id = "jetbrains-idea"; }
                        { app-id = "jetbrains-idea-ce"; }
                        { app-id = "jetbrains-idea-ultimate"; }
                    ];
                    open-on-workspace = "w2";
                }
                # Gaming: Steam, games
                {
                    matches = [
                        { app-id = "steam"; }
                        { app-id = "Steam"; }
                        { app-id = "gamescope"; }
                    ];
                    open-on-workspace = "w3";
                }
                # Brave (Personal) -- second window on w4
                {
                    matches = [{ app-id = "Brave-browser"; title = ".* — Personal — Brave"; }];
                    open-on-workspace = "w4";
                }
                # Discord (Vesktop)
                {
                    matches = [{ app-id = "vesktop"; }];
                    open-on-workspace = "w5";
                }
                # Bitwarden
                {
                    matches = [{ app-id = "Bitwarden"; }];
                    open-on-workspace = "w6";
                }
                # Mail (Thunderbird)
                {
                    matches = [{ app-id = "thunderbird"; }];
                    open-on-workspace = "w7";
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
                            x = 1;
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
                # DP-1 (left monitor): workspaces 1-4
                "w0" = settings // monitor1;
                "w1" = settings // monitor1;
                "w2" = settings // monitor1;
                "w3" = settings // monitor1;
                # HDMI-A-1 (right monitor): workspaces 5-9
                "w4" = settings // monitor2;
                "w5" = settings // monitor2;
                "w6" = settings // monitor2;
                "w7" = settings // monitor2;
                "w8" = settings // monitor2;
            };

            xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

            spawn-at-startup = [
                noctaliaExe
                "${pkgs.swaybg}/bin/swaybg -c 181818"
                # Autostart apps (except coding tools)
                "brave --profile-directory=Default"
                "brave --profile-directory=Profile\\ 1"
                "vesktop"
                "bitwarden-desktop"
                "thunderbird"
            ];
        };
    };
}