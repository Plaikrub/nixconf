{self, ...}: {
    flake.nixosModules.desktop = {pkgs, lib, config, ...}: let
        user = config.preferences.user.name;
        selfpkgs = self.packages."${pkgs.stdenv.hostPlatform.system}";
        # ponytail: wrap vesktop with mullvad-exclude so Discord bypasses VPN
        vesktop-split = pkgs.symlinkJoin {
            name = "vesktop";
            paths = [pkgs.vesktop];
            postBuild = ''
                rm $out/bin/vesktop
                cat > $out/bin/vesktop <<'EOF'
            #!${pkgs.bash}/bin/bash
            exec ${pkgs.mullvad}/bin/mullvad-exclude ${pkgs.vesktop}/bin/vesktop "$@"
            EOF
                chmod +x $out/bin/vesktop
            '';
        };
    in {
        imports = [
            self.nixosModules.pipewire
            self.nixosModules.brave
        ];

        programs.niri.enable = true;
        programs.niri.package = selfpkgs.niri;

        # ponytail: nirinit saves/restores window layout — replaces spawn-at-startup for most apps
        services.nirinit = {
            enable = true;
            settings = {
                skip.apps = ["steam"];
                launch = {
                    "brave-work" = ''${lib.getExe pkgs.brave} --class=brave-work --profile-directory="Default" %U'';
                    "brave-personal" = ''${lib.getExe pkgs.brave} --class=brave-personal --profile-directory="Profile 1" %U'';
                };
            };
        };

        environment.systemPackages = [
            pkgs.pcmanfm
            selfpkgs.git
            selfpkgs.terminal
            selfpkgs.noctalia-shell
            pkgs.xdg-utils
            pkgs.xdg-user-dirs
            pkgs.pwvucontrol
            pkgs.wl-clipboard
            pkgs.bitwarden-desktop
            pkgs.thunderbird

            # ponytail: desktop entry so noctalia launcher finds mullvad-exclude vesktop
            (pkgs.makeDesktopItem {
                name = "vesktop";
                desktopName = "Vesktop";
                genericName = "Discord";
                exec = "${vesktop-split}/bin/vesktop %U";
                icon = "vesktop";
                categories = [ "Network" "InstantMessaging" ];
                mimeTypes = [ "x-scheme-handler/discord" ];
            })
        ];

        fonts.packages = with pkgs; [
            noto-fonts
            noto-fonts-cjk-sans
            noto-fonts-color-emoji
            nerd-fonts.fira-code
            nerd-fonts.fira-mono
            ubuntu-sans
            cm_unicode
            corefonts
            unifont
        ];

        fonts.fontconfig.defaultFonts = {
            serif = ["Ubuntu Sans"];
            sansSerif = ["Ubuntu Sans"];
            monospace = ["FiraMono Nerd Font"];
        };

        hjem.users.${user} = {
            files.".config/user-dirs.dirs".text = ''
                XDG_DESKTOP_DIR="$HOME/desktop"
                XDG_DOWNLOAD_DIR="$HOME/downloads"
                XDG_DOCUMENTS_DIR="$HOME/documents"
                XDG_PICTURES_DIR="$HOME/media/pictures"
                XDG_MUSIC_DIR="$HOME/media/music"
                XDG_VIDEOS_DIR="$HOME/media/videos"
            '';

            clobberFiles = true;
        };

        # Tell apps to prefer dark theme
        environment.sessionVariables = {
            GTK_THEME = "Dracula:dark";
            QT_QPA_PLATFORMTHEME = "gtk2";
            QT_STYLE_OVERRIDE = "gtk2";
            MOZ_ENABLE_WAYLAND = "1";
        };

        # Libadwaita / GTK4 dark preference
        programs.dconf.profiles.user.databases = lib.mkAfter [
            {
                lockAll = false;
                settings = {
                    "org/gnome/desktop/interface" = {
                        color-scheme = "prefer-dark";
                    };
                };
            }
        ];

        time.timeZone = "Asia/Bangkok";
        i18n.defaultLocale = "en_US.UTF-8";
        i18n.extraLocaleSettings = {
            LC_ADDRESS = "th_TH.UTF-8";
            LC_IDENTIFICATION = "th_TH.UTF-8";
            LC_MEASUREMENT = "en_GB.UTF-8";
            LC_MONETARY = "en_US.UTF-8";
            LC_NAME = "en_GB.UTF-8";
            LC_NUMERIC = "en_GB.UTF-8";
            LC_PAPER = "en_GB.UTF-8";
            LC_TELEPHONE = "th_TH.UTF-8";
            LC_TIME = "th_TH.UTF-8";
        };

        services.upower.enable = true;

        security.polkit.enable = true;

        hardware = {
            enableAllFirmware = true;

            # bluetooth.enable = true;
            # bluetooth.powerOnBoot = true;

            graphics = {
                enable = true;
                enable32Bit = true;
            };
        };
    };
}