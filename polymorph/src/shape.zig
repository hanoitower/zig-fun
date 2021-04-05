//
// shape.zig
//

pub const ShapeFunctions = struct {
    areaFn: fn (shape: *const Shape) f32,
};

pub const Shape = struct {
    fcns: *const ShapeFunctions,

    pub fn area(self: *const Shape) f32 {
        return self.fcns.areaFn(self);
    }
};
