const std = @import("std");

const myrand = @import("myrand.zig");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Guessing Game\n", .{});
    var prng = try myrand.Prng.create();
    while (true) {
        const answer = prng.uintLessThan(u8, 100) + 1;
        try stdout.print("random number: {d}\n", .{answer});
        if (answer == 0 or answer == 1) break;
    }
}
