const std = @import("std");
const perm = @import("perm.zig");

const Perm4 = perm.Perm(4, u8);

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.writeAll("\nP E R M U T A T I O N S\n\n");
    const a = Perm4.identity;
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
