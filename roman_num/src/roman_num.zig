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
