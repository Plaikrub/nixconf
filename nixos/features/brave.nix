{
    flake.nixosModules.brave = { pkgs, lib, ... }: let
        brave-bin = lib.getExe pkgs.brave;
    in {
        environment.systemPackages = [
            pkgs.brave

            # Desktop entries to launch Brave directly into specific profiles
            (pkgs.makeDesktopItem {
                name = "brave-work";
                desktopName = "Brave (Work)";
                genericName = "Web Browser";
                exec = ''${brave-bin} --class=brave-work --profile-directory="Default" %U'';
                icon = "brave";
                mimeTypes = [
                    "text/html"
                    "text/xml"
                    "application/xhtml+xml"
                    "x-scheme-handler/http"
                    "x-scheme-handler/https"
                ];
                categories = [ "Network" "WebBrowser" ];
            })

            (pkgs.makeDesktopItem {
                name = "brave-personal";
                desktopName = "Brave (Personal)";
                genericName = "Web Browser";
                exec = ''${brave-bin} --class=brave-personal --profile-directory="Profile 1" %U'';
                icon = "brave";
                mimeTypes = [
                    "text/html"
                    "text/xml"
                    "application/xhtml+xml"
                    "x-scheme-handler/http"
                    "x-scheme-handler/https"
                ];
                categories = [ "Network" "WebBrowser" ];
            })
        ];

        # Browser policies
        environment.etc."brave/policies/managed/preferences.json".text = builtins.toJSON {
            BrowserSignin = 0;
            SyncDisabled = false;
            DefaultProfileSettingAllowed = true;
        };
    };
}