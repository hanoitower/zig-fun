const std = @import("std");

const c = @cImport({
    @cInclude("SDL.h");
});

pub const HelloSdl = struct {
    pub fn init() !void {
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

        var quit = false;
        while (!quit) {
            var event: c.SDL_Event = undefined;
            while (c.SDL_PollEvent(&event) != 0) {
                if (event.@"type" == c.SDL_QUIT) {
                    quit = true;
                }
            }
            _ = c.SDL_SetRenderDrawColor(renderer, 0, 0, 0, c.SDL_ALPHA_OPAQUE);
            _ = c.SDL_RenderClear(renderer);
            c.SDL_RenderPresent(renderer);
        }
    }
};

pub fn main() !void {
    var hello = try HelloSdl.init();
}
