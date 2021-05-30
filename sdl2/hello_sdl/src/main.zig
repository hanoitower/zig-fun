//
// main.zig
// ---------
// hello sdl
//

const c = @import("c.zig");
const simple_sdl = @import("simple_sdl.zig");
const simple_ttf = @import("simple_ttf.zig");
const myrand = @import("myrand.zig");

const Map = struct {
    const dx = 32;
    const dy = 32;
    const x0 = 16;
    const y0 = 16 + 88;
    const nx = 30;
    const ny = 20;

    const width = (nx + 1) * dx;
    const height = 88 + (ny + 1) * dy;

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
        try self.drawFields(renderer);
        try self.drawGrid(renderer);
    }

    fn drawFields(self: *Map, renderer: *simple_sdl.Renderer) !void {
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

    fn drawGrid(self: *Map, renderer: *simple_sdl.Renderer) !void {
        try renderer.setDrawColor(0, 0x90, 0, c.SDL_ALPHA_OPAQUE);
        const xn = x0 + @intCast(i32, nx) * dx;
        var iy: usize = 0;
        while (iy <= ny) : (iy += 1) {
            const y: i32 = y0 + @intCast(i32, iy) * dy;
            try renderer.drawLine(x0, y, xn, y);
        }
        const yn = y0 + @intCast(i32, ny) * dy;
        var ix: usize = 0;
        while (ix <= nx) : (ix += 1) {
            const x: i32 = x0 + @intCast(i32, ix) * dx;
            try renderer.drawLine(x, y0, x, yn);
        }
    }
};

pub fn main() !void {
    var prng = try myrand.Prng.create();
    var map = Map.init(&prng);
    var sdl = try simple_sdl.init();
    defer sdl.deinit();
    var ttf = try simple_ttf.init();
    defer ttf.deinit();
    // var font = try ttf.openFont("fonts/gameovercre1.ttf", 32);
    // var font = try ttf.openFont("fonts/enhanced_dot_digital-7.ttf", 40);
    var font = try ttf.openFont("fonts/edundot.ttf", 88);
    defer font.deinit();
    const text_color = simple_sdl.Color{
        .r = 0,
        .g = 0x90,
        .b = 0,
        .a = c.SDL_ALPHA_OPAQUE,
    };
    var text_surface = try font.renderSolidText("Game of Life", text_color);
    defer text_surface.deinit();
    var window = try sdl.createWindow("Game of Life", Map.width, Map.height);
    defer window.deinit();
    var renderer = try window.createRenderer();
    defer renderer.deinit();
    var text_texture = try renderer.createTextureFromSurface(text_surface);
    defer text_texture.deinit();
    while (!sdl.quit) {
        sdl.tick();
        try map.draw(&renderer);
        try renderer.drawTexture(text_texture, 16 + 16 * 11, 16);
        // try renderer.drawTexture(text_texture, 100, 140);
        renderer.present();
    }
}
