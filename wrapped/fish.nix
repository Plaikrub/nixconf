{self, ...}: {
    flake.wrappers.fish = { wlib, pkgs, lib, ... }: {
        imports = [wlib.wrapperModules.fish];
        configFile.content = let
            selfpkgs = self.packages."${pkgs.stdenv.hostPlatform.system}";
        in
        # fish
        ''
            set fish_greeting
            fish_vi_key_bindings

            # ponytail: --no-config skips fish's default fish_history setup
            set -g fish_history fish
            set -g fish_history_max 100000
            # sync history across sessions before each command
            function _fish_sync_history --on-event fish_preexec
                history merge
            end

            if test -S $HOME/.bitwarden-ssh-agent.sock
                set -gx SSH_AUTH_SOCK $HOME/.bitwarden-ssh-agent.sock
            end

            ${lib.getExe pkgs.zoxide} init fish | source

            if type -q direnv
                direnv hook fish | source
            end

            fish_add_path $HOME/.local/share/cargo/bin $HOME/.local/share/go/bin $HOME/.local/bin

            function vi; nvim $argv; end
            function vim; nvim $argv; end
        '';
    };
}