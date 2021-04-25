const std = @import("std");

const roman_num = @import("roman_num.zig");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    const stdin = std.io.getStdIn();
    while (true) {
        try stdout.print("Enter a roman numeral: ", .{});
        var line_buf: [20]u8 = undefined;
        const amt = try stdin.read(&line_buf);
        if (amt == line_buf.len) {
            try stdout.print("Input too long.\n", .{});
            break;
        }
        const line = std.mem.trim(u8, line_buf[0..amt], " \r\n");
        const value = roman_num.parse(line) catch |err| {
            try stdout.print("The input '{s}' is not a roman numeral.\n", .{line});
            continue;
        };
        if (value == 0) {
            break;
        }
        try stdout.print("The roman numeral {s} is {d}\n", .{ line, value });
    }
}
