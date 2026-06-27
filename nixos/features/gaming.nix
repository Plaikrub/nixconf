{ inputs, self, ... }: {
    flake.nixosModules.gaming = {
        pkgs,
        lib,
        ...
    }: {
        hardware.graphics.enable = lib.mkDefault true;

        programs = {
            gamemode.enable = true;
            gamescope.enable = true;
            steam = {
                enable = true;
                extraCompatPackages = with pkgs; [
                    proton-ge-bin
                ];
                protontricks.enable = true;
            };
        };

        environment.systemPackages = with pkgs; [
            steam-run
            steamtinkerlaunch
            protonup-qt
            dxvk
            mangohud
            winetricks
            wineWow64Packages.staging
            umu-launcher
            # Wrapped umu-run with separate wine prefix
            self.packages.${pkgs.stdenv.hostPlatform.system}.umu

            # Launcher tools
            bottles
            prismlauncher
            heroic
            mcpelauncher-client
            mcpelauncher-ui-qt
        ];

        # Use nix-gaming binary cache
        nix.settings = {
            substituters = ["https://nix-gaming.cachix.org"];
            trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
        };
    };

    perSystem = { pkgs, ... }: {
        # Wrapped umu-run that uses a separate wine prefix under ~/.local/prefixes/umu
        # so it doesn't conflict with your regular wine prefix
        packages.umu = pkgs.writeShellApplication {
            name = "umu";

            runtimeInputs = [ pkgs.umu-launcher ];

            text = ''
                export WINEPREFIX="$HOME/.local/prefixes/umu"
                export PROTONPATH="${pkgs.proton-ge-bin}"
                exec umu-run "$@"
            '';
        };
    };
}