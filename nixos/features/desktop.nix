{self, ...}: {
    flake.nixosModules.desktop = {pkgs, lib, ...}: let
        selfpkgs = self.packages."${pkgs.stdenv.hostPlatform.system}";
    in {
        imports = [
            self.nixosModules.gtk

            self.nixosModules.pipewire
            self.nixosModules.brave
        ];

        programs.niri.enable = true;
        programs.niri.package = selfpkgs.niri;

        environment.systemPackages = [
            pkgs.pcmanfm
            selfpkgs.terminal
            selfpkgs.noctalia-shell
            pkgs.wl-clipboard
            pkgs.vesktop
            pkgs.bitwarden-desktop
            pkgs.thunderbird
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

        environment.etc."xdg/user-dirs.dirs".text = ''
            XDG_DESKTOP_DIR="$HOME/desktop"
            XDG_DOCUMENTS_DIR="$HOME/documents"
            XDG_DOWNLOAD_DIR="$HOME/downloads"
            XDG_PICTURES_DIR="$HOME/media/pictures"
            XDG_MUSIC_DIR="$HOME/media/music"
            XDG_VIDEOS_DIR="$HOME/media/videos"
        '';

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