{
    flake.wrappers.git = { wlib, pkgs, ... }: {
        imports = [wlib.modules.default];
        package = pkgs.git;
        env = {
            GIT_CONFIG_GLOBAL = toString (pkgs.writeText "gitconfig" ''
                [user]
                    name = Atsada Choichueadee
                    email = atsada.choichueadee@protonmail.com
                [init]
                    defaultBranch = main
                [push]
                    autoSetupRemote = true
                [filter "lfs"]
                    clean = git-lfs clean -- %f
                    smudge = git-lfs smudge -- %f
                    process = git-lfs filter-process
                    required = true
            '');
        };
    };
}