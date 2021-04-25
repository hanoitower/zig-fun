const std = @import("std");

const roman_num = @import("roman_num.zig");

const expect = @import("std").testing.expect;
const expectError = @import("std").testing.expectError;

test "single roman uppercase letters" {
    expect(1 == try roman_num.parse("I"));
    expect(5 == try roman_num.parse("V"));
    expect(10 == try roman_num.parse("X"));
    expect(50 == try roman_num.parse("L"));
    expect(100 == try roman_num.parse("C"));
    expect(500 == try roman_num.parse("D"));
    expect(1000 == try roman_num.parse("M"));
}

test "single roman lowercase letters" {
    expect(1 == try roman_num.parse("i"));
    expect(5 == try roman_num.parse("v"));
    expect(10 == try roman_num.parse("x"));
    expect(50 == try roman_num.parse("l"));
    expect(100 == try roman_num.parse("c"));
    expect(500 == try roman_num.parse("d"));
    expect(1000 == try roman_num.parse("m"));
}

test "roman numbers without substraction" {
    expect(2 == try roman_num.parse("II"));
    expect(3 == try roman_num.parse("III"));
    expect(6 == try roman_num.parse("VI"));
    expect(7 == try roman_num.parse("VII"));
    expect(8 == try roman_num.parse("VIII"));
    expect(11 == try roman_num.parse("XI"));
    expect(12 == try roman_num.parse("XII"));
    expect(13 == try roman_num.parse("XIII"));
    expect(15 == try roman_num.parse("XV"));
    expect(16 == try roman_num.parse("XVI"));
    expect(17 == try roman_num.parse("XVII"));
    expect(18 == try roman_num.parse("XVIII"));
    expect(20 == try roman_num.parse("XX"));
    expect(30 == try roman_num.parse("XXX"));
    expect(60 == try roman_num.parse("LX"));
    expect(70 == try roman_num.parse("LXX"));
    expect(80 == try roman_num.parse("LXXX"));
    expect(101 == try roman_num.parse("CI"));
    expect(501 == try roman_num.parse("DI"));
    expect(1001 == try roman_num.parse("MI"));
    expect(1678 == try roman_num.parse("MDCLXXVIII"));
}

test "roman numbers with substraction" {
    expect(4 == try roman_num.parse("IV"));
    expect(9 == try roman_num.parse("IX"));
    expect(40 == try roman_num.parse("XL"));
    expect(90 == try roman_num.parse("XC"));
    expect(400 == try roman_num.parse("CD"));
    expect(900 == try roman_num.parse("CM"));
    expect(1984 == try roman_num.parse("MCMLXXXIV"));
}

test "roman numbers with irregular substraction" {
    expect(8 == try roman_num.parse("IIX"));
    expect(17 == try roman_num.parse("IIIXX"));
    expect(18 == try roman_num.parse("IIXX"));
    expect(18 == try roman_num.parse("XIIX"));
    expect(28 == try roman_num.parse("XXIIX"));
    expect(97 == try roman_num.parse("IIIC"));
    expect(98 == try roman_num.parse("IIC"));
    expect(99 == try roman_num.parse("IC"));
}

test "invalid roman letters" {
    expectError(roman_num.ParseError.InvalidLetter, roman_num.parse("A"));
}

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
