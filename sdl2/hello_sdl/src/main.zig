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

    values: [ny][nx]u8,

    pub fn init(prng: *myrand.Prng) Map {
        var self: Map = undefined;
        var iy: usize = 0;
        while (iy < ny) : (iy += 1) {
            var ix: usize = 0;
            while (ix < nx) : (ix += 1) {
                self.values[iy][ix] = prng.uintLessThan(u8, 0xff);
            }
        }
        return self;
    }

    pub fn draw(self: *Map, renderer: *simple_sdl.Renderer) !void {
        try renderer.setDrawColor(0, 0, 0, c.SDL_ALPHA_OPAQUE);
        try renderer.clear();

        var iy: usize = 0;
        while (iy < ny) : (iy += 1) {
            const y: i32 = y0 + @intCast(i32, iy) * dy;
            var ix: usize = 0;
            while (ix < nx) : (ix += 1) {
                const x: i32 = x0 + @intCast(i32, ix) * dx;
                const value = self.values[iy][ix];
                try renderer.setDrawColor(value, value, value, c.SDL_ALPHA_OPAQUE);
                try renderer.fillRect(x, y, dx, dy);
            }
        }
    }
};

pub fn main() !void {
    var prng = try myrand.Prng.create();
    var map = Map.init(&prng);
    var sdl = try simple_sdl.init();
    defer sdl.deinit();
    var window = try sdl.createWindow(Map.width, Map.height);
    defer window.deinit();
    var renderer = try window.createRenderer();
    defer renderer.deinit();
    while (!sdl.quit) {
        sdl.tick();
        try map.draw(&renderer);
        renderer.present();
    }
}
