const std = @import("std");

const stdout = std.io.getStdOut().writer();

const cube_chain = [_]u8{ 2, 1, 1, 2, 1, 2, 1, 1, 2, 2, 1, 1, 1, 2, 2, 2, 2 };

const cell_skip = [_]i8{ 1, 5, 25, -25, -5, -1 };

var cube_cells = [_]u8{99} ** (5 * 5 * 5);

fn printCubeCells() !void {
    var p: i8 = 0;
    var iy: u8 = 0;
    while (iy < 5) : (iy += 1) {
        var ix: u8 = 0;
        while (ix < 5) : (ix += 1) {
            var iz: u8 = 0;
            while (iz < 5) : (iz += 1) {
                try stdout.print("{:3}", .{cube_cells[@intCast(usize, p)]});
                p += cell_skip[0];
            }
            try stdout.print("\n", .{});
        }
        try stdout.print("\n", .{});
    }
}

pub fn main() !void {
    try stdout.print("Cube Chain Solver\n\n", .{});
    try printCubeCells();
}
