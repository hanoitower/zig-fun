const std = @import("std");

const roman_num = @import("roman_num.zig");

const stdout = std.io.getStdOut();

pub fn main() anyerror!void {
    const roman = "MCMIX";
    var value = roman_num.parse(roman);
    try stdout.writer().print("{s} = {d}\n", .{ roman, value });
}
