{
    flake.nixosModules.network = {
        services.tailscale.enable = true;
        services.mullvad-vpn.enable = true;
        services.openssh.enable = true;

        networking.firewall = {
            enable = true;
            trustedInterfaces = ["tailscale0"];
            allowedTCPPorts = [22]; # ssh
            allowedUDPPorts = [41641]; # tailscale
        };
    };
}