//
// simple_ttf.zig
//

const c = @import("c.zig");
const std = @import("std");

pub fn init() !SimpleTtf {
    if (c.TTF_Init() != 0) {
        std.log.emerg("Unable to initialize TTF: {s}", .{c.SDL_GetError()});
        return error.Failed;
    }
    return SimpleTtf{};
}

pub const SimpleTtf = struct {
    pub fn deinit(self: *SimpleTtf) void {
        c.TTF_Quit();
    }
};
