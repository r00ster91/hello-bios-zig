const spaceship =
    [_][]const u8{
    "1010110100100111",
    "1010100100100101",
    "1110110100100101",
    "1010100100100101",
    "1010110110110111",
};

export fn _start() callconv(.Naked) noreturn {
    // I couldn't figure out how to do this without immediates,
    // which means I had to give up on anything else I wanted to do
    // (code size is too big)
    inline for (spaceship) |line, y| {
        setCursorPosition(y, 0);
        VideoService.interrupt();
        VideoService.write_char.set();
        inline for (line) |char| {
            if (char == '1')
                asm volatile ("movb $0xdb, %%al")
            else
                asm volatile ("movb $32, %%al");
            VideoService.interrupt();
        }
    }

    while (true) {}
}

const VideoService = enum(u8) {
    set_cursor_pos = 0x02,
    write_char = 0x0e,

    fn set(self: VideoService) void {
        asm volatile ("mov %[video_service], %%ah"
            :
            : [video_service] "n" (self),
        );
    }

    fn interrupt() void {
        asm volatile ("int $0x10");
    }
};

/// https://www.ctyme.com/intr/rb-0087.htm
fn setCursorPosition(row: u8, col: u8) void {
    VideoService.set_cursor_pos.set();
    asm volatile ("mov $0, %%bh");
    asm volatile ("mov %[row], %%dh"
        :
        : [row]
          // Using "{dh}" instead of "n" somehow causes the text to be bigger
          "{dh}" (row),
    );
    asm volatile ("mov %[col], %%dl"
        :
        : [col] "n" (col),
    );
}

fn write(char: u8) void {
    asm volatile ("mov $0x0e, %%ah");
    asm volatile (
        \\mov %[char], %%al
        \\int $0x10
        :
        : [char] "n" (char),
    );
}
