const std = @import("std");

pub const Perm = struct {
    const len = 4;
    const ElementType = u8;

    elements: [len]ElementType,

    pub const identity = calc: {
        var p: Perm = undefined;
        var i: usize = 0;
        while (i < len) : (i += 1) {
            p.elements[i] = @intCast(ElementType, i);
        }
        break :calc p;
    };

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

    pub fn multiply_self(self: *Perm, a: *const Perm) void {
        var i: usize = 0;
        while (i < len) : (i += 1) {
            self.elements[i] = a.elements[self.elements[i]];
        }
    }

    pub fn format(self: *const Perm, comptime fmt: []const u8, options: std.fmt.FormatOptions, writer: anytype) !void {
        try writer.writeAll("perm[");
        var i: usize = 0;
        while (i < len) : (i += 1) {
            try writer.print(" {d} -> {d} ", .{ i, self.elements[i] });
        }
        try writer.writeAll("]");
    }
};

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.writeAll("\nP E R M U T A T I O N S\n\n");
    const a: Perm = Perm.identity;
    // a.identity();
    try stdout.print("a := {s}\n\n", .{a});
    var b = a;
    b.swap_elements(0, 1);
    b.swap_elements(1, 2);
    // b.swap_elements(2, 3);
    try stdout.print("b := {s}\n\n", .{b});
    var c = b;
    c.multiply_self(&b);
    try stdout.print("c := b x b = {s}\n\n", .{c});
    c.multiply_self(&b);
    try stdout.print("c := c x b = {s}\n\n", .{c});
}
