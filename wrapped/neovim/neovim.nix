{ self, ... }: {
    flake.wrappers.neovim = { config, wlib, lib, pkgs, ... }: {
        imports = [wlib.wrapperModules.neovim];

        settings.config_directory = ./.;

        specs.init = {
            before = ["MAIN_INIT"];
            config = "require('init')";
            data = null;
        };

        specs.plugins = {
            after = ["init"];
            before = ["MAIN_INIT"];
            data = [
                pkgs.vimPlugins.lz-n
                pkgs.vimPlugins.plenary-nvim
                pkgs.vimPlugins.nvim-lspconfig
                pkgs.vimPlugins.nvim-treesitter.withAllGrammars

                pkgs.vimPlugins.nvim-web-devicons
                pkgs.vimPlugins.lspkind-nvim
                pkgs.vimPlugins.colorful-menu-nvim
                pkgs.vimPlugins.blink-cmp

                pkgs.vimPlugins.snacks-nvim
                pkgs.vimPlugins.oil-nvim
                pkgs.vimPlugins.lualine-nvim
                pkgs.vimPlugins.luasnip

                # Indent guide lines
                pkgs.vimPlugins.indent-blankline-nvim
            ];
        };

        specs.lazyPlugins = {
            lazy = true;
            data = [
                pkgs.vimPlugins.lazydev-nvim
                pkgs.vimPlugins.gitsigns-nvim
                pkgs.vimPlugins.nvim-autopairs
                pkgs.vimPlugins.fastaction-nvim
                pkgs.vimPlugins.mini-files
                pkgs.vimPlugins.codecompanion-nvim
            ];
        };
    };

    flake.wrappers.neovimDynamic = { config, wlib, lib, pkgs, ... }: {
        imports = [wlib.wrapperModules.neovim];

        settings.config_directory = lib.generators.mkLuaInline "vim.uv.os_homedir() .. '/.local/nixconf/wrapped/neovim'";

        specs.init = {
            before = ["MAIN_INIT"];
            config = "require('init')";
            data = null;
        };

        specs.plugins = {
            after = ["init"];
            before = ["MAIN_INIT"];
            data = [
                pkgs.vimPlugins.lz-n
                pkgs.vimPlugins.plenary-nvim
                pkgs.vimPlugins.nvim-lspconfig
                pkgs.vimPlugins.nvim-treesitter.withAllGrammars

                pkgs.vimPlugins.nvim-web-devicons
                pkgs.vimPlugins.lspkind-nvim
                pkgs.vimPlugins.colorful-menu-nvim
                pkgs.vimPlugins.blink-cmp

                pkgs.vimPlugins.snacks-nvim
                pkgs.vimPlugins.oil-nvim
                pkgs.vimPlugins.lualine-nvim
                pkgs.vimPlugins.luasnip

                # Indent guide lines
                pkgs.vimPlugins.indent-blankline-nvim
            ];
        };

        specs.lazyPlugins = {
            lazy = true;
            data = [
                pkgs.vimPlugins.lazydev-nvim
                pkgs.vimPlugins.gitsigns-nvim
                pkgs.vimPlugins.nvim-autopairs
                pkgs.vimPlugins.fastaction-nvim
                pkgs.vimPlugins.mini-files
                pkgs.vimPlugins.codecompanion-nvim
            ];
        };
    };
}