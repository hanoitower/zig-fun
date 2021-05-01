//
// perm.zig
//

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
