ENTRY(_start)

SECTIONS {
    .text : {
        /* the text segment contains our function code and the instructions */
        *(.text*)

        /* we need to be 0.5 KiB big */
        FILL(0)
        . = 510; /* -2 for the magic word below */

        /* the boot signature */
        BYTE(0x55)
        BYTE(0xAA)
    }
    .data : {
        /* the read-only data segment contains static constants */
        *(.rodata*)
        /* the data segment contains static variables with an initial value */
        *(.data*)
    }
    .bss : {
        /* the BSS (block starting symbol) segment contains uninitialized
           static variables without an initial value (garbage) */
        *(.bss*)
    }
}
