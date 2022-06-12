# hello-bios-zig

Some attempts to write BIOS bootloaders with Zig.
It didn't go great. Will probably have to wait for <https://github.com/ziglang/zig/issues/7469>.

## Building, running, and cleaning

```
make build run clean
```
to run rules `build`, `run`, and `clean`.
By default, it uses `hello.zig`.
To run `big_hello.zig`, use `sed -i 's/hello/big_hello/g' Makefile`.

There is a lot to be desired in regard to the setup and the building process.
Until Zig supports `-ofmt=raw` as a target object format,
it will probably stay this way.

![image](https://user-images.githubusercontent.com/35064754/173230785-eef3bc8b-5056-444a-9466-aef469661b35.png)
