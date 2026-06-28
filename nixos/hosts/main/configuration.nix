{ inputs, self, ... }: {
    flake.nixosConfigurations.main = inputs.nixpkgs.lib.nixosSystem {
        modules = [ self.nixosModules.hostMain ];
    };

    flake.nixosModules.hostMain = { pkgs, config, ... }: {
        imports = [
            self.nixosModules.base
            self.nixosModules.general
            self.nixosModules.network
            
            self.nixosModules.login
            self.nixosModules.desktop
            self.nixosModules.gaming
            self.nixosModules.dev

            # nirinit — niri session save/restore
            inputs.nirinit.nixosModules.nirinit

            # disko
            inputs.disko.nixosModules.disko
            self.diskoConfigurations.hostMain
        ];

        boot = {
            kernelPackages = pkgs.linuxPackages_latest;

            loader.grub.enable = true;
            loader.grub.efiSupport = true;
            loader.grub.efiInstallAsRemovable = true;
            loader.timeout = 2;

            supportedFilesystems = ["ntfs"];

            kernelParams = ["quiet"];
            kernelModules = ["coretemp" "cpuid" "v4l2loopback"];
        };

        hardware.graphics.enable = true;
        hardware.nvidia.open = true;
        hardware.nvidia.modesetting.enable = true;
        services.xserver.videoDrivers = [ "nvidia" ];

        networking = {
            hostName = "atsada-pc";
            networkmanager.enable = true;
        };

        services = {
            flatpak.enable = true;
            udisks2.enable = true;
            printing.enable = true;
        };

        programs.alvr.enable = true;
        programs.alvr.openFirewall = true;

        programs.appimage.enable = true;
        programs.appimage.binfmt = true;

        xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
        xdg.portal.enable = true;

        system.stateVersion = "26.05";
    };
}