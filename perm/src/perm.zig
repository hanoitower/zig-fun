//
// perm.zig
//

const std = @import("std");

pub fn Perm(comptime len: usize, comptime ElementType: type) type {
    return struct {
        elements: [len]ElementType,

        const Self = @This();

        pub const identity = calc: {
            var p: Self = undefined;
            var i: usize = 0;
            while (i < len) : (i += 1) {
                p.elements[i] = @intCast(ElementType, i);
            }
            break :calc p;
        };

        pub fn swap_elements(self: *Self, i: usize, j: usize) void {
            const e = self.elements[i];
            self.elements[i] = self.elements[j];
            self.elements[j] = e;
        }

        pub fn multiply(self: *Self, a: *const Self, b: *const Self) void {
            var i: usize = 0;
            while (i < len) : (i += 1) {
                self.elements[i] = b.elements[a.elements[i]];
            }
        }

        pub fn multiply_self(self: *Self, a: *const Self) void {
            var i: usize = 0;
            while (i < len) : (i += 1) {
                self.elements[i] = a.elements[self.elements[i]];
            }
        }

        pub fn format(self: *const Self, comptime fmt: []const u8, options: std.fmt.FormatOptions, writer: anytype) !void {
            try writer.writeAll("perm[");
            var i: usize = 0;
            while (i < len) : (i += 1) {
                try writer.print(" {d} -> {d} ", .{ i, self.elements[i] });
            }
            try writer.writeAll("]");
        }
    };
}
