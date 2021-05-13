//
// readlines demo
//

const std = @import("std");

const File = std.fs.File;

pub fn main() !void {
    var my_file = try std.fs.cwd().openFile("build.zig", .{});
    defer my_file.close();
    var buffer: [8]u8 = undefined;
    while (true) {
        const num_read = try my_file.read(&buffer);
        if (num_read == 0) break;
        std.log.info("read {} bytes.", .{num_read});
    }
    std.log.info("done.", .{});
}
