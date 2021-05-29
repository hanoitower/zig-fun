//
// main.zig
// ---------
// hello sdl
//

const c = @import("c.zig");
const simple_sdl = @import("simple_sdl.zig");
const myrand = @import("myrand.zig");

const Map = struct {
    const dx = 32;
    const dy = 32;
    const x0 = 16;
    const y0 = 16;
    const nx = 30;
    const ny = 20;

    const width = (nx + 1) * dx;
    const height = (ny + 1) * dy;

    pub fn draw(renderer: *simple_sdl.Renderer, prng: *myrand.Prng) !void {
        try renderer.setDrawColor(0, 0, 0, c.SDL_ALPHA_OPAQUE);
        try renderer.clear();

        var iy: i32 = 0;
        while (iy < ny) : (iy += 1) {
            const y = y0 + iy * dy;
            var ix: i32 = 0;
            while (ix < nx) : (ix += 1) {
                const x = x0 + ix * dx;
                const red = prng.uintLessThan(u8, 0xff);
                const green = prng.uintLessThan(u8, 0xff);
                const blue = prng.uintLessThan(u8, 0xff);
                try renderer.setDrawColor(red, green, blue, c.SDL_ALPHA_OPAQUE);
                try renderer.fillRect(x, y, dx, dy);
            }
        }
    }
};

pub fn main() !void {
    var prng = try myrand.Prng.create();
    var sdl = try simple_sdl.init();
    defer sdl.deinit();
    var window = try sdl.createWindow(Map.width, Map.height);
    defer window.deinit();
    var renderer = try window.createRenderer();
    defer renderer.deinit();
    while (!sdl.quit) {
        sdl.tick();
        try Map.draw(&renderer, &prng);
        renderer.present();
    }
}
