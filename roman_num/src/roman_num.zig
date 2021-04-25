//
// roman_num.zig
//
// roman numerals
//

pub const ParseError = error{InvalidLetter};

fn parseLetter(roman_letter: u8) ParseError!u16 {
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
        return error.InvalidLetter;
    }
}

pub fn parse(roman_num: []const u8) ParseError!u16 {
    var value: u16 = 0;
    var last_letter_value: u16 = 0;
    var len: usize = roman_num.len;
    while (len > 0) : (len -= 1) {
        const letter_value = try parseLetter(roman_num[len - 1]);
        if (letter_value >= last_letter_value) {
            value += letter_value;
        } else {
            value -= letter_value;
        }
        last_letter_value = letter_value;
    }
    return value;
}
