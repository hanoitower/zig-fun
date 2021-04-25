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

test "single roman lowercase letters" {
    expect(roman_num.parse("i") == 1);
    expect(roman_num.parse("v") == 5);
    expect(roman_num.parse("x") == 10);
    expect(roman_num.parse("l") == 50);
    expect(roman_num.parse("c") == 100);
    expect(roman_num.parse("d") == 500);
    expect(roman_num.parse("m") == 1000);
}

test "roman numbers without substraction" {
    expect(roman_num.parse("II") == 2);
    expect(roman_num.parse("III") == 3);
    expect(roman_num.parse("VI") == 6);
    expect(roman_num.parse("VII") == 7);
    expect(roman_num.parse("VIII") == 8);
    expect(roman_num.parse("XI") == 11);
    expect(roman_num.parse("XII") == 12);
    expect(roman_num.parse("XIII") == 13);
    expect(roman_num.parse("XV") == 15);
    expect(roman_num.parse("XVI") == 16);
    expect(roman_num.parse("XVII") == 17);
    expect(roman_num.parse("XVIII") == 18);
    expect(roman_num.parse("XX") == 20);
    expect(roman_num.parse("XXX") == 30);
    expect(roman_num.parse("LX") == 60);
    expect(roman_num.parse("LXX") == 70);
    expect(roman_num.parse("LXXX") == 80);
    expect(roman_num.parse("CI") == 101);
    expect(roman_num.parse("DI") == 501);
    expect(roman_num.parse("MI") == 1001);
    expect(roman_num.parse("MDCLXXVIII") == 1678);
}

test "roman numbers with substraction" {
    expect(roman_num.parse("IV") == 4);
    expect(roman_num.parse("IX") == 9);
    expect(roman_num.parse("XL") == 40);
    expect(roman_num.parse("XC") == 90);
    expect(roman_num.parse("CD") == 400);
    expect(roman_num.parse("CM") == 900);
    expect(roman_num.parse("MCMLXXXIV") == 1984);
}

pub fn main() anyerror!void {
    const roman = "MCMIX";
    var value = roman_num.parse(roman);
    try stdout.writer().print("{s} = {d}\n", .{ roman, value });
}
