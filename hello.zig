export fn _start()
// This calling convention avoids any function prologue or epilogue
callconv(.Naked) noreturn {
    // AX (16-bit) = AH + AL (both 8-bit)
    asm volatile ("mov $0x0e, %%ah");
    inline for ("hello") |char| {
        asm volatile (
            \\mov %[char], %%al
            \\int $0x10
            :
            : [char]
              // "n" = immediate unsigned 8-bit integer
              // https://releases.llvm.org/14.0.0/docs/LangRef.html#supported-constraint-code-list
              "n" (char),
        );
    }

    while (true) {}
}
