//
// readlines demo
//

const std = @import("std");

pub fn main() !void {
    const my_file = try std.fs.cwd().openFile("build.zig", .{});
    defer my_file.close();
    const std_out = std.io.getStdOut();
    var buffer: [8]u8 = undefined;
    while (true) {
        const num_read = try my_file.read(&buffer);
        if (num_read == 0) break;
        // std.log.info("read {} bytes.", .{num_read});
        try std_out.writeAll(buffer[0..num_read]);
    }
    // std.log.info("done.", .{});
}
