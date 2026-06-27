{
    flake.nixosModules.pipewire = {pkgs, ...}: {
        security.rtkit.enable = true;
        services.pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
            jack.enable = true;

            configPackages = [pkgs.deepfilternet];
            extraLadspaPackages = [pkgs.deepfilternet];
            extraConfig = {
                pipewire = {
                    "90-defaults" = {
                        "context.properties" = {
                            "clock.power-of-two-quantum" = true;
                            "core.daemon" = true;
                            "core.name" = "pipewire-0";
                            "link.max-buffers" = 16;
                            "settings.check-quantum" = true;

                            "default.clock.rate" = 96000;
                            "default.clock.allowed-rates" = [44100 48000 88200 96000 192000 352800 384000];
                            "default.clock.quantum" = 256;
                            "default.clock.min-quantum" = 32;
                            "default.clock.max-quantum" = 4096;
                        };
                        "stream.properties" = {
                            "resample.quality" = 10;
                        };
                    };

                    "90-disable-bell" = {
                        "context.properties" = {
                            "module.x11.bell" = false;
                        };
                    };
                };

                pipewire-pulse = {
                    "90-defaults" = {
                        "context.spa-libs" = {
                            "audio.convert.*" = "audioconvert/libspa-audioconvert";
                            "support.*" = "support/libspa-support";
                        };

                        "stream.properties" = {
                            "resample.quality" = 10;
                        };

                        "pulse.properties" = {
                            "server.address" = ["unix:native"];
                        };
                    };
                };

                # virtual sinks for per-app volume control
                # ponytail: null sinks + loopback to default output, no WirePlumber rules needed
                pipewire."98-virtual-sinks" = {
                    "context.modules" = [
                        {
                            name = "libpipewire-module-null-sink";
                            args = {
                                "node.name" = "browser";
                                "node.description" = "Browser";
                                "media.class" = "Audio/Sink";
                                "audio.rate" = 48000;
                                "audio.channels" = 2;
                            };
                        }
                        {
                            name = "libpipewire-module-loopback";
                            args = {
                                "capture.props" = {
                                    "node.name" = "browser-loopback";
                                    "node.target" = "browser";
                                    "stream.capture.sink" = true;
                                };
                                "playback.props" = {};
                            };
                        }
                        {
                            name = "libpipewire-module-null-sink";
                            args = {
                                "node.name" = "discord";
                                "node.description" = "Discord";
                                "media.class" = "Audio/Sink";
                                "audio.rate" = 48000;
                                "audio.channels" = 2;
                            };
                        }
                        {
                            name = "libpipewire-module-loopback";
                            args = {
                                "capture.props" = {
                                    "node.name" = "discord-loopback";
                                    "node.target" = "discord";
                                    "stream.capture.sink" = true;
                                };
                                "playback.props" = {};
                            };
                        }
                    ];
                };

                # cooler denoising
                pipewire."99-input-denoising" = {
                    "context.modules" = [
                        {
                            "name" = "libpipewire-module-filter-chain";
                            "args" = {
                                "node.description" = "DeepFilter Noise Cancelling Source";
                                "media.name" = "DeepFilter Noise Cancelling Source";
                                "filter.graph" = {
                                    "nodes" = [
                                        {
                                            "type" = "ladspa";
                                            "name" = "DeepFilter Mono";
                                            "plugin" = "libdeep_filter_ladspa";
                                            "label" = "deep_filter_mono";
                                            "control" = {
                                                "Attenuation Limit (dB)" = 100;
                                            };
                                        }
                                    ];
                                };
                                "audio.rate" = 48000;
                                "capture.props" = {
                                    "node.name" = "deep_filter_mono_input";
                                    "node.passive" = true;
                                };
                                "playback.props" = {
                                    "node.name" = "deep_filter_mono_output";
                                    "media.class" = "Audio/Source";
                                };
                            };
                        }
                    ];
                };
            };
        };
    };
}