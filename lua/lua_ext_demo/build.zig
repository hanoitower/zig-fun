const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) void {
    const mode = b.standardReleaseOptions();
    const lib = b.addSharedLibrary("lua_ext_demo", "src/main.zig", b.version(0, 0, 1));
    lib.setBuildMode(mode);
    lib.linkSystemLibrary("lua");
    lib.linkSystemLibrary("c");
    lib.install();

    var main_tests = b.addTest("src/main.zig");
    main_tests.setBuildMode(mode);

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&main_tests.step);
}
