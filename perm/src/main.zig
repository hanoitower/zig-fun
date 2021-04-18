const std = @import("std");

pub const Perm = struct {
    const len = 4;
    const ElementType = u8;

    elements: [len]ElementType,

    pub fn identity(self: *Perm) void {
        var i: usize = 0;
        while (i < len) : (i += 1) {
            self.elements[i] = @intCast(ElementType, i);
        }
    }

    pub fn print(self: *const Perm, out: std.fs.File) !void {
        const writer = out.writer();
        try writer.writeAll("perm[");
        var i: usize = 0;
        while (i < len) : (i += 1) {
            try writer.print(" {d} -> {d} ", .{ i, self.elements[i] });
        }
        try writer.writeAll("]\n");
    }
};

pub fn main() !void {
    const stdout = std.io.getStdOut();
    try stdout.writeAll("permutations\n");
    var a: Perm = undefined;
    a.identity();
    try a.print(stdout);
}
