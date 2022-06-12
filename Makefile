build:
	zig build-obj \
	-target x86_64-freestanding-none \
	--strip -O ReleaseSmall \
	-femit-llvm-ir -femit-asm \
	-T linker.ld \
	hello.zig

	# Zig doesn't support this by itself yet
	objcopy -O binary hello.o hello.bin

	# The following is an alternative the linker script:
	#if [ `wc -c <hello.bin` -gt 512 ]; then \
	#	echo "We're over the 512B budget!"; \
	#	exit 1; \
	#else \
	#	# - 2 because of the magic word \
	#	truncate -s 510 hello.bin; \
	#	# Somehow `printf "\xaa\x55"` doesn't work properly in a Makefile \
	#   # so `55aa` will need to contain the bytes \
	#	cat 55aa >> hello.bin; \
	#fi

run:
	qemu-system-x86_64 -drive file=hello.bin,format=raw

clean:
	rm hello.o hello.ll hello.s hello.bin
