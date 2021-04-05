const std = @import("std");

const stdout = std.io.getStdOut().writer();

const cube_size = 5;

const cube_size_sqr = cube_size * cube_size;

const cube_chain = [_]u8{ 2, 1, 1, 2, 1, 2, 1, 1, 2, 2, 1, 1, 1, 2, 2, 2, 2 };

const cell_skip = [_]i8{ 1, cube_size, cube_size_sqr, -cube_size_sqr, -cube_size, -1 };

var cube_cells = [_]u8{99} ** (cube_size * cube_size * cube_size);

fn printCubeCells() !void {
    var p: i8 = 0;
    var iy: u8 = 0;
    while (iy < cube_size) : (iy += 1) {
        var ix: u8 = 0;
        while (ix < cube_size) : (ix += 1) {
            var iz: u8 = 0;
            while (iz < cube_size) : (iz += 1) {
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
