const std = @import("std");
const SocketConf = @import("config.zig");
const Request = @import("request.zig");
const stdout = std.io.getStdOut().writer();

pub fn main() !void {
    const socket = try SocketConf.Socket.init();
    try stdout.print("Server Addr: {any}\n", .{socket._address});
    var server = try socket._address.listen(.{});
    const connection = try server.accept();

    var buffer = [_]u8{0} ** 1000;
    try Request.read_request(connection, buffer[0..buffer.len]);
    try stdout.print("{s}\n", .{buffer});
}
