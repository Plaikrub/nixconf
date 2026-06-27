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