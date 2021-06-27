const std = @import("std");
const c = @import("c.zig");

fn print_hello(widget: *c.GtkWidget, data: c.gpointer) callconv(.C) void {
    c.g_print("Hello World\n");
}

fn activate(app: *c.GtkApplication, user_data: c.gpointer) callconv(.C) void {
    const window = c.gtk_application_window_new(app);
    c.gtk_window_set_title(@ptrCast(*c.GtkWindow, window), "Window");
    c.gtk_window_set_default_size(@ptrCast(*c.GtkWindow, window), 200, 200);

    const button_box = c.gtk_button_box_new(.GTK_ORIENTATION_HORIZONTAL);
    c.gtk_container_add(@ptrCast(*c.GtkContainer, window), button_box);

    const button = c.gtk_button_new_with_label("Hello World");
    _ = c.g_signal_connect_data(button, "clicked", @ptrCast(c.GCallback, print_hello), null, null, @intToEnum(c.GConnectFlags, 0));

    c.gtk_container_add(@ptrCast(*c.GtkContainer, button_box), button);

    c.gtk_widget_show_all(window);
}

pub fn main() !void {
    std.log.info("All your codebase are belong to us.", .{});

    const win_type = c.gtk_window_get_type();
    // const win_type = c.GTK_TYPE_WINDOW;
    std.log.info("Window type is {d}", .{win_type});

    const app = c.gtk_application_new("org.gtk.example", .G_APPLICATION_FLAGS_NONE);
    defer c.g_object_unref(app);

    _ = c.g_signal_connect_data(app, "activate", @ptrCast(c.GCallback, activate), null, null, @intToEnum(c.GConnectFlags, 0));

    const result = c.g_application_run(@ptrCast(*c.GApplication, app), 0, 0);
}
