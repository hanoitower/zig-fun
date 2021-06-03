const c = @import("c.zig");

fn luapi_average(L: ?*c.lua_State) callconv(.C) c_int {
    const n = c.lua_gettop(L); // number of arguments
    var sum: c.lua_Number = 0;
    var i: c_int = 1;
    while (i <= n) : (i += 1) {
        var is_num: c_int = 0;
        const num: c.lua_Number = c.lua_tonumberx(L, i, &is_num);
        if (is_num != 0) {
            sum += num;
        }
    }
    const aver: c.lua_Number = sum / @intToFloat(c.lua_Number, n);
    c.lua_pushnumber(L, aver); // first result
    c.lua_pushnumber(L, sum); // second result
    return 2; // number of results
}

export fn luaopen_liblua_ext_demo(L: ?*c.lua_State) c_int {
    c.lua_newtable(L);
    c.lua_pushcfunction(L, luapi_average);
    c.lua_setfield(L, -2, "average");
    return 1;
}
