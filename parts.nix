{inputs, ...}: {
    imports = [
        inputs.wrapper-modules.flakeModules.wrappers
    ];

    config = {
        systems = [
            "x86_64-linux"
        ];
    };
}