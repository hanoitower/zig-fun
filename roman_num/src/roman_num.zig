//
// roman_num.zig
//
// roman numerals
//

pub const ParseError = error{InvalidLetter};

fn parseLetter(roman_letter: u8) ParseError!u16 {
    return switch (roman_letter) {
        'I', 'i' => 1,
        'V', 'v' => 5,
        'X', 'x' => 10,
        'L', 'l' => 50,
        'C', 'c' => 100,
        'D', 'd' => 500,
        'M', 'm' => 1000,
        else => error.InvalidLetter,
    };
}

pub fn parse(roman_num: []const u8) ParseError!u16 {
    var value: u16 = 0;
    var max_letter_value: u16 = 0;
    var len: usize = roman_num.len;
    while (len > 0) : (len -= 1) {
        const letter_value = try parseLetter(roman_num[len - 1]);
        if (letter_value >= max_letter_value) {
            value += letter_value;
            max_letter_value = letter_value;
        } else {
            value -= letter_value;
        }
    }
    return value;
}

const expect = @import("std").testing.expect;
const expectError = @import("std").testing.expectError;

test "single roman uppercase letters" {
    expect(1 == try parse("I"));
    expect(5 == try parse("V"));
    expect(10 == try parse("X"));
    expect(50 == try parse("L"));
    expect(100 == try parse("C"));
    expect(500 == try parse("D"));
    expect(1000 == try parse("M"));
}

test "single roman lowercase letters" {
    expect(1 == try parse("i"));
    expect(5 == try parse("v"));
    expect(10 == try parse("x"));
    expect(50 == try parse("l"));
    expect(100 == try parse("c"));
    expect(500 == try parse("d"));
    expect(1000 == try parse("m"));
}

test "roman numbers without substraction" {
    expect(2 == try parse("II"));
    expect(3 == try parse("III"));
    expect(6 == try parse("VI"));
    expect(7 == try parse("VII"));
    expect(8 == try parse("VIII"));
    expect(11 == try parse("XI"));
    expect(12 == try parse("XII"));
    expect(13 == try parse("XIII"));
    expect(15 == try parse("XV"));
    expect(16 == try parse("XVI"));
    expect(17 == try parse("XVII"));
    expect(18 == try parse("XVIII"));
    expect(20 == try parse("XX"));
    expect(30 == try parse("XXX"));
    expect(60 == try parse("LX"));
    expect(70 == try parse("LXX"));
    expect(80 == try parse("LXXX"));
    expect(101 == try parse("CI"));
    expect(501 == try parse("DI"));
    expect(1001 == try parse("MI"));
    expect(1678 == try parse("MDCLXXVIII"));
}

test "roman numbers with substraction" {
    expect(4 == try parse("IV"));
    expect(9 == try parse("IX"));
    expect(40 == try parse("XL"));
    expect(90 == try parse("XC"));
    expect(400 == try parse("CD"));
    expect(900 == try parse("CM"));
    expect(1984 == try parse("MCMLXXXIV"));
}

test "roman numbers with irregular substraction" {
    expect(8 == try parse("IIX"));
    expect(17 == try parse("IIIXX"));
    expect(18 == try parse("IIXX"));
    expect(18 == try parse("XIIX"));
    expect(28 == try parse("XXIIX"));
    expect(97 == try parse("IIIC"));
    expect(98 == try parse("IIC"));
    expect(99 == try parse("IC"));
}

test "invalid roman letters" {
    expectError(ParseError.InvalidLetter, parse("A"));
}
