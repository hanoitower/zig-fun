//
// main.zig
// ---------
// hello sdl
//

const c = @import("c.zig");
const simple_sdl = @import("simple_sdl.zig");

const Map = struct {
    const dx = 32;
    const dy = 32;
    const nx = 30;
    const ny = 20;

    const width = (nx + 1) * dx;
    const height = (ny + 1) * dy;

    pub fn draw(renderer: *simple_sdl.Renderer) !void {
        try renderer.setDrawColor(0, 0, 0, c.SDL_ALPHA_OPAQUE);
        try renderer.clear();
        try renderer.setDrawColor(0xff, 0x80, 0, c.SDL_ALPHA_OPAQUE);
        try renderer.fillRect(10, 10, 100, 100);
    }
};

pub fn main() !void {
    var sdl = try simple_sdl.init();
    defer sdl.deinit();
    var window = try sdl.createWindow(Map.width, Map.height);
    defer window.deinit();
    var renderer = try window.createRenderer();
    defer renderer.deinit();
    while (!sdl.quit) {
        sdl.tick();
        try Map.draw(&renderer);
        renderer.present();
    }
}
