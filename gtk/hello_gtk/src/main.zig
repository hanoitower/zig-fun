const std = @import("std");
const c = @import("c.zig");

fn print_hello(widget: *c.GtkWidget, data: c.gpointer) callconv(.C) void {
    c.g_print("Hello World\n");
}

fn activate(app: *c.GtkApplication, user_data: c.gpointer) callconv(.C) void {
    const window = c.gtk_application_window_new(app);
    c.gtk_window_set_title(@ptrCast(*c.GtkWindow, window), "Window");
    c.gtk_window_set_default_size(@ptrCast(*c.GtkWindow, window), 200, 200);

    const button = c.gtk_button_new_with_label("Hello World");
    _ = c.g_signal_connect_data(button, "clicked", @ptrCast(c.GCallback, print_hello), c.NULL, @ptrCast(c.GClosureNotify, c.NULL), @intToEnum(c.GConnectFlags, 0));

    // c.gtk_window_set_child(window, button);

    c.gtk_window_present(@ptrCast(*c.GtkWindow, window));
}

pub fn main() !void {
    std.log.info("All your codebase are belong to us.", .{});

    const app = c.gtk_application_new("org.gtk.example", .G_APPLICATION_FLAGS_NONE);
    defer c.g_object_unref(app);

    _ = c.g_signal_connect_data(app, "activate", @ptrCast(fn () callconv(.C) void, activate), c.NULL, @ptrCast(c.GClosureNotify, c.NULL), @intToEnum(c.GConnectFlags, 0));

    const result = c.g_application_run(@ptrCast(*c.GApplication, app), 0, 0);
}
