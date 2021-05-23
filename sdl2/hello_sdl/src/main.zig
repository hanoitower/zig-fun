const std = @import("std");

const c = @cImport({
    @cInclude("SDL.h");
});

pub fn main() anyerror!void {
    std.log.info("Initializing SDL...", .{});
    if (c.SDL_Init(c.SDL_INIT_VIDEO) != 0) {
        std.log.emerg("Unable to initialize SDL: {s}", .{c.SDL_GetError()});
        return error.Failed;
    }
    defer c.SDL_Quit();
    std.log.info("Initializing SDL done.", .{});
}
