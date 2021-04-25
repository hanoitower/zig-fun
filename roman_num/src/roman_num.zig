//
// roman_num.zig
//
// roman numerals
//

fn parseLetter(roman_letter: u8) u16 {
    if (roman_letter == 'I' or roman_letter == 'i') {
        return 1;
    } else if (roman_letter == 'V' or roman_letter == 'v') {
        return 5;
    } else if (roman_letter == 'X' or roman_letter == 'x') {
        return 10;
    } else if (roman_letter == 'L' or roman_letter == 'l') {
        return 50;
    } else if (roman_letter == 'C' or roman_letter == 'c') {
        return 100;
    } else if (roman_letter == 'D' or roman_letter == 'd') {
        return 500;
    } else if (roman_letter == 'M' or roman_letter == 'm') {
        return 1000;
    } else {
        return 0; // ignore all other letters
    }
}

pub fn parse(roman_num: []const u8) u16 {
    var value: u16 = 0;
    var i: usize = 0;
    while (i < roman_num.len) : (i += 1) {
        value += parseLetter(roman_num[i]);
    }
    return value;
}
