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
            jetbrains.idea-oss
            jdk21
            gradle
            godot
            blockbench
            blender
            ollama
            claude-code
            lazygit
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