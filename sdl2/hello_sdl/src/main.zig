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

    const window = c.SDL_CreateWindow("Hello SDL2", c.SDL_WINDOWPOS_CENTERED, c.SDL_WINDOWPOS_CENTERED, 640, 480, 0) orelse {
        std.log.emerg("Unable to create window: {s}", .{c.SDL_GetError()});
        return error.Failed;
    };
    defer c.SDL_DestroyWindow(window);

    const renderer = c.SDL_CreateRenderer(window, -1, c.SDL_RENDERER_PRESENTVSYNC) orelse {
        std.log.emerg("Unable to create SDL renderer: {s}", .{c.SDL_GetError()});
        return error.Failed;
    };
    defer c.SDL_DestroyRenderer(renderer);

    _ = c.SDL_SetRenderDrawColor(renderer, 0, 0, 0, c.SDL_ALPHA_OPAQUE);
    _ = c.SDL_RenderClear(renderer);

    c.SDL_RenderPresent(renderer);

    c.SDL_Delay(3000);
}
