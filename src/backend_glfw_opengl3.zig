const gui = @import("gui.zig");

const c = @cImport(
    @cInclude("GLFW/glfw3.h"),
);

pub fn init(window: *const anyopaque, install_callbacks: bool, version: [*]const u8) void {
    if (!ImGui_ImplGlfw_InitForOpenGL(window, install_callbacks)) unreachable;
    if (!ImGui_ImplOpenGL3_Init(version)) unreachable;
}

pub fn deinit() void {
    ImGui_ImplOpenGL3_Shutdown();
    ImGui_ImplGlfw_Shutdown();
}

pub fn newFrame() void {
    ImGui_ImplOpenGL3_NewFrame();
    ImGui_ImplGlfw_NewFrame();

    gui.newFrame();
}

pub fn draw(width: u32, height: u32) void {
    gui.render();

    c.glViewport(0, 0, @intCast(c_int, width), @intCast(c_int, height));
    c.glClear(c.GL_COLOR_BUFFER_BIT);
    ImGui_ImplOpenGL3_RenderDrawData(gui.getDrawData());
}

extern fn ImGui_ImplOpenGL3_Init(version: [*]const u8) bool;
extern fn ImGui_ImplOpenGL3_NewFrame() void;
extern fn ImGui_ImplOpenGL3_RenderDrawData(draw_data: *const anyopaque) void;
extern fn ImGui_ImplOpenGL3_Shutdown() void;

extern fn ImGui_ImplGlfw_InitForOpenGL(window: *const anyopaque, install_callbacks: bool) bool;
extern fn ImGui_ImplGlfw_NewFrame() void;
extern fn ImGui_ImplGlfw_Shutdown() void;
extern fn ImGui_ImplOpenGL3_CreateDeviceObjects() bool;
extern fn ImGui_ImplOpenGL3_DestroyDeviceObjects() void;
