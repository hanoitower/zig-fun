//
// roman_num.zig
//
// roman numerals
//

pub fn parse(roman_num: []const u8) u16 {
    var value: u16 = 0;
    for (roman_num) |roman_letter| {
        if (roman_letter == 'I' or roman_letter == 'i') {
            value += 1;
        } else if (roman_letter == 'V' or roman_letter == 'v') {
            value += 5;
        } else if (roman_letter == 'X' or roman_letter == 'x') {
            value += 10;
        } else if (roman_letter == 'L' or roman_letter == 'l') {
            value += 50;
        } else if (roman_letter == 'C' or roman_letter == 'c') {
            value += 100;
        } else if (roman_letter == 'D' or roman_letter == 'd') {
            value += 500;
        } else if (roman_letter == 'M' or roman_letter == 'm') {
            value += 1000;
        } else {
            // ignore all other letters
        }
    }
    return value;
}
