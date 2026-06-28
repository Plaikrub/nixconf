{
    flake.nixosModules.network = {
        services.tailscale.enable = true;
        services.mullvad-vpn.enable = true;
        services.mullvad-vpn.enableExcludeWrapper = true;
        services.openssh.enable = true;

        fileSystems."/sys/fs/cgroup/net_cls" = {
            device = "net_cls";
            fsType = "cgroup";
            options = [ "net_cls" "x-mount.mkdir" ];
        };

        systemd.services.mullvad-cgroup-fix = {
            description = "Fix permissions for Mullvad split tunneling cgroup";
            after = [ "mullvad-daemon.service" ];
            requires = [ "mullvad-daemon.service" ];
            wantedBy = [ "multi-user.target" ];

            serviceConfig = {
                Type = "oneshot";
                RemainAfterExit = true;
                ExecStart = pkgs.writeShellScript "mullvad-cgroup-fix" ''
                    dir="/sys/fs/cgroup/net_cls/mullvad-exclusions"
                    if [ -d "$dir" ]; then
                        chmod 777 "$dir"
                        chmod 666 "$dir/cgroup.procs" 2>/dev/null || true
                        echo "Mullvad cgroup permissions fixed"
                    else
                        echo "Warning: Mullvad cgroup directory not found"
                    fi
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