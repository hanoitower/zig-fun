const Builder = @import("std").build.Builder;
const Package = @import("std").build.Pkg;

const myrand_package = Package{
    .name = "myrand",
    .path = "../../common/lib/myrand.zig",
};

const cimport_package = Package{
    .name = "cimport",
    .path = "lib/c.zig",
};

const simple_sdl_package = Package{
    .name = "simple_sdl",
    .path = "../../common/lib/simple_sdl.zig",
    .dependencies = &[_]Package{cimport_package},
};

const simple_ttf_package = Package{
    .name = "simple_ttf",
    .path = "../../common/lib/simple_ttf.zig",
    .dependencies = &[_]Package{cimport_package},
};

pub fn build(b: *Builder) void {
    // Standard target options allows the person running `zig build` to choose
    // what target to build for. Here we do not override the defaults, which
    // means any target is allowed, and the default is native. Other options
    // for restricting supported target set are available.
    const target = b.standardTargetOptions(.{});

    // Standard release options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    const mode = b.standardReleaseOptions();

    const exe = b.addExecutable("hello_sdl", "src/main.zig");
    exe.setTarget(target);
    exe.setBuildMode(mode);
    exe.addPackage(cimport_package);
    exe.addPackage(myrand_package);
    exe.addPackage(simple_sdl_package);
    exe.addPackage(simple_ttf_package);
    exe.linkSystemLibrary("SDL2");
    exe.linkSystemLibrary("SDL2_ttf");
    exe.linkSystemLibrary("c");
    exe.install();

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
