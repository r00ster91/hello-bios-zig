# hello-bios-zig

Some attempts to write BIOS bootloaders with Zig.
It didn't go great. Will probably have to wait for <https://github.com/ziglang/zig/issues/7469>.

## Building, running, and cleaning

```
make build run clean
```
to run rules `build`, `run`, and `clean`.
By default, it uses `hello.zig`. Edit the Makefile to build a different file.

There is a lot to be desired in regard to the setup and the building process.
Until Zig supports `-ofmt=raw` as a target object format,
it will probably stay this way.
