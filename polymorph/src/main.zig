//
// polymorph
//

const std = @import("std");

const sh = @import("shape.zig");

const RectangleShape = struct {
    const fcns: sh.ShapeFunctions = .{
        .areaFn = RectangleShape.area,
    };

    fn area(shape: *const sh.Shape) f32 {
        const self = @fieldParentPtr(Rectangle, "shape", shape);
        return self.area();
    }
};

pub const Rectangle = struct {
    shape: sh.Shape = .{
        .fcns = &RectangleShape.fcns,
    },
    width: f32,
    height: f32,

    fn area(self: *const Rectangle) f32 {
        return self.width * self.height;
    }

    fn asShape(self: *const Rectangle) *const sh.Shape {
        return &self.shape;
    }
};

const Circle = struct {
    shape: sh.Shape = .{
        .fcns = &CircleShape.fcns,
    },
    radius: f32,

    fn area(self: *const Circle) f32 {
        return self.radius * self.radius * std.math.pi;
    }

    fn asShape(self: *const Circle) *const sh.Shape {
        return &self.shape;
    }
};

const CircleShape = struct {
    const fcns: sh.ShapeFunctions = .{
        .areaFn = CircleShape.area,
    };

    fn area(shape: *const sh.Shape) f32 {
        const self = @fieldParentPtr(Circle, "shape", shape);
        return self.area();
    }
};

pub fn main() anyerror!void {
    const stdout = std.io.getStdOut().writer();

    const rect = Rectangle{
        .width = 2,
        .height = 3,
    };

    const rect_area = rect.area();

    try stdout.print("rect area = {}\n", .{rect_area});

    const circ = Circle{
        .radius = 2,
    };

    const circ_area = circ.area();

    try stdout.print("circ area = {}\n", .{circ_area});

    const rect_shape: *const sh.Shape = rect.asShape();
    const circ_shape: *const sh.Shape = circ.asShape();

    try stdout.print("rect shape area = {}\n", .{rect_shape.area()});
    try stdout.print("circ shape area = {}\n", .{circ_shape.area()});

    const shapes = [_]*const sh.Shape{
        rect_shape,
        circ_shape,
        rect_shape,
        circ_shape,
        circ_shape,
    };

    for (shapes) |shape, i| {
        try stdout.print("shape {} area = {}\n", .{
            i,
            shape.area(),
        });
    }
}
