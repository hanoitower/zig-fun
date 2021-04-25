//
// roman_num.zig
//
// roman numerals
//

pub fn parse(roman_num: []const u8) u16 {
    var value: u16 = 0;
    for (roman_num) |roman_letter| {
        if (roman_letter == 'I') {
            value += 1;
        } else if (roman_letter == 'V') {
            value += 5;
        } else if (roman_letter == 'X') {
            value += 10;
        } else if (roman_letter == 'L') {
            value += 50;
        } else if (roman_letter == 'C') {
            value += 100;
        } else if (roman_letter == 'D') {
            value += 500;
        } else if (roman_letter == 'M') {
            value += 1000;
        } else {
            // ignore all other letters
        }
    }
    return value;
}
