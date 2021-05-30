//
// simple_ttf.zig
//

const c = @import("c.zig");
const std = @import("std");
const sdl = @import("simple_sdl.zig");

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

    pub fn openFont(self: *SimpleTtf, file_name: [*:0]const u8, pt_size: i32) !Font {
        return Font{
            .font = c.TTF_OpenFont(file_name, pt_size) orelse {
                std.log.emerg("Unable to open font: {s}", .{c.SDL_GetError()});
                return error.Failed;
            },
        };
    }
};

pub const Font = struct {
    font: *c.TTF_Font,

    pub fn deinit(self: *Font) void {
        c.TTF_CloseFont(self.font);
    }

    pub fn renderSolidText(self: *Font, text: [*:0]const u8, color: sdl.Color) !sdl.Surface {
        return sdl.Surface{
            .surface = c.TTF_RenderUTF8_Solid(self.font, text, color) orelse {
                std.log.emerg("Unable to open font: {s}", .{c.SDL_GetError()});
                return error.Failed;
            },
        };
    }
};
