const std = @import("std");

const roman_num = @import("roman_num.zig");

const expect = @import("std").testing.expect;

const stdout = std.io.getStdOut();

test "single roman uppercase letters" {
    expect(roman_num.parse("I") == 1);
    expect(roman_num.parse("V") == 5);
    expect(roman_num.parse("X") == 10);
    expect(roman_num.parse("L") == 50);
    expect(roman_num.parse("C") == 100);
    expect(roman_num.parse("D") == 500);
    expect(roman_num.parse("M") == 1000);
}

pub fn main() anyerror!void {
    const roman = "MCMIX";
    var value = roman_num.parse(roman);
    try stdout.writer().print("{s} = {d}\n", .{ roman, value });
}
