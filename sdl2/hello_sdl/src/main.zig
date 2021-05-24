const std = @import("std");

const c = @cImport({
    @cInclude("SDL.h");
});

pub const HelloSdl = struct {
    quit: bool,

    pub fn init() !HelloSdl {
        if (c.SDL_Init(c.SDL_INIT_VIDEO) != 0) {
            std.log.emerg("Unable to initialize SDL: {s}", .{c.SDL_GetError()});
            return error.Failed;
        }
        return HelloSdl{
            .quit = false,
        };
    }

    pub fn deinit(self: *HelloSdl) void {
        c.SDL_Quit();
    }

    pub fn createWindow(self: *HelloSdl) !Window {
        return Window{
            .window = c.SDL_CreateWindow("Hello SDL2", c.SDL_WINDOWPOS_CENTERED, c.SDL_WINDOWPOS_CENTERED, 640, 480, 0) orelse {
                std.log.emerg("Unable to create window: {s}", .{c.SDL_GetError()});
                return error.Failed;
            },
        };
    }

    pub fn tick(self: *HelloSdl) void {
        var event: c.SDL_Event = undefined;
        while (c.SDL_PollEvent(&event) != 0) {
            if (event.@"type" == c.SDL_QUIT) {
                self.quit = true;
            }
        }
    }
};

pub const Window = struct {
    window: *c.SDL_Window,

    pub fn deinit(self: *Window) void {
        c.SDL_DestroyWindow(self.window);
    }

    pub fn createRenderer(self: *Window) !Renderer {
        return Renderer{
            .renderer = c.SDL_CreateRenderer(self.window, -1, c.SDL_RENDERER_PRESENTVSYNC) orelse {
                std.log.emerg("Unable to create SDL renderer: {s}", .{c.SDL_GetError()});
                return error.Failed;
            },
        };
    }
};

pub const Renderer = struct {
    renderer: *c.SDL_Renderer,

    pub fn deinit(self: *Renderer) void {
        c.SDL_DestroyRenderer(self.renderer);
    }

    pub fn setDrawColor(self: *Renderer, red: u8, green: u8, blue: u8, alpha: u8) !void {
        if (c.SDL_SetRenderDrawColor(self.renderer, red, green, blue, alpha) != 0) {
            std.log.emerg("Error in SDL_SetRenderDrawColor: {s}", .{c.SDL_GetError()});
            return error.Failed;
        }
    }

    pub fn clear(self: *Renderer) !void {
        if (c.SDL_RenderClear(self.renderer) != 0) {
            std.log.emerg("Error in SDL_RenderClear: {s}", .{c.SDL_GetError()});
            return error.Failed;
        }
    }

    pub fn fillRect(self: *Renderer, x: i32, y: i32, width: i32, height: i32) !void {
        const rect = c.SDL_Rect{ .x = x, .y = y, .w = width, .h = height };
        if (c.SDL_RenderFillRect(self.renderer, &rect) != 0) {
            std.log.emerg("Error in SDL_RenderFillRect: {s}", .{c.SDL_GetError()});
            return error.Failed;
        }
    }

    pub fn present(self: *Renderer) void {
        c.SDL_RenderPresent(self.renderer);
    }
};

pub fn main() !void {
    var hello = try HelloSdl.init();
    defer hello.deinit();
    var window = try hello.createWindow();
    defer window.deinit();
    var renderer = try window.createRenderer();
    defer renderer.deinit();
    while (!hello.quit) {
        hello.tick();
        try renderer.setDrawColor(0, 0, 0, c.SDL_ALPHA_OPAQUE);
        try renderer.clear();
        try renderer.setDrawColor(0xff, 0x80, 0, c.SDL_ALPHA_OPAQUE);
        try renderer.fillRect(10, 10, 100, 100);
        renderer.present();
    }
}
