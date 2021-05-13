//
// readlines demo
//

const std = @import("std");

const File = std.fs.File;

pub fn main() !void {
    var my_file = try std.fs.cwd().openFile("build.zig", .{});
    defer my_file.close();

    std.log.info("All your codebase are belong to us.", .{});
}
