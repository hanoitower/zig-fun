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

    pub fn swap_elements(self: *Perm, i: usize, j: usize) void {
        const e = self.elements[i];
        self.elements[i] = self.elements[j];
        self.elements[j] = e;
    }

    pub fn multiply(self: *Perm, a: *const Perm, b: *const Perm) void {
        var i: usize = 0;
        while (i < len) : (i += 1) {
            self.elements[i] = b.elements[a.elements[i]];
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
    var b = a;
    b.swap_elements(0, 1);
    b.swap_elements(1, 2);
    b.swap_elements(2, 3);
    try b.print(stdout);
    var c: Perm = undefined;
    c.multiply(&b, &b);
    try c.print(stdout);
}
