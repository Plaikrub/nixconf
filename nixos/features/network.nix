{
    flake.nixosModules.network = {
        services.tailscale.enable = true;
        services.mullvad-vpn.enable = true;
        services.mullvad-vpn.enableExcludeWrapper = true;
        services.openssh.enable = true;

        # Mount net_cls cgroup v1 controller
        fileSystems."/sys/fs/cgroup/net_cls" = {
            device = "net_cls";
            fsType = "cgroup";
            options = [ "net_cls" "x-mount.mkdir" ];  # x-mount.mkdir ensures the dir is created
        };

        systemd.services.mullvad-cgroup-setup = {
            description = "Setup Mullvad net_cls cgroup for split tunneling";
            before = [ "mullvad-daemon.service" ];
            wantedBy = [ "mullvad-daemon.service" ];
            serviceConfig = {
                Type = "oneshot";
                RemainAfterExit = true;
                ExecStart = ''
                    /run/current-system/sw/bin/mkdir -p /sys/fs/cgroup/net_cls/mullvad-exclusions
                    /run/current-system/sw/bin/touch /sys/fs/cgroup/net_cls/mullvad-exclusions/cgroup.procs
                    /run/current-system/sw/bin/chmod 666 /sys/fs/cgroup/net_cls/mullvad-exclusions/cgroup.procs
                    /run/current-system/sw/bin/chown root:root /sys/fs/cgroup/net_cls/mullvad-exclusions/cgroup.procs
                '';
            };
        };

        networking.firewall = {
            enable = true;
            trustedInterfaces = ["tailscale0"];
            allowedTCPPorts = [22]; # ssh
            allowedUDPPorts = [41641]; # tailscale
        };
    };
}