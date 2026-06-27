{
    flake.diskoConfigurations.hostMain = {
        disko.devices = {
            disk.nvme0 = {
                type = "disk";
                device = "/dev/disk/by-id/nvme-SPCC_M.2_PCIe_SSD_DBEE073B126600693077";
                content = {
                    type = "gpt";
                    partitions = {
                        boot = {
                            name = "boot";
                            size = "1M";
                            type = "EF02";
                        };
                        esp = {
                            name = "ESP";
                            size = "1G";
                            type = "EF00";
                            content = {
                                type = "filesystem";
                                format = "vfat";
                                mountpoint = "/boot";
                                mountOptions = ["umask=0077"];
                            };
                        };
                        swap = {
                            size = "16G";
                            content = {
                                type = "swap";
                                resumeDevice = true;
                            };
                        };
                        root = {
                            name = "NixOS";
                            size = "100%FREE";
                            content = {
                                type = "btrfs";
                                extraArgs = [
                                    "-f"
                                    "-d" "raid0"
                                    "-m" "raid1"
                                    "/dev/disk/by-id/nvme-WDC_WDS100T2B0C-00PXH0_211821800546"
                                ];
                                subvolumes = {
                                    "/@" = {
                                        mountOptions = ["subvol=@" "compress=zstd" "noatime"];
                                        mountpoint = "/";
                                    };
                                    "/@home" = {
                                        mountOptions = ["subvol=@home" "compress=zstd" "noatime"];
                                        mountpoint = "/home";
                                    };
                                    "/@nix" = {
                                        mountOptions = ["subvol=@nix" "compress=zstd" "noatime"];
                                        mountpoint = "/nix";
                                    };
                                };
                            };
                        };
                    };
                };
            };
            disk.nvme1 = {
                type = "disk";
                device = "/dev/disk/by-id/nvme-WDC_WDS100T2B0C-00PXH0_211821800546";
                content = {
                    type = "gpt";
                    partitions = {};
                };
            };
        };
    };
}