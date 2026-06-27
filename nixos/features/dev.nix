{
    flake.nixosModules.dev = {pkgs, ...}: {
        virtualisation.docker = {
            enable = true;
            enableOnBoot = true;
            rootless = {
                enable = true;
                setSocketVariable = true;
            };
        };

        environment.systemPackages = with pkgs; [
            docker-compose
            uv
            rustup
            go
            zig
            nodejs
            vscode
            jetbrains.idea
            jdk21
            gradle
            godot
            blockbench
            blender
            claude-code
            curl
            jq
            sqlite
            httpie
            gcc
            gnumake
            cmake
            clang
            clang-tools
            pkg-config
            devenv
        ];

        services.ollama.enable = true;

        environment.sessionVariables = {
            GOPATH = "$HOME/.local/share/go";
            GOBIN = "$HOME/.local/bin";
            CARGO_HOME = "$HOME/.local/share/cargo";
            RUSTUP_HOME = "$HOME/.local/share/rustup";
            GRADLE_USER_HOME = "$HOME/.local/share/gradle";
            HERMES_HOME = "$HOME/.local/hermes";
        };
    };
}