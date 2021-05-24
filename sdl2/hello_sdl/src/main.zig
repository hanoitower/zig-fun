//
// main.zig
// ---------
// hello sdl
//

const c = @import("c.zig");
const simple_sdl = @import("simple_sdl.zig");

pub fn main() !void {
    var sdl = try simple_sdl.init();
    defer sdl.deinit();
    var window = try sdl.createWindow();
    defer window.deinit();
    var renderer = try window.createRenderer();
    defer renderer.deinit();
    while (!sdl.quit) {
        sdl.tick();
        try renderer.setDrawColor(0, 0, 0, c.SDL_ALPHA_OPAQUE);
        try renderer.clear();
        try renderer.setDrawColor(0xff, 0x80, 0, c.SDL_ALPHA_OPAQUE);
        try renderer.fillRect(10, 10, 100, 100);
        renderer.present();
    }
}
