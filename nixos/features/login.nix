{
    flake.nixosModules.login = { pkgs, lib, config, ... }: {
        services.greetd = {
            enable = true;
            settings = {
                default_session = {
                    command = "${lib.getExe pkgs.tuigreet} --time --remember --user ${config.preferences.user.name} --cmd ${config.programs.niri.package}/bin/niri-session";
                    user = config.preferences.user.name;
                };
            };
        };

        # Unlock keyring on login (needed by apps like bitwarden-desktop)
        security.pam.services.greetd.enableGnomeKeyring = true;
        services.gnome.gnome-keyring.enable = true;
    };
}